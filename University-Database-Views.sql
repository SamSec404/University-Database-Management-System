-- ============================================================
--  UNIVERSITY ERP SYSTEM
--  File        : views.sql
--  Description : Reusable Database Views (10 Views)
--  Engine      : MySQL 8.0
-- ============================================================

-- ─────────────────────────────────────────────────────
--  Drop views if they already exist (safe re-run)
-- ─────────────────────────────────────────────────────
DROP VIEW IF EXISTS vw_student_profile;
DROP VIEW IF EXISTS vw_student_academic_record;
DROP VIEW IF EXISTS vw_section_timetable;
DROP VIEW IF EXISTS vw_course_enrollment_summary;
DROP VIEW IF EXISTS vw_department_overview;
DROP VIEW IF EXISTS vw_student_fee_summary;
DROP VIEW IF EXISTS vw_library_book_availability;
DROP VIEW IF EXISTS vw_attendance_summary;
DROP VIEW IF EXISTS vw_instructor_workload;
DROP VIEW IF EXISTS vw_hostel_occupancy;


-- ============================================================
--  VIEW 1 : vw_student_profile
--  Full student profile joined with program and department.
--  Useful for admission office and student portal.
--  Usage : SELECT * FROM vw_student_profile WHERE status = 'Active';
-- ============================================================
CREATE VIEW vw_student_profile AS
SELECT
    s.student_id,
    s.registration_no,
    CONCAT(s.first_name, ' ', s.last_name)  AS full_name,
    s.gender,
    s.date_of_birth,
    s.email,
    s.phone,
    s.blood_group,
    s.nationality,
    s.admission_date,
    s.cgpa,
    s.status                                AS student_status,
    p.program_code,
    p.program_name,
    p.degree_level,
    d.department_code,
    d.department_name
FROM student s
JOIN program    p ON s.program_id    = p.program_id
JOIN department d ON p.department_id = d.department_id
ORDER BY s.registration_no;


-- ============================================================
--  VIEW 2 : vw_student_academic_record
--  Every course a student has ever enrolled in, with the
--  semester, grade, and computed grade points.
--  Backbone for transcript generation.
--  Usage : SELECT * FROM vw_student_academic_record
--          WHERE student_id = 1 ORDER BY session_name, semester_name;
-- ============================================================
CREATE VIEW vw_student_academic_record AS
SELECT
    s.student_id,
    s.registration_no,
    CONCAT(s.first_name, ' ', s.last_name)  AS student_name,
    d.department_name,
    acad.session_name,
    sm.semester_name,
    c.course_code,
    c.course_title,
    c.credit_hours,
    sec.section_name,
    CONCAT(i.first_name, ' ', i.last_name)  AS instructor_name,
    e.enrollment_date,
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
        WHEN 'F'  THEN 0.0                   ELSE NULL
    END                                     AS quality_points
FROM enrollment e
JOIN student          s    ON e.student_id   = s.student_id
JOIN section          sec  ON e.section_id   = sec.section_id
JOIN course           c    ON sec.course_id  = c.course_id
JOIN semester         sm   ON sec.semester_id = sm.semester_id
JOIN academic_session acad ON sm.session_id  = acad.session_id
JOIN program          p    ON s.program_id   = p.program_id
JOIN department       d    ON p.department_id = d.department_id
LEFT JOIN instructor  i    ON sec.instructor_id = i.instructor_id
ORDER BY s.registration_no, acad.session_name, sm.semester_name, c.course_code;


-- ============================================================
--  VIEW 3 : vw_section_timetable
--  Complete class schedule: course, instructor, building,
--  room number, day and time — for every active section.
--  Usage : SELECT * FROM vw_section_timetable
--          WHERE session_name = '2024-2025' AND semester_name = 'Fall';
-- ============================================================
CREATE VIEW vw_section_timetable AS
SELECT
    sec.section_id,
    sec.section_name,
    acad.session_name,
    sm.semester_name,
    c.course_code,
    c.course_title,
    c.credit_hours,
    CONCAT(i.first_name, ' ', i.last_name)  AS instructor_name,
    i.email                                 AS instructor_email,
    ts.day_of_week,
    ts.start_time,
    ts.end_time,
    b.building_name,
    cl.room_number,
    sec.capacity,
    COUNT(e.enrollment_id)                  AS enrolled_students,
    (sec.capacity - COUNT(e.enrollment_id)) AS seats_available
FROM section sec
JOIN course           c    ON sec.course_id   = c.course_id
JOIN semester         sm   ON sec.semester_id  = sm.semester_id
JOIN academic_session acad ON sm.session_id   = acad.session_id
LEFT JOIN instructor  i    ON sec.instructor_id = i.instructor_id
LEFT JOIN time_slot   ts   ON sec.time_slot_id  = ts.time_slot_id
LEFT JOIN classroom   cl   ON sec.classroom_id  = cl.classroom_id
LEFT JOIN building    b    ON cl.building_id    = b.building_id
LEFT JOIN enrollment  e    ON sec.section_id    = e.section_id
GROUP BY
    sec.section_id, sec.section_name,
    acad.session_name, sm.semester_name,
    c.course_code, c.course_title, c.credit_hours,
    i.first_name, i.last_name, i.email,
    ts.day_of_week, ts.start_time, ts.end_time,
    b.building_name, cl.room_number, sec.capacity
ORDER BY sm.semester_name, ts.day_of_week, ts.start_time;


-- ============================================================
--  VIEW 4 : vw_course_enrollment_summary
--  Per-course statistics: total enrolments, pass / fail
--  counts, and average grade points across all sections.
--  Usage : SELECT * FROM vw_course_enrollment_summary
--          ORDER BY total_enrollments DESC;
-- ============================================================
CREATE VIEW vw_course_enrollment_summary AS
SELECT
    c.course_id,
    c.course_code,
    c.course_title,
    c.credit_hours,
    d.department_name,
    COUNT(e.enrollment_id)                                      AS total_enrollments,
    SUM(CASE WHEN e.grade IS NOT NULL
             AND e.grade NOT IN ('F','W','I') THEN 1 ELSE 0 END) AS passed_count,
    SUM(CASE WHEN e.grade = 'F'              THEN 1 ELSE 0 END)  AS failed_count,
    SUM(CASE WHEN e.grade = 'W'              THEN 1 ELSE 0 END)  AS withdrawn_count,
    ROUND(
        AVG(CASE e.grade
            WHEN 'A'  THEN 4.0  WHEN 'A-' THEN 3.7
            WHEN 'B+' THEN 3.3  WHEN 'B'  THEN 3.0
            WHEN 'B-' THEN 2.7  WHEN 'C+' THEN 2.3
            WHEN 'C'  THEN 2.0  WHEN 'C-' THEN 1.7
            WHEN 'D+' THEN 1.3  WHEN 'D'  THEN 1.0
            WHEN 'F'  THEN 0.0  ELSE NULL
        END), 2
    )                                                           AS avg_grade_points
FROM course c
JOIN department  d   ON c.department_id = d.department_id
LEFT JOIN section    sec ON c.course_id     = sec.course_id
LEFT JOIN enrollment e   ON sec.section_id  = e.section_id
GROUP BY c.course_id, c.course_code, c.course_title, c.credit_hours, d.department_name
ORDER BY total_enrollments DESC;


-- ============================================================
--  VIEW 5 : vw_department_overview
--  High-level summary of every department: number of
--  programs, instructors, students, courses and budget.
--  Usage : SELECT * FROM vw_department_overview
--          ORDER BY total_students DESC;
-- ============================================================
CREATE VIEW vw_department_overview AS
SELECT
    d.department_id,
    d.department_code,
    d.department_name,
    d.building_name,
    d.budget,
    COUNT(DISTINCT p.program_id)       AS total_programs,
    COUNT(DISTINCT i.instructor_id)    AS total_instructors,
    COUNT(DISTINCT s.student_id)       AS total_students,
    SUM(CASE WHEN s.status = 'Active'
             THEN 1 ELSE 0 END)        AS active_students,
    COUNT(DISTINCT c.course_id)        AS total_courses
FROM department d
LEFT JOIN program    p ON d.department_id = p.department_id
LEFT JOIN instructor i ON d.department_id = i.department_id
LEFT JOIN student    s ON p.program_id    = s.program_id
LEFT JOIN course     c ON d.department_id = c.department_id
GROUP BY
    d.department_id, d.department_code,
    d.department_name, d.building_name, d.budget
ORDER BY d.department_name;


-- ============================================================
--  VIEW 6 : vw_student_fee_summary
--  Financial snapshot per student: balance, total paid,
--  total due and invoice breakdown by status.
--  Usage : SELECT * FROM vw_student_fee_summary
--          WHERE overdue_invoices > 0;
-- ============================================================
CREATE VIEW vw_student_fee_summary AS
SELECT
    s.student_id,
    s.registration_no,
    CONCAT(s.first_name, ' ', s.last_name)      AS student_name,
    p.program_name,
    d.department_name,
    COALESCE(sfa.current_balance, 0)            AS current_balance,
    COALESCE(sfa.total_paid, 0)                 AS total_paid,
    COALESCE(sfa.total_due, 0)                  AS total_due,
    COUNT(DISTINCT inv.invoice_id)              AS total_invoices,
    SUM(CASE WHEN inv.status = 'Paid'
             THEN 1 ELSE 0 END)                 AS paid_invoices,
    SUM(CASE WHEN inv.status = 'Overdue'
             THEN 1 ELSE 0 END)                 AS overdue_invoices,
    SUM(CASE WHEN inv.status IN ('Pending','Partially Paid')
             THEN 1 ELSE 0 END)                 AS pending_invoices,
    COALESCE(SUM(inv.total_amount), 0)          AS total_invoiced
FROM student s
JOIN program              p   ON s.program_id  = p.program_id
JOIN department           d   ON p.department_id = d.department_id
LEFT JOIN student_fee_account sfa ON s.student_id = sfa.student_id
LEFT JOIN invoice             inv ON s.student_id = inv.student_id
GROUP BY
    s.student_id, s.registration_no,
    s.first_name, s.last_name,
    p.program_name, d.department_name,
    sfa.current_balance, sfa.total_paid, sfa.total_due
ORDER BY s.registration_no;


-- ============================================================
--  VIEW 7 : vw_library_book_availability
--  Every book with its total copies, how many are available,
--  issued, reserved, damaged or lost.
--  Usage : SELECT * FROM vw_library_book_availability
--          WHERE available_copies > 0;
-- ============================================================
CREATE VIEW vw_library_book_availability AS
SELECT
    b.book_id,
    b.isbn,
    b.title,
    b.edition,
    b.publication_year,
    bc_cat.category_name,
    pub.publisher_name,
    GROUP_CONCAT(
        CONCAT(a.first_name, ' ', a.last_name)
        ORDER BY a.last_name SEPARATOR ', '
    )                                           AS authors,
    COUNT(bc.copy_id)                           AS total_copies,
    SUM(CASE WHEN bc.status = 'Available'  THEN 1 ELSE 0 END) AS available_copies,
    SUM(CASE WHEN bc.status = 'Issued'     THEN 1 ELSE 0 END) AS issued_copies,
    SUM(CASE WHEN bc.status = 'Reserved'   THEN 1 ELSE 0 END) AS reserved_copies,
    SUM(CASE WHEN bc.status = 'Damaged'    THEN 1 ELSE 0 END) AS damaged_copies,
    SUM(CASE WHEN bc.status = 'Lost'       THEN 1 ELSE 0 END) AS lost_copies
FROM book b
LEFT JOIN book_category bc_cat ON b.category_id   = bc_cat.category_id
LEFT JOIN publisher     pub    ON b.publisher_id   = pub.publisher_id
LEFT JOIN book_copy     bc     ON b.book_id        = bc.book_id
LEFT JOIN book_author   ba     ON b.book_id        = ba.book_id
LEFT JOIN author        a      ON ba.author_id     = a.author_id
GROUP BY
    b.book_id, b.isbn, b.title, b.edition,
    b.publication_year, bc_cat.category_name, pub.publisher_name
ORDER BY b.title;


-- ============================================================
--  VIEW 8 : vw_attendance_summary
--  Per-student, per-section attendance percentage with a
--  shortfall flag for students below 75 %.
--  Usage : SELECT * FROM vw_attendance_summary
--          WHERE attendance_percentage < 75;
-- ============================================================
CREATE VIEW vw_attendance_summary AS
SELECT
    s.student_id,
    s.registration_no,
    CONCAT(s.first_name, ' ', s.last_name)      AS student_name,
    acad.session_name,
    sm.semester_name,
    c.course_code,
    c.course_title,
    sec.section_name,
    COUNT(a.attendance_id)                      AS total_classes,
    SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) AS present_count,
    SUM(CASE WHEN a.status = 'Absent'  THEN 1 ELSE 0 END) AS absent_count,
    SUM(CASE WHEN a.status = 'Late'    THEN 1 ELSE 0 END) AS late_count,
    SUM(CASE WHEN a.status = 'Excused' THEN 1 ELSE 0 END) AS excused_count,
    ROUND(
        SUM(CASE WHEN a.status IN ('Present','Late') THEN 1 ELSE 0 END)
        * 100.0 / NULLIF(COUNT(a.attendance_id), 0), 2
    )                                           AS attendance_percentage,
    CASE
        WHEN ROUND(
            SUM(CASE WHEN a.status IN ('Present','Late') THEN 1 ELSE 0 END)
            * 100.0 / NULLIF(COUNT(a.attendance_id), 0), 2
        ) < 75 THEN 'SHORTAGE'
        ELSE 'OK'
    END                                         AS attendance_status
FROM attendance a
JOIN student          s    ON a.student_id   = s.student_id
JOIN section          sec  ON a.section_id   = sec.section_id
JOIN course           c    ON sec.course_id  = c.course_id
JOIN semester         sm   ON sec.semester_id = sm.semester_id
JOIN academic_session acad ON sm.session_id  = acad.session_id
GROUP BY
    s.student_id, s.registration_no,
    s.first_name, s.last_name,
    acad.session_name, sm.semester_name,
    c.course_code, c.course_title, sec.section_name
ORDER BY s.registration_no, sm.semester_name, c.course_code;


-- ============================================================
--  VIEW 9 : vw_instructor_workload
--  Per-instructor, per-semester summary of sections assigned,
--  total credit hours taught and number of students.
--  Usage : SELECT * FROM vw_instructor_workload
--          WHERE session_name = '2024-2025'
--          ORDER BY total_credit_hours DESC;
-- ============================================================
CREATE VIEW vw_instructor_workload AS
SELECT
    i.instructor_id,
    i.employee_no,
    CONCAT(i.first_name, ' ', i.last_name)      AS instructor_name,
    i.designation,
    i.email,
    d.department_name,
    acad.session_name,
    sm.semester_name,
    COUNT(DISTINCT sec.section_id)              AS sections_assigned,
    COALESCE(SUM(c.credit_hours), 0)            AS total_credit_hours,
    COUNT(DISTINCT e.student_id)                AS total_students_taught
FROM instructor i
JOIN department       d    ON i.department_id  = d.department_id
LEFT JOIN section     sec  ON i.instructor_id  = sec.instructor_id
LEFT JOIN course      c    ON sec.course_id    = c.course_id
LEFT JOIN semester    sm   ON sec.semester_id  = sm.semester_id
LEFT JOIN academic_session acad ON sm.session_id = acad.session_id
LEFT JOIN enrollment  e    ON sec.section_id   = e.section_id
GROUP BY
    i.instructor_id, i.employee_no,
    i.first_name, i.last_name,
    i.designation, i.email, d.department_name,
    acad.session_name, sm.semester_name
ORDER BY d.department_name, i.last_name, acad.session_name;


-- ============================================================
--  VIEW 10 : vw_hostel_occupancy
--  Hostel → block → room → bed breakdown showing current
--  occupancy counts and free bed availability.
--  Usage : SELECT * FROM vw_hostel_occupancy
--          WHERE available_beds > 0 AND hostel_type = 'Male';
-- ============================================================
CREATE VIEW vw_hostel_occupancy AS
SELECT
    h.hostel_id,
    h.hostel_name,
    h.hostel_type,
    hb.block_id,
    hb.block_name,
    hr.room_id,
    hr.room_number,
    hr.room_type,
    hr.capacity                                 AS room_capacity,
    COUNT(b.bed_id)                             AS total_beds,
    SUM(CASE WHEN b.status = 'Available' THEN 1 ELSE 0 END) AS available_beds,
    SUM(CASE WHEN b.status = 'Occupied'  THEN 1 ELSE 0 END) AS occupied_beds,
    SUM(CASE WHEN b.status = 'Reserved'  THEN 1 ELSE 0 END) AS reserved_beds,
    ROUND(
        SUM(CASE WHEN b.status = 'Occupied' THEN 1 ELSE 0 END)
        * 100.0 / NULLIF(COUNT(b.bed_id), 0), 2
    )                                           AS occupancy_percentage
FROM hostel h
JOIN hostel_block hb ON h.hostel_id  = hb.hostel_id
JOIN hostel_room  hr ON hb.block_id  = hr.block_id
LEFT JOIN bed     b  ON hr.room_id   = b.room_id
GROUP BY
    h.hostel_id, h.hostel_name, h.hostel_type,
    hb.block_id, hb.block_name,
    hr.room_id, hr.room_number, hr.room_type, hr.capacity
ORDER BY h.hostel_name, hb.block_name, hr.room_number;
