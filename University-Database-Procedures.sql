-- ============================================================
--  UNIVERSITY ERP SYSTEM
--  File        : procedures.sql
--  Description : Stored Procedures (8) + Triggers (6)
--  Engine      : MySQL 8.0
-- ============================================================

DELIMITER $$


-- ============================================================
--  STORED PROCEDURE 1 : sp_enroll_student
--
--  Safely enrolls a student into a section.
--  Validations performed:
--    (a) Student exists and is Active
--    (b) Section exists
--    (c) Student is not already enrolled in this section
--    (d) Section still has seats available
--
--  Usage:
--    CALL sp_enroll_student(1, 3, '2024-09-01');
-- ============================================================
DROP PROCEDURE IF EXISTS sp_enroll_student $$

CREATE PROCEDURE sp_enroll_student(
    IN  p_student_id    INT,
    IN  p_section_id    INT,
    IN  p_enroll_date   DATE
)
BEGIN
    DECLARE v_capacity       INT     DEFAULT 0;
    DECLARE v_enrolled       INT     DEFAULT 0;
    DECLARE v_already        INT     DEFAULT 0;
    DECLARE v_student_active INT     DEFAULT 0;

    -- (a) Student must exist and be Active
    SELECT COUNT(*) INTO v_student_active
    FROM student
    WHERE student_id = p_student_id AND status = 'Active';

    IF v_student_active = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'ERROR: Student does not exist or is not Active.';
    END IF;

    -- (b) Section must exist — also retrieve capacity
    SELECT capacity INTO v_capacity
    FROM section
    WHERE section_id = p_section_id;

    IF v_capacity IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'ERROR: Section does not exist.';
    END IF;

    -- (c) Duplicate enrollment check
    SELECT COUNT(*) INTO v_already
    FROM enrollment
    WHERE student_id = p_student_id AND section_id = p_section_id;

    IF v_already > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'ERROR: Student is already enrolled in this section.';
    END IF;

    -- (d) Capacity check
    SELECT COUNT(*) INTO v_enrolled
    FROM enrollment
    WHERE section_id = p_section_id;

    IF v_enrolled >= v_capacity THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'ERROR: Section has reached maximum capacity.';
    END IF;

    -- All checks passed — insert enrollment
    INSERT INTO enrollment (student_id, section_id, enrollment_date, grade)
    VALUES (p_student_id, p_section_id, p_enroll_date, NULL);

    SELECT
        CONCAT('SUCCESS: Student ', p_student_id,
               ' enrolled in section ', p_section_id)  AS message,
        (v_capacity - v_enrolled - 1)                  AS seats_remaining;
END $$


-- ============================================================
--  STORED PROCEDURE 2 : sp_calculate_cgpa
--
--  Recalculates and updates a student's CGPA from their
--  complete enrollment history. Called internally by
--  sp_update_grade and by the grade-update trigger.
--
--  Usage:
--    CALL sp_calculate_cgpa(1);
-- ============================================================
DROP PROCEDURE IF EXISTS sp_calculate_cgpa $$

CREATE PROCEDURE sp_calculate_cgpa(
    IN p_student_id INT
)
BEGIN
    DECLARE v_total_quality_pts DECIMAL(10,2) DEFAULT 0.00;
    DECLARE v_total_credits     INT           DEFAULT 0;
    DECLARE v_cgpa              DECIMAL(4,2)  DEFAULT 0.00;

    SELECT
        SUM(CASE e.grade
            WHEN 'A'  THEN 4.0 * c.credit_hours  WHEN 'A-' THEN 3.7 * c.credit_hours
            WHEN 'B+' THEN 3.3 * c.credit_hours  WHEN 'B'  THEN 3.0 * c.credit_hours
            WHEN 'B-' THEN 2.7 * c.credit_hours  WHEN 'C+' THEN 2.3 * c.credit_hours
            WHEN 'C'  THEN 2.0 * c.credit_hours  WHEN 'C-' THEN 1.7 * c.credit_hours
            WHEN 'D+' THEN 1.3 * c.credit_hours  WHEN 'D'  THEN 1.0 * c.credit_hours
            WHEN 'F'  THEN 0.0                   ELSE 0
        END),
        SUM(c.credit_hours)
    INTO v_total_quality_pts, v_total_credits
    FROM enrollment e
    JOIN section sec ON e.section_id = sec.section_id
    JOIN course   c  ON sec.course_id = c.course_id
    WHERE e.student_id = p_student_id
      AND e.grade IS NOT NULL
      AND e.grade NOT IN ('W', 'I');

    IF COALESCE(v_total_credits, 0) > 0 THEN
        SET v_cgpa = ROUND(v_total_quality_pts / v_total_credits, 2);
    END IF;

    UPDATE student
    SET cgpa = v_cgpa
    WHERE student_id = p_student_id;

    SELECT
        p_student_id                                AS student_id,
        v_cgpa                                      AS updated_cgpa,
        COALESCE(v_total_credits, 0)                AS total_credit_hours,
        CONCAT('CGPA updated to ', v_cgpa)          AS message;
END $$


-- ============================================================
--  STORED PROCEDURE 3 : sp_update_grade
--
--  Updates a student's grade for a specific section and
--  automatically triggers CGPA recalculation.
--
--  Usage:
--    CALL sp_update_grade(1, 2, 'A-');
-- ============================================================
DROP PROCEDURE IF EXISTS sp_update_grade $$

CREATE PROCEDURE sp_update_grade(
    IN p_student_id  INT,
    IN p_section_id  INT,
    IN p_grade       VARCHAR(5)
)
BEGIN
    DECLARE v_exists INT DEFAULT 0;

    -- Verify enrollment exists
    SELECT COUNT(*) INTO v_exists
    FROM enrollment
    WHERE student_id = p_student_id AND section_id = p_section_id;

    IF v_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'ERROR: No enrollment found for this student and section.';
    END IF;

    -- Validate grade value
    IF p_grade NOT IN ('A','A-','B+','B','B-','C+','C','C-','D+','D','F','W','I') THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'ERROR: Invalid grade value supplied.';
    END IF;

    -- Update grade in enrollment
    UPDATE enrollment
    SET grade = p_grade
    WHERE student_id = p_student_id AND section_id = p_section_id;

    -- Recalculate CGPA
    CALL sp_calculate_cgpa(p_student_id);
END $$


-- ============================================================
--  STORED PROCEDURE 4 : sp_get_student_transcript
--
--  Returns a student's full academic transcript in two
--  result sets:
--    (1) Header  — student and programme info
--    (2) Detail  — one row per course with grade points
--    (3) Summary — total credits and calculated CGPA
--
--  Usage:
--    CALL sp_get_student_transcript(1);
-- ============================================================
DROP PROCEDURE IF EXISTS sp_get_student_transcript $$

CREATE PROCEDURE sp_get_student_transcript(
    IN p_student_id INT
)
BEGIN
    DECLARE v_exists INT DEFAULT 0;

    SELECT COUNT(*) INTO v_exists FROM student WHERE student_id = p_student_id;
    IF v_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'ERROR: Student not found.';
    END IF;

    -- ── Result Set 1: Student header ──────────────────────
    SELECT
        s.student_id,
        s.registration_no,
        CONCAT(s.first_name, ' ', s.last_name)  AS student_name,
        p.program_code,
        p.program_name,
        p.degree_level,
        d.department_name,
        s.admission_date,
        s.cgpa                                  AS stored_cgpa,
        s.status
    FROM student    s
    JOIN program    p ON s.program_id    = p.program_id
    JOIN department d ON p.department_id = d.department_id
    WHERE s.student_id = p_student_id;

    -- ── Result Set 2: Course-wise record ──────────────────
    SELECT
        acad.session_name,
        sm.semester_name,
        c.course_code,
        c.course_title,
        c.credit_hours,
        e.grade,
        CASE e.grade
            WHEN 'A'  THEN 4.0  WHEN 'A-' THEN 3.7
            WHEN 'B+' THEN 3.3  WHEN 'B'  THEN 3.0
            WHEN 'B-' THEN 2.7  WHEN 'C+' THEN 2.3
            WHEN 'C'  THEN 2.0  WHEN 'C-' THEN 1.7
            WHEN 'D+' THEN 1.3  WHEN 'D'  THEN 1.0
            WHEN 'F'  THEN 0.0  ELSE NULL
        END                                     AS grade_points,
        CASE e.grade
            WHEN 'A'  THEN 4.0 * c.credit_hours  WHEN 'A-' THEN 3.7 * c.credit_hours
            WHEN 'B+' THEN 3.3 * c.credit_hours  WHEN 'B'  THEN 3.0 * c.credit_hours
            WHEN 'B-' THEN 2.7 * c.credit_hours  WHEN 'C+' THEN 2.3 * c.credit_hours
            WHEN 'C'  THEN 2.0 * c.credit_hours  WHEN 'C-' THEN 1.7 * c.credit_hours
            WHEN 'D+' THEN 1.3 * c.credit_hours  WHEN 'D'  THEN 1.0 * c.credit_hours
            WHEN 'F'  THEN 0.0                   ELSE 0
        END                                     AS quality_points
    FROM enrollment e
    JOIN section          sec  ON e.section_id   = sec.section_id
    JOIN course           c    ON sec.course_id  = c.course_id
    JOIN semester         sm   ON sec.semester_id = sm.semester_id
    JOIN academic_session acad ON sm.session_id  = acad.session_id
    WHERE e.student_id = p_student_id
    ORDER BY acad.session_name, sm.semester_name, c.course_code;

    -- ── Result Set 3: Summary ─────────────────────────────
    SELECT
        COUNT(c.course_id)                      AS total_courses,
        SUM(c.credit_hours)                     AS total_credit_hours_attempted,
        SUM(CASE WHEN e.grade NOT IN ('F','W','I')
                  AND e.grade IS NOT NULL
                 THEN c.credit_hours ELSE 0 END) AS credit_hours_earned,
        ROUND(
            SUM(CASE e.grade
                WHEN 'A'  THEN 4.0 * c.credit_hours  WHEN 'A-' THEN 3.7 * c.credit_hours
                WHEN 'B+' THEN 3.3 * c.credit_hours  WHEN 'B'  THEN 3.0 * c.credit_hours
                WHEN 'B-' THEN 2.7 * c.credit_hours  WHEN 'C+' THEN 2.3 * c.credit_hours
                WHEN 'C'  THEN 2.0 * c.credit_hours  WHEN 'C-' THEN 1.7 * c.credit_hours
                WHEN 'D+' THEN 1.3 * c.credit_hours  WHEN 'D'  THEN 1.0 * c.credit_hours
                WHEN 'F'  THEN 0.0                   ELSE 0
            END) / NULLIF(SUM(c.credit_hours), 0), 2
        )                                       AS calculated_cgpa
    FROM enrollment e
    JOIN section sec ON e.section_id  = sec.section_id
    JOIN course   c  ON sec.course_id = c.course_id
    WHERE e.student_id = p_student_id
      AND e.grade IS NOT NULL
      AND e.grade NOT IN ('W', 'I');
END $$


-- ============================================================
--  STORED PROCEDURE 5 : sp_generate_invoice
--
--  Generates a semester fee invoice for a student by reading
--  the fee_structure for their programme.  Also inserts a
--  row into financial_ledger.
--
--  Usage:
--    CALL sp_generate_invoice(1, 2, '2024-09-01', '2024-09-15');
-- ============================================================
DROP PROCEDURE IF EXISTS sp_generate_invoice $$

CREATE PROCEDURE sp_generate_invoice(
    IN p_student_id   INT,
    IN p_semester_id  INT,
    IN p_invoice_date DATE,
    IN p_due_date     DATE
)
BEGIN
    DECLARE v_program_id   INT;
    DECLARE v_total_amount DECIMAL(12,2) DEFAULT 0.00;
    DECLARE v_invoice_id   INT;
    DECLARE v_existing     INT DEFAULT 0;

    -- Prevent duplicate invoices
    SELECT COUNT(*) INTO v_existing
    FROM invoice
    WHERE student_id = p_student_id AND semester_id = p_semester_id;

    IF v_existing > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'ERROR: Invoice already exists for this student and semester.';
    END IF;

    -- Get student programme
    SELECT program_id INTO v_program_id
    FROM student WHERE student_id = p_student_id;

    IF v_program_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'ERROR: Student not found.';
    END IF;

    -- Sum applicable fee structure rows
    SELECT COALESCE(SUM(fs.amount), 0) INTO v_total_amount
    FROM fee_structure fs
    WHERE fs.program_id = v_program_id
      AND fs.effective_date <= p_invoice_date;

    IF v_total_amount = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'ERROR: No fee structure found for this programme.';
    END IF;

    -- Create invoice header
    INSERT INTO invoice (student_id, semester_id, invoice_date, due_date, total_amount, status)
    VALUES (p_student_id, p_semester_id, p_invoice_date, p_due_date, v_total_amount, 'Pending');

    SET v_invoice_id = LAST_INSERT_ID();

    -- Create per-category detail rows
    INSERT INTO invoice_detail (invoice_id, category_id, amount)
    SELECT v_invoice_id, fs.category_id, fs.amount
    FROM fee_structure fs
    WHERE fs.program_id = v_program_id
      AND fs.effective_date <= p_invoice_date;

    -- Log to financial ledger
    INSERT INTO financial_ledger (student_id, transaction_date, transaction_type, amount, description)
    VALUES (p_student_id, NOW(), 'Invoice', v_total_amount,
            CONCAT('Semester invoice #', v_invoice_id, ' generated for semester ', p_semester_id));

    SELECT
        v_invoice_id    AS invoice_id,
        v_total_amount  AS total_amount,
        'SUCCESS: Invoice generated successfully.' AS message;
END $$


-- ============================================================
--  STORED PROCEDURE 6 : sp_department_report
--
--  Four result sets covering a department's complete profile:
--    (1) Department info
--    (2) Active programmes
--    (3) Instructors
--    (4) Student headcount per programme with average CGPA
--    (5) Courses offered
--
--  Usage:
--    CALL sp_department_report(1);
-- ============================================================
DROP PROCEDURE IF EXISTS sp_department_report $$

CREATE PROCEDURE sp_department_report(
    IN p_department_id INT
)
BEGIN
    DECLARE v_exists INT DEFAULT 0;

    SELECT COUNT(*) INTO v_exists
    FROM department WHERE department_id = p_department_id;

    IF v_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'ERROR: Department not found.';
    END IF;

    -- ── RS 1: Department header ────────────────────────────
    SELECT department_id, department_code, department_name,
           building_name, budget, created_at
    FROM department
    WHERE department_id = p_department_id;

    -- ── RS 2: Programmes ───────────────────────────────────
    SELECT program_id, program_code, program_name,
           degree_level, duration_years, total_credit_hours
    FROM program
    WHERE department_id = p_department_id
    ORDER BY degree_level, program_name;

    -- ── RS 3: Instructors ──────────────────────────────────
    SELECT
        instructor_id,
        employee_no,
        CONCAT(first_name, ' ', last_name) AS instructor_name,
        designation,
        email,
        hire_date,
        salary
    FROM instructor
    WHERE department_id = p_department_id
    ORDER BY designation, last_name;

    -- ── RS 4: Student headcount per programme ──────────────
    SELECT
        p.program_name,
        p.degree_level,
        COUNT(s.student_id)                                    AS total_students,
        SUM(CASE WHEN s.status = 'Active'    THEN 1 ELSE 0 END) AS active,
        SUM(CASE WHEN s.status = 'Graduated' THEN 1 ELSE 0 END) AS graduated,
        SUM(CASE WHEN s.status = 'Suspended' THEN 1 ELSE 0 END) AS suspended,
        ROUND(AVG(s.cgpa), 2)                                  AS avg_cgpa
    FROM student s
    JOIN program p ON s.program_id = p.program_id
    WHERE p.department_id = p_department_id
    GROUP BY p.program_id, p.program_name, p.degree_level
    ORDER BY p.degree_level;

    -- ── RS 5: Courses ──────────────────────────────────────
    SELECT course_id, course_code, course_title, credit_hours
    FROM course
    WHERE department_id = p_department_id
    ORDER BY course_code;
END $$


-- ============================================================
--  STORED PROCEDURE 7 : sp_issue_library_book
--
--  Issues a book copy to an active library member.
--  Validations:
--    (a) Copy exists and is Available
--    (b) Member exists and is Active
--    (c) Due date must be after issue date
--
--  Usage:
--    CALL sp_issue_library_book(1, 1, '2024-11-01', '2024-11-15');
-- ============================================================
DROP PROCEDURE IF EXISTS sp_issue_library_book $$

CREATE PROCEDURE sp_issue_library_book(
    IN p_copy_id    INT,
    IN p_member_id  INT,
    IN p_issue_date DATE,
    IN p_due_date   DATE
)
BEGIN
    DECLARE v_copy_status   VARCHAR(20);
    DECLARE v_member_status VARCHAR(20);

    IF p_due_date <= p_issue_date THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'ERROR: Due date must be after issue date.';
    END IF;

    -- (a) Validate copy
    SELECT status INTO v_copy_status FROM book_copy WHERE copy_id = p_copy_id;
    IF v_copy_status IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'ERROR: Book copy not found.';
    END IF;
    IF v_copy_status != 'Available' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'ERROR: Book copy is not available for issue.';
    END IF;

    -- (b) Validate member
    SELECT status INTO v_member_status FROM library_member WHERE member_id = p_member_id;
    IF v_member_status IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'ERROR: Library member not found.';
    END IF;
    IF v_member_status != 'Active' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'ERROR: Library membership is not Active.';
    END IF;

    -- Issue the book
    INSERT INTO book_issue (copy_id, member_id, issue_date, due_date)
    VALUES (p_copy_id, p_member_id, p_issue_date, p_due_date);

    -- Mark copy as Issued (trigger also handles this — belt & braces)
    UPDATE book_copy SET status = 'Issued' WHERE copy_id = p_copy_id;

    SELECT CONCAT('SUCCESS: Copy ', p_copy_id,
                  ' issued to member ', p_member_id,
                  '. Due: ', p_due_date) AS message;
END $$


-- ============================================================
--  STORED PROCEDURE 8 : sp_return_library_book
--
--  Processes a book return and auto-calculates an overdue
--  fine (PKR 10/day) if returned after due date.
--
--  Usage:
--    CALL sp_return_library_book(1, '2024-11-20');
-- ============================================================
DROP PROCEDURE IF EXISTS sp_return_library_book $$

CREATE PROCEDURE sp_return_library_book(
    IN p_issue_id    INT,
    IN p_return_date DATE
)
BEGIN
    DECLARE v_copy_id       INT;
    DECLARE v_due_date      DATE;
    DECLARE v_already_ret   INT DEFAULT 0;
    DECLARE v_days_late     INT DEFAULT 0;
    DECLARE v_fine_amount   DECIMAL(10,2) DEFAULT 0.00;
    DECLARE v_fine_per_day  DECIMAL(10,2) DEFAULT 10.00; -- PKR 10 per day

    -- Check not already returned
    SELECT COUNT(*) INTO v_already_ret FROM book_return WHERE issue_id = p_issue_id;
    IF v_already_ret > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'ERROR: This book has already been returned.';
    END IF;

    -- Get issue details
    SELECT copy_id, due_date INTO v_copy_id, v_due_date
    FROM book_issue WHERE issue_id = p_issue_id;

    IF v_copy_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'ERROR: Issue record not found.';
    END IF;

    -- Record the return
    INSERT INTO book_return (issue_id, return_date)
    VALUES (p_issue_id, p_return_date);

    -- Free the copy
    UPDATE book_copy SET status = 'Available' WHERE copy_id = v_copy_id;

    -- Calculate and record fine if overdue
    IF p_return_date > v_due_date THEN
        SET v_days_late   = DATEDIFF(p_return_date, v_due_date);
        SET v_fine_amount = v_days_late * v_fine_per_day;

        INSERT INTO library_fine (issue_id, amount, fine_reason, paid_status)
        VALUES (p_issue_id, v_fine_amount,
                CONCAT('Overdue by ', v_days_late, ' day(s)'),
                'Unpaid');

        SELECT CONCAT('Book returned. Overdue fine: PKR ', v_fine_amount,
                      ' (', v_days_late, ' day(s) late).') AS message;
    ELSE
        SELECT 'Book returned on time. No fine applied.' AS message;
    END IF;
END $$


-- ============================================================
--  TRIGGER 1 : trg_before_enrollment_capacity
--
--  Blocks any INSERT into enrollment when the section has
--  already reached its declared capacity.
-- ============================================================
DROP TRIGGER IF EXISTS trg_before_enrollment_capacity $$

CREATE TRIGGER trg_before_enrollment_capacity
BEFORE INSERT ON enrollment
FOR EACH ROW
BEGIN
    DECLARE v_capacity INT;
    DECLARE v_enrolled INT;

    SELECT capacity INTO v_capacity
    FROM section WHERE section_id = NEW.section_id;

    SELECT COUNT(*) INTO v_enrolled
    FROM enrollment WHERE section_id = NEW.section_id;

    IF v_enrolled >= v_capacity THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'ENROLLMENT BLOCKED: Section has reached maximum capacity.';
    END IF;
END $$


-- ============================================================
--  TRIGGER 2 : trg_after_grade_update_cgpa
--
--  Recalculates and stores the student's CGPA every time a
--  grade is changed in the enrollment table.
-- ============================================================
DROP TRIGGER IF EXISTS trg_after_grade_update_cgpa $$

CREATE TRIGGER trg_after_grade_update_cgpa
AFTER UPDATE ON enrollment
FOR EACH ROW
BEGIN
    IF NEW.grade IS NOT NULL
       AND (OLD.grade IS NULL OR NEW.grade != OLD.grade) THEN

        UPDATE student
        SET cgpa = (
            SELECT ROUND(
                SUM(CASE e.grade
                    WHEN 'A'  THEN 4.0 * c.credit_hours  WHEN 'A-' THEN 3.7 * c.credit_hours
                    WHEN 'B+' THEN 3.3 * c.credit_hours  WHEN 'B'  THEN 3.0 * c.credit_hours
                    WHEN 'B-' THEN 2.7 * c.credit_hours  WHEN 'C+' THEN 2.3 * c.credit_hours
                    WHEN 'C'  THEN 2.0 * c.credit_hours  WHEN 'C-' THEN 1.7 * c.credit_hours
                    WHEN 'D+' THEN 1.3 * c.credit_hours  WHEN 'D'  THEN 1.0 * c.credit_hours
                    WHEN 'F'  THEN 0.0                   ELSE 0
                END) / NULLIF(SUM(c.credit_hours), 0), 2
            )
            FROM enrollment e
            JOIN section sec ON e.section_id = sec.section_id
            JOIN course   c  ON sec.course_id = c.course_id
            WHERE e.student_id = NEW.student_id
              AND e.grade IS NOT NULL
              AND e.grade NOT IN ('W', 'I')
        )
        WHERE student_id = NEW.student_id;
    END IF;
END $$


-- ============================================================
--  TRIGGER 3 : trg_after_payment_update_invoice_status
--
--  After every payment is recorded, checks the cumulative
--  amount paid against the invoice total and sets the
--  invoice status to 'Partially Paid' or 'Paid'.
--  Also appends an entry to financial_ledger.
-- ============================================================
DROP TRIGGER IF EXISTS trg_after_payment_update_invoice_status $$

CREATE TRIGGER trg_after_payment_update_invoice_status
AFTER INSERT ON payment
FOR EACH ROW
BEGIN
    DECLARE v_total_amount DECIMAL(12,2);
    DECLARE v_total_paid   DECIMAL(12,2);

    SELECT total_amount INTO v_total_amount
    FROM invoice WHERE invoice_id = NEW.invoice_id;

    SELECT COALESCE(SUM(amount_paid), 0) INTO v_total_paid
    FROM payment WHERE invoice_id = NEW.invoice_id;

    IF v_total_paid >= v_total_amount THEN
        UPDATE invoice SET status = 'Paid'
        WHERE invoice_id = NEW.invoice_id;
    ELSEIF v_total_paid > 0 THEN
        UPDATE invoice SET status = 'Partially Paid'
        WHERE invoice_id = NEW.invoice_id;
    END IF;

    -- Append payment entry to financial ledger
    INSERT INTO financial_ledger
        (student_id, transaction_date, transaction_type, amount, description)
    SELECT
        i.student_id,
        NOW(),
        'Payment',
        NEW.amount_paid,
        CONCAT('Payment of PKR ', NEW.amount_paid,
               ' received for invoice #', NEW.invoice_id)
    FROM invoice i
    WHERE i.invoice_id = NEW.invoice_id;
END $$


-- ============================================================
--  TRIGGER 4 : trg_after_room_allocation_occupy_bed
--
--  Marks a bed as 'Occupied' as soon as an Active allocation
--  is inserted for it.  If the allocation is Cancelled, the
--  bed is freed back to 'Available'.
-- ============================================================
DROP TRIGGER IF EXISTS trg_after_room_allocation_occupy_bed $$

CREATE TRIGGER trg_after_room_allocation_occupy_bed
AFTER INSERT ON room_allocation
FOR EACH ROW
BEGIN
    IF NEW.status = 'Active' THEN
        UPDATE bed SET status = 'Occupied' WHERE bed_id = NEW.bed_id;
    ELSEIF NEW.status = 'Cancelled' THEN
        UPDATE bed SET status = 'Available' WHERE bed_id = NEW.bed_id;
    END IF;
END $$


-- ============================================================
--  TRIGGER 5 : trg_after_book_issue_mark_issued
--
--  Automatically marks a book copy as 'Issued' when a
--  book_issue record is inserted.
-- ============================================================
DROP TRIGGER IF EXISTS trg_after_book_issue_mark_issued $$

CREATE TRIGGER trg_after_book_issue_mark_issued
AFTER INSERT ON book_issue
FOR EACH ROW
BEGIN
    UPDATE book_copy
    SET status = 'Issued'
    WHERE copy_id = NEW.copy_id;
END $$


-- ============================================================
--  TRIGGER 6 : trg_after_book_return_free_copy
--
--  When a book_return record is inserted, the corresponding
--  copy is automatically set back to 'Available'.
-- ============================================================
DROP TRIGGER IF EXISTS trg_after_book_return_free_copy $$

CREATE TRIGGER trg_after_book_return_free_copy
AFTER INSERT ON book_return
FOR EACH ROW
BEGIN
    DECLARE v_copy_id INT;

    SELECT copy_id INTO v_copy_id
    FROM book_issue WHERE issue_id = NEW.issue_id;

    UPDATE book_copy
    SET status = 'Available'
    WHERE copy_id = v_copy_id;
END $$


DELIMITER ;


-- ============================================================
--  QUICK TEST CALLS
--  Uncomment after running schema.sql and seed_data.sql
-- ============================================================

-- CALL sp_enroll_student(1, 1, '2024-09-01');
-- CALL sp_calculate_cgpa(1);
-- CALL sp_update_grade(1, 1, 'A');
-- CALL sp_get_student_transcript(1);
-- CALL sp_generate_invoice(1, 1, '2024-09-01', '2024-09-15');
-- CALL sp_department_report(1);
-- CALL sp_issue_library_book(1, 1, '2024-11-01', '2024-11-15');
-- CALL sp_return_library_book(1, '2024-11-20');
