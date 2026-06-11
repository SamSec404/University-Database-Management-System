-- =====================================================
-- UNIVERSITY ERP SYSTEM — SAMPLE DATASET
-- Compatible with the university_erp schema (MySQL 8.0)
-- Insert order respects all FK dependencies
-- =====================================================

USE university_erp;

SET FOREIGN_KEY_CHECKS = 0;

-- =====================================================
-- DEPARTMENT
-- =====================================================

INSERT INTO department (department_code, department_name, building_name, budget) VALUES
('CS',   'Computer Science',          'Tech Block A',      15000000.00),
('EE',   'Electrical Engineering',    'Engineering Block', 12000000.00),
('BBA',  'Business Administration',   'Commerce Block',    10000000.00),
('MATH', 'Mathematics',               'Science Block',      8000000.00),
('PHY',  'Physics',                   'Science Block',      7500000.00),
('ENG',  'English Language',          'Humanities Block',   5000000.00),
('ME',   'Mechanical Engineering',    'Engineering Block', 11000000.00),
('HR',   'Human Resources',           'Admin Block',        4000000.00);

-- =====================================================
-- PROGRAM
-- =====================================================

INSERT INTO program (department_id, program_code, program_name, degree_level, duration_years, total_credit_hours) VALUES
(1, 'BSCS',   'BS Computer Science',              'BS',  4, 130),
(1, 'MSCS',   'MS Computer Science',              'MS',  2,  66),
(1, 'PhDCS',  'PhD Computer Science',             'PhD', 3,  90),
(2, 'BSEE',   'BS Electrical Engineering',        'BS',  4, 136),
(2, 'MSEE',   'MS Electrical Engineering',        'MS',  2,  66),
(3, 'BBA',    'Bachelor of Business Admin',       'BS',  4, 126),
(3, 'MBA',    'Master of Business Admin',         'MS',  2,  60),
(4, 'BSMATH', 'BS Mathematics',                   'BS',  4, 124),
(5, 'BSPHY',  'BS Physics',                       'BS',  4, 128),
(6, 'BSENG',  'BS English',                       'BS',  4, 120),
(7, 'BSME',   'BS Mechanical Engineering',        'BS',  4, 136);

-- =====================================================
-- ACADEMIC SESSION
-- =====================================================

INSERT INTO academic_session (session_name, start_date, end_date) VALUES
('2022-2023', '2022-09-01', '2023-08-31'),
('2023-2024', '2023-09-01', '2024-08-31'),
('2024-2025', '2024-09-01', '2025-08-31');

-- =====================================================
-- SEMESTER
-- =====================================================

INSERT INTO semester (session_id, semester_name, start_date, end_date) VALUES
(1, 'Fall',   '2022-09-05', '2023-01-15'),
(1, 'Spring', '2023-02-01', '2023-06-15'),
(1, 'Summer', '2023-07-01', '2023-08-20'),
(2, 'Fall',   '2023-09-04', '2024-01-20'),
(2, 'Spring', '2024-02-05', '2024-06-20'),
(2, 'Summer', '2024-07-01', '2024-08-20'),
(3, 'Fall',   '2024-09-02', '2025-01-18'),
(3, 'Spring', '2025-02-03', '2025-06-18');

-- =====================================================
-- BUILDING
-- =====================================================

INSERT INTO building (building_name, total_floors) VALUES
('Tech Block A',      5),
('Engineering Block', 6),
('Commerce Block',    4),
('Science Block',     5),
('Humanities Block',  3),
('Admin Block',       4),
('Library Block',     3),
('Hostel Block A',    4),
('Hostel Block B',    4);

-- =====================================================
-- CLASSROOM
-- =====================================================

INSERT INTO classroom (building_id, room_number, capacity) VALUES
(1, 'CS-101', 50),
(1, 'CS-102', 50),
(1, 'CS-201', 40),
(1, 'CS-Lab1',30),
(2, 'EE-101', 50),
(2, 'EE-102', 50),
(2, 'EE-Lab1',30),
(3, 'BBA-101',60),
(3, 'BBA-102',60),
(4, 'SCI-101',45),
(4, 'SCI-102',45),
(5, 'HUM-101',55),
(1, 'CS-301', 40),
(1, 'CS-302', 40),
(2, 'ME-101', 50);

-- =====================================================
-- TIME SLOT
-- =====================================================

INSERT INTO time_slot (day_of_week, start_time, end_time) VALUES
('Monday',    '08:00:00', '09:30:00'),
('Monday',    '09:30:00', '11:00:00'),
('Monday',    '11:00:00', '12:30:00'),
('Tuesday',   '08:00:00', '09:30:00'),
('Tuesday',   '09:30:00', '11:00:00'),
('Tuesday',   '11:00:00', '12:30:00'),
('Wednesday', '08:00:00', '09:30:00'),
('Wednesday', '09:30:00', '11:00:00'),
('Wednesday', '11:00:00', '12:30:00'),
('Thursday',  '08:00:00', '09:30:00'),
('Thursday',  '09:30:00', '11:00:00'),
('Thursday',  '11:00:00', '12:30:00'),
('Friday',    '08:00:00', '09:00:00'),
('Friday',    '09:00:00', '10:30:00'),
('Saturday',  '09:00:00', '12:00:00');

-- =====================================================
-- INSTRUCTOR
-- =====================================================

INSERT INTO instructor (department_id, employee_no, first_name, last_name, email, phone, designation, salary, hire_date) VALUES
(1, 'EMP001', 'Ahmed',    'Khan',     'ahmed.khan@uni.edu.pk',     '03001234567', 'Professor',         180000.00, '2010-08-15'),
(1, 'EMP002', 'Sara',     'Ali',      'sara.ali@uni.edu.pk',       '03011234567', 'Associate Professor',150000.00, '2013-03-01'),
(1, 'EMP003', 'Usman',    'Malik',    'usman.malik@uni.edu.pk',    '03021234567', 'Assistant Professor',120000.00, '2017-09-10'),
(1, 'EMP004', 'Fatima',   'Sheikh',   'fatima.sheikh@uni.edu.pk',  '03031234567', 'Lecturer',          100000.00, '2020-01-15'),
(2, 'EMP005', 'Bilal',    'Iqbal',    'bilal.iqbal@uni.edu.pk',    '03041234567', 'Professor',         175000.00, '2009-07-20'),
(2, 'EMP006', 'Ayesha',   'Siddiqui', 'ayesha.siddiqui@uni.edu.pk','03051234567', 'Associate Professor',145000.00, '2014-02-28'),
(3, 'EMP007', 'Zara',     'Rehman',   'zara.rehman@uni.edu.pk',    '03061234567', 'Professor',         160000.00, '2011-06-01'),
(3, 'EMP008', 'Hassan',   'Qureshi',  'hassan.qureshi@uni.edu.pk', '03071234567', 'Assistant Professor',115000.00, '2019-08-05'),
(4, 'EMP009', 'Nadia',    'Hussain',  'nadia.hussain@uni.edu.pk',  '03081234567', 'Associate Professor',140000.00, '2015-03-12'),
(5, 'EMP010', 'Tariq',    'Mehmood',  'tariq.mehmood@uni.edu.pk',  '03091234567', 'Professor',         170000.00, '2008-09-01'),
(6, 'EMP011', 'Amina',    'Butt',     'amina.butt@uni.edu.pk',     '03101234567', 'Associate Professor',135000.00, '2016-01-20'),
(7, 'EMP012', 'Kamran',   'Javed',    'kamran.javed@uni.edu.pk',   '03111234567', 'Professor',         178000.00, '2010-05-15'),
(1, 'EMP013', 'Sana',     'Farooq',   'sana.farooq@uni.edu.pk',    '03121234567', 'Lecturer',           98000.00, '2021-02-01'),
(2, 'EMP014', 'Imran',    'Chaudhry', 'imran.chaudhry@uni.edu.pk', '03131234567', 'Assistant Professor',118000.00, '2018-07-10'),
(3, 'EMP015', 'Rabia',    'Nawaz',    'rabia.nawaz@uni.edu.pk',    '03141234567', 'Lecturer',           95000.00, '2022-01-10');

-- =====================================================
-- FACULTY QUALIFICATION
-- =====================================================

INSERT INTO faculty_qualification (instructor_id, degree_name, institution, completion_year) VALUES
(1,  'PhD Computer Science',     'University of Engineering & Technology Lahore', 2008),
(1,  'MS Computer Science',      'FAST NUCES',                                   2004),
(2,  'PhD Artificial Intelligence','NUST Islamabad',                              2011),
(3,  'MS Software Engineering',  'COMSATS Islamabad',                             2015),
(4,  'MS Computer Science',      'Punjab University',                             2019),
(5,  'PhD Electrical Engineering','UET Peshawar',                                 2007),
(6,  'MS Power Systems',         'NED University',                                2012),
(7,  'PhD Business Management',  'IBA Karachi',                                   2009),
(8,  'MBA Finance',              'LUMS',                                          2017),
(9,  'PhD Mathematics',          'Quaid-i-Azam University',                       2013),
(10, 'PhD Physics',              'University of Punjab',                           2006),
(11, 'MA English Literature',    'University of the Punjab',                      2014),
(12, 'PhD Mechanical Engineering','UET Taxila',                                   2008),
(13, 'MS Data Science',          'ITU Lahore',                                    2020),
(14, 'MS Electrical Engineering','GIKI',                                          2016);

-- =====================================================
-- FACULTY PUBLICATION
-- =====================================================

INSERT INTO faculty_publication (instructor_id, title, journal_name, publication_year) VALUES
(1,  'Deep Learning Approaches for Network Intrusion Detection',          'IEEE Transactions on Neural Networks', 2022),
(1,  'Federated Learning in Edge Computing Environments',                 'ACM Computing Surveys',                2021),
(2,  'Explainable AI in Healthcare Diagnostics',                          'Nature Machine Intelligence',          2023),
(3,  'Microservices Architecture for Scalable Web Applications',          'Journal of Systems and Software',      2022),
(5,  'Smart Grid Optimization Using Reinforcement Learning',              'IEEE Transactions on Smart Grid',      2021),
(6,  'Renewable Energy Forecasting with LSTM Networks',                   'Applied Energy',                      2023),
(7,  'Digital Transformation in Pakistani SMEs',                          'Journal of Business Research',        2022),
(9,  'Numerical Methods for Fractional Differential Equations',           'Applied Mathematics and Computation',  2020),
(10, 'Quantum Computing Implications for Cryptographic Systems',          'Physical Review Letters',             2021),
(12, 'Additive Manufacturing Process Optimization',                       'Journal of Manufacturing Processes',  2022);

-- =====================================================
-- COURSE
-- =====================================================

INSERT INTO course (department_id, course_code, course_title, credit_hours, description) VALUES
(1, 'CS101',  'Introduction to Programming',           3,  'Fundamentals of programming using Python'),
(1, 'CS102',  'Object Oriented Programming',           3,  'OOP concepts using C++'),
(1, 'CS201',  'Data Structures and Algorithms',        3,  'Core data structures and algorithmic thinking'),
(1, 'CS202',  'Database Management Systems',           3,  'Relational databases, SQL and normalization'),
(1, 'CS301',  'Operating Systems',                     3,  'Process management, memory and file systems'),
(1, 'CS302',  'Computer Networks',                     3,  'Network models, protocols and security basics'),
(1, 'CS401',  'Artificial Intelligence',               3,  'Search, planning, machine learning fundamentals'),
(1, 'CS402',  'Software Engineering',                  3,  'SDLC, design patterns and project management'),
(1, 'CS403',  'Information Security',                  3,  'Cybersecurity principles and ethical hacking'),
(1, 'CS404',  'Machine Learning',                      3,  'Supervised and unsupervised learning algorithms'),
(1, 'CS501',  'Deep Learning',                         3,  'Neural networks, CNNs, RNNs and transformers'),
(1, 'CS502',  'Cloud Computing',                       3,  'Cloud architectures, services and deployment'),
(2, 'EE101',  'Circuit Analysis',                      3,  'Kirchhoff laws, mesh and node analysis'),
(2, 'EE201',  'Digital Logic Design',                  3,  'Boolean algebra, gates and combinational circuits'),
(2, 'EE301',  'Signals and Systems',                   3,  'Continuous and discrete time signals'),
(3, 'BBA101', 'Principles of Management',              3,  'Management functions and organizational behavior'),
(3, 'BBA201', 'Financial Accounting',                  3,  'Double entry bookkeeping and financial statements'),
(3, 'BBA301', 'Marketing Management',                  3,  'Market analysis, segmentation and strategy'),
(4, 'MATH101','Calculus I',                            3,  'Limits, derivatives and integration'),
(4, 'MATH201','Linear Algebra',                        3,  'Matrices, vectors and eigenvalues'),
(5, 'PHY101', 'Engineering Physics',                   3,  'Mechanics, waves and thermodynamics'),
(6, 'ENG101', 'English Composition',                   3,  'Academic writing and critical reading'),
(7, 'ME101',  'Engineering Drawing',                   2,  'Technical drawing standards and CAD basics');

-- =====================================================
-- PREREQUISITE
-- =====================================================

INSERT INTO prerequisite (course_id, prerequisite_course_id) VALUES
(3,  1),   -- DSA requires Intro to Programming
(3,  2),   -- DSA requires OOP
(4,  3),   -- DBMS requires DSA
(5,  3),   -- OS requires DSA
(6,  5),   -- Networks requires OS
(7,  3),   -- AI requires DSA
(10, 7),   -- ML requires AI
(11, 10),  -- Deep Learning requires ML
(9,  6),   -- Info Security requires Networks
(12, 6),   -- Cloud requires Networks
(14, 13),  -- Digital Logic requires Circuit Analysis
(15, 14);  -- Signals requires Digital Logic

-- =====================================================
-- COURSE OUTCOME
-- =====================================================

INSERT INTO course_outcome (course_id, outcome_description) VALUES
(1,  'Write basic Python programs using variables, loops, and functions'),
(1,  'Debug simple programs and understand runtime errors'),
(2,  'Implement classes, inheritance, and polymorphism in C++'),
(3,  'Implement and analyze linked lists, trees, and graph algorithms'),
(3,  'Analyze time and space complexity using Big-O notation'),
(4,  'Design normalized relational database schemas'),
(4,  'Write complex SQL queries including joins and subqueries'),
(5,  'Understand process scheduling and memory management'),
(7,  'Implement search algorithms: BFS, DFS, A*'),
(7,  'Build basic ML classifiers using scikit-learn'),
(10, 'Train and evaluate supervised learning models'),
(11, 'Design and train convolutional neural networks');

-- =====================================================
-- STUDENT
-- =====================================================

INSERT INTO student (registration_no, program_id, first_name, last_name, gender, date_of_birth, email, phone, cnic, blood_group, nationality, admission_date, cgpa, status) VALUES
('2022-BSCS-001', 1, 'Ali',       'Hassan',    'Male',   '2003-03-15', 'ali.hassan@student.uni.edu.pk',       '03201234567', '3520100000001', 'B+', 'Pakistani', '2022-09-05', 3.75, 'Active'),
('2022-BSCS-002', 1, 'Zainab',    'Farooq',    'Female', '2003-07-22', 'zainab.farooq@student.uni.edu.pk',    '03211234567', '3520100000002', 'A+', 'Pakistani', '2022-09-05', 3.90, 'Active'),
('2022-BSCS-003', 1, 'Hamza',     'Tariq',     'Male',   '2002-11-10', 'hamza.tariq@student.uni.edu.pk',      '03221234567', '3520100000003', 'O+', 'Pakistani', '2022-09-05', 3.20, 'Active'),
('2022-BSCS-004', 1, 'Maham',     'Riaz',      'Female', '2003-01-05', 'maham.riaz@student.uni.edu.pk',       '03231234567', '3520100000004', 'A-', 'Pakistani', '2022-09-05', 3.55, 'Active'),
('2022-BSCS-005', 1, 'Daniyal',   'Ahmed',     'Male',   '2002-06-30', 'daniyal.ahmed@student.uni.edu.pk',    '03241234567', '3520100000005', 'B-', 'Pakistani', '2022-09-05', 2.80, 'Active'),
('2022-BSCS-006', 1, 'Hira',      'Malik',     'Female', '2003-09-18', 'hira.malik@student.uni.edu.pk',       '03251234567', '3520100000006', 'AB+','Pakistani', '2022-09-05', 3.10, 'Active'),
('2022-BSCS-007', 1, 'Umar',      'Shafiq',    'Male',   '2002-12-25', 'umar.shafiq@student.uni.edu.pk',      '03261234567', '3520100000007', 'O-', 'Pakistani', '2022-09-05', 3.40, 'Active'),
('2022-BSCS-008', 1, 'Sadia',     'Nawaz',     'Female', '2003-04-14', 'sadia.nawaz@student.uni.edu.pk',      '03271234567', '3520100000008', 'B+', 'Pakistani', '2022-09-05', 2.95, 'Active'),
('2021-BSCS-010', 1, 'Faisal',    'Chaudhry',  'Male',   '2001-08-08', 'faisal.ch@student.uni.edu.pk',        '03281234567', '3520100000009', 'A+', 'Pakistani', '2021-09-06', 3.60, 'Active'),
('2021-BSCS-011', 1, 'Nimra',     'Khan',      'Female', '2001-03-19', 'nimra.khan@student.uni.edu.pk',       '03291234567', '3520100000010', 'O+', 'Pakistani', '2021-09-06', 3.85, 'Active'),
('2022-BSEE-001', 4, 'Shahzaib',  'Alam',      'Male',   '2003-05-12', 'shahzaib.alam@student.uni.edu.pk',    '03301234567', '3520100000011', 'B+', 'Pakistani', '2022-09-05', 3.30, 'Active'),
('2022-BSEE-002', 4, 'Laiba',     'Sattar',    'Female', '2003-02-28', 'laiba.sattar@student.uni.edu.pk',     '03311234567', '3520100000012', 'A-', 'Pakistani', '2022-09-05', 3.70, 'Active'),
('2022-BBA-001',  6, 'Amir',      'Sohail',    'Male',   '2002-10-05', 'amir.sohail@student.uni.edu.pk',      '03321234567', '3520100000013', 'O+', 'Pakistani', '2022-09-05', 3.20, 'Active'),
('2022-BBA-002',  6, 'Kiran',     'Ashraf',    'Female', '2003-06-21', 'kiran.ashraf@student.uni.edu.pk',     '03331234567', '3520100000014', 'B+', 'Pakistani', '2022-09-05', 3.55, 'Active'),
('2022-BSME-001', 11,'Omar',      'Baig',      'Male',   '2002-09-17', 'omar.baig@student.uni.edu.pk',        '03341234567', '3520100000015', 'A+', 'Pakistani', '2022-09-05', 2.90, 'Active'),
('2023-BSCS-001', 1, 'Rida',      'Hussain',   'Female', '2004-01-30', 'rida.hussain@student.uni.edu.pk',     '03351234567', '3520100000016', 'AB-','Pakistani', '2023-09-04', 3.80, 'Active'),
('2023-BSCS-002', 1, 'Talha',     'Zafar',     'Male',   '2004-04-11', 'talha.zafar@student.uni.edu.pk',      '03361234567', '3520100000017', 'B+', 'Pakistani', '2023-09-04', 3.45, 'Active'),
('2023-BSCS-003', 1, 'Iqra',      'Maqsood',   'Female', '2004-07-07', 'iqra.maqsood@student.uni.edu.pk',    '03371234567', '3520100000018', 'O+', 'Pakistani', '2023-09-04', 3.65, 'Active'),
('2020-BSCS-001', 1, 'Bilal',     'Saeed',     'Male',   '2000-02-14', 'bilal.saeed@student.uni.edu.pk',      '03381234567', '3520100000019', 'A+', 'Pakistani', '2020-09-07', 3.72, 'Graduated'),
('2020-BSCS-002', 1, 'Maryam',    'Qazi',      'Female', '2000-11-03', 'maryam.qazi@student.uni.edu.pk',     '03391234567', '3520100000020', 'B-', 'Pakistani', '2020-09-07', 2.50, 'Dropped');

-- =====================================================
-- STUDENT ADDRESS
-- =====================================================

INSERT INTO student_address (student_id, address_type, country, province, city, postal_code, street_address) VALUES
(1,  'Permanent', 'Pakistan', 'Punjab',    'Lahore',     '54000', 'House 12, Street 5, Johar Town'),
(1,  'Current',   'Pakistan', 'Punjab',    'Lahore',     '54782', 'Hostel Block A, Room 101, University Campus'),
(2,  'Permanent', 'Pakistan', 'Punjab',    'Faisalabad', '38000', 'House 45, Block C, Madina Town'),
(2,  'Current',   'Pakistan', 'Punjab',    'Lahore',     '54782', 'Hostel Block B, Room 205, University Campus'),
(3,  'Permanent', 'Pakistan', 'Punjab',    'Gujranwala', '52250', 'Street 7, Model Town, Gujranwala'),
(4,  'Permanent', 'Pakistan', 'Punjab',    'Lahore',     '54600', 'House 89, DHA Phase 5'),
(5,  'Permanent', 'Pakistan', 'Sindh',     'Karachi',    '75500', 'Flat 3B, Block 14, Gulistan-e-Jauhar'),
(6,  'Permanent', 'Pakistan', 'Punjab',    'Multan',     '60000', 'House 22, Gulgasht Colony'),
(7,  'Permanent', 'Pakistan', 'KPK',       'Peshawar',   '25000', 'Street 3, Hayatabad Phase 2'),
(8,  'Permanent', 'Pakistan', 'Punjab',    'Sialkot',    '51310', 'House 67, Cantt Area'),
(9,  'Permanent', 'Pakistan', 'Punjab',    'Lahore',     '54000', 'House 5, Gulberg III'),
(10, 'Permanent', 'Pakistan', 'Punjab',    'Lahore',     '54000', 'House 200, Model Town'),
(11, 'Permanent', 'Pakistan', 'Punjab',    'Rawalpindi', '46000', 'House 14, Satellite Town'),
(12, 'Permanent', 'Pakistan', 'Punjab',    'Lahore',     '54700', 'House 33, Garden Town'),
(13, 'Permanent', 'Pakistan', 'Punjab',    'Lahore',     '54000', 'House 7, Iqbal Town'),
(14, 'Permanent', 'Pakistan', 'Punjab',    'Lahore',     '54000', 'House 19, Township'),
(15, 'Permanent', 'Pakistan', 'Punjab',    'Lahore',     '54000', 'House 55, Bahria Town');

-- =====================================================
-- STUDENT GUARDIAN
-- =====================================================

INSERT INTO student_guardian (student_id, guardian_name, relationship_type, phone, occupation) VALUES
(1,  'Tariq Hassan',      'Father', '03001112233', 'Business'),
(2,  'Sajida Farooq',     'Mother', '03011112233', 'Teacher'),
(3,  'Saleem Tariq',      'Father', '03021112233', 'Engineer'),
(4,  'Riaz Ahmed',        'Father', '03031112233', 'Doctor'),
(5,  'Arshad Ahmed',      'Father', '03041112233', 'Businessman'),
(6,  'Ghulam Malik',      'Father', '03051112233', 'Retired'),
(7,  'Shafiq Hussain',    'Father', '03061112233', 'Government Officer'),
(8,  'Perveen Nawaz',     'Mother', '03071112233', 'Housewife'),
(9,  'Ijaz Chaudhry',     'Father', '03081112233', 'Banker'),
(10, 'Zahida Begum',      'Mother', '03091112233', 'Housewife'),
(11, 'Zulfiqar Alam',     'Father', '03101112233', 'Army Officer'),
(12, 'Sattar Hussain',    'Father', '03111112233', 'Farmer'),
(13, 'Sohail Ahmed',      'Father', '03121112233', 'Accountant'),
(14, 'Ashraf Begum',      'Mother', '03131112233', 'Housewife'),
(15, 'Baig Muhammad',     'Father', '03141112233', 'IT Professional');

-- =====================================================
-- STUDENT DOCUMENT
-- =====================================================

INSERT INTO student_document (student_id, document_type, document_path, verification_status) VALUES
(1,  'Matric Certificate',     '/docs/students/1/matric.pdf',       'Verified'),
(1,  'Inter Certificate',      '/docs/students/1/inter.pdf',        'Verified'),
(1,  'CNIC Copy',              '/docs/students/1/cnic.pdf',         'Verified'),
(2,  'Matric Certificate',     '/docs/students/2/matric.pdf',       'Verified'),
(2,  'Inter Certificate',      '/docs/students/2/inter.pdf',        'Verified'),
(3,  'Matric Certificate',     '/docs/students/3/matric.pdf',       'Verified'),
(3,  'Inter Certificate',      '/docs/students/3/inter.pdf',        'Pending'),
(4,  'Matric Certificate',     '/docs/students/4/matric.pdf',       'Verified'),
(5,  'Matric Certificate',     '/docs/students/5/matric.pdf',       'Verified'),
(5,  'CNIC Copy',              '/docs/students/5/cnic.pdf',         'Pending'),
(6,  'Matric Certificate',     '/docs/students/6/matric.pdf',       'Verified'),
(7,  'Matric Certificate',     '/docs/students/7/matric.pdf',       'Verified'),
(8,  'Matric Certificate',     '/docs/students/8/matric.pdf',       'Rejected'),
(8,  'Inter Certificate',      '/docs/students/8/inter.pdf',        'Pending'),
(11, 'Matric Certificate',     '/docs/students/11/matric.pdf',      'Verified');

-- =====================================================
-- SECTION
-- =====================================================

-- Fall 2022 (semester_id=1) sections
INSERT INTO section (course_id, instructor_id, semester_id, classroom_id, time_slot_id, section_name, capacity) VALUES
(1,  3,  1, 1,  1,  'CS101-A', 50),   -- Intro to Programming sec A
(1,  4,  1, 2,  4,  'CS101-B', 50),   -- Intro to Programming sec B
(22, 11, 1, 12, 2,  'ENG101-A',55),   -- English Composition
(19, 9,  1, 10, 5,  'MATH101-A',45),  -- Calculus I
(21, 10, 1, 11, 7,  'PHY101-A', 45),  -- Engineering Physics
(13, 5,  1, 5,  3,  'EE101-A',  50),  -- Circuit Analysis
(16, 7,  1, 8,  8,  'BBA101-A', 60),  -- Principles of Mgmt

-- Spring 2023 (semester_id=2) sections
(2,  3,  2, 1,  1,  'CS102-A', 50),   -- OOP sec A
(2,  4,  2, 2,  4,  'CS102-B', 50),   -- OOP sec B
(20, 9,  2, 10, 5,  'MATH201-A',45),  -- Linear Algebra
(17, 7,  2, 8,  8,  'BBA201-A', 60),  -- Financial Accounting
(14, 5,  2, 5,  1,  'EE201-A',  50),  -- Digital Logic

-- Fall 2023 (semester_id=4) sections
(3,  1,  4, 1,  2,  'CS201-A', 50),   -- DSA sec A
(3,  3,  4, 2,  5,  'CS201-B', 50),   -- DSA sec B
(4,  2,  4, 3,  7,  'CS202-A', 40),   -- DBMS sec A
(5,  1,  4, 13, 10, 'CS301-A', 40),   -- OS sec A
(15, 5,  4, 5,  3,  'EE301-A', 50),   -- Signals & Systems
(18, 7,  4, 9,  8,  'BBA301-A',60),   -- Marketing Mgmt

-- Spring 2024 (semester_id=5) sections
(6,  2,  5, 1,  1,  'CS302-A', 40),   -- Computer Networks
(7,  1,  5, 3,  4,  'CS401-A', 40),   -- Artificial Intelligence
(8,  3,  5, 13, 7,  'CS402-A', 40),   -- Software Engineering
(9,  4,  5, 14, 10, 'CS403-A', 40),   -- Information Security

-- Fall 2024 (semester_id=7) sections
(10, 1,  7, 1,  2,  'CS404-A', 40),   -- Machine Learning
(11, 2,  7, 3,  5,  'CS501-A', 35),   -- Deep Learning
(12, 3,  7, 13, 8,  'CS502-A', 35);   -- Cloud Computing

-- =====================================================
-- ENROLLMENT
-- =====================================================

-- Fall 2022 enrollments (section IDs 1-7)
INSERT INTO enrollment (student_id, section_id, enrollment_date, grade) VALUES
-- CS101-A (sec 1): CS students batch 2022
(1, 1, '2022-09-10', 'A'),
(2, 1, '2022-09-10', 'A+'),
(3, 1, '2022-09-10', 'B+'),
(4, 1, '2022-09-10', 'A'),
(5, 1, '2022-09-10', 'B'),
-- CS101-B (sec 2)
(6, 2, '2022-09-10', 'B+'),
(7, 2, '2022-09-10', 'A'),
(8, 2, '2022-09-10', 'B'),
-- ENG101 (sec 3)
(1, 3, '2022-09-10', 'A'),
(2, 3, '2022-09-10', 'A+'),
(3, 3, '2022-09-10', 'B'),
(6, 3, '2022-09-10', 'A'),
(7, 3, '2022-09-10', 'B+'),
(11,3, '2022-09-10', 'A'),
(12,3, '2022-09-10', 'A+'),
-- MATH101 (sec 4)
(1, 4, '2022-09-10', 'A+'),
(2, 4, '2022-09-10', 'A'),
(3, 4, '2022-09-10', 'C+'),
(4, 4, '2022-09-10', 'B+'),
(5, 4, '2022-09-10', 'B'),
(11,4, '2022-09-10', 'A'),
-- PHY101 (sec 5)
(11,5, '2022-09-10', 'B+'),
(12,5, '2022-09-10', 'A'),
(15,5, '2022-09-10', 'B'),
-- EE101 (sec 6)
(11,6, '2022-09-10', 'A'),
(12,6, '2022-09-10', 'A+'),
-- BBA101 (sec 7)
(13,7, '2022-09-10', 'A'),
(14,7, '2022-09-10', 'A+'),

-- Spring 2023 (sec 8-12)
(1, 8, '2023-02-08', 'A'),
(2, 8, '2023-02-08', 'A+'),
(3, 8, '2023-02-08', 'B+'),
(4, 8, '2023-02-08', 'A'),
(5, 8, '2023-02-08', 'B'),
(6, 9, '2023-02-08', 'B+'),
(7, 9, '2023-02-08', 'A'),
(8, 9, '2023-02-08', 'C+'),
(1, 10,'2023-02-08', 'A+'),
(4, 10,'2023-02-08', 'A'),
(11,12,'2023-02-08', 'A'),
(12,12,'2023-02-08', 'B+'),
(13,11,'2023-02-08', 'A'),
(14,11,'2023-02-08', 'B+'),

-- Fall 2023 (sec 13-18)
(1, 13,'2023-09-10', 'A'),
(2, 13,'2023-09-10', 'A+'),
(3, 13,'2023-09-10', 'B'),
(4, 13,'2023-09-10', 'A'),
(5, 13,'2023-09-10', 'C+'),
(6, 14,'2023-09-10', 'A'),
(7, 14,'2023-09-10', 'B+'),
(8, 14,'2023-09-10', 'B'),
(1, 15,'2023-09-10', 'A+'),
(2, 15,'2023-09-10', 'A'),
(3, 15,'2023-09-10', 'B+'),
(9, 15,'2023-09-10', 'A'),
(10,15,'2023-09-10', 'A+'),
(1, 16,'2023-09-10', 'A'),
(2, 16,'2023-09-10', 'A+'),
(9, 16,'2023-09-10', 'A'),
(10,16,'2023-09-10', 'A'),
(11,17,'2023-09-10', 'B+'),
(12,17,'2023-09-10', 'A'),
(13,18,'2023-09-10', 'A'),
(14,18,'2023-09-10', 'A+'),

-- Spring 2024 (sec 19-22)
(1, 19,'2024-02-08', NULL),
(2, 19,'2024-02-08', NULL),
(9, 19,'2024-02-08', NULL),
(10,19,'2024-02-08', NULL),
(1, 20,'2024-02-08', NULL),
(2, 20,'2024-02-08', NULL),
(9, 20,'2024-02-08', NULL),
(10,20,'2024-02-08', NULL),
(1, 21,'2024-02-08', NULL),
(3, 21,'2024-02-08', NULL),
(1, 22,'2024-02-08', NULL),
(2, 22,'2024-02-08', NULL),

-- Fall 2024 (sec 23-25)
(16,23,'2024-09-05', NULL),
(17,23,'2024-09-05', NULL),
(18,23,'2024-09-05', NULL),
(16,24,'2024-09-05', NULL),
(17,24,'2024-09-05', NULL),
(16,25,'2024-09-05', NULL),
(18,25,'2024-09-05', NULL);

-- =====================================================
-- ATTENDANCE  (sample weeks for active sections)
-- =====================================================

INSERT INTO attendance (student_id, section_id, attendance_date, status) VALUES
-- Section 1 (CS101-A) Fall 2022
(1,1,'2022-09-12','Present'), (2,1,'2022-09-12','Present'), (3,1,'2022-09-12','Absent'),
(4,1,'2022-09-12','Present'), (5,1,'2022-09-12','Late'),
(1,1,'2022-09-19','Present'), (2,1,'2022-09-19','Present'), (3,1,'2022-09-19','Present'),
(4,1,'2022-09-19','Present'), (5,1,'2022-09-19','Absent'),
(1,1,'2022-09-26','Present'), (2,1,'2022-09-26','Present'), (3,1,'2022-09-26','Late'),
(4,1,'2022-09-26','Excused'), (5,1,'2022-09-26','Present'),
-- Section 13 (CS201-A) Fall 2023
(1,13,'2023-09-11','Present'), (2,13,'2023-09-11','Present'), (3,13,'2023-09-11','Absent'),
(4,13,'2023-09-11','Present'), (5,13,'2023-09-11','Present'),
(1,13,'2023-09-18','Present'), (2,13,'2023-09-18','Present'), (3,13,'2023-09-18','Present'),
(4,13,'2023-09-18','Late'),    (5,13,'2023-09-18','Absent'),
-- Section 23 (CS404-A) Fall 2024
(16,23,'2024-09-09','Present'), (17,23,'2024-09-09','Present'), (18,23,'2024-09-09','Present'),
(16,23,'2024-09-16','Present'), (17,23,'2024-09-16','Absent'),  (18,23,'2024-09-16','Present');

-- =====================================================
-- ASSIGNMENT
-- =====================================================

INSERT INTO assignment (section_id, title, description, total_marks, assigned_date, due_date, weightage) VALUES
-- CS101-A (Fall 2022)
(1, 'Assignment 1: Variables & Loops',     'Write 5 Python programs using variables and loops',        10, '2022-09-15', '2022-09-25', 5.00),
(1, 'Assignment 2: Functions',             'Implement recursive functions for factorial and Fibonacci', 10, '2022-10-05', '2022-10-15', 5.00),
(1, 'Assignment 3: OOP Basics',            'Define classes for Bank Account and Student',              15, '2022-11-01', '2022-11-15', 5.00),
-- CS201-A (Fall 2023)
(13,'Assignment 1: Linked Lists',          'Implement singly and doubly linked list',                  20, '2023-09-15', '2023-09-30', 7.00),
(13,'Assignment 2: Trees & BST',           'Implement BST with insert, delete, search',                20, '2023-10-15', '2023-10-30', 7.00),
-- CS202-A (Fall 2023)
(15,'Assignment 1: ER Diagram',            'Design ER diagram for library management system',          15, '2023-09-20', '2023-10-05', 5.00),
(15,'Assignment 2: SQL Queries',           'Write 10 SQL queries on given schema',                     20, '2023-10-20', '2023-11-05', 7.00),
-- CS404-A (Fall 2024)
(23,'Assignment 1: Linear Regression',     'Implement linear regression from scratch in Python',       25, '2024-09-15', '2024-09-30', 8.00),
(23,'Assignment 2: Classification Models', 'Train KNN, SVM, and Decision Tree on Iris dataset',        25, '2024-10-10', '2024-10-25', 8.00);

-- =====================================================
-- ASSIGNMENT SUBMISSION
-- =====================================================

INSERT INTO assignment_submission (assignment_id, student_id, submission_date, marks_obtained, remarks, status) VALUES
-- Assignment 1 CS101
(1,1,'2022-09-24 20:30:00',9.5,'Excellent work',               'Submitted'),
(1,2,'2022-09-25 10:00:00',10, 'Perfect',                      'Submitted'),
(1,3,'2022-09-26 12:00:00',7,  'Submitted late, marks deducted','Late'),
(1,4,'2022-09-24 18:00:00',8.5,'Good',                         'Submitted'),
(1,5,'2022-09-25 09:00:00',6,  'Average work',                 'Submitted'),
-- Assignment 2 CS101
(2,1,'2022-10-14 22:00:00',9,  'Well done',                    'Submitted'),
(2,2,'2022-10-15 08:00:00',10, 'Outstanding',                  'Submitted'),
(2,3,'2022-10-17 11:00:00',5,  'Late submission',              'Late'),
(2,4,'2022-10-14 20:00:00',8,  'Good',                         'Submitted'),
-- Assignment 1 CS201
(4,1,'2023-09-29 21:00:00',18, 'Great implementation',         'Submitted'),
(4,2,'2023-09-30 09:00:00',20, 'Perfect',                      'Submitted'),
(4,3,'2023-10-02 10:00:00',12, 'Late, issues in delete op',   'Late'),
(4,4,'2023-09-29 19:00:00',17, 'Minor edge case missed',       'Submitted'),
-- Assignment 1 CS202
(6,1,'2023-10-04 20:00:00',14, 'Good ER design',               'Submitted'),
(6,2,'2023-10-05 08:00:00',15, 'Perfect',                      'Submitted'),
(6,9,'2023-10-04 22:00:00',13, 'Missing weak entity',          'Submitted'),
(6,10,'2023-10-05 07:00:00',15,'Excellent',                    'Submitted'),
-- Assignment 1 ML (Fall 2024)
(8,16,'2024-09-29 21:00:00',23,'Good implementation',          'Submitted'),
(8,17,'2024-09-28 18:00:00',20,'Some formula errors',          'Submitted'),
(8,18,'2024-09-30 10:00:00',22,'Nice work',                    'Submitted');

-- =====================================================
-- QUIZ
-- =====================================================

INSERT INTO quiz (section_id, title, quiz_date, total_marks, weightage) VALUES
(1,  'Quiz 1: Python Basics',         '2022-09-28', 10, 2.50),
(1,  'Quiz 2: Functions & Lists',     '2022-10-26', 10, 2.50),
(13, 'Quiz 1: Arrays & Linked Lists', '2023-09-27', 10, 3.00),
(13, 'Quiz 2: Trees',                 '2023-10-25', 10, 3.00),
(15, 'Quiz 1: Relational Model',      '2023-09-28', 10, 3.00),
(23, 'Quiz 1: Regression Concepts',   '2024-09-18', 10, 3.00);

-- =====================================================
-- QUIZ RESULT
-- =====================================================

INSERT INTO quiz_result (quiz_id, student_id, obtained_marks, remarks) VALUES
-- Quiz 1 CS101
(1,1,9.5,'Excellent'), (1,2,10,'Perfect'), (1,3,7,'Good'), (1,4,8.5,'Good'), (1,5,6,'Average'),
-- Quiz 2 CS101
(2,1,9,  'Well done'), (2,2,10,'Perfect'), (2,3,6, 'Needs improvement'), (2,4,8,'Good'),
-- Quiz 1 CS201
(3,1,9,  'Well done'), (3,2,10,'Perfect'), (3,3,7, 'Good'), (3,4,8,'Good'), (3,5,5,'Weak'),
-- Quiz 2 CS201
(4,1,8.5,'Good'),      (4,2,10,'Perfect'), (4,3,6, 'Average'),             (4,4,9,'Very good'),
-- Quiz 1 CS202
(5,1,9,  'Good'),      (5,2,10,'Perfect'), (5,9,8.5,'Good'),               (5,10,10,'Perfect'),
-- Quiz 1 ML
(6,16,8.5,'Good'),     (6,17,7, 'Average'),(6,18,9, 'Well done');

-- =====================================================
-- EXAM
-- =====================================================

INSERT INTO exam (section_id, exam_type, exam_date, total_marks, weightage) VALUES
-- CS101-A
(1,  'Midterm', '2022-10-31', 30, 30.00),
(1,  'Final',   '2023-01-10', 50, 50.00),
-- CS201-A
(13, 'Midterm', '2023-11-06', 30, 30.00),
(13, 'Final',   '2024-01-15', 50, 50.00),
-- CS202-A
(15, 'Midterm', '2023-11-07', 30, 30.00),
(15, 'Final',   '2024-01-16', 50, 50.00),
-- CS301-A
(16, 'Midterm', '2023-11-08', 30, 30.00),
(16, 'Final',   '2024-01-17', 50, 50.00),
-- CS404-A
(23, 'Midterm', '2024-11-04', 30, 30.00),
(23, 'Final',   '2025-01-13', 50, 50.00);

-- =====================================================
-- EXAM RESULT
-- =====================================================

INSERT INTO exam_result (exam_id, student_id, obtained_marks, grade, remarks) VALUES
-- Midterm CS101
(1,1,27,'A+','Excellent'), (1,2,28,'A+','Outstanding'), (1,3,20,'B','Good'),
(1,4,24,'A', 'Good'),      (1,5,18,'C+','Average'),
-- Final CS101
(2,1,46,'A+','Excellent'), (2,2,49,'A+','Outstanding'), (2,3,35,'B','Good'),
(2,4,42,'A', 'Very Good'), (2,5,30,'C','Passed'),
-- Midterm CS201
(3,1,27,'A+','Excellent'), (3,2,29,'A+','Outstanding'), (3,3,21,'B','Good'),
(3,4,25,'A', 'Good'),      (3,5,14,'D','Below Average'),
-- Final CS201
(4,1,45,'A+','Excellent'), (4,2,49,'A+','Outstanding'), (4,3,34,'B','Good'),
(4,4,40,'A', 'Good'),      (4,5,25,'C','Passed'),
-- Midterm CS202
(5,1,28,'A+','Excellent'), (5,2,29,'A+','Outstanding'), (5,9,26,'A','Good'), (5,10,28,'A+','Perfect'),
-- Final CS202
(6,1,46,'A+','Excellent'), (6,2,48,'A+','Outstanding'), (6,9,43,'A','Good'), (6,10,47,'A+','Excellent'),
-- Midterm CS301
(7,1,26,'A', 'Good'),      (7,2,29,'A+','Outstanding'), (7,9,27,'A+','Excellent'), (7,10,28,'A+','Excellent'),
-- Final CS301
(8,1,44,'A', 'Good'),      (8,2,49,'A+','Outstanding'), (8,9,46,'A+','Excellent'), (8,10,47,'A+','Excellent');

-- =====================================================
-- GRADEBOOK
-- =====================================================

INSERT INTO gradebook (student_id, section_id, assignment_score, quiz_score, midterm_score, final_score, total_score, letter_grade, grade_points) VALUES
(1, 1,  9.33, 9.25, 27.00, 46.00, 91.58, 'A+', 4.00),
(2, 1,  10.0, 10.0, 28.00, 49.00, 97.00, 'A+', 4.00),
(3, 1,  6.33, 6.50, 20.00, 35.00, 67.83, 'B',  3.00),
(4, 1,  8.25, 8.25, 24.00, 42.00, 82.50, 'A',  4.00),
(5, 1,  6.00, 6.00, 18.00, 30.00, 60.00, 'C',  2.00),
(1, 13, 17.50,8.75, 27.00, 45.00, 88.50, 'A+', 4.00),
(2, 13, 20.0, 10.0, 29.00, 49.00, 97.50, 'A+', 4.00),
(3, 13, 12.0, 6.50, 21.00, 34.00, 67.50, 'B',  3.00),
(4, 13, 17.0, 8.50, 25.00, 40.00, 85.00, 'A',  4.00),
(5, 13, NULL, 5.00, 14.00, 25.00, 49.50, 'D',  1.00),
(1, 15, 13.5, 9.00, 28.00, 46.00, 90.00, 'A+', 4.00),
(2, 15, 15.0, 10.0, 29.00, 48.00, 96.00, 'A+', 4.00),
(9, 15, 13.0, 8.50, 26.00, 43.00, 86.00, 'A',  4.00),
(10,15, 15.0, 10.0, 28.00, 47.00, 95.00, 'A+', 4.00);

-- =====================================================
-- TRANSCRIPT
-- =====================================================

INSERT INTO transcript (student_id, semester_id, generated_date, semester_gpa, cumulative_gpa, remarks) VALUES
(1,  1, '2023-01-25', 3.80, 3.80, 'Good academic standing'),
(2,  1, '2023-01-25', 4.00, 4.00, 'Dean''s List'),
(3,  1, '2023-01-25', 3.00, 3.00, 'Satisfactory'),
(4,  1, '2023-01-25', 3.70, 3.70, 'Good academic standing'),
(5,  1, '2023-01-25', 2.50, 2.50, 'Academic Warning'),
(1,  2, '2023-06-25', 3.85, 3.82, 'Good academic standing'),
(2,  2, '2023-06-25', 4.00, 4.00, 'Dean''s List'),
(1,  4, '2024-01-28', 3.90, 3.85, 'Good academic standing'),
(2,  4, '2024-01-28', 4.00, 4.00, 'Dean''s List'),
(9,  4, '2024-01-28', 3.75, 3.70, 'Good academic standing'),
(10, 4, '2024-01-28', 4.00, 3.90, 'Dean''s List');

-- =====================================================
-- COURSE REGISTRATION
-- =====================================================

INSERT INTO course_registration (student_id, semester_id, registration_date, status) VALUES
(1,  7, '2024-08-25', 'Approved'),
(2,  7, '2024-08-25', 'Approved'),
(3,  7, '2024-08-26', 'Approved'),
(16, 7, '2024-08-25', 'Approved'),
(17, 7, '2024-08-25', 'Approved'),
(18, 7, '2024-08-26', 'Approved'),
(1,  8, '2025-01-20', 'Pending'),
(2,  8, '2025-01-20', 'Pending');

INSERT INTO registration_detail (registration_id, section_id) VALUES
(1, 23), (1, 24), (1, 25),
(2, 23), (2, 24),
(3, 25),
(4, 23), (4, 24), (4, 25),
(5, 23),
(6, 25);

-- =====================================================
-- ACADEMIC ADVISOR
-- =====================================================

INSERT INTO academic_advisor (student_id, instructor_id, assigned_date) VALUES
(1,  1, '2022-09-10'), (2,  1, '2022-09-10'), (3,  2, '2022-09-10'),
(4,  2, '2022-09-10'), (5,  3, '2022-09-10'), (6,  3, '2022-09-10'),
(7,  4, '2022-09-10'), (8,  4, '2022-09-10'), (9,  1, '2021-09-06'),
(10, 2, '2021-09-06'), (11, 5, '2022-09-10'), (12, 6, '2022-09-10'),
(13, 7, '2022-09-10'), (14, 7, '2022-09-10'), (15,12, '2022-09-10'),
(16, 1, '2023-09-04'), (17, 3, '2023-09-04'), (18, 2, '2023-09-04');

-- =====================================================
-- COURSE EVALUATION
-- =====================================================

INSERT INTO course_evaluation (student_id, section_id, rating, comments, evaluation_date) VALUES
(1,  1,  5, 'Excellent instructor, very clear explanations.',          '2023-01-12'),
(2,  1,  5, 'Best course of the semester. Highly recommend.',          '2023-01-12'),
(3,  1,  3, 'Average, needed more practical examples.',                '2023-01-12'),
(4,  1,  4, 'Good course content, engaging lectures.',                 '2023-01-12'),
(5,  1,  3, 'Concepts were hard to grasp initially.',                  '2023-01-12'),
(1,  13, 5, 'DSA is challenging but sir made it manageable.',          '2024-01-20'),
(2,  13, 5, 'Loved the assignments, great learning experience.',       '2024-01-20'),
(3,  13, 4, 'Good course, would like more practice sessions.',         '2024-01-20'),
(1,  15, 5, 'DBMS was very well structured.',                          '2024-01-20'),
(9,  16, 5, 'OS course is excellent. Very relevant concepts.',         '2024-01-20'),
(10, 16, 5, 'Prof Ahmed is one of the best faculty members.',         '2024-01-20');

-- =====================================================
-- FEE CATEGORY
-- =====================================================

INSERT INTO fee_category (category_name, description) VALUES
('Tuition Fee',         'Per semester tuition charges'),
('Admission Fee',       'One-time admission processing fee'),
('Library Fee',         'Annual library access fee'),
('Sports Fee',          'Annual sports facilities fee'),
('Examination Fee',     'Per semester examination fee'),
('Lab Fee',             'Lab usage and consumables'),
('Security Deposit',    'Refundable security deposit'),
('Transport Fee',       'Per semester transport charges'),
('Hostel Fee',          'Per semester hostel accommodation'),
('Internet/IT Fee',     'Campus network and IT services fee');

-- =====================================================
-- FEE STRUCTURE
-- =====================================================

INSERT INTO fee_structure (program_id, category_id, amount, effective_date) VALUES
-- BSCS
(1, 1, 45000.00, '2022-01-01'),
(1, 3,  5000.00, '2022-01-01'),
(1, 4,  3000.00, '2022-01-01'),
(1, 5,  3000.00, '2022-01-01'),
(1, 6,  5000.00, '2022-01-01'),
(1,10,  2000.00, '2022-01-01'),
-- BSEE
(4, 1, 48000.00, '2022-01-01'),
(4, 5,  3000.00, '2022-01-01'),
(4, 6,  6000.00, '2022-01-01'),
-- BBA
(6, 1, 40000.00, '2022-01-01'),
(6, 5,  3000.00, '2022-01-01');

-- =====================================================
-- STUDENT FEE ACCOUNT
-- =====================================================

INSERT INTO student_fee_account (student_id, current_balance, total_paid, total_due) VALUES
(1,  0.00,    261000.00, 261000.00),
(2,  0.00,    261000.00, 261000.00),
(3,  5000.00, 200000.00, 205000.00),
(4,  0.00,    200000.00, 200000.00),
(5,  10000.00,180000.00, 190000.00),
(6,  0.00,    200000.00, 200000.00),
(7,  0.00,    200000.00, 200000.00),
(8,  15000.00,170000.00, 185000.00),
(9,  0.00,    290000.00, 290000.00),
(10, 0.00,    290000.00, 290000.00),
(11, 0.00,    200000.00, 200000.00),
(12, 0.00,    200000.00, 200000.00),
(13, 0.00,    185000.00, 185000.00),
(14, 0.00,    185000.00, 185000.00),
(15, 0.00,    200000.00, 200000.00),
(16, 0.00,     63000.00,  63000.00),
(17, 0.00,     63000.00,  63000.00),
(18, 0.00,     63000.00,  63000.00);

-- =====================================================
-- INVOICE
-- =====================================================

INSERT INTO invoice (student_id, semester_id, invoice_date, due_date, total_amount, status) VALUES
(1, 1, '2022-09-01', '2022-09-20', 63000.00, 'Paid'),
(2, 1, '2022-09-01', '2022-09-20', 63000.00, 'Paid'),
(3, 1, '2022-09-01', '2022-09-20', 63000.00, 'Partially Paid'),
(4, 1, '2022-09-01', '2022-09-20', 63000.00, 'Paid'),
(5, 1, '2022-09-01', '2022-09-20', 63000.00, 'Overdue'),
(1, 2, '2023-02-01', '2023-02-20', 63000.00, 'Paid'),
(2, 2, '2023-02-01', '2023-02-20', 63000.00, 'Paid'),
(1, 4, '2023-09-01', '2023-09-20', 63000.00, 'Paid'),
(2, 4, '2023-09-01', '2023-09-20', 63000.00, 'Paid'),
(3, 4, '2023-09-01', '2023-09-20', 63000.00, 'Partially Paid'),
(16,7, '2024-09-01', '2024-09-20', 63000.00, 'Paid'),
(17,7, '2024-09-01', '2024-09-20', 63000.00, 'Paid'),
(18,7, '2024-09-01', '2024-09-20', 63000.00, 'Pending');

-- =====================================================
-- INVOICE DETAIL
-- =====================================================

INSERT INTO invoice_detail (invoice_id, category_id, amount) VALUES
(1, 1, 45000.00), (1, 3, 5000.00), (1, 4, 3000.00), (1, 5, 3000.00), (1, 6, 5000.00), (1, 10, 2000.00),
(2, 1, 45000.00), (2, 3, 5000.00), (2, 4, 3000.00), (2, 5, 3000.00), (2, 6, 5000.00), (2, 10, 2000.00),
(3, 1, 45000.00), (3, 3, 5000.00), (3, 4, 3000.00), (3, 5, 3000.00), (3, 6, 5000.00), (3, 10, 2000.00),
(4, 1, 45000.00), (4, 3, 5000.00), (4, 4, 3000.00), (4, 5, 3000.00), (4, 6, 5000.00), (4, 10, 2000.00),
(5, 1, 45000.00), (5, 3, 5000.00), (5, 4, 3000.00), (5, 5, 3000.00), (5, 6, 5000.00), (5, 10, 2000.00);

-- =====================================================
-- PAYMENT
-- =====================================================

INSERT INTO payment (invoice_id, payment_date, amount_paid, payment_method, reference_number) VALUES
(1, '2022-09-15 10:30:00', 63000.00, 'Bank Transfer',   'TXN-2022-0001'),
(2, '2022-09-15 11:00:00', 63000.00, 'Online Payment',  'TXN-2022-0002'),
(3, '2022-09-18 09:00:00', 40000.00, 'Cash',            'TXN-2022-0003'),
(4, '2022-09-14 14:00:00', 63000.00, 'Bank Transfer',   'TXN-2022-0004'),
(6, '2023-02-15 10:00:00', 63000.00, 'Bank Transfer',   'TXN-2023-0001'),
(7, '2023-02-15 11:30:00', 63000.00, 'Online Payment',  'TXN-2023-0002'),
(8, '2023-09-10 09:00:00', 63000.00, 'Bank Transfer',   'TXN-2023-0101'),
(9, '2023-09-10 10:00:00', 63000.00, 'Online Payment',  'TXN-2023-0102'),
(10,'2023-09-12 09:00:00', 45000.00, 'Cash',            'TXN-2023-0103'),
(11,'2024-09-15 10:00:00', 63000.00, 'Bank Transfer',   'TXN-2024-0001'),
(12,'2024-09-14 11:00:00', 63000.00, 'Online Payment',  'TXN-2024-0002');

-- =====================================================
-- PAYMENT TRANSACTION
-- =====================================================

INSERT INTO payment_transaction (payment_id, gateway_name, transaction_reference, transaction_status) VALUES
(1,  'HBL Bank',         'HBL-20220915-001', 'Successful'),
(2,  'JazzCash',         'JC-20220915-001',  'Successful'),
(3,  NULL,               NULL,               'Successful'),
(4,  'MCB Bank',         'MCB-20220914-001', 'Successful'),
(5,  'Easypaisa',        'EP-20230215-001',  'Successful'),
(6,  'JazzCash',         'JC-20230215-002',  'Successful'),
(7,  'HBL Bank',         'HBL-20230910-001', 'Successful'),
(8,  'JazzCash',         'JC-20230910-001',  'Successful'),
(9,  'MCB Bank',         'MCB-20230912-001', 'Successful'),
(10, 'HBL Bank',         'HBL-20240915-001', 'Successful'),
(11, 'JazzCash',         'JC-20240914-001',  'Successful');

-- =====================================================
-- SCHOLARSHIP
-- =====================================================

INSERT INTO scholarship (scholarship_name, sponsor, scholarship_type, amount) VALUES
('HEC Need-Based Scholarship',         'Higher Education Commission',  'Need Based', 40000.00),
('University Merit Award',             'University Endowment Fund',    'Merit',      30000.00),
('Sports Excellence Award',            'University Sports Board',      'Sports',     20000.00),
('Research Assistantship',             'CS Department',                'Research',   50000.00),
('Dean''s Excellence Scholarship',    'University Administration',    'Merit',      35000.00);

-- =====================================================
-- STUDENT SCHOLARSHIP
-- =====================================================

INSERT INTO student_scholarship (student_id, scholarship_id, award_date, status) VALUES
(2,  2, '2022-12-01', 'Active'),   -- Zainab: Merit
(2,  5, '2023-06-01', 'Active'),   -- Zainab: Dean's
(10, 2, '2022-12-01', 'Active'),   -- Nimra: Merit
(5,  1, '2022-11-01', 'Active'),   -- Daniyal: Need-based
(8,  1, '2022-11-01', 'Active'),   -- Sadia: Need-based
(1,  4, '2023-09-15', 'Active'),   -- Ali: Research
(9,  4, '2023-09-15', 'Active');   -- Faisal: Research

-- =====================================================
-- FINANCIAL AID
-- =====================================================

INSERT INTO financial_aid (student_id, aid_type, amount, approval_date) VALUES
(5,  'Loan',          50000.00, '2022-11-15'),
(8,  'Grant',         30000.00, '2023-02-01'),
(3,  'Emergency Fund',15000.00, '2023-10-10');

-- =====================================================
-- INSTALLMENT PLAN
-- =====================================================

INSERT INTO installment_plan (invoice_id, installment_number, due_date, amount, status) VALUES
(3, 1, '2022-09-20', 21000.00, 'Paid'),
(3, 2, '2022-10-20', 21000.00, 'Paid'),
(3, 3, '2022-11-20', 21000.00, 'Pending');

-- =====================================================
-- LATE FEE PENALTY
-- =====================================================

INSERT INTO late_fee_penalty (invoice_id, penalty_amount, penalty_date, reason) VALUES
(5,  1000.00, '2022-09-25', 'Payment not received by due date'),
(10, 500.00,  '2023-09-25', 'Late payment after deadline');

-- =====================================================
-- FINANCIAL LEDGER
-- =====================================================

INSERT INTO financial_ledger (student_id, transaction_date, transaction_type, amount, description) VALUES
(1,  '2022-09-15 10:30:00', 'Invoice',     63000.00, 'Fall 2022 Semester Invoice'),
(1,  '2022-09-15 10:30:00', 'Payment',     63000.00, 'Payment received via Bank Transfer'),
(2,  '2022-09-15 11:00:00', 'Invoice',     63000.00, 'Fall 2022 Semester Invoice'),
(2,  '2022-09-15 11:00:00', 'Payment',     63000.00, 'Payment received via JazzCash'),
(2,  '2022-12-01 00:00:00', 'Scholarship', 30000.00, 'Merit Scholarship Awarded'),
(5,  '2022-09-01 00:00:00', 'Invoice',     63000.00, 'Fall 2022 Semester Invoice'),
(5,  '2022-09-25 00:00:00', 'Penalty',      1000.00, 'Late payment penalty applied'),
(5,  '2022-11-15 00:00:00', 'Scholarship', 40000.00, 'HEC Need-Based Scholarship'),
(1,  '2023-09-10 09:00:00', 'Invoice',     63000.00, 'Fall 2023 Semester Invoice'),
(1,  '2023-09-10 09:00:00', 'Payment',     63000.00, 'Payment received via Bank Transfer'),
(1,  '2023-09-15 00:00:00', 'Scholarship', 50000.00, 'Research Assistantship Awarded');

-- =====================================================
-- REFUND
-- =====================================================

INSERT INTO refund (student_id, invoice_id, refund_amount, refund_date, reason) VALUES
(20, NULL, 10000.00, '2023-11-01', 'Student dropped, partial refund of security deposit');

-- =====================================================
-- BOOK CATEGORY
-- =====================================================

INSERT INTO book_category (category_name, description) VALUES
('Computer Science',    'Programming, algorithms, AI/ML textbooks'),
('Engineering',         'Electrical, mechanical and civil engineering texts'),
('Mathematics',         'Calculus, algebra and statistics books'),
('Business',            'Management, finance and marketing books'),
('Physics',             'Classical and modern physics textbooks'),
('Literature',          'Fiction, non-fiction and language books'),
('Research & Journals', 'Academic journals and research publications'),
('Reference',           'Dictionaries, encyclopedias and atlases');

-- =====================================================
-- AUTHOR
-- =====================================================

INSERT INTO author (first_name, last_name, nationality, date_of_birth) VALUES
('Thomas',   'Cormen',      'American',  '1956-06-01'),
('Charles',  'Leiserson',   'American',  '1953-08-10'),
('Abraham',  'Silberschatz','American',  '1952-05-20'),
('Ramez',    'Elmasri',     'American',  '1951-03-15'),
('Andrew',   'Tanenbaum',   'American',  '1944-03-16'),
('Stuart',   'Russell',     'British',   '1962-05-01'),
('Peter',    'Norvig',      'American',  '1956-12-14'),
('Ian',      'Goodfellow',  'Canadian',  '1986-01-01'),
('William',  'Stallings',   'American',  '1945-07-19'),
('Harvey',   'Deitel',      'American',  '1945-01-01');

-- =====================================================
-- PUBLISHER
-- =====================================================

INSERT INTO publisher (publisher_name, country, website) VALUES
('MIT Press',                       'USA',   'https://mitpress.mit.edu'),
('McGraw-Hill Education',           'USA',   'https://www.mheducation.com'),
('Pearson Education',               'USA',   'https://www.pearson.com'),
('O''Reilly Media',                 'USA',   'https://www.oreilly.com'),
('Wiley',                           'USA',   'https://www.wiley.com'),
('Oxford University Press',         'UK',    'https://global.oup.com'),
('Addison-Wesley',                  'USA',   'https://www.pearson.com'),
('Cambridge University Press',      'UK',    'https://www.cambridge.org');

-- =====================================================
-- BOOK
-- =====================================================

INSERT INTO book (category_id, publisher_id, isbn, title, edition, publication_year, language, total_pages) VALUES
(1, 1,  '978-0262033848', 'Introduction to Algorithms',                  '4th', 2022, 'English', 1312),
(1, 3,  '978-0136042594', 'Operating System Concepts',                   '10th',2018, 'English',  976),
(1, 2,  '978-0078022159', 'Database System Concepts',                    '7th', 2019, 'English',  1376),
(1, 3,  '978-0136019671', 'Computer Networks: A Top-Down Approach',      '8th', 2020, 'English',  864),
(1, 1,  '978-0262043793', 'Artificial Intelligence: A Modern Approach',  '4th', 2020, 'English',  1132),
(1, 1,  '978-0262035613', 'Deep Learning',                               '1st', 2016, 'English',  800),
(1, 4,  '978-1492032649', 'Python Data Science Handbook',                '2nd', 2022, 'English',  548),
(2, 3,  '978-0131391710', 'Computer Organization and Architecture',      '10th',2015, 'English',  800),
(3, 7,  '978-0321999221', 'Thomas Calculus',                             '14th',2017, 'English', 1212),
(3, 5,  '978-0471321484', 'Linear Algebra and Its Applications',         '5th', 2015, 'English',  576),
(4, 2,  '978-0073524597', 'Principles of Management',                    '12th',2019, 'English',  576),
(5, 8,  '978-1108470087', 'University Physics',                          '15th',2019, 'English', 1696),
(6, 6,  '978-0198390312', 'The Oxford English Dictionary',               '3rd', 2010, 'English',  22000),
(1, 5,  '978-1119562740', 'Information Security: Principles and Practice','3rd',2018, 'English',  480),
(7, 8,  '978-1108476126', 'Nature Machine Intelligence Journal Vol.5',    NULL,  2023, 'English',  350);

-- =====================================================
-- BOOK AUTHOR
-- =====================================================

INSERT INTO book_author (book_id, author_id) VALUES
(1, 1), (1, 2),   -- Algorithms: Cormen, Leiserson
(2, 9),           -- OS Concepts: Stallings
(3, 3),           -- DBMS: Silberschatz
(4, 5),           -- Networks: Tanenbaum
(5, 6), (5, 7),   -- AI: Russell, Norvig
(6, 8),           -- Deep Learning: Goodfellow
(8, 10);          -- Computer Organization: Deitel

-- =====================================================
-- BOOK COPY
-- =====================================================

INSERT INTO book_copy (book_id, barcode, acquisition_date, shelf_location, status) VALUES
(1, 'BC-0001', '2020-01-10', 'CS-A1-S1', 'Available'),
(1, 'BC-0002', '2020-01-10', 'CS-A1-S1', 'Issued'),
(1, 'BC-0003', '2022-08-05', 'CS-A1-S1', 'Available'),
(2, 'BC-0004', '2019-06-15', 'CS-A1-S2', 'Available'),
(2, 'BC-0005', '2019-06-15', 'CS-A1-S2', 'Issued'),
(3, 'BC-0006', '2021-01-20', 'CS-A2-S1', 'Available'),
(3, 'BC-0007', '2021-01-20', 'CS-A2-S1', 'Issued'),
(4, 'BC-0008', '2021-03-10', 'CS-A2-S2', 'Available'),
(5, 'BC-0009', '2021-05-20', 'CS-A3-S1', 'Available'),
(5, 'BC-0010', '2021-05-20', 'CS-A3-S1', 'Issued'),
(6, 'BC-0011', '2022-07-01', 'CS-A3-S2', 'Available'),
(7, 'BC-0012', '2022-09-01', 'CS-A4-S1', 'Available'),
(9, 'BC-0013', '2018-01-15', 'MTH-A1-S1','Available'),
(9, 'BC-0014', '2018-01-15', 'MTH-A1-S1','Issued'),
(10,'BC-0015', '2018-03-20', 'MTH-A1-S2','Available'),
(11,'BC-0016', '2020-02-10', 'BBA-A1-S1','Available'),
(12,'BC-0017', '2019-08-20', 'PHY-A1-S1','Available'),
(14,'BC-0018', '2020-09-05', 'CS-A5-S1', 'Available'),
(14,'BC-0019', '2020-09-05', 'CS-A5-S1', 'Damaged');

-- =====================================================
-- LIBRARY MEMBER
-- =====================================================

INSERT INTO library_member (student_id, instructor_id, membership_date, expiry_date, status) VALUES
(1,  NULL, '2022-09-10', '2026-09-10', 'Active'),
(2,  NULL, '2022-09-10', '2026-09-10', 'Active'),
(3,  NULL, '2022-09-10', '2026-09-10', 'Active'),
(4,  NULL, '2022-09-10', '2026-09-10', 'Active'),
(5,  NULL, '2022-09-10', '2026-09-10', 'Active'),
(6,  NULL, '2022-09-10', '2026-09-10', 'Active'),
(9,  NULL, '2021-09-10', '2025-09-10', 'Active'),
(10, NULL, '2021-09-10', '2025-09-10', 'Active'),
(11, NULL, '2022-09-10', '2026-09-10', 'Active'),
(16, NULL, '2023-09-05', '2027-09-05', 'Active'),
(NULL, 1,  '2010-09-01', '2026-09-01', 'Active'),
(NULL, 2,  '2013-03-01', '2026-03-01', 'Active'),
(NULL, 3,  '2017-09-10', '2026-09-10', 'Active');

-- =====================================================
-- BOOK ISSUE
-- =====================================================

INSERT INTO book_issue (copy_id, member_id, issue_date, due_date) VALUES
(2,  1,  '2023-10-05', '2023-10-19'),  -- Algorithms copy 2 to student 1
(5,  2,  '2023-10-06', '2023-10-20'),  -- OS copy 2 to student 2
(7,  3,  '2023-11-01', '2023-11-15'),  -- DBMS copy 2 to student 3
(10, 4,  '2023-11-10', '2023-11-24'),  -- AI copy 2 to student 4
(14, 7,  '2024-01-08', '2024-01-22'),  -- Calculus to member 7
(2,  11, '2024-09-10', '2024-09-24'),  -- Algorithms to member 11
(10, 12, '2024-09-11', '2024-09-25');  -- AI to member 12

-- =====================================================
-- BOOK RETURN
-- =====================================================

INSERT INTO book_return (issue_id, return_date, remarks) VALUES
(1, '2023-10-18', 'Returned in good condition'),
(2, '2023-10-22', 'Returned 2 days late'),
(3, '2023-11-14', 'Returned in good condition'),
(4, '2023-11-30', 'Returned late, fine applied'),
(5, '2024-01-20', 'Returned in good condition');

-- =====================================================
-- LIBRARY FINE
-- =====================================================

INSERT INTO library_fine (issue_id, amount, fine_reason, paid_status) VALUES
(2, 40.00,  'Overdue return: 2 days × PKR 20/day', 'Paid'),
(4, 300.00, 'Overdue return: 6 days × PKR 50/day', 'Unpaid');

-- =====================================================
-- BOOK RESERVATION
-- =====================================================

INSERT INTO book_reservation (member_id, book_id, reservation_date, status) VALUES
(5,  1, '2023-10-10', 'Fulfilled'),
(8,  5, '2023-11-15', 'Pending'),
(9,  6, '2024-01-05', 'Pending'),
(10, 3, '2024-02-01', 'Cancelled');

-- =====================================================
-- DIGITAL RESOURCE
-- =====================================================

INSERT INTO digital_resource (title, resource_type, file_url, upload_date) VALUES
('Introduction to Python Programming',              'Video Lecture',  '/digital/lectures/python-intro.mp4',         '2022-09-01'),
('DSA Notes Semester 4',                           'EBook',          '/digital/ebooks/dsa-notes-s4.pdf',           '2023-08-15'),
('Network Intrusion Detection using ML - Thesis',  'Thesis',         '/digital/thesis/nids-ml-2024.pdf',           '2024-07-01'),
('IEEE Transactions on Neural Networks Vol.33',    'Journal',        '/digital/journals/ieee-tnn-v33.pdf',         '2022-03-01'),
('ACM Computing Surveys - Federated Learning',     'Research Paper', '/digital/papers/federated-learning-acm.pdf', '2021-11-01'),
('Linear Algebra Lecture Series',                  'Video Lecture',  '/digital/lectures/linear-algebra.mp4',       '2023-01-10'),
('Deep Learning with PyTorch',                     'EBook',          '/digital/ebooks/dl-pytorch.pdf',             '2023-06-01');

-- =====================================================
-- READING ROOM
-- =====================================================

INSERT INTO reading_room (room_name, capacity) VALUES
('Reading Room A', 40),
('Reading Room B', 30),
('Discussion Room 1', 10),
('Discussion Room 2', 10),
('Postgrad Research Room', 20);

-- =====================================================
-- READING ROOM RESERVATION
-- =====================================================

INSERT INTO reading_room_reservation (member_id, room_id, reservation_date, start_time, end_time) VALUES
(1, 1, '2024-10-05', '09:00:00', '12:00:00'),
(2, 3, '2024-10-05', '10:00:00', '12:00:00'),
(7, 5, '2024-10-06', '09:00:00', '13:00:00'),
(11,2, '2024-10-07', '14:00:00', '17:00:00');

-- =====================================================
-- BOOK DONATION
-- =====================================================

INSERT INTO book_donation (donor_name, book_id, donation_date) VALUES
('Dr. Ahmed Khan',        5,    '2022-06-01'),
('Punjab Public Library', 1,    '2021-12-15'),
('Mr. Tariq Hassan',      NULL, '2023-03-10');

-- =====================================================
-- HOSTEL
-- =====================================================

INSERT INTO hostel (hostel_name, hostel_type, total_capacity, address) VALUES
('Al-Biruni Hostel',  'Male',   200, 'North Campus, University Road'),
('Al-Razi Hostel',    'Male',   150, 'North Campus, University Road'),
('Rabia Basri Hostel','Female', 180, 'South Campus, University Road'),
('Fatima Hostel',     'Female', 160, 'South Campus, University Road');

-- =====================================================
-- HOSTEL BLOCK
-- =====================================================

INSERT INTO hostel_block (hostel_id, block_name, number_of_floors) VALUES
(1, 'Block A', 4),
(1, 'Block B', 4),
(2, 'Block A', 3),
(3, 'Block A', 4),
(3, 'Block B', 4),
(4, 'Block A', 3);

-- =====================================================
-- HOSTEL ROOM
-- =====================================================

INSERT INTO hostel_room (block_id, room_number, room_type, capacity) VALUES
(1, '101', 'Double', 2),
(1, '102', 'Double', 2),
(1, '103', 'Triple', 3),
(1, '104', 'Single', 1),
(2, '201', 'Double', 2),
(2, '202', 'Double', 2),
(3, '101', 'Double', 2),
(4, '101', 'Double', 2),
(4, '102', 'Triple', 3),
(5, '201', 'Double', 2),
(6, '101', 'Single', 1);

-- =====================================================
-- BED
-- =====================================================

INSERT INTO bed (room_id, bed_number, status) VALUES
(1, 'B1', 'Occupied'),  (1, 'B2', 'Occupied'),
(2, 'B1', 'Available'), (2, 'B2', 'Available'),
(3, 'B1', 'Occupied'),  (3, 'B2', 'Occupied'),  (3, 'B3', 'Available'),
(4, 'B1', 'Occupied'),
(5, 'B1', 'Occupied'),  (5, 'B2', 'Available'),
(6, 'B1', 'Available'), (6, 'B2', 'Available'),
(7, 'B1', 'Available'), (7, 'B2', 'Available'),
(8, 'B1', 'Occupied'),  (8, 'B2', 'Occupied'),
(9, 'B1', 'Available'), (9, 'B2', 'Available'), (9, 'B3', 'Occupied'),
(10,'B1', 'Available'), (10,'B2', 'Occupied'),
(11,'B1', 'Available');

-- =====================================================
-- ROOM ALLOCATION
-- =====================================================

INSERT INTO room_allocation (student_id, bed_id, allocation_date, checkout_date, status) VALUES
(1,  1,  '2022-09-08', NULL,         'Active'),
(3,  5,  '2022-09-08', NULL,         'Active'),
(7,  8,  '2022-09-08', NULL,         'Active'),
(9,  9,  '2021-09-08', NULL,         'Active'),
(2,  15, '2022-09-08', NULL,         'Active'),
(10, 16, '2021-09-08', NULL,         'Active'),
(4,  19, '2022-09-08', NULL,         'Active'),
(20, 2,  '2020-09-10', '2024-06-30', 'Completed');

-- =====================================================
-- HOSTEL FEE
-- =====================================================

INSERT INTO hostel_fee (student_id, semester_id, amount, payment_status) VALUES
(1, 1, 18000.00, 'Paid'),
(1, 2, 18000.00, 'Paid'),
(1, 4, 18000.00, 'Paid'),
(3, 1, 18000.00, 'Paid'),
(3, 2, 18000.00, 'Paid'),
(7, 1, 18000.00, 'Paid'),
(2, 1, 18000.00, 'Paid'),
(2, 2, 18000.00, 'Paid'),
(9, 1, 18000.00, 'Paid'),
(1, 7, 18000.00, 'Paid'),
(3, 7, 18000.00, 'Partial');

-- =====================================================
-- HOSTEL VISITOR
-- =====================================================

INSERT INTO hostel_visitor (student_id, visitor_name, relationship_type, visit_date, entry_time, exit_time) VALUES
(1, 'Tariq Hassan',   'Father', '2023-04-15', '10:00:00', '15:00:00'),
(3, 'Saleem Tariq',   'Father', '2023-05-20', '11:00:00', '14:00:00'),
(2, 'Sajida Farooq',  'Mother', '2023-06-10', '09:30:00', '13:00:00'),
(7, 'Shafiq Hussain', 'Father', '2024-02-25', '10:00:00', '16:00:00');

-- =====================================================
-- HOSTEL COMPLAINT
-- =====================================================

INSERT INTO hostel_complaint (student_id, complaint_type, description, complaint_date, status) VALUES
(1, 'Maintenance',    'Hot water not working in bathroom.',               '2023-02-10', 'Resolved'),
(3, 'Noise',          'Roommates playing loud music at midnight.',        '2023-03-15', 'Closed'),
(7, 'Maintenance',    'Room ceiling fan is broken.',                     '2023-09-20', 'In Progress'),
(9, 'Electricity',    'Power socket in room not working.',               '2024-01-05', 'Open'),
(2, 'Cleanliness',    'Common bathroom not cleaned for 3 days.',         '2024-02-10', 'Resolved');

-- =====================================================
-- MAINTENANCE REQUEST
-- =====================================================

INSERT INTO maintenance_request (room_id, reported_by, issue_description, request_date, status) VALUES
(1,  1, 'Hot water geyser not working.',        '2023-02-10', 'Completed'),
(3,  7, 'Ceiling fan broken, needs replacement.','2023-09-20', 'Assigned'),
(9,  4, 'Window latch broken.',                 '2024-01-10', 'Pending');

-- =====================================================
-- MESS
-- =====================================================

INSERT INTO mess (hostel_id, mess_name, capacity) VALUES
(1, 'Al-Biruni Dining Hall', 200),
(2, 'Al-Razi Mess',          150),
(3, 'Rabia Basri Dining',    180),
(4, 'Fatima Mess',           160);

-- =====================================================
-- MEAL PLAN
-- =====================================================

INSERT INTO meal_plan (mess_id, plan_name, monthly_fee) VALUES
(1, 'Full Board (3 meals)',  8000.00),
(1, 'Half Board (2 meals)',  5500.00),
(2, 'Full Board (3 meals)',  8000.00),
(3, 'Full Board (3 meals)',  8000.00),
(3, 'Half Board (2 meals)',  5500.00);

-- =====================================================
-- STUDENT MEAL PLAN
-- =====================================================

INSERT INTO student_meal_plan (student_id, meal_plan_id, start_date, end_date) VALUES
(1, 1, '2022-09-08', '2023-01-20'),
(3, 1, '2022-09-08', '2023-01-20'),
(7, 1, '2022-09-08', '2023-01-20'),
(9, 3, '2021-09-08', '2022-01-20'),
(2, 4, '2022-09-08', '2023-01-20'),
(1, 1, '2023-09-05', '2024-01-25');

-- =====================================================
-- HOSTEL INVENTORY
-- =====================================================

INSERT INTO hostel_inventory (hostel_id, item_name, quantity, purchase_date) VALUES
(1, 'Single Bed',          50,  '2020-01-15'),
(1, 'Study Table',         50,  '2020-01-15'),
(1, 'Chair',               100, '2020-01-15'),
(1, 'Mattress',            50,  '2020-01-15'),
(3, 'Single Bed',          45,  '2020-01-20'),
(3, 'Study Table',         45,  '2020-01-20'),
(3, 'Room Heater',         20,  '2022-11-01'),
(1, 'Fire Extinguisher',   10,  '2021-06-01');

-- =====================================================
-- TRANSPORT ROUTE
-- =====================================================

INSERT INTO transport_route (route_name, route_description, estimated_distance_km) VALUES
('Route 1 - Johar Town',       'University → Liberty → Johar Town',           18.50),
('Route 2 - DHA',              'University → Gulberg → DHA Phase 5',          22.00),
('Route 3 - Model Town',       'University → Canal → Model Town',             15.00),
('Route 4 - Bahria Town',      'University → Ring Road → Bahria Town',        35.00),
('Route 5 - Samanabad',        'University → GT Road → Samanabad',            12.00);

-- =====================================================
-- BUS STOP
-- =====================================================

INSERT INTO bus_stop (route_id, stop_name, stop_order, arrival_time) VALUES
(1, 'University Gate',   1, '07:00:00'),
(1, 'Liberty Market',    2, '07:20:00'),
(1, 'Expo Centre',       3, '07:35:00'),
(1, 'Johar Town Stop',   4, '07:50:00'),
(2, 'University Gate',   1, '07:00:00'),
(2, 'Gulberg Main Blvd', 2, '07:25:00'),
(2, 'DHA Y Block',       3, '07:50:00'),
(3, 'University Gate',   1, '07:00:00'),
(3, 'Canal Bank Road',   2, '07:15:00'),
(3, 'Model Town Stop',   3, '07:30:00');

-- =====================================================
-- VEHICLE
-- =====================================================

INSERT INTO vehicle (vehicle_number, vehicle_type, model, manufacturer, seating_capacity, purchase_date, status) VALUES
('LEA-1001', 'Bus',      'Super Falcon',  'Hino',        45, '2019-06-01', 'Active'),
('LEA-1002', 'Bus',      'Super Falcon',  'Hino',        45, '2020-03-15', 'Active'),
('LEA-2001', 'Coaster',  'Rosa',          'Toyota',      30, '2021-01-10', 'Active'),
('LEA-2002', 'Coaster',  'Rosa',          'Toyota',      30, '2021-01-10', 'Active'),
('LEA-3001', 'Van',      'Hiace',         'Toyota',      14, '2020-08-20', 'Active'),
('LEA-3002', 'Van',      'Hiace',         'Toyota',      14, '2022-05-01', 'Active'),
('LEA-1003', 'Bus',      'Super Falcon',  'Hino',        45, '2018-09-01', 'Maintenance');

-- =====================================================
-- STUDENT TRANSPORT REGISTRATION
-- =====================================================

INSERT INTO student_transport_registration (student_id, route_id, registration_date, transport_fee, status) VALUES
(5,  1, '2022-09-10', 12000.00, 'Active'),
(6,  1, '2022-09-10', 12000.00, 'Active'),
(8,  3, '2022-09-10', 10000.00, 'Active'),
(11, 2, '2022-09-10', 14000.00, 'Active'),
(13, 1, '2022-09-10', 12000.00, 'Active'),
(14, 3, '2022-09-10', 10000.00, 'Active'),
(16, 4, '2023-09-05', 18000.00, 'Active'),
(17, 5, '2023-09-05',  8000.00, 'Active'),
(18, 1, '2023-09-05', 12000.00, 'Active'),
(15, 2, '2022-09-10', 14000.00, 'Cancelled');

-- =====================================================
-- VEHICLE MAINTENANCE
-- =====================================================

INSERT INTO vehicle_maintenance (vehicle_id, maintenance_date, maintenance_type, description, cost, next_service_date) VALUES
(1, '2023-06-15', 'Oil Change',         'Engine oil and filter replaced',          5000.00, '2023-12-15'),
(1, '2024-01-10', 'Tyre Replacement',   'All 6 tyres replaced',                  45000.00, '2026-01-10'),
(2, '2023-07-20', 'Oil Change',         'Engine oil changed',                      5000.00, '2024-01-20'),
(7, '2024-03-01', 'Engine Overhaul',    'Major engine repair and overhaul',      150000.00, '2026-03-01'),
(3, '2023-09-10', 'Brake Service',      'Brake pads and discs replaced',          18000.00, '2024-09-10'),
(5, '2024-02-14', 'AC Service',         'Air conditioning system serviced',        8000.00, '2025-02-14');

-- =====================================================
-- FUEL LOG
-- =====================================================

INSERT INTO fuel_log (vehicle_id, fuel_date, liters, cost, odometer_reading) VALUES
(1, '2024-09-01', 80.00, 24000.00, 85000),
(1, '2024-09-08', 75.00, 22500.00, 86200),
(2, '2024-09-01', 80.00, 24000.00, 72000),
(3, '2024-09-02', 50.00, 15000.00, 45000),
(4, '2024-09-02', 50.00, 15000.00, 38000),
(5, '2024-09-03', 30.00,  9000.00, 52000),
(6, '2024-09-03', 30.00,  9000.00, 28000);

-- =====================================================
-- TRANSPORT ATTENDANCE
-- =====================================================

INSERT INTO transport_attendance (student_id, vehicle_id, attendance_date, trip_type) VALUES
(5,  1, '2024-09-09', 'Pickup'), (5,  1, '2024-09-09', 'Drop'),
(6,  1, '2024-09-09', 'Pickup'), (6,  1, '2024-09-09', 'Drop'),
(8,  3, '2024-09-09', 'Pickup'), (8,  3, '2024-09-09', 'Drop'),
(5,  1, '2024-09-10', 'Pickup'), (5,  1, '2024-09-10', 'Drop'),
(11, 2, '2024-09-09', 'Pickup'), (11, 2, '2024-09-09', 'Drop');

-- =====================================================
-- VEHICLE INSURANCE
-- =====================================================

INSERT INTO vehicle_insurance (vehicle_id, insurance_provider, policy_number, coverage_amount, expiry_date) VALUES
(1, 'EFU Life Assurance',   'POL-EFU-2024-001', 5000000.00, '2025-06-01'),
(2, 'Jubilee General Ins.', 'POL-JUB-2024-002', 5000000.00, '2025-07-01'),
(3, 'State Life Insurance', 'POL-SLI-2024-003', 3000000.00, '2025-05-15'),
(4, 'EFU Life Assurance',   'POL-EFU-2024-004', 3000000.00, '2025-05-15'),
(5, 'Jubilee General Ins.', 'POL-JUB-2024-005', 2000000.00, '2025-08-01');

-- =====================================================
-- TRANSPORT INCIDENT
-- =====================================================

INSERT INTO transport_incident (vehicle_id, incident_date, incident_type, description, reported_by) VALUES
(7, '2024-02-28', 'Breakdown',    'Engine failure on Ring Road. Bus towed to workshop.',          'Driver Malik'),
(1, '2023-11-15', 'Minor Accident','Bus sideswiped a motorcycle at Liberty signal. No injuries.', 'Driver Raza'),
(3, '2024-04-10', 'Breakdown',    'Flat tyre on DHA route. Passengers shifted to backup vehicle.','Conductor Asad');

-- =====================================================
-- ROUTE FEE STRUCTURE
-- =====================================================

INSERT INTO route_fee_structure (route_id, semester_fee) VALUES
(1, 12000.00),
(2, 14000.00),
(3, 10000.00),
(4, 18000.00),
(5,  8000.00);

-- =====================================================
-- GPS TRACKING LOG (sample)
-- =====================================================

INSERT INTO gps_tracking_log (vehicle_id, latitude, longitude, recorded_at) VALUES
(1, 31.5204000, 74.3587000, '2024-09-09 07:00:00'),
(1, 31.5100000, 74.3200000, '2024-09-09 07:20:00'),
(1, 31.4700000, 74.2700000, '2024-09-09 07:50:00'),
(2, 31.5204000, 74.3587000, '2024-09-09 07:00:00'),
(2, 31.5400000, 74.3800000, '2024-09-09 07:25:00');

-- =====================================================
-- USER ACCOUNT
-- =====================================================

INSERT INTO user_account (username, email, password_hash, account_status) VALUES
('ali.hassan',       'ali.hassan@student.uni.edu.pk',       '$2b$12$xKzZJHrQ1placeholder001', 'Active'),
('zainab.farooq',    'zainab.farooq@student.uni.edu.pk',    '$2b$12$xKzZJHrQ1placeholder002', 'Active'),
('hamza.tariq',      'hamza.tariq@student.uni.edu.pk',      '$2b$12$xKzZJHrQ1placeholder003', 'Active'),
('faisal.ch',        'faisal.ch@student.uni.edu.pk',        '$2b$12$xKzZJHrQ1placeholder009', 'Active'),
('nimra.khan',       'nimra.khan@student.uni.edu.pk',       '$2b$12$xKzZJHrQ1placeholder010', 'Active'),
('ahmed.khan.fac',   'ahmed.khan@uni.edu.pk',               '$2b$12$xKzZJHrQ1placeholderfac1','Active'),
('sara.ali.fac',     'sara.ali@uni.edu.pk',                 '$2b$12$xKzZJHrQ1placeholderfac2','Active'),
('admin.erp',        'admin@uni.edu.pk',                    '$2b$12$xKzZJHrQ1placeholderadm1','Active'),
('registrar',        'registrar@uni.edu.pk',                '$2b$12$xKzZJHrQ1placeholdradm2', 'Active'),
('rida.hussain',     'rida.hussain@student.uni.edu.pk',     '$2b$12$xKzZJHrQ1placeholder016', 'Active'),
('bilal.saeed',      'bilal.saeed@student.uni.edu.pk',      '$2b$12$xKzZJHrQ1placeholder019', 'Inactive'),
('maryam.qazi',      'maryam.qazi@student.uni.edu.pk',      '$2b$12$xKzZJHrQ1placeholder020', 'Suspended');

-- =====================================================
-- ROLE
-- =====================================================

INSERT INTO role (role_name, description) VALUES
('Super Admin',  'Full system access — all modules'),
('Registrar',    'Manages student registration, enrollment and transcripts'),
('Instructor',   'Access to own sections, grades, and attendance'),
('Student',      'Access to own academic, financial and library records'),
('Finance Officer','Manages invoices, payments, scholarships and financial aid'),
('Librarian',    'Manages book issuance, returns and reservations'),
('Hostel Warden','Manages room allocations and hostel complaints'),
('Transport Manager','Manages routes, vehicles and transport registrations'),
('HR Manager',   'Manages employee records, payroll and leave'),
('Department Head','Access to department data, faculty and programs');

-- =====================================================
-- PERMISSION
-- =====================================================

INSERT INTO permission (permission_name, description) VALUES
('student.view',           'View student records'),
('student.edit',           'Edit student records'),
('student.delete',         'Delete student records'),
('enrollment.manage',      'Manage course enrollments'),
('grade.enter',            'Enter and update grades'),
('grade.view',             'View grades'),
('attendance.manage',      'Manage attendance records'),
('fee.view',               'View fee records'),
('fee.manage',             'Manage invoices and payments'),
('scholarship.manage',     'Manage scholarships and financial aid'),
('book.issue',             'Issue and return books'),
('book.manage',            'Add, edit, and remove books'),
('hostel.manage',          'Manage hostel allocations'),
('transport.manage',       'Manage transport routes and vehicles'),
('payroll.manage',         'Manage employee payroll'),
('report.view',            'View reports and analytics'),
('system.admin',           'System-wide administration access'),
('course.manage',          'Add and edit courses and sections'),
('user.manage',            'Create and manage user accounts'),
('audit.view',             'View audit logs and security events');

-- =====================================================
-- USER ROLE
-- =====================================================

INSERT INTO user_role (user_id, role_id, assigned_date) VALUES
(8,  1, '2022-01-01'),  -- admin.erp → Super Admin
(9,  2, '2022-01-01'),  -- registrar → Registrar
(6,  3, '2022-09-10'),  -- ahmed.khan → Instructor
(7,  3, '2022-09-10'),  -- sara.ali → Instructor
(1,  4, '2022-09-10'),  -- ali.hassan → Student
(2,  4, '2022-09-10'),  -- zainab → Student
(3,  4, '2022-09-10'),  -- hamza → Student
(4,  4, '2021-09-10'),  -- faisal → Student
(5,  4, '2021-09-10'),  -- nimra → Student
(10, 4, '2023-09-05'),  -- rida → Student
(8,  9, '2022-01-01'),  -- admin also manages HR
(9, 10, '2022-01-01');  -- registrar also dept head access

-- =====================================================
-- ROLE PERMISSION
-- =====================================================

INSERT INTO role_permission (role_id, permission_id) VALUES
-- Super Admin gets all
(1, 1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),
(1,11),(1,12),(1,13),(1,14),(1,15),(1,16),(1,17),(1,18),(1,19),(1,20),
-- Registrar
(2,1),(2,2),(2,4),(2,6),(2,16),(2,18),
-- Instructor
(3,1),(3,5),(3,6),(3,7),(3,16),
-- Student
(4,6),(4,8),
-- Finance Officer
(5,8),(5,9),(5,10),(5,16),
-- Librarian
(6,11),(6,12),(6,16),
-- Hostel Warden
(7,13),(7,16),
-- Transport Manager
(8,14),(8,16),
-- HR Manager
(9,15),(9,16),
-- Department Head
(10,1),(10,6),(10,16),(10,18);

-- =====================================================
-- USER SESSION
-- =====================================================

INSERT INTO user_session (user_id, login_time, logout_time, ip_address, device_info) VALUES
(1,  '2024-10-01 09:05:00', '2024-10-01 12:30:00', '192.168.1.101', 'Chrome/Windows 11'),
(2,  '2024-10-01 09:10:00', '2024-10-01 11:00:00', '192.168.1.102', 'Firefox/macOS'),
(8,  '2024-10-01 08:00:00', '2024-10-01 17:00:00', '10.0.0.5',      'Chrome/Ubuntu 22'),
(6,  '2024-10-02 08:30:00', '2024-10-02 14:00:00', '192.168.1.110', 'Safari/macOS'),
(1,  '2024-10-02 10:00:00', '2024-10-02 11:45:00', '192.168.1.101', 'Chrome/Windows 11');

-- =====================================================
-- LOGIN HISTORY
-- =====================================================

INSERT INTO login_history (user_id, login_timestamp, ip_address, login_status) VALUES
(1,  '2024-10-01 09:05:00', '192.168.1.101', 'Success'),
(1,  '2024-09-30 20:00:00', '192.168.1.101', 'Success'),
(2,  '2024-10-01 09:10:00', '192.168.1.102', 'Success'),
(3,  '2024-10-01 08:45:00', '192.168.1.105', 'Failed'),
(3,  '2024-10-01 08:46:00', '192.168.1.105', 'Failed'),
(3,  '2024-10-01 08:47:00', '192.168.1.105', 'Success'),
(8,  '2024-10-01 08:00:00', '10.0.0.5',      'Success'),
(12, '2024-10-03 22:00:00', '45.12.99.200',  'Failed'),
(12, '2024-10-03 22:01:00', '45.12.99.200',  'Failed');

-- =====================================================
-- PASSWORD POLICY
-- =====================================================

INSERT INTO password_policy (minimum_length, require_uppercase, require_lowercase, require_numbers, require_special_characters, password_expiry_days) VALUES
(10, TRUE, TRUE, TRUE, TRUE, 90);

-- =====================================================
-- PASSWORD HISTORY
-- =====================================================

INSERT INTO password_history (user_id, password_hash, changed_at) VALUES
(1, '$2b$12$oldpasswordhash001aaaa', '2022-09-10 09:00:00'),
(1, '$2b$12$oldpasswordhash001bbbb', '2022-12-10 09:00:00'),
(1, '$2b$12$xKzZJHrQ1placeholder001','2023-03-10 09:00:00'),
(8, '$2b$12$adminoldhash001aaaaaaaa', '2022-01-01 08:00:00'),
(8, '$2b$12$xKzZJHrQ1placeholderadm1','2023-01-01 08:00:00');

-- =====================================================
-- USER MFA
-- =====================================================

INSERT INTO user_mfa (user_id, mfa_type, secret_key, enabled) VALUES
(8,  'Authenticator App', 'JBSWY3DPEHPK3PXP', TRUE),
(9,  'Email',             NULL,               TRUE),
(6,  'SMS',               NULL,               TRUE),
(1,  'Email',             NULL,               FALSE);

-- =====================================================
-- ACCOUNT LOCK
-- =====================================================

INSERT INTO account_lock (user_id, locked_at, unlock_at, reason) VALUES
(12, '2024-10-03 22:05:00', '2024-10-04 22:05:00', 'Multiple failed login attempts from suspicious IP');

-- =====================================================
-- SECURITY EVENT
-- =====================================================

INSERT INTO security_event (user_id, event_type, event_description, event_timestamp, severity) VALUES
(NULL, 'Brute Force Attempt', 'Multiple failed logins on user maryam.qazi from IP 45.12.99.200',  '2024-10-03 22:05:00', 'High'),
(8,    'Admin Login',         'Admin account logged in from expected IP',                          '2024-10-01 08:00:00', 'Low'),
(3,    'Password Reset',      'User hamza.tariq reset password after 2 failed attempts',           '2024-10-01 08:50:00', 'Medium'),
(NULL, 'Suspicious IP',       'Login attempt from foreign IP range on admin account (blocked)',     '2024-09-25 03:22:00', 'Critical');

-- =====================================================
-- AUDIT LOG
-- =====================================================

INSERT INTO audit_log (user_id, table_name, record_id, operation_type, old_value, new_value, operation_timestamp) VALUES
(9,  'enrollment',   '45',  'INSERT', NULL,
     '{"student_id":16,"section_id":23,"enrollment_date":"2024-09-05"}',
     '2024-09-05 10:00:00'),
(9,  'student',      '3',   'UPDATE',
     '{"cgpa":3.10}',
     '{"cgpa":3.20}',
     '2024-01-28 11:00:00'),
(8,  'user_account', '12',  'UPDATE',
     '{"account_status":"Active"}',
     '{"account_status":"Suspended"}',
     '2024-10-03 22:10:00'),
(6,  'exam_result',  '5',   'UPDATE',
     '{"obtained_marks":25.00}',
     '{"obtained_marks":27.00}',
     '2023-11-15 14:00:00');

-- =====================================================
-- NOTIFICATION
-- =====================================================

INSERT INTO notification (user_id, title, message, notification_type, is_read, created_at) VALUES
(1,  'Enrollment Confirmed',      'Your enrollment for Fall 2024 has been approved.',                   'Academic', TRUE,  '2024-09-05 10:30:00'),
(1,  'Fee Reminder',              'Your semester invoice of PKR 63,000 is due by September 20, 2024.',  'Finance',  FALSE, '2024-09-10 09:00:00'),
(2,  'Dean''s List',              'Congratulations! You have been placed on the Dean''s List.',         'Academic', TRUE,  '2024-02-01 08:00:00'),
(3,  'Library Fine',              'You have an outstanding library fine of PKR 300. Please clear it.',  'Library',  FALSE, '2024-01-25 09:00:00'),
(4,  'Assignment Due',            'Assignment 2 for CS201 is due in 3 days.',                          'Academic', FALSE, '2023-10-27 08:00:00'),
(5,  'Scholarship Awarded',       'You have been awarded the HEC Need-Based Scholarship.',              'Finance',  TRUE,  '2022-11-01 10:00:00'),
(8,  'Security Alert',            'Suspicious login attempt detected and blocked. Please review.',      'Security', FALSE, '2024-09-25 03:25:00'),
(1,  'Grade Released',            'Your grades for Fall 2023 semester are now available.',              'Academic', TRUE,  '2024-01-28 12:00:00'),
(10, 'Welcome',                   'Welcome to the University ERP Portal. Your account is ready.',       'Academic', TRUE,  '2023-09-04 09:00:00'),
(1,  'Advisor Meeting Scheduled', 'Your academic advisor has scheduled a meeting for October 15.',      'Academic', FALSE, '2024-10-08 11:00:00');

-- =====================================================
-- API TOKEN (sample)
-- =====================================================

INSERT INTO api_token (user_id, token_hash, created_at, expiry_date) VALUES
(8, '$2b$12$apitoken_admin_placeholder_001', '2024-01-01 00:00:00', '2025-01-01 00:00:00'),
(9, '$2b$12$apitoken_regis_placeholder_002', '2024-01-01 00:00:00', '2025-01-01 00:00:00');

-- =====================================================
-- FILE ACCESS LOG
-- =====================================================

INSERT INTO file_access_log (user_id, document_name, access_time, action_type) VALUES
(1,  'ali_hassan_transcript_fall2023.pdf',  '2024-02-01 10:00:00', 'Download'),
(2,  'zainab_farooq_gradebook.pdf',         '2024-02-02 09:30:00', 'View'),
(9,  'student_masterlist_fall2024.xlsx',    '2024-09-06 11:00:00', 'Download'),
(8,  'audit_report_sep2024.pdf',            '2024-10-01 09:00:00', 'View'),
(1,  'cs401_lecture_notes_week3.pdf',       '2024-10-05 14:00:00', 'Download'),
(6,  'ahmed_khan_publication_list.pdf',     '2024-09-20 10:30:00', 'Upload');

SET FOREIGN_KEY_CHECKS = 1;

-- =====================================================
-- END OF DATASET
-- =====================================================
