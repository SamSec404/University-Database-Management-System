-- =====================================================
-- UNIVERSITY ERP SYSTEM
-- MySQL 8.0
-- =====================================================

DROP DATABASE IF EXISTS university_erp;
CREATE DATABASE university_erp;
USE university_erp;

-- =====================================================
-- DEPARTMENT
-- =====================================================

CREATE TABLE department (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_code VARCHAR(10) NOT NULL UNIQUE,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    building_name VARCHAR(100),
    budget DECIMAL(15,2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- PROGRAM
-- =====================================================

CREATE TABLE program (
    program_id INT AUTO_INCREMENT PRIMARY KEY,
    department_id INT NOT NULL,
    program_code VARCHAR(20) UNIQUE,
    program_name VARCHAR(100) NOT NULL,
    degree_level ENUM('BS','MS','PhD') NOT NULL,
    duration_years INT NOT NULL,
    total_credit_hours INT NOT NULL,
    FOREIGN KEY (department_id)
        REFERENCES department(department_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE INDEX idx_program_department
ON program(department_id);

-- =====================================================
-- ACADEMIC SESSION
-- =====================================================

CREATE TABLE academic_session (
    session_id INT AUTO_INCREMENT PRIMARY KEY,
    session_name VARCHAR(50) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    CHECK (end_date > start_date)
);

-- =====================================================
-- SEMESTER
-- =====================================================

CREATE TABLE semester (
    semester_id INT AUTO_INCREMENT PRIMARY KEY,
    session_id INT NOT NULL,
    semester_name ENUM('Spring','Summer','Fall') NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,

    FOREIGN KEY (session_id)
        REFERENCES academic_session(session_id)
        ON DELETE CASCADE
);

CREATE INDEX idx_semester_session
ON semester(session_id);

-- =====================================================
-- STUDENT
-- =====================================================

CREATE TABLE student (
    student_id INT AUTO_INCREMENT PRIMARY KEY,

    registration_no VARCHAR(25) UNIQUE NOT NULL,

    program_id INT NOT NULL,

    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,

    gender ENUM('Male','Female','Other'),

    date_of_birth DATE,

    email VARCHAR(120) UNIQUE,
    phone VARCHAR(20),

    cnic VARCHAR(20) UNIQUE,

    blood_group VARCHAR(5),

    nationality VARCHAR(50),

    admission_date DATE NOT NULL,

    cgpa DECIMAL(4,2) DEFAULT 0.00,

    status ENUM(
        'Active',
        'Graduated',
        'Suspended',
        'Dropped'
    ) DEFAULT 'Active',

    FOREIGN KEY (program_id)
        REFERENCES program(program_id)
);

CREATE INDEX idx_student_program
ON student(program_id);

-- =====================================================
-- STUDENT ADDRESS
-- =====================================================

CREATE TABLE student_address (

    address_id INT AUTO_INCREMENT PRIMARY KEY,

    student_id INT NOT NULL,

    address_type ENUM(
        'Permanent',
        'Current'
    ) NOT NULL,

    country VARCHAR(50),
    province VARCHAR(50),
    city VARCHAR(50),

    postal_code VARCHAR(20),

    street_address VARCHAR(255),

    FOREIGN KEY(student_id)
        REFERENCES student(student_id)
        ON DELETE CASCADE
);

CREATE INDEX idx_student_address_student
ON student_address(student_id);

-- =====================================================
-- STUDENT GUARDIAN
-- =====================================================

CREATE TABLE student_guardian (

    guardian_id INT AUTO_INCREMENT PRIMARY KEY,

    student_id INT NOT NULL,

    guardian_name VARCHAR(100) NOT NULL,

    relationship_type VARCHAR(50),

    phone VARCHAR(20),

    occupation VARCHAR(100),

    FOREIGN KEY(student_id)
        REFERENCES student(student_id)
        ON DELETE CASCADE
);

-- =====================================================
-- STUDENT DOCUMENT
-- =====================================================

CREATE TABLE student_document (

    document_id INT AUTO_INCREMENT PRIMARY KEY,

    student_id INT NOT NULL,

    document_type VARCHAR(50),

    document_path VARCHAR(255),

    verification_status ENUM(
        'Pending',
        'Verified',
        'Rejected'
    ) DEFAULT 'Pending',

    FOREIGN KEY(student_id)
        REFERENCES student(student_id)
        ON DELETE CASCADE
);

-- =====================================================
-- INSTRUCTOR
-- =====================================================

CREATE TABLE instructor (

    instructor_id INT AUTO_INCREMENT PRIMARY KEY,

    department_id INT,

    employee_no VARCHAR(20) UNIQUE,

    first_name VARCHAR(50) NOT NULL,

    last_name VARCHAR(50) NOT NULL,

    email VARCHAR(100) UNIQUE,

    phone VARCHAR(20),

    designation VARCHAR(100),

    salary DECIMAL(12,2),

    hire_date DATE,

    FOREIGN KEY(department_id)
        REFERENCES department(department_id)
);

CREATE INDEX idx_instructor_department
ON instructor(department_id);

-- =====================================================
-- FACULTY QUALIFICATION
-- =====================================================

CREATE TABLE faculty_qualification (

    qualification_id INT AUTO_INCREMENT PRIMARY KEY,

    instructor_id INT NOT NULL,

    degree_name VARCHAR(100),

    institution VARCHAR(150),

    completion_year YEAR,

    FOREIGN KEY(instructor_id)
        REFERENCES instructor(instructor_id)
        ON DELETE CASCADE
);

-- =====================================================
-- FACULTY PUBLICATION
-- =====================================================

CREATE TABLE faculty_publication (

    publication_id INT AUTO_INCREMENT PRIMARY KEY,

    instructor_id INT NOT NULL,

    title VARCHAR(255),

    journal_name VARCHAR(255),

    publication_year YEAR,

    FOREIGN KEY(instructor_id)
        REFERENCES instructor(instructor_id)
        ON DELETE CASCADE
);

-- =====================================================
-- BUILDING
-- =====================================================

CREATE TABLE building (

    building_id INT AUTO_INCREMENT PRIMARY KEY,

    building_name VARCHAR(100) UNIQUE,

    total_floors INT
);

-- =====================================================
-- CLASSROOM
-- =====================================================

CREATE TABLE classroom (

    classroom_id INT AUTO_INCREMENT PRIMARY KEY,

    building_id INT NOT NULL,

    room_number VARCHAR(20),

    capacity INT NOT NULL,

    FOREIGN KEY(building_id)
        REFERENCES building(building_id)
);

-- =====================================================
-- TIME SLOT
-- =====================================================

CREATE TABLE time_slot (

    time_slot_id INT AUTO_INCREMENT PRIMARY KEY,

    day_of_week ENUM(
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday'
    ),

    start_time TIME,

    end_time TIME,

    CHECK(end_time > start_time)
);

-- =====================================================
-- COURSE
-- =====================================================

CREATE TABLE course (

    course_id INT AUTO_INCREMENT PRIMARY KEY,

    department_id INT NOT NULL,

    course_code VARCHAR(20) UNIQUE,

    course_title VARCHAR(200),

    credit_hours INT,

    description TEXT,

    FOREIGN KEY(department_id)
        REFERENCES department(department_id)
);

CREATE INDEX idx_course_department
ON course(department_id);

-- =====================================================
-- COURSE OUTCOME
-- =====================================================

CREATE TABLE course_outcome (

    outcome_id INT AUTO_INCREMENT PRIMARY KEY,

    course_id INT NOT NULL,

    outcome_description TEXT,

    FOREIGN KEY(course_id)
        REFERENCES course(course_id)
        ON DELETE CASCADE
);

-- =====================================================
-- PREREQUISITE
-- =====================================================

CREATE TABLE prerequisite (

    course_id INT NOT NULL,

    prerequisite_course_id INT NOT NULL,

    PRIMARY KEY(
        course_id,
        prerequisite_course_id
    ),

    FOREIGN KEY(course_id)
        REFERENCES course(course_id)
        ON DELETE CASCADE,

    FOREIGN KEY(prerequisite_course_id)
        REFERENCES course(course_id)
        ON DELETE CASCADE
);

-- =====================================================
-- SECTION
-- =====================================================

CREATE TABLE section (

    section_id INT AUTO_INCREMENT PRIMARY KEY,

    course_id INT NOT NULL,

    instructor_id INT,

    semester_id INT NOT NULL,

    classroom_id INT,

    time_slot_id INT,

    section_name VARCHAR(20),

    capacity INT DEFAULT 40,

    FOREIGN KEY(course_id)
        REFERENCES course(course_id),

    FOREIGN KEY(instructor_id)
        REFERENCES instructor(instructor_id),

    FOREIGN KEY(semester_id)
        REFERENCES semester(semester_id),

    FOREIGN KEY(classroom_id)
        REFERENCES classroom(classroom_id),

    FOREIGN KEY(time_slot_id)
        REFERENCES time_slot(time_slot_id)
);

-- =====================================================
-- ENROLLMENT
-- =====================================================

CREATE TABLE enrollment (

    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,

    student_id INT NOT NULL,

    section_id INT NOT NULL,

    enrollment_date DATE NOT NULL,

    grade VARCHAR(5),

    UNIQUE(student_id, section_id),

    FOREIGN KEY(student_id)
        REFERENCES student(student_id)
        ON DELETE CASCADE,

    FOREIGN KEY(section_id)
        REFERENCES section(section_id)
        ON DELETE CASCADE
);

-- =====================================================
-- ATTENDANCE
-- =====================================================

CREATE TABLE attendance (

    attendance_id INT AUTO_INCREMENT PRIMARY KEY,

    student_id INT NOT NULL,

    section_id INT NOT NULL,

    attendance_date DATE NOT NULL,

    status ENUM(
        'Present',
        'Absent',
        'Late',
        'Excused'
    ) NOT NULL,

    FOREIGN KEY(student_id)
        REFERENCES student(student_id)
        ON DELETE CASCADE,

    FOREIGN KEY(section_id)
        REFERENCES section(section_id)
        ON DELETE CASCADE
);

CREATE INDEX idx_attendance_student
ON attendance(student_id);

CREATE INDEX idx_attendance_section
ON attendance(section_id);


CREATE TABLE assignment (

    assignment_id INT AUTO_INCREMENT PRIMARY KEY,

    section_id INT NOT NULL,

    title VARCHAR(200) NOT NULL,

    description TEXT,

    total_marks DECIMAL(5,2) NOT NULL,

    assigned_date DATE NOT NULL,

    due_date DATE NOT NULL,

    weightage DECIMAL(5,2) DEFAULT 0,

    FOREIGN KEY(section_id)
        REFERENCES section(section_id)
        ON DELETE CASCADE,

    CHECK(total_marks > 0),

    CHECK(due_date >= assigned_date)
);

CREATE TABLE assignment_submission (

    submission_id INT AUTO_INCREMENT PRIMARY KEY,

    assignment_id INT NOT NULL,

    student_id INT NOT NULL,

    submission_date DATETIME,

    marks_obtained DECIMAL(5,2),

    remarks TEXT,

    status ENUM(
        'Submitted',
        'Late',
        'Missing'
    ) DEFAULT 'Missing',

    UNIQUE(assignment_id,student_id),

    FOREIGN KEY(assignment_id)
        REFERENCES assignment(assignment_id)
        ON DELETE CASCADE,

    FOREIGN KEY(student_id)
        REFERENCES student(student_id)
        ON DELETE CASCADE
);

CREATE TABLE quiz (

    quiz_id INT AUTO_INCREMENT PRIMARY KEY,

    section_id INT NOT NULL,

    title VARCHAR(150),

    quiz_date DATE NOT NULL,

    total_marks DECIMAL(5,2) NOT NULL,

    weightage DECIMAL(5,2) DEFAULT 0,

    FOREIGN KEY(section_id)
        REFERENCES section(section_id)
        ON DELETE CASCADE
);

CREATE TABLE quiz_result (

    quiz_result_id INT AUTO_INCREMENT PRIMARY KEY,

    quiz_id INT NOT NULL,

    student_id INT NOT NULL,

    obtained_marks DECIMAL(5,2),

    remarks TEXT,

    UNIQUE(quiz_id,student_id),

    FOREIGN KEY(quiz_id)
        REFERENCES quiz(quiz_id)
        ON DELETE CASCADE,

    FOREIGN KEY(student_id)
        REFERENCES student(student_id)
        ON DELETE CASCADE
);

CREATE TABLE exam (

    exam_id INT AUTO_INCREMENT PRIMARY KEY,

    section_id INT NOT NULL,

    exam_type ENUM(
        'Midterm',
        'Final',
        'Practical',
        'Project',
        'Viva'
    ) NOT NULL,

    exam_date DATE NOT NULL,

    total_marks DECIMAL(5,2) NOT NULL,

    weightage DECIMAL(5,2) DEFAULT 0,

    FOREIGN KEY(section_id)
        REFERENCES section(section_id)
        ON DELETE CASCADE
);

CREATE TABLE exam_result (

    result_id INT AUTO_INCREMENT PRIMARY KEY,

    exam_id INT NOT NULL,

    student_id INT NOT NULL,

    obtained_marks DECIMAL(5,2),

    grade VARCHAR(5),

    remarks TEXT,

    UNIQUE(exam_id,student_id),

    FOREIGN KEY(exam_id)
        REFERENCES exam(exam_id)
        ON DELETE CASCADE,

    FOREIGN KEY(student_id)
        REFERENCES student(student_id)
        ON DELETE CASCADE
);

CREATE TABLE gradebook (

    gradebook_id INT AUTO_INCREMENT PRIMARY KEY,

    student_id INT NOT NULL,

    section_id INT NOT NULL,

    assignment_score DECIMAL(6,2),

    quiz_score DECIMAL(6,2),

    midterm_score DECIMAL(6,2),

    final_score DECIMAL(6,2),

    total_score DECIMAL(6,2),

    letter_grade VARCHAR(5),

    grade_points DECIMAL(3,2),

    FOREIGN KEY(student_id)
        REFERENCES student(student_id)
        ON DELETE CASCADE,

    FOREIGN KEY(section_id)
        REFERENCES section(section_id)
        ON DELETE CASCADE,

    UNIQUE(student_id,section_id)
);

CREATE TABLE transcript (

    transcript_id INT AUTO_INCREMENT PRIMARY KEY,

    student_id INT NOT NULL,

    semester_id INT NOT NULL,

    generated_date DATE NOT NULL,

    semester_gpa DECIMAL(4,2),

    cumulative_gpa DECIMAL(4,2),

    remarks VARCHAR(255),

    FOREIGN KEY(student_id)
        REFERENCES student(student_id),

    FOREIGN KEY(semester_id)
        REFERENCES semester(semester_id)
);

CREATE TABLE course_registration (

    registration_id INT AUTO_INCREMENT PRIMARY KEY,

    student_id INT NOT NULL,

    semester_id INT NOT NULL,

    registration_date DATE NOT NULL,

    status ENUM(
        'Pending',
        'Approved',
        'Rejected'
    ) DEFAULT 'Pending',

    FOREIGN KEY(student_id)
        REFERENCES student(student_id),

    FOREIGN KEY(semester_id)
        REFERENCES semester(semester_id)
);

CREATE TABLE registration_detail (

    detail_id INT AUTO_INCREMENT PRIMARY KEY,

    registration_id INT NOT NULL,

    section_id INT NOT NULL,

    FOREIGN KEY(registration_id)
        REFERENCES course_registration(registration_id)
        ON DELETE CASCADE,

    FOREIGN KEY(section_id)
        REFERENCES section(section_id)
        ON DELETE CASCADE
);

CREATE TABLE academic_advisor (

    advisor_id INT AUTO_INCREMENT PRIMARY KEY,

    student_id INT NOT NULL,

    instructor_id INT NOT NULL,

    assigned_date DATE NOT NULL,

    FOREIGN KEY(student_id)
        REFERENCES student(student_id)
        ON DELETE CASCADE,

    FOREIGN KEY(instructor_id)
        REFERENCES instructor(instructor_id)
        ON DELETE CASCADE
);

CREATE TABLE course_evaluation (

    evaluation_id INT AUTO_INCREMENT PRIMARY KEY,

    student_id INT NOT NULL,

    section_id INT NOT NULL,

    rating INT CHECK(rating BETWEEN 1 AND 5),

    comments TEXT,

    evaluation_date DATE,

    FOREIGN KEY(student_id)
        REFERENCES student(student_id)
        ON DELETE CASCADE,

    FOREIGN KEY(section_id)
        REFERENCES section(section_id)
        ON DELETE CASCADE
);

CREATE INDEX idx_exam_student
ON exam_result(student_id);

CREATE INDEX idx_quiz_student
ON quiz_result(student_id);

CREATE INDEX idx_assignment_student
ON assignment_submission(student_id);

CREATE INDEX idx_gradebook_student
ON gradebook(student_id);

CREATE INDEX idx_transcript_student
ON transcript(student_id);




CREATE TABLE fee_category (

    category_id INT AUTO_INCREMENT PRIMARY KEY,

    category_name VARCHAR(100) NOT NULL UNIQUE,

    description TEXT
);

CREATE TABLE fee_structure (

    fee_structure_id INT AUTO_INCREMENT PRIMARY KEY,

    program_id INT NOT NULL,

    category_id INT NOT NULL,

    amount DECIMAL(12,2) NOT NULL,

    effective_date DATE NOT NULL,

    FOREIGN KEY(program_id)
        REFERENCES program(program_id),

    FOREIGN KEY(category_id)
        REFERENCES fee_category(category_id)
);

CREATE TABLE student_fee_account (

    account_id INT AUTO_INCREMENT PRIMARY KEY,

    student_id INT NOT NULL UNIQUE,

    current_balance DECIMAL(12,2) DEFAULT 0,

    total_paid DECIMAL(12,2) DEFAULT 0,

    total_due DECIMAL(12,2) DEFAULT 0,

    FOREIGN KEY(student_id)
        REFERENCES student(student_id)
        ON DELETE CASCADE
);

CREATE TABLE invoice (

    invoice_id INT AUTO_INCREMENT PRIMARY KEY,

    student_id INT NOT NULL,

    semester_id INT NOT NULL,

    invoice_date DATE NOT NULL,

    due_date DATE NOT NULL,

    total_amount DECIMAL(12,2) NOT NULL,

    status ENUM(
        'Pending',
        'Partially Paid',
        'Paid',
        'Overdue'
    ) DEFAULT 'Pending',

    FOREIGN KEY(student_id)
        REFERENCES student(student_id),

    FOREIGN KEY(semester_id)
        REFERENCES semester(semester_id)
);

CREATE TABLE invoice_detail (

    invoice_detail_id INT AUTO_INCREMENT PRIMARY KEY,

    invoice_id INT NOT NULL,

    category_id INT NOT NULL,

    amount DECIMAL(12,2) NOT NULL,

    FOREIGN KEY(invoice_id)
        REFERENCES invoice(invoice_id)
        ON DELETE CASCADE,

    FOREIGN KEY(category_id)
        REFERENCES fee_category(category_id)
);

CREATE TABLE payment (

    payment_id INT AUTO_INCREMENT PRIMARY KEY,

    invoice_id INT NOT NULL,

    payment_date DATETIME NOT NULL,

    amount_paid DECIMAL(12,2) NOT NULL,

    payment_method ENUM(
        'Cash',
        'Bank Transfer',
        'Credit Card',
        'Debit Card',
        'Online Payment'
    ),

    reference_number VARCHAR(100),

    FOREIGN KEY(invoice_id)
        REFERENCES invoice(invoice_id)
);

CREATE TABLE payment_transaction (

    transaction_id INT AUTO_INCREMENT PRIMARY KEY,

    payment_id INT NOT NULL,

    gateway_name VARCHAR(100),

    transaction_reference VARCHAR(100),

    transaction_status ENUM(
        'Pending',
        'Successful',
        'Failed'
    ),

    FOREIGN KEY(payment_id)
        REFERENCES payment(payment_id)
        ON DELETE CASCADE
);

CREATE TABLE scholarship (

    scholarship_id INT AUTO_INCREMENT PRIMARY KEY,

    scholarship_name VARCHAR(150) NOT NULL,

    sponsor VARCHAR(150),

    scholarship_type ENUM(
        'Merit',
        'Need Based',
        'Sports',
        'Research',
        'Other'
    ),

    amount DECIMAL(12,2)
);

CREATE TABLE student_scholarship (

    student_scholarship_id INT AUTO_INCREMENT PRIMARY KEY,

    student_id INT NOT NULL,

    scholarship_id INT NOT NULL,

    award_date DATE,

    status ENUM(
        'Active',
        'Expired',
        'Cancelled'
    ) DEFAULT 'Active',

    FOREIGN KEY(student_id)
        REFERENCES student(student_id),

    FOREIGN KEY(scholarship_id)
        REFERENCES scholarship(scholarship_id)
);

CREATE TABLE financial_aid (

    aid_id INT AUTO_INCREMENT PRIMARY KEY,

    student_id INT NOT NULL,

    aid_type ENUM(
        'Loan',
        'Grant',
        'Emergency Fund'
    ),

    amount DECIMAL(12,2),

    approval_date DATE,

    FOREIGN KEY(student_id)
        REFERENCES student(student_id)
);

CREATE TABLE installment_plan (

    installment_id INT AUTO_INCREMENT PRIMARY KEY,

    invoice_id INT NOT NULL,

    installment_number INT NOT NULL,

    due_date DATE NOT NULL,

    amount DECIMAL(12,2) NOT NULL,

    status ENUM(
        'Pending',
        'Paid',
        'Overdue'
    ) DEFAULT 'Pending',

    FOREIGN KEY(invoice_id)
        REFERENCES invoice(invoice_id)
        ON DELETE CASCADE
);

CREATE TABLE refund (

    refund_id INT AUTO_INCREMENT PRIMARY KEY,

    student_id INT NOT NULL,

    invoice_id INT,

    refund_amount DECIMAL(12,2),

    refund_date DATE,

    reason TEXT,

    FOREIGN KEY(student_id)
        REFERENCES student(student_id),

    FOREIGN KEY(invoice_id)
        REFERENCES invoice(invoice_id)
);

CREATE TABLE late_fee_penalty (

    penalty_id INT AUTO_INCREMENT PRIMARY KEY,

    invoice_id INT NOT NULL,

    penalty_amount DECIMAL(12,2),

    penalty_date DATE,

    reason VARCHAR(255),

    FOREIGN KEY(invoice_id)
        REFERENCES invoice(invoice_id)
        ON DELETE CASCADE
);

CREATE TABLE financial_ledger (

    ledger_id INT AUTO_INCREMENT PRIMARY KEY,

    student_id INT NOT NULL,

    transaction_date DATETIME NOT NULL,

    transaction_type ENUM(
        'Invoice',
        'Payment',
        'Scholarship',
        'Refund',
        'Penalty'
    ),

    amount DECIMAL(12,2),

    description TEXT,

    FOREIGN KEY(student_id)
        REFERENCES student(student_id)
);

CREATE INDEX idx_invoice_student
ON invoice(student_id);

CREATE INDEX idx_payment_invoice
ON payment(invoice_id);

CREATE INDEX idx_scholarship_student
ON student_scholarship(student_id);

CREATE INDEX idx_financial_ledger_student
ON financial_ledger(student_id);




CREATE TABLE book_category (

    category_id INT AUTO_INCREMENT PRIMARY KEY,

    category_name VARCHAR(100) NOT NULL UNIQUE,

    description TEXT
);

CREATE TABLE author (

    author_id INT AUTO_INCREMENT PRIMARY KEY,

    first_name VARCHAR(100),

    last_name VARCHAR(100),

    nationality VARCHAR(100),

    date_of_birth DATE
);

CREATE TABLE publisher (

    publisher_id INT AUTO_INCREMENT PRIMARY KEY,

    publisher_name VARCHAR(200) NOT NULL,

    country VARCHAR(100),

    website VARCHAR(255)
);

CREATE TABLE book (

    book_id INT AUTO_INCREMENT PRIMARY KEY,

    category_id INT,

    publisher_id INT,

    isbn VARCHAR(20) UNIQUE,

    title VARCHAR(255) NOT NULL,

    edition VARCHAR(50),

    publication_year YEAR,

    language VARCHAR(50),

    total_pages INT,

    FOREIGN KEY(category_id)
        REFERENCES book_category(category_id),

    FOREIGN KEY(publisher_id)
        REFERENCES publisher(publisher_id)
);

CREATE TABLE book_author (

    book_id INT NOT NULL,

    author_id INT NOT NULL,

    PRIMARY KEY(book_id,author_id),

    FOREIGN KEY(book_id)
        REFERENCES book(book_id)
        ON DELETE CASCADE,

    FOREIGN KEY(author_id)
        REFERENCES author(author_id)
        ON DELETE CASCADE
);

CREATE TABLE book_copy (

    copy_id INT AUTO_INCREMENT PRIMARY KEY,

    book_id INT NOT NULL,

    barcode VARCHAR(100) UNIQUE,

    acquisition_date DATE,

    shelf_location VARCHAR(100),

    status ENUM(
        'Available',
        'Issued',
        'Lost',
        'Damaged',
        'Reserved'
    ) DEFAULT 'Available',

    FOREIGN KEY(book_id)
        REFERENCES book(book_id)
        ON DELETE CASCADE
);

CREATE TABLE library_member (

    member_id INT AUTO_INCREMENT PRIMARY KEY,

    student_id INT NULL,

    instructor_id INT NULL,

    membership_date DATE NOT NULL,

    expiry_date DATE NOT NULL,

    status ENUM(
        'Active',
        'Expired',
        'Suspended'
    ) DEFAULT 'Active',

    FOREIGN KEY(student_id)
        REFERENCES student(student_id),

    FOREIGN KEY(instructor_id)
        REFERENCES instructor(instructor_id)
);

CREATE TABLE book_issue (

    issue_id INT AUTO_INCREMENT PRIMARY KEY,

    copy_id INT NOT NULL,

    member_id INT NOT NULL,

    issue_date DATE NOT NULL,

    due_date DATE NOT NULL,

    FOREIGN KEY(copy_id)
        REFERENCES book_copy(copy_id),

    FOREIGN KEY(member_id)
        REFERENCES library_member(member_id)
);

CREATE TABLE book_return (

    return_id INT AUTO_INCREMENT PRIMARY KEY,

    issue_id INT NOT NULL,

    return_date DATE NOT NULL,

    remarks TEXT,

    FOREIGN KEY(issue_id)
        REFERENCES book_issue(issue_id)
);

CREATE TABLE library_fine (

    fine_id INT AUTO_INCREMENT PRIMARY KEY,

    issue_id INT NOT NULL,

    amount DECIMAL(10,2) NOT NULL,

    fine_reason VARCHAR(255),

    paid_status ENUM(
        'Paid',
        'Unpaid'
    ) DEFAULT 'Unpaid',

    FOREIGN KEY(issue_id)
        REFERENCES book_issue(issue_id)
);

CREATE TABLE book_reservation (

    reservation_id INT AUTO_INCREMENT PRIMARY KEY,

    member_id INT NOT NULL,

    book_id INT NOT NULL,

    reservation_date DATE NOT NULL,

    status ENUM(
        'Pending',
        'Fulfilled',
        'Cancelled'
    ) DEFAULT 'Pending',

    FOREIGN KEY(member_id)
        REFERENCES library_member(member_id),

    FOREIGN KEY(book_id)
        REFERENCES book(book_id)
);

CREATE TABLE digital_resource (

    resource_id INT AUTO_INCREMENT PRIMARY KEY,

    title VARCHAR(255) NOT NULL,

    resource_type ENUM(
        'EBook',
        'Research Paper',
        'Thesis',
        'Journal',
        'Video Lecture'
    ),

    file_url VARCHAR(500),

    upload_date DATE
);

CREATE TABLE library_staff (

    librarian_id INT AUTO_INCREMENT PRIMARY KEY,

    employee_id INT NOT NULL UNIQUE,

    designation VARCHAR(100),

    FOREIGN KEY(employee_id)
        REFERENCES employee(employee_id)
);

CREATE TABLE reading_room (

    room_id INT AUTO_INCREMENT PRIMARY KEY,

    room_name VARCHAR(100),

    capacity INT
);

CREATE TABLE reading_room_reservation (

    reservation_id INT AUTO_INCREMENT PRIMARY KEY,

    member_id INT NOT NULL,

    room_id INT NOT NULL,

    reservation_date DATE,

    start_time TIME,

    end_time TIME,

    FOREIGN KEY(member_id)
        REFERENCES library_member(member_id),

    FOREIGN KEY(room_id)
        REFERENCES reading_room(room_id)
);

CREATE TABLE book_donation (

    donation_id INT AUTO_INCREMENT PRIMARY KEY,

    donor_name VARCHAR(200),

    book_id INT,

    donation_date DATE,

    FOREIGN KEY(book_id)
        REFERENCES book(book_id)
);

CREATE INDEX idx_book_title
ON book(title);

CREATE INDEX idx_book_isbn
ON book(isbn);

CREATE INDEX idx_issue_member
ON book_issue(member_id);

CREATE INDEX idx_reservation_book
ON book_reservation(book_id);

CREATE INDEX idx_copy_status
ON book_copy(status);






CREATE TABLE hostel (

    hostel_id INT AUTO_INCREMENT PRIMARY KEY,

    hostel_name VARCHAR(100) NOT NULL,

    hostel_type ENUM(
        'Male',
        'Female',
        'Mixed'
    ),

    total_capacity INT,

    address VARCHAR(255)
);

CREATE TABLE hostel_block (

    block_id INT AUTO_INCREMENT PRIMARY KEY,

    hostel_id INT NOT NULL,

    block_name VARCHAR(50),

    number_of_floors INT,

    FOREIGN KEY(hostel_id)
        REFERENCES hostel(hostel_id)
        ON DELETE CASCADE
);

CREATE TABLE hostel_room (

    room_id INT AUTO_INCREMENT PRIMARY KEY,

    block_id INT NOT NULL,

    room_number VARCHAR(20),

    room_type ENUM(
        'Single',
        'Double',
        'Triple',
        'Quad'
    ),

    capacity INT,

    FOREIGN KEY(block_id)
        REFERENCES hostel_block(block_id)
        ON DELETE CASCADE
);

CREATE TABLE bed (

    bed_id INT AUTO_INCREMENT PRIMARY KEY,

    room_id INT NOT NULL,

    bed_number VARCHAR(20),

    status ENUM(
        'Available',
        'Occupied',
        'Reserved'
    ) DEFAULT 'Available',

    FOREIGN KEY(room_id)
        REFERENCES hostel_room(room_id)
        ON DELETE CASCADE
);

CREATE TABLE room_allocation (

    allocation_id INT AUTO_INCREMENT PRIMARY KEY,

    student_id INT NOT NULL,

    bed_id INT NOT NULL,

    allocation_date DATE NOT NULL,

    checkout_date DATE,

    status ENUM(
        'Active',
        'Completed',
        'Cancelled'
    ) DEFAULT 'Active',

    FOREIGN KEY(student_id)
        REFERENCES student(student_id),

    FOREIGN KEY(bed_id)
        REFERENCES bed(bed_id)
);

CREATE TABLE hostel_fee (

    hostel_fee_id INT AUTO_INCREMENT PRIMARY KEY,

    student_id INT NOT NULL,

    semester_id INT NOT NULL,

    amount DECIMAL(12,2),

    payment_status ENUM(
        'Pending',
        'Paid',
        'Partial'
    ) DEFAULT 'Pending',

    FOREIGN KEY(student_id)
        REFERENCES student(student_id),

    FOREIGN KEY(semester_id)
        REFERENCES semester(semester_id)
);

CREATE TABLE hostel_visitor (

    visitor_id INT AUTO_INCREMENT PRIMARY KEY,

    student_id INT NOT NULL,

    visitor_name VARCHAR(150),

    relationship_type VARCHAR(100),

    visit_date DATE,

    entry_time TIME,

    exit_time TIME,

    FOREIGN KEY(student_id)
        REFERENCES student(student_id)
);

CREATE TABLE hostel_complaint (

    complaint_id INT AUTO_INCREMENT PRIMARY KEY,

    student_id INT NOT NULL,

    complaint_type VARCHAR(100),

    description TEXT,

    complaint_date DATE,

    status ENUM(
        'Open',
        'In Progress',
        'Resolved',
        'Closed'
    ) DEFAULT 'Open',

    FOREIGN KEY(student_id)
        REFERENCES student(student_id)
);

CREATE TABLE maintenance_request (

    request_id INT AUTO_INCREMENT PRIMARY KEY,

    room_id INT NOT NULL,

    reported_by INT NOT NULL,

    issue_description TEXT,

    request_date DATE,

    status ENUM(
        'Pending',
        'Assigned',
        'Completed'
    ) DEFAULT 'Pending',

    FOREIGN KEY(room_id)
        REFERENCES hostel_room(room_id),

    FOREIGN KEY(reported_by)
        REFERENCES student(student_id)
);

CREATE TABLE hostel_staff (

    hostel_staff_id INT AUTO_INCREMENT PRIMARY KEY,

    employee_id INT NOT NULL UNIQUE,

    hostel_id INT NOT NULL,

    designation VARCHAR(100),

    FOREIGN KEY(employee_id)
        REFERENCES employee(employee_id),

    FOREIGN KEY(hostel_id)
        REFERENCES hostel(hostel_id)
);

CREATE TABLE mess (

    mess_id INT AUTO_INCREMENT PRIMARY KEY,

    hostel_id INT NOT NULL,

    mess_name VARCHAR(100),

    capacity INT,

    FOREIGN KEY(hostel_id)
        REFERENCES hostel(hostel_id)
);

CREATE TABLE meal_plan (

    meal_plan_id INT AUTO_INCREMENT PRIMARY KEY,

    mess_id INT NOT NULL,

    plan_name VARCHAR(100),

    monthly_fee DECIMAL(10,2),

    FOREIGN KEY(mess_id)
        REFERENCES mess(mess_id)
);

CREATE TABLE student_meal_plan (

    student_meal_plan_id INT AUTO_INCREMENT PRIMARY KEY,

    student_id INT NOT NULL,

    meal_plan_id INT NOT NULL,

    start_date DATE,

    end_date DATE,

    FOREIGN KEY(student_id)
        REFERENCES student(student_id),

    FOREIGN KEY(meal_plan_id)
        REFERENCES meal_plan(meal_plan_id)
);

CREATE TABLE hostel_inventory (

    inventory_id INT AUTO_INCREMENT PRIMARY KEY,

    hostel_id INT NOT NULL,

    item_name VARCHAR(150),

    quantity INT,

    purchase_date DATE,

    FOREIGN KEY(hostel_id)
        REFERENCES hostel(hostel_id)
);

CREATE TABLE inventory_issue (

    issue_id INT AUTO_INCREMENT PRIMARY KEY,

    inventory_id INT NOT NULL,

    issued_to VARCHAR(150),

    quantity INT,

    issue_date DATE,

    FOREIGN KEY(inventory_id)
        REFERENCES hostel_inventory(inventory_id)
);

CREATE INDEX idx_room_allocation_student
ON room_allocation(student_id);

CREATE INDEX idx_complaint_student
ON hostel_complaint(student_id);

CREATE INDEX idx_maintenance_room
ON maintenance_request(room_id);

CREATE INDEX idx_hostel_fee_student
ON hostel_fee(student_id);






CREATE TABLE vehicle (

    vehicle_id INT AUTO_INCREMENT PRIMARY KEY,

    vehicle_number VARCHAR(50) NOT NULL UNIQUE,

    vehicle_type ENUM(
        'Bus',
        'Van',
        'Coaster',
        'Mini Bus'
    ) NOT NULL,

    model VARCHAR(100),

    manufacturer VARCHAR(100),

    seating_capacity INT NOT NULL,

    purchase_date DATE,

    status ENUM(
        'Active',
        'Maintenance',
        'Retired'
    ) DEFAULT 'Active'
);

CREATE TABLE driver (

    driver_id INT AUTO_INCREMENT PRIMARY KEY,

    employee_id INT NOT NULL UNIQUE,

    license_number VARCHAR(100) NOT NULL UNIQUE,

    license_expiry DATE,

    experience_years INT,

    FOREIGN KEY(employee_id)
        REFERENCES employee(employee_id)
);

CREATE TABLE conductor (

    conductor_id INT AUTO_INCREMENT PRIMARY KEY,

    employee_id INT NOT NULL UNIQUE,

    FOREIGN KEY(employee_id)
        REFERENCES employee(employee_id)
);

CREATE TABLE transport_route (

    route_id INT AUTO_INCREMENT PRIMARY KEY,

    route_name VARCHAR(150) NOT NULL,

    route_description TEXT,

    estimated_distance_km DECIMAL(8,2)
);

CREATE TABLE bus_stop (

    stop_id INT AUTO_INCREMENT PRIMARY KEY,

    route_id INT NOT NULL,

    stop_name VARCHAR(150) NOT NULL,

    stop_order INT NOT NULL,

    arrival_time TIME,

    FOREIGN KEY(route_id)
        REFERENCES transport_route(route_id)
        ON DELETE CASCADE
);

CREATE TABLE vehicle_assignment (

    assignment_id INT AUTO_INCREMENT PRIMARY KEY,

    vehicle_id INT NOT NULL,

    driver_id INT NOT NULL,

    conductor_id INT,

    route_id INT NOT NULL,

    assignment_date DATE NOT NULL,

    FOREIGN KEY(vehicle_id)
        REFERENCES vehicle(vehicle_id),

    FOREIGN KEY(driver_id)
        REFERENCES driver(driver_id),

    FOREIGN KEY(conductor_id)
        REFERENCES conductor(conductor_id),

    FOREIGN KEY(route_id)
        REFERENCES transport_route(route_id)
);

CREATE TABLE student_transport_registration (

    registration_id INT AUTO_INCREMENT PRIMARY KEY,

    student_id INT NOT NULL,

    route_id INT NOT NULL,

    registration_date DATE,

    transport_fee DECIMAL(10,2),

    status ENUM(
        'Active',
        'Suspended',
        'Cancelled'
    ) DEFAULT 'Active',

    FOREIGN KEY(student_id)
        REFERENCES student(student_id),

    FOREIGN KEY(route_id)
        REFERENCES transport_route(route_id)
);

CREATE TABLE transport_attendance (

    attendance_id INT AUTO_INCREMENT PRIMARY KEY,

    student_id INT NOT NULL,

    vehicle_id INT NOT NULL,

    attendance_date DATE NOT NULL,

    trip_type ENUM(
        'Pickup',
        'Drop'
    ),

    FOREIGN KEY(student_id)
        REFERENCES student(student_id),

    FOREIGN KEY(vehicle_id)
        REFERENCES vehicle(vehicle_id)
);

CREATE TABLE vehicle_maintenance (

    maintenance_id INT AUTO_INCREMENT PRIMARY KEY,

    vehicle_id INT NOT NULL,

    maintenance_date DATE,

    maintenance_type VARCHAR(100),

    description TEXT,

    cost DECIMAL(12,2),

    next_service_date DATE,

    FOREIGN KEY(vehicle_id)
        REFERENCES vehicle(vehicle_id)
);

CREATE TABLE fuel_log (

    fuel_log_id INT AUTO_INCREMENT PRIMARY KEY,

    vehicle_id INT NOT NULL,

    fuel_date DATE,

    liters DECIMAL(10,2),

    cost DECIMAL(12,2),

    odometer_reading INT,

    FOREIGN KEY(vehicle_id)
        REFERENCES vehicle(vehicle_id)
);

CREATE TABLE gps_tracking_log (

    gps_log_id INT AUTO_INCREMENT PRIMARY KEY,

    vehicle_id INT NOT NULL,

    latitude DECIMAL(10,7),

    longitude DECIMAL(10,7),

    recorded_at DATETIME,

    FOREIGN KEY(vehicle_id)
        REFERENCES vehicle(vehicle_id)
);

CREATE TABLE transport_incident (

    incident_id INT AUTO_INCREMENT PRIMARY KEY,

    vehicle_id INT NOT NULL,

    incident_date DATE,

    incident_type VARCHAR(100),

    description TEXT,

    reported_by VARCHAR(150),

    FOREIGN KEY(vehicle_id)
        REFERENCES vehicle(vehicle_id)
);

CREATE TABLE transport_staff (

    transport_staff_id INT AUTO_INCREMENT PRIMARY KEY,

    employee_id INT NOT NULL UNIQUE,

    designation VARCHAR(100),

    FOREIGN KEY(employee_id)
        REFERENCES employee(employee_id)
);

CREATE TABLE route_fee_structure (

    route_fee_id INT AUTO_INCREMENT PRIMARY KEY,

    route_id INT NOT NULL,

    semester_fee DECIMAL(10,2),

    FOREIGN KEY(route_id)
        REFERENCES transport_route(route_id)
);

CREATE TABLE vehicle_insurance (

    insurance_id INT AUTO_INCREMENT PRIMARY KEY,

    vehicle_id INT NOT NULL,

    insurance_provider VARCHAR(150),

    policy_number VARCHAR(100),

    coverage_amount DECIMAL(15,2),

    expiry_date DATE,

    FOREIGN KEY(vehicle_id)
        REFERENCES vehicle(vehicle_id)
);

CREATE INDEX idx_transport_student
ON student_transport_registration(student_id);

CREATE INDEX idx_transport_route
ON student_transport_registration(route_id);

CREATE INDEX idx_vehicle_maintenance_vehicle
ON vehicle_maintenance(vehicle_id);

CREATE INDEX idx_fuel_vehicle
ON fuel_log(vehicle_id);

CREATE INDEX idx_gps_vehicle
ON gps_tracking_log(vehicle_id);





CREATE TABLE job_position (

    position_id INT AUTO_INCREMENT PRIMARY KEY,

    department_id INT NOT NULL,

    position_title VARCHAR(150) NOT NULL,

    employment_type ENUM(
        'Full-Time',
        'Part-Time',
        'Contract',
        'Adjunct'
    ),

    min_salary DECIMAL(12,2),

    max_salary DECIMAL(12,2),

    FOREIGN KEY(department_id)
        REFERENCES department(department_id)
);

CREATE TABLE job_posting (

    posting_id INT AUTO_INCREMENT PRIMARY KEY,

    position_id INT NOT NULL,

    posting_date DATE NOT NULL,

    closing_date DATE NOT NULL,

    vacancies INT DEFAULT 1,

    description TEXT,

    FOREIGN KEY(position_id)
        REFERENCES job_position(position_id)
);

CREATE TABLE applicant (

    applicant_id INT AUTO_INCREMENT PRIMARY KEY,

    first_name VARCHAR(100),

    last_name VARCHAR(100),

    email VARCHAR(150) UNIQUE,

    phone VARCHAR(30),

    highest_qualification VARCHAR(150),

    years_experience INT
);

CREATE TABLE job_application (

    application_id INT AUTO_INCREMENT PRIMARY KEY,

    applicant_id INT NOT NULL,

    posting_id INT NOT NULL,

    application_date DATE,

    application_status ENUM(
        'Applied',
        'Shortlisted',
        'Interviewed',
        'Selected',
        'Rejected'
    ) DEFAULT 'Applied',

    FOREIGN KEY(applicant_id)
        REFERENCES applicant(applicant_id),

    FOREIGN KEY(posting_id)
        REFERENCES job_posting(posting_id)
);

CREATE TABLE interview (

    interview_id INT AUTO_INCREMENT PRIMARY KEY,

    application_id INT NOT NULL,

    interview_date DATETIME,

    interviewer_name VARCHAR(150),

    score DECIMAL(5,2),

    remarks TEXT,

    FOREIGN KEY(application_id)
        REFERENCES job_application(application_id)
);

CREATE TABLE employment_contract (

    contract_id INT AUTO_INCREMENT PRIMARY KEY,

    employee_id INT NOT NULL,

    contract_type ENUM(
        'Permanent',
        'Temporary',
        'Contract'
    ),

    start_date DATE,

    end_date DATE,

    basic_salary DECIMAL(12,2),

    FOREIGN KEY(employee_id)
        REFERENCES employee(employee_id)
);

CREATE TABLE employee_document (

    document_id INT AUTO_INCREMENT PRIMARY KEY,

    employee_id INT NOT NULL,

    document_type VARCHAR(100),

    file_path VARCHAR(500),

    upload_date DATE,

    FOREIGN KEY(employee_id)
        REFERENCES employee(employee_id)
);

CREATE TABLE payroll (

    payroll_id INT AUTO_INCREMENT PRIMARY KEY,

    employee_id INT NOT NULL,

    payroll_month INT,

    payroll_year INT,

    gross_salary DECIMAL(12,2),

    deductions DECIMAL(12,2),

    net_salary DECIMAL(12,2),

    payment_date DATE,

    FOREIGN KEY(employee_id)
        REFERENCES employee(employee_id)
);

CREATE TABLE salary_history (

    salary_history_id INT AUTO_INCREMENT PRIMARY KEY,

    employee_id INT NOT NULL,

    old_salary DECIMAL(12,2),

    new_salary DECIMAL(12,2),

    effective_date DATE,

    FOREIGN KEY(employee_id)
        REFERENCES employee(employee_id)
);

CREATE TABLE leave_type (

    leave_type_id INT AUTO_INCREMENT PRIMARY KEY,

    leave_name VARCHAR(100),

    annual_quota INT
);

CREATE TABLE leave_request (

    leave_request_id INT AUTO_INCREMENT PRIMARY KEY,

    employee_id INT NOT NULL,

    leave_type_id INT NOT NULL,

    start_date DATE,

    end_date DATE,

    reason TEXT,

    approval_status ENUM(
        'Pending',
        'Approved',
        'Rejected'
    ) DEFAULT 'Pending',

    FOREIGN KEY(employee_id)
        REFERENCES employee(employee_id),

    FOREIGN KEY(leave_type_id)
        REFERENCES leave_type(leave_type_id)
);

CREATE TABLE employee_attendance_log (

    attendance_log_id INT AUTO_INCREMENT PRIMARY KEY,

    employee_id INT NOT NULL,

    attendance_date DATE,

    check_in TIME,

    check_out TIME,

    FOREIGN KEY(employee_id)
        REFERENCES employee(employee_id)
);

CREATE TABLE performance_review (

    review_id INT AUTO_INCREMENT PRIMARY KEY,

    employee_id INT NOT NULL,

    reviewer_id INT,

    review_date DATE,

    performance_score DECIMAL(5,2),

    comments TEXT,

    FOREIGN KEY(employee_id)
        REFERENCES employee(employee_id),

    FOREIGN KEY(reviewer_id)
        REFERENCES employee(employee_id)
);

CREATE TABLE promotion_history (

    promotion_id INT AUTO_INCREMENT PRIMARY KEY,

    employee_id INT NOT NULL,

    old_position VARCHAR(150),

    new_position VARCHAR(150),

    promotion_date DATE,

    FOREIGN KEY(employee_id)
        REFERENCES employee(employee_id)
);

CREATE TABLE training_program (

    training_id INT AUTO_INCREMENT PRIMARY KEY,

    training_name VARCHAR(150),

    provider VARCHAR(150),

    start_date DATE,

    end_date DATE
);

CREATE TABLE employee_training (

    employee_id INT NOT NULL,

    training_id INT NOT NULL,

    completion_status ENUM(
        'Enrolled',
        'Completed',
        'Failed'
    ),

    PRIMARY KEY(employee_id,training_id),

    FOREIGN KEY(employee_id)
        REFERENCES employee(employee_id),

    FOREIGN KEY(training_id)
        REFERENCES training_program(training_id)
);

CREATE TABLE benefit_plan (

    benefit_plan_id INT AUTO_INCREMENT PRIMARY KEY,

    benefit_name VARCHAR(150),

    monthly_cost DECIMAL(10,2)
);

CREATE TABLE employee_benefit (

    employee_id INT NOT NULL,

    benefit_plan_id INT NOT NULL,

    enrollment_date DATE,

    PRIMARY KEY(employee_id,benefit_plan_id),

    FOREIGN KEY(employee_id)
        REFERENCES employee(employee_id),

    FOREIGN KEY(benefit_plan_id)
        REFERENCES benefit_plan(benefit_plan_id)
);

CREATE TABLE disciplinary_action (

    action_id INT AUTO_INCREMENT PRIMARY KEY,

    employee_id INT NOT NULL,

    action_date DATE,

    action_type VARCHAR(100),

    description TEXT,

    FOREIGN KEY(employee_id)
        REFERENCES employee(employee_id)
);

CREATE INDEX idx_payroll_employee
ON payroll(employee_id);

CREATE INDEX idx_leave_employee
ON leave_request(employee_id);

CREATE INDEX idx_review_employee
ON performance_review(employee_id);

CREATE INDEX idx_training_employee
ON employee_training(employee_id);






CREATE TABLE user_account (

    user_id INT AUTO_INCREMENT PRIMARY KEY,

    username VARCHAR(100) NOT NULL UNIQUE,

    email VARCHAR(150) NOT NULL UNIQUE,

    password_hash VARCHAR(255) NOT NULL,

    account_status ENUM(
        'Active',
        'Inactive',
        'Locked',
        'Suspended'
    ) DEFAULT 'Active',

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    last_login DATETIME
);

CREATE TABLE role (

    role_id INT AUTO_INCREMENT PRIMARY KEY,

    role_name VARCHAR(100) UNIQUE NOT NULL,

    description TEXT
);

CREATE TABLE permission (

    permission_id INT AUTO_INCREMENT PRIMARY KEY,

    permission_name VARCHAR(150) UNIQUE NOT NULL,

    description TEXT
);

CREATE TABLE user_role (

    user_id INT NOT NULL,

    role_id INT NOT NULL,

    assigned_date DATE,

    PRIMARY KEY(user_id,role_id),

    FOREIGN KEY(user_id)
        REFERENCES user_account(user_id)
        ON DELETE CASCADE,

    FOREIGN KEY(role_id)
        REFERENCES role(role_id)
        ON DELETE CASCADE
);

CREATE TABLE role_permission (

    role_id INT NOT NULL,

    permission_id INT NOT NULL,

    PRIMARY KEY(role_id,permission_id),

    FOREIGN KEY(role_id)
        REFERENCES role(role_id)
        ON DELETE CASCADE,

    FOREIGN KEY(permission_id)
        REFERENCES permission(permission_id)
        ON DELETE CASCADE
);

CREATE TABLE user_session (

    session_id BIGINT AUTO_INCREMENT PRIMARY KEY,

    user_id INT NOT NULL,

    login_time DATETIME NOT NULL,

    logout_time DATETIME,

    ip_address VARCHAR(50),

    device_info VARCHAR(255),

    FOREIGN KEY(user_id)
        REFERENCES user_account(user_id)
);

CREATE TABLE login_history (

    login_history_id BIGINT AUTO_INCREMENT PRIMARY KEY,

    user_id INT NOT NULL,

    login_timestamp DATETIME,

    ip_address VARCHAR(50),

    login_status ENUM(
        'Success',
        'Failed'
    ),

    FOREIGN KEY(user_id)
        REFERENCES user_account(user_id)
);

CREATE TABLE password_policy (

    policy_id INT AUTO_INCREMENT PRIMARY KEY,

    minimum_length INT,

    require_uppercase BOOLEAN,

    require_lowercase BOOLEAN,

    require_numbers BOOLEAN,

    require_special_characters BOOLEAN,

    password_expiry_days INT
);

CREATE TABLE password_history (

    history_id BIGINT AUTO_INCREMENT PRIMARY KEY,

    user_id INT NOT NULL,

    password_hash VARCHAR(255),

    changed_at DATETIME,

    FOREIGN KEY(user_id)
        REFERENCES user_account(user_id)
);

CREATE TABLE account_lock (

    lock_id INT AUTO_INCREMENT PRIMARY KEY,

    user_id INT NOT NULL,

    locked_at DATETIME,

    unlock_at DATETIME,

    reason VARCHAR(255),

    FOREIGN KEY(user_id)
        REFERENCES user_account(user_id)
);

CREATE TABLE user_mfa (

    mfa_id INT AUTO_INCREMENT PRIMARY KEY,

    user_id INT NOT NULL UNIQUE,

    mfa_type ENUM(
        'Email',
        'SMS',
        'Authenticator App'
    ),

    secret_key VARCHAR(255),

    enabled BOOLEAN DEFAULT FALSE,

    FOREIGN KEY(user_id)
        REFERENCES user_account(user_id)
);

CREATE TABLE security_event (

    security_event_id BIGINT AUTO_INCREMENT PRIMARY KEY,

    user_id INT,

    event_type VARCHAR(100),

    event_description TEXT,

    event_timestamp DATETIME,

    severity ENUM(
        'Low',
        'Medium',
        'High',
        'Critical'
    ),

    FOREIGN KEY(user_id)
        REFERENCES user_account(user_id)
);

CREATE TABLE audit_log (

    audit_id BIGINT AUTO_INCREMENT PRIMARY KEY,

    user_id INT,

    table_name VARCHAR(100),

    record_id VARCHAR(100),

    operation_type ENUM(
        'INSERT',
        'UPDATE',
        'DELETE'
    ),

    old_value JSON,

    new_value JSON,

    operation_timestamp DATETIME,

    FOREIGN KEY(user_id)
        REFERENCES user_account(user_id)
);

CREATE TABLE api_token (

    token_id BIGINT AUTO_INCREMENT PRIMARY KEY,

    user_id INT NOT NULL,

    token_hash VARCHAR(255),

    created_at DATETIME,

    expiry_date DATETIME,

    FOREIGN KEY(user_id)
        REFERENCES user_account(user_id)
);

CREATE TABLE notification (

    notification_id BIGINT AUTO_INCREMENT PRIMARY KEY,

    user_id INT NOT NULL,

    title VARCHAR(255),

    message TEXT,

    notification_type ENUM(
        'Academic',
        'Finance',
        'Library',
        'Security',
        'HR'
    ),

    is_read BOOLEAN DEFAULT FALSE,

    created_at DATETIME,

    FOREIGN KEY(user_id)
        REFERENCES user_account(user_id)
);

CREATE TABLE file_access_log (

    access_log_id BIGINT AUTO_INCREMENT PRIMARY KEY,

    user_id INT,

    document_name VARCHAR(255),

    access_time DATETIME,

    action_type ENUM(
        'View',
        'Download',
        'Upload',
        'Delete'
    ),

    FOREIGN KEY(user_id)
        REFERENCES user_account(user_id)
);

CREATE INDEX idx_user_username
ON user_account(username);

CREATE INDEX idx_audit_user
ON audit_log(user_id);

CREATE INDEX idx_security_event_user
ON security_event(user_id);

CREATE INDEX idx_notification_user
ON notification(user_id);

CREATE INDEX idx_login_history_user
ON login_history(user_id);
