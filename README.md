<div align="">

<img src="https://capsule-render.vercel.app/api?type=waving&height=280&color=0:1e3a8a,40:2563eb,70:7c3aed,100:9333ea&text=University%20ERP%20Database%20System&fontColor=ffffff&fontSize=40&fontAlignY=38&desc=Enterprise-Grade%20Academic%20Information%20Platform%20%7C%20MySQL%208.0&descAlignY=58&animation=fadeIn" width="100%" />

<br/>

<img src="https://readme-typing-svg.herokuapp.com?font=Inter&weight=700&size=22&duration=2800&pause=900&color=7C3AED&center=true&vCenter=true&width=950&lines=127+Tables+%E2%80%A2+8+ERP+Modules+%E2%80%A2+Fully+Normalized+Schema;10+Views+%E2%80%A2+8+Stored+Procedures+%E2%80%A2+6+Triggers;Academic+%7C+Finance+%7C+Library+%7C+Hostel+%7C+Transport+%7C+HR+%7C+Security;Node.js+REST+API+%E2%80%A2+8+Live+Frontend+Pages;FAST-NUCES+%E2%80%A2+Database+Systems+Lab+%E2%80%A2+Spring+2025" />

<br/><br/>

![MySQL](https://img.shields.io/badge/MySQL_8.0-Database-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Node.js](https://img.shields.io/badge/Node.js-Backend-339933?style=for-the-badge&logo=nodedotjs&logoColor=white)
![Express](https://img.shields.io/badge/Express.js-REST_API-000000?style=for-the-badge&logo=express&logoColor=white)
![Frontend](https://img.shields.io/badge/Frontend-HTML%2FCSS%2FJS-E34F26?style=for-the-badge&logo=html5&logoColor=white)
![Chart.js](https://img.shields.io/badge/Chart.js-Visualizations-FF6384?style=for-the-badge&logo=chartdotjs&logoColor=white)
![Status](https://img.shields.io/badge/Status-Complete-22c55e?style=for-the-badge)
![Academic](https://img.shields.io/badge/Academic-Project-7c3aed?style=for-the-badge)

<br/>

# 🎓 University ERP Database System

### Enterprise-Grade Academic Information Platform

<p align="center">
A production-quality, fully normalized university ERP built with MySQL 8.0. The system spans eight institutional modules — Academic, Students, Finance, Library, Hostel, Transport, HR, and Security — with 127 relational tables, a 29-route REST API, stored procedures, triggers, views, and a live 8-page frontend dashboard.
</p>

<br/>

</div>

---

## 📋 Table of Contents

- [📌 Project Overview](#-project-overview)
- [📊 Project Snapshot](#-project-snapshot)
- [🏗 System Architecture](#-system-architecture)
- [🗄 Database Modules](#-database-modules)
- [🔗 Entity Relationships](#-entity-relationships)
- [📁 File Structure](#-file-structure)
- [⚙ Backend API](#-backend-api)
- [🖥 Frontend Pages](#-frontend-pages)
- [🚀 Getting Started](#-getting-started)
- [🧪 Running Tests](#-running-tests)
- [👁 Views](#-views)
- [🧠 Stored Procedures](#-stored-procedures)
- [⚡ Triggers](#-triggers)
- [🔍 Sample Queries](#-sample-queries)
- [📸 Application Preview](#-application-preview)
- [🛠 Tech Stack](#-tech-stack)
- [🔮 Possible Improvements](#-possible-improvements)
- [📜 License](#-license)

---

## 📌 Project Overview

The **University ERP Database System** is a comprehensive, enterprise-grade relational database solution that models the complete operational lifecycle of a modern university. It goes far beyond a basic academic schema — covering eight institutional modules with full referential integrity, business logic enforced at the database tier, and a connected full-stack application.

**What makes this system stand out:**

- **Depth** — 127 relational tables across 8 fully integrated modules
- **Correctness** — All foreign keys, cascades, constraints, and indexes are properly defined
- **Intelligence** — Business logic is enforced inside the database via stored procedures, triggers, and views — not just in application code
- **Completeness** — Every module includes its own fee/billing, staff, complaints, and audit capabilities
- **Connected** — A real Express REST API (29 routes) and 8 live frontend pages query this schema directly, with no mock data
- **Scale** — Designed to support real-world university operations with thousands of students, courses, and transactions

---

## 📊 Project Snapshot

<div align="center">

| Component | Count | Details |
|:---|:---:|:---|
| 🗃️ Database Tables | **127** | Across 8 ERP modules |
| 📦 ERP Modules | **8** | Academic, Students, Finance, Library, Hostel, Transport, HR, Security |
| 👁️ Database Views | **10** | Profile, schedule, fees, attendance, workload, occupancy |
| 🧠 Stored Procedures | **8** | Enroll, CGPA, grade, invoice, transcript, library, report |
| ⚡ Triggers | **6** | Capacity, CGPA, payment, bed, book issue/return |
| 🌐 REST API Routes | **29** | Students, courses, finance, library, hostel, transport & more |
| 🖥️ Frontend Pages | **8** | Dashboard, Students, Courses, Transcript, Library, Finance, Hostel, Transport |
| 🔍 SQL Sample Queries | **15** | JOINs, subqueries, window functions, aggregates |

</div>

---

## 🏗 System Architecture

```
┌──────────────────────────────────────────────────────────────────────┐
│                          FRONTEND LAYER                              │
│              HTML5 · CSS3 · Vanilla JavaScript · Chart.js            │
│  Dashboard │ Students │ Courses │ Transcript │ Library │ Finance     │
│                    Hostel │ Transport                                │
└────────────────────────────┬─────────────────────────────────────────┘
                             │  HTTP / fetch API
                             ▼
┌──────────────────────────────────────────────────────────────────────┐
│                          BACKEND LAYER                               │
│                     Node.js + Express.js                             │
│                                                                      │
│   /api/stats          /api/students        /api/students/:id         │
│   /api/courses        /api/sections        /api/semesters            │
│   /api/programs       /api/departments     /api/instructors          │
│   /api/enrollments    /api/transcript/:id  /api/enroll  (POST)       │
│   /api/grade  (PUT)   /api/library/*       /api/finance/*            │
│   /api/hostel/*       /api/transport/*     /api/view/*               │
└────────────────────────────┬─────────────────────────────────────────┘
                             │  mysql2 driver · parameterized queries
                             ▼
┌──────────────────────────────────────────────────────────────────────┐
│                         DATABASE LAYER                               │
│                    MySQL 8.0 · phpMyAdmin / CLI                       │
│                                                                      │
│   127 Tables  │  10 Views  │  8 Procedures  │  6 Triggers           │
│                                                                      │
│  ┌──────────┐ ┌─────────┐ ┌─────────┐ ┌──────────┐ ┌────────────┐  │
│  │ Academic │ │ Finance │ │ Library │ │  Hostel  │ │ Transport  │  │
│  └──────────┘ └─────────┘ └─────────┘ └──────────┘ └────────────┘  │
│              ┌────────┐ ┌──────────────────┐                        │
│              │   HR   │ │ Security / Audit  │                        │
│              └────────┘ └──────────────────┘                        │
└──────────────────────────────────────────────────────────────────────┘
```

---

## 🗄 Database Modules

The schema is divided into **8 fully independent yet interlinked ERP modules**. Each module manages its own entities, fees, and staff relationships.

<br/>

### 📚 Module 1 — Academic Core (32 Tables)

> The heart of the system. Manages everything from admission to graduation.

| Table Group | Tables |
|:---|:---|
| **Structure** | `department`, `program`, `academic_session`, `semester` |
| **Students** | `student`, `student_address`, `student_guardian`, `student_document` |
| **Faculty** | `instructor`, `faculty_qualification`, `faculty_publication` |
| **Facilities** | `building`, `classroom`, `time_slot` |
| **Curriculum** | `course`, `course_outcome`, `prerequisite` |
| **Teaching** | `section`, `enrollment`, `attendance` |
| **Assessment** | `assignment`, `assignment_submission`, `quiz`, `quiz_result`, `exam`, `exam_result` |
| **Records** | `gradebook`, `transcript`, `course_registration`, `registration_detail` |
| **Advisory** | `academic_advisor`, `course_evaluation` |

<br/>

### 💰 Module 2 — Finance & Fee Management (14 Tables)

> Full financial lifecycle: invoicing, payments, scholarships, and ledger tracking.

| Table Group | Tables |
|:---|:---|
| **Structure** | `fee_category`, `fee_structure`, `student_fee_account` |
| **Invoicing** | `invoice`, `invoice_detail`, `installment_plan`, `late_fee_penalty` |
| **Payments** | `payment`, `payment_transaction` |
| **Aid** | `scholarship`, `student_scholarship`, `financial_aid`, `refund` |
| **Audit** | `financial_ledger` |

<br/>

### 📖 Module 3 — Library Management (16 Tables)

> Book catalog, copy tracking, member issuance, fines, reservations, and digital resources.

| Table Group | Tables |
|:---|:---|
| **Catalog** | `book_category`, `author`, `publisher`, `book`, `book_author` |
| **Inventory** | `book_copy`, `digital_resource`, `book_donation` |
| **Circulation** | `library_member`, `book_issue`, `book_return`, `library_fine`, `book_reservation` |
| **Facilities** | `reading_room`, `reading_room_reservation`, `library_staff` |

<br/>

### 🏠 Module 4 — Hostel Management (15 Tables)

> Hostel hierarchy from building to individual bed, with occupancy, complaints, and meal plans.

| Table Group | Tables |
|:---|:---|
| **Infrastructure** | `hostel`, `hostel_block`, `hostel_room`, `bed` |
| **Allocation** | `room_allocation`, `hostel_fee` |
| **Operations** | `hostel_visitor`, `hostel_complaint`, `maintenance_request` |
| **Amenities** | `mess`, `meal_plan`, `student_meal_plan`, `hostel_inventory`, `inventory_issue` |
| **Staff** | `hostel_staff` |

<br/>

### 🚌 Module 5 — Transport Management (15 Tables)

> Fleet, routes, drivers, GPS logs, fuel tracking, and student transport registration.

| Table Group | Tables |
|:---|:---|
| **Fleet** | `vehicle`, `vehicle_insurance`, `vehicle_maintenance`, `fuel_log` |
| **Routes** | `transport_route`, `bus_stop`, `route_fee_structure` |
| **Personnel** | `driver`, `conductor`, `transport_staff` |
| **Operations** | `vehicle_assignment`, `student_transport_registration`, `transport_attendance` |
| **Tracking** | `gps_tracking_log`, `transport_incident` |

<br/>

### 👔 Module 6 — HR & Payroll (19 Tables)

> Full employee lifecycle: recruitment, contracts, payroll, leave, performance, and training.

| Table Group | Tables |
|:---|:---|
| **Recruitment** | `job_position`, `job_posting`, `applicant`, `job_application`, `interview` |
| **Employment** | `employment_contract`, `employee_document`, `promotion_history` |
| **Payroll** | `payroll`, `salary_history`, `benefit_plan`, `employee_benefit` |
| **Attendance & Leave** | `leave_type`, `leave_request`, `employee_attendance_log` |
| **Development** | `performance_review`, `training_program`, `employee_training` |
| **Discipline** | `disciplinary_action` |

<br/>

### 🔐 Module 7 — Security & Audit (16 Tables)

> Role-based access control, MFA, session tracking, complete audit logs, and notifications.

| Table Group | Tables |
|:---|:---|
| **Identity** | `user_account`, `role`, `permission`, `user_role`, `role_permission` |
| **Sessions** | `user_session`, `login_history`, `account_lock` |
| **Security** | `user_mfa`, `password_policy`, `password_history` |
| **Monitoring** | `security_event`, `audit_log`, `file_access_log` |
| **Messaging** | `notification`, `api_token` |

---

## 🔗 Entity Relationships

| Relationship | Type | Description |
|:---|:---:|:---|
| `student` → `program` → `department` | Many-to-One | Students belong to a program which belongs to a department |
| `student` ↔ `section` | Many-to-Many | Via `enrollment` junction table |
| `course` → `course` (self) | Self Join | Via `prerequisite` table |
| `section` → `course`, `instructor`, `semester`, `classroom`, `time_slot` | Many-to-One | Section aggregates five FK references |
| `invoice` → `fee_structure` → `program` | Traceability chain | Fee invoices are generated from program-level fee structures |
| `book_copy` → `book` | Many-to-One | Multiple physical copies per title |
| `library_member` → `student` / `instructor` | Polymorphic | A member can be either a student or an instructor |
| `bed` → `room` → `block` → `hostel` | Deep hierarchy | Four-level hostel nesting |
| `user_account` ↔ `role` ↔ `permission` | Many-to-Many | Full RBAC via junction tables |
| `audit_log` → `user_account` | Tracking | Every INSERT / UPDATE / DELETE is logged with old and new JSON values |

---

## 📁 File Structure

```
📦 University-Database-Management-System/
│
├── server.js                       ← Express REST API server (29 routes)
├── package.json                    ← Dependencies & npm scripts
├── .env.example                    ← Environment variable template
├── .gitignore
├── LICENSE
├── README.md
│
├── index.html                      ← Dashboard
├── students.html                   ← Student management
├── courses.html                    ← Course catalog & class schedule
├── transcript.html                 ← Transcript viewer
├── library.html                    ← Library management
├── finance.html                    ← Finance & fee management
├── hostel.html                     ← Hostel management
├── transport.html                  ← Transport management
├── style.css                       ← Global stylesheet
│
├── University_Database.sql              ← 127-table schema (MySQL 8.0)
├── University-Database-DataSet.sql      ← Sample data for all modules
├── University-Database-Views.sql        ← 10 reporting views
├── University-Database-Procedures.sql   ← 8 stored procedures + 6 triggers
│
├── tests/
│   └── api.test.js                 ← Jest + Supertest API tests
│
├── screenshots/
│   ├── dashboard.png
│   ├── students.png
│   ├── courses.png
│   ├── transcript.png
│   ├── library.png
│   ├── finance.png
│   ├── hostel.png
│   └── transport.png
│
└── diagrams/
    └── University_ERP_ERD.png
```

---

## ⚙ Backend API

Base URL: `http://localhost:3000`

### Dashboard

| Method | Endpoint | Description |
|:---|:---|:---|
| `GET` | `/api/stats` | Overall counts, status breakdown, top students by CGPA, monthly enrollment trend |

### Students

| Method | Endpoint | Description |
|:---|:---|:---|
| `GET` | `/api/students` | List students — supports `?search=`, `?status=`, `?program_id=` |
| `GET` | `/api/students/:id` | Single student profile |
| `GET` | `/api/enrollments?student_id=` | Enrollment history for a student |
| `GET` | `/api/transcript/:id` | Full academic transcript (calls `sp_get_student_transcript`) |
| `POST` | `/api/enroll` | Enroll a student in a section (calls `sp_enroll_student`) |
| `PUT` | `/api/grade` | Update a grade and trigger CGPA recalculation (calls `sp_update_grade`) |

### Academics

| Method | Endpoint | Description |
|:---|:---|:---|
| `GET` | `/api/courses` | Course catalog with department info, section count, total enrolled |
| `GET` | `/api/sections` | Sections with schedule, instructor, room — supports `?semester_id=` |
| `GET` | `/api/semesters` | All semesters with their parent academic sessions |
| `GET` | `/api/programs` | All academic programs |
| `GET` | `/api/departments` | All departments |
| `GET` | `/api/instructors` | All instructors |
| `GET` | `/api/view/instructor-workload` | Instructor workload report (`vw_instructor_workload`) |
| `GET` | `/api/view/attendance` | Attendance summary with shortage flags (`vw_attendance_summary`) |

### Library

| Method | Endpoint | Description |
|:---|:---|:---|
| `GET` | `/api/library/books` | Book catalog with author, publisher, and copy availability |
| `GET` | `/api/library/issues` | Issue/return log with overdue calculation |

### Finance

| Method | Endpoint | Description |
|:---|:---|:---|
| `GET` | `/api/finance/summary` | Totals (invoiced, collected, pending, overdue) and breakdown by status |
| `GET` | `/api/finance/invoices` | Full invoice register with student and semester info |

### Hostel

| Method | Endpoint | Description |
|:---|:---|:---|
| `GET` | `/api/hostel/overview` | Per-hostel bed occupancy stats + complaints list |

### Transport

| Method | Endpoint | Description |
|:---|:---|:---|
| `GET` | `/api/transport/overview` | Fleet status by type/condition + routes with registered student counts |

---

## 🖥 Frontend Pages

| Page | Route | Key Features |
|:---|:---|:---|
| **Dashboard** | `index.html` | Live module stats, top-CGPA students, status & program distribution charts, monthly enrollment trend |
| **Students** | `students.html` | Search by name/registration number, filter by status & program, detail modal with enrollment history |
| **Courses** | `courses.html` | Card/table catalog view with department filter, full weekly class schedule with seat availability |
| **Transcript** | `transcript.html` | Live student search, semester-by-semester academic record, auto-calculated GPA, print view |
| **Library** | `library.html` | Book catalog with availability pills, issue/return log with overdue tracking |
| **Finance** | `finance.html` | Revenue overview, invoice status charts, searchable invoice register |
| **Hostel** | `hostel.html` | Per-hostel occupancy bars, bed distribution chart, complaints register with status filter |
| **Transport** | `transport.html` | Fleet overview by type/status, route list with registered student counts |

---

## 🚀 Getting Started

### Prerequisites

Ensure the following are installed:

- [MySQL 8.0](https://dev.mysql.com/downloads/) (or via [XAMPP](https://www.apachefriends.org/))
- [Node.js](https://nodejs.org/) v18+
- A modern web browser

---

### Step 1 — Clone the Repository

```bash
git clone https://github.com/SamSec404/University-Database-Management-System.git
cd University-Database-Management-System
```

---

### Step 2 — Set Up the Database

1. Start MySQL (via XAMPP or your local MySQL service)
2. Open phpMyAdmin or the MySQL CLI
3. Create a new database:

```sql
CREATE DATABASE university_erp;
```

4. Import SQL files **in this exact order**:

```
1.  University_Database.sql              ← Creates all 127 tables with constraints and indexes
2.  University-Database-DataSet.sql      ← Populates all modules with sample data
3.  University-Database-Views.sql        ← Creates 10 analytical views
4.  University-Database-Procedures.sql   ← Creates 8 stored procedures and 6 triggers
```

Via CLI:

```bash
mysql -u root -p university_erp < University_Database.sql
mysql -u root -p university_erp < University-Database-DataSet.sql
mysql -u root -p university_erp < University-Database-Views.sql
mysql -u root -p university_erp < University-Database-Procedures.sql
```

---

### Step 3 — Configure Environment Variables

```bash
cp .env.example .env
```

Edit `.env` with your MySQL credentials:

```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=
DB_NAME=university_erp
DB_PORT=3306
PORT=3000
```

---

### Step 4 — Install Dependencies & Start Server

```bash
npm install
npm start
```

Expected output:

```
🎓 University ERP running at http://localhost:3000
✅ MySQL connected to university_erp
```

---

### Step 5 — Launch Frontend

Open your browser to:

```
http://localhost:3000
```

All 8 pages (Dashboard, Students, Courses, Transcript, Library, Finance, Hostel, Transport) are served directly by the Express server.

---

## 🧪 Running Tests

```bash
npm test
```

Tests use **Jest + Supertest** to verify all API endpoints respond correctly against a live MySQL connection. Make sure the database is set up and `.env` is configured before running tests.

---

## 👁 Views

All views are built against the actual schema column names and are safe to query directly.

| View | Purpose | Key Columns |
|:---|:---|:---|
| `vw_student_profile` | Full student info with program and department | `registration_no`, `full_name`, `program_name`, `degree_level`, `cgpa`, `status` |
| `vw_student_academic_record` | Complete enrollment history with grade points | `session_name`, `course_code`, `credit_hours`, `grade`, `grade_points`, `quality_points` |
| `vw_section_timetable` | Full schedule with room, instructor, and seat count | `day_of_week`, `start_time`, `building_name`, `room_number`, `seats_available` |
| `vw_course_enrollment_summary` | Enrollment analytics per course | `total_enrollments`, `passed_count`, `failed_count`, `avg_grade_points` |
| `vw_department_overview` | Department headcounts and budget | `total_programs`, `total_instructors`, `active_students`, `budget` |
| `vw_student_fee_summary` | Financial snapshot per student | `total_paid`, `total_due`, `overdue_invoices`, `pending_invoices` |
| `vw_library_book_availability` | Copy counts by status per book | `available_copies`, `issued_copies`, `reserved_copies`, `authors` |
| `vw_attendance_summary` | Per-student, per-section attendance % with shortage flag | `attendance_percentage`, `attendance_status` (OK / SHORTAGE) |
| `vw_instructor_workload` | Sections and students per instructor per semester | `sections_assigned`, `total_credit_hours`, `total_students_taught` |
| `vw_hostel_occupancy` | Bed availability per room with occupancy % | `available_beds`, `occupied_beds`, `occupancy_percentage` |

**Example usage:**

```sql
-- Students with attendance shortage
SELECT * FROM vw_attendance_summary WHERE attendance_status = 'SHORTAGE';

-- Sections with open seats this semester
SELECT * FROM vw_section_timetable WHERE seats_available > 0;

-- Students with overdue invoices
SELECT * FROM vw_student_fee_summary WHERE overdue_invoices > 0;
```

---

## 🧠 Stored Procedures

| Procedure | Parameters | Purpose |
|:---|:---|:---|
| `sp_enroll_student` | `student_id, section_id, enroll_date` | Enrolls a student after checking active status, duplicate enrollment, and section capacity |
| `sp_calculate_cgpa` | `student_id` | Recalculates credit-weighted CGPA from full enrollment history and updates `student.cgpa` |
| `sp_update_grade` | `student_id, section_id, grade` | Validates and updates a grade, then calls `sp_calculate_cgpa` automatically |
| `sp_get_student_transcript` | `student_id` | Returns 3 result sets: student header, course-by-course record with quality points, and CGPA summary |
| `sp_generate_invoice` | `student_id, semester_id, invoice_date, due_date` | Generates a semester fee invoice from the program's fee structure and logs it to `financial_ledger` |
| `sp_department_report` | `department_id` | Returns 5 result sets: department info, programmes, instructors, student headcount per programme, and course list |
| `sp_issue_library_book` | `copy_id, member_id, issue_date, due_date` | Issues a book after validating copy availability and active membership |
| `sp_return_library_book` | `issue_id, return_date` | Processes a return, frees the copy, and auto-calculates an overdue fine (PKR 10/day) |

**Example usage:**

```sql
-- Enroll student ID 1 into section ID 3
CALL sp_enroll_student(1, 3, '2024-09-01');

-- Get full transcript for student ID 1
CALL sp_get_student_transcript(1);

-- Update a grade and auto-recalculate CGPA
CALL sp_update_grade(1, 3, 'A-');

-- Generate a semester fee invoice
CALL sp_generate_invoice(1, 2, '2024-09-01', '2024-09-15');

-- Issue a library book
CALL sp_issue_library_book(5, 2, '2024-11-01', '2024-11-15');

-- Return a library book (fine auto-calculated if late)
CALL sp_return_library_book(1, '2024-11-20');
```

---

## ⚡ Triggers

| Trigger | Event | Purpose |
|:---|:---|:---|
| `trg_before_enrollment_capacity` | `BEFORE INSERT` on `enrollment` | Blocks enrollment when section has reached maximum capacity |
| `trg_after_grade_update_cgpa` | `AFTER UPDATE` on `enrollment` | Recalculates and stores `student.cgpa` every time a grade changes |
| `trg_after_payment_update_invoice_status` | `AFTER INSERT` on `payment` | Sets invoice status to `Partially Paid` or `Paid` based on cumulative payments; logs to `financial_ledger` |
| `trg_after_room_allocation_occupy_bed` | `AFTER INSERT` on `room_allocation` | Marks a bed as `Occupied` on active allocation, or `Available` on cancellation |
| `trg_after_book_issue_mark_issued` | `AFTER INSERT` on `book_issue` | Automatically sets `book_copy.status` to `Issued` |
| `trg_after_book_return_free_copy` | `AFTER INSERT` on `book_return` | Automatically sets `book_copy.status` back to `Available` |

---

## 🔍 Sample Queries

15 production-quality SQL queries demonstrating advanced MySQL features:

| # | Query | Concepts Used |
|:---:|:---|:---|
| 1 | Top 5 students by CGPA per department | `RANK()`, window function, subquery |
| 2 | Courses with highest failure rate | `GROUP BY`, `HAVING`, aggregate |
| 3 | Students with attendance below 75% | Multi-table JOIN, percentage calculation |
| 4 | Monthly fee collection summary | `DATE_FORMAT`, `SUM`, GROUP BY date |
| 5 | Instructors teaching overloaded sections | Self-join on section, `COUNT` with `HAVING` |
| 6 | Books overdue in library with fine amount | `DATEDIFF`, conditional JOIN |
| 7 | Hostel occupancy rate per block | Nested aggregation, percentage |
| 8 | Students on merit scholarship with GPA | Multi-module JOIN across finance + academic |
| 9 | Prerequisite chain for a course | Recursive self-join on `prerequisite` |
| 10 | Department budget vs instructor salary cost | Correlated subquery |
| 11 | Students enrolled in sections with no instructor | `LEFT JOIN`, `IS NULL` filter |
| 12 | Semester-wise GPA trend per student | `LAG()` window function |
| 13 | Vehicle fuel efficiency (km per litre) | Computed column, `fuel_log` JOIN |
| 14 | Most evaluated courses by student rating | `AVG(rating)`, `course_evaluation` |
| 15 | Complete financial position per student | Multi-JOIN across 5 finance tables |

---

## 📸 Application Preview

> Screenshots below are placeholders — replace with real captures of each
> page after running the app locally and save into `screenshots/`.

### 🏠 Dashboard

<p align="center">
  <img width="1400" height="700" alt="dashboard" src="https://github.com/user-attachments/assets/29f156ee-c7d4-429a-825b-46ad7a073576" />

</p>

---

### 👨‍🎓 Students Management

<p align="center">
  <img width="1915" height="834" alt="Students" src="https://github.com/user-attachments/assets/2c4e23a2-1afe-4558-a6e9-71c13866d72e" />

</p>

---

### 📚 Courses & Schedule

<p align="center">
  <img width="1908" height="866" alt="Courses" src="https://github.com/user-attachments/assets/20027b33-8836-4918-a0c0-f5b0e42cde52" />

</p>

---

### 📄 Transcript Viewer

<p align="center">
  <img width="1919" height="676" alt="Transcript" src="https://github.com/user-attachments/assets/fcd1a8a5-3d3f-4740-9699-92022076c30c" />

</p>

---

### 📖 Library

<p align="center">
  <img width="1902" height="770" alt="Library" src="https://github.com/user-attachments/assets/b3f0467e-881c-492b-88b2-eab28ca89bd9" />

</p>

---

### 💰 Finance

<p align="center">
  <img width="1906" height="925" alt="Finance" src="https://github.com/user-attachments/assets/cb4b9d8c-3170-400c-923a-1db96fe8ea1d" />

</p>

---

### 🏠 Hostel

<p align="center">
  <img width="1909" height="938" alt="Hostel" src="https://github.com/user-attachments/assets/a1a64266-07c9-4fae-ab73-f0262c88ff53" />

</p>

---

### 🚌 Transport

<p align="center">
  <img width="1909" height="696" alt="Transport" src="https://github.com/user-attachments/assets/beaf12ce-e26b-4f67-8002-a37cfcdddeab" />

</p>

---

## 🛠 Tech Stack

<div align="center">

| Layer | Technology | Purpose |
|:---|:---|:---|
| 🎨 **Frontend** | HTML5, CSS3, Vanilla JavaScript, Chart.js | UI, dashboards, charts, dynamic data rendering |
| ⚙️ **Backend** | Node.js, Express.js | REST API server (29 routes), route handling |
| 🗄️ **Database** | MySQL 8.0 | Relational data, procedures, triggers, views |
| 🔌 **DB Driver** | mysql2 | Parameterized queries from Node.js |
| 🔐 **Config** | dotenv | Environment-based configuration, no hardcoded credentials |
| 🧪 **Testing** | Jest, Supertest | API endpoint testing |
| 🧠 **ER Modeling** | draw.io | Entity-relationship diagram design |
| 💻 **IDE** | VS Code | Development environment |

<br/>

<img src="https://skillicons.dev/icons?i=html,css,js,nodejs,express,mysql,vscode,github" />

</div>

---

## 🔮 Possible Improvements

- Authentication & role-based access control using the existing `user_account` / `role` / `permission` tables
- Pagination on large list endpoints (`/api/students`, `/api/courses`)
- Admin forms to add/edit sections, students, and invoices directly from the UI
- Deployed live demo (e.g. Railway/Render backend + PlanetScale MySQL)
- CI pipeline running `npm test` on every push

---

## 🤝 Contribution

This project was developed as part of the **Database Systems Lab** course at **FAST-NUCES**, Spring 2025.

Contributions and suggestions are welcome for educational purposes.

```bash
# Fork the repository
git fork https://github.com/SamSec404/University-Database-Management-System.git

# Create a feature branch
git checkout -b feature/your-feature-name

# Commit changes
git commit -m "feat: describe your change"

# Push and open a pull request
git push origin feature/your-feature-name
```

---

## 📜 License

This project is licensed under the **MIT License** — see [LICENSE](LICENSE) for details.

© 2025 FAST-NUCES — Group 13 · Ibrahim Khatak · Malik Muhammad Sanaullah

---

<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&height=150&color=0:9333ea,50:7c3aed,100:1e3a8a&section=footer"/>

## ⭐ If this project helped you, please consider starring the repository!

### Made with ❤️ by Group 13 — FAST-NUCES
**Ibrahim Khatak** `24P-0648` &nbsp;•&nbsp; **Malik Muhammad Sanaullah** `24P-0554`

<br/>

![Database Systems](https://img.shields.io/badge/Database%20Systems-Lab%20Project-7c3aed?style=for-the-badge)
![FAST-NUCES](https://img.shields.io/badge/FAST--NUCES-Spring%202025-1e3a8a?style=for-the-badge)
![MySQL](https://img.shields.io/badge/127%20Tables-8%20Modules-4479A1?style=for-the-badge&logo=mysql&logoColor=white)

</div>
