<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&height=280&color=0:1e3a8a,40:2563eb,70:7c3aed,100:9333ea&text=University%20ERP%20Database%20System&fontColor=ffffff&fontSize=40&fontAlignY=38&desc=Enterprise-Grade%20Academic%20Information%20Platform%20%7C%20MySQL%208.0&descAlignY=58&animation=fadeIn" width="100%" />

<br/>

<img src="https://readme-typing-svg.herokuapp.com?font=Inter&weight=700&size=22&duration=2800&pause=900&color=7C3AED&center=true&vCenter=true&width=950&lines=127+Tables+%E2%80%A2+7+ERP+Modules+%E2%80%A2+Fully+Normalized+Schema;10+Views+%E2%80%A2+8+Stored+Procedures+%E2%80%A2+6+Triggers;Academic+%7C+Finance+%7C+Library+%7C+Hostel+%7C+Transport+%7C+HR+%7C+Security;Node.js+REST+API+%E2%80%A2+Vanilla+JS+Frontend;FAST-NUCES+%E2%80%A2+Database+Systems+Lab+%E2%80%A2+Spring+2025" />

<br/><br/>

![MySQL](https://img.shields.io/badge/MySQL_8.0-Database-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Node.js](https://img.shields.io/badge/Node.js-Backend-339933?style=for-the-badge&logo=nodedotjs&logoColor=white)
![Express](https://img.shields.io/badge/Express.js-REST_API-000000?style=for-the-badge&logo=express&logoColor=white)
![Frontend](https://img.shields.io/badge/Frontend-HTML%2FCSS%2FJS-E34F26?style=for-the-badge&logo=html5&logoColor=white)
![XAMPP](https://img.shields.io/badge/XAMPP-phpMyAdmin-FB7A24?style=for-the-badge&logo=xampp&logoColor=white)
![Status](https://img.shields.io/badge/Status-Complete-22c55e?style=for-the-badge)
![Academic](https://img.shields.io/badge/Academic-Project-7c3aed?style=for-the-badge)

<br/>

# 🎓 University ERP Database System

### Enterprise-Grade Academic Information Platform

<p align="center">
A production-quality, fully normalized university ERP built with MySQL 8.0. The system spans seven institutional modules — Academic, Finance, Library, Hostel, Transport, HR, and Security — with 127 relational tables, a REST API layer, stored procedures, triggers, views, and a live frontend dashboard.
</p>

<br/>

<table>
<tr>
<td align="center" width="33%">

### 🏫 Institution
National University of Computer  
& Emerging Sciences  
**(FAST-NUCES)**

</td>
<td align="center" width="33%">

### 📘 Course
**Database Systems Lab**  
Spring 2025

**Theory** — Sir Shoaib Khan  
**Lab** — Muhammad Mehdi

</td>
<td align="center" width="33%">

### 👥 Team
**Group #13**

</td>
</tr>
</table>

---

## 👨‍💻 Developers

<table>
<tr>
<td align="center" width="50%">

<img src="https://avatars.githubusercontent.com/u/9919?s=200&v=4" width="100" style="border-radius:50%"/>

### Muhammad Ibrahim Khatak
`24P-0648`

[![GitHub](https://img.shields.io/badge/GitHub-Profile-181717?style=flat-square&logo=github)](https://github.com/ibrahim-khatak)

</td>
<td align="center" width="50%">

<img width="100" height="100" alt="SamSec404_under_1MB" src="https://github.com/user-attachments/assets/5e18358b-23ce-4e26-8ec8-17b836ea0274" />

### Malik Muhammad Sanaullah
`24P-0554`

[![GitHub](https://img.shields.io/badge/GitHub-Profile-181717?style=flat-square&logo=github)](https://github.com/SamSec404)

</td>
</tr>
</table>

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
- [👁 Views](#-views)
- [🧠 Stored Procedures](#-stored-procedures)
- [⚡ Triggers](#-triggers)
- [🔍 Sample Queries](#-sample-queries)
- [📸 Application Preview](#-application-preview)
- [🛠 Tech Stack](#-tech-stack)
- [📜 License](#-license)

---

## 📌 Project Overview

The **University ERP Database System** is a comprehensive, enterprise-grade relational database solution that models the complete operational lifecycle of a modern university. It goes far beyond a basic academic schema — covering seven institutional modules with full referential integrity, business logic enforced at the database tier, and a connected full-stack application.

**What makes this system stand out:**

- **Depth** — 127 relational tables across 7 fully integrated modules
- **Correctness** — All foreign keys, cascades, constraints, and indexes are properly defined
- **Intelligence** — Business logic is enforced inside the database via stored procedures, triggers, and views — not just in application code
- **Completeness** — Every module includes its own fee/billing, staff, complaints, and audit capabilities
- **Scale** — Designed to support real-world university operations with thousands of students, courses, and transactions

---

## 📊 Project Snapshot

<div align="center">

| Component | Count | Details |
|:---|:---:|:---|
| 🗃️ Database Tables | **127** | Across 7 ERP modules |
| 📦 ERP Modules | **7** | Academic, Finance, Library, Hostel, Transport, HR, Security |
| 👁️ Database Views | **10** | Profile, schedule, fees, attendance, workload, occupancy |
| 🧠 Stored Procedures | **8** | Enroll, CGPA, grade, invoice, transcript, library, report |
| ⚡ Triggers | **6** | Capacity, CGPA, payment, bed, book issue/return |
| 🌐 REST API Routes | **10** | Full CRUD for core entities |
| 🖥️ Frontend Pages | **4** | Dashboard, Students, Courses, Transcript |
| 🔍 SQL Sample Queries | **15** | JOINs, subqueries, window functions, aggregates |

</div>

---

## 🏗 System Architecture

```
┌──────────────────────────────────────────────────────────────────────┐
│                          FRONTEND LAYER                              │
│              HTML5 · CSS3 · Vanilla JavaScript                       │
│        Dashboard  │  Students  │  Courses  │  Transcript             │
└────────────────────────────┬─────────────────────────────────────────┘
                             │  HTTP / fetch API
                             ▼
┌──────────────────────────────────────────────────────────────────────┐
│                          BACKEND LAYER                               │
│                     Node.js + Express.js                             │
│                                                                      │
│   GET /api/students        GET /api/courses       GET /api/schedule  │
│   GET /api/transcript/:id  POST /api/enroll       PUT /api/grade     │
│   GET /api/departments     GET /api/enrollments   GET /api/employees │
│   GET /api/instructors                                               │
└────────────────────────────┬─────────────────────────────────────────┘
                             │  mysql2 driver · parameterized queries
                             ▼
┌──────────────────────────────────────────────────────────────────────┐
│                         DATABASE LAYER                               │
│                    MySQL 8.0 · phpMyAdmin · XAMPP                    │
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

The schema is divided into **7 fully independent yet interlinked ERP modules**. Each module manages its own entities, fees, and staff relationships.

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
📦 University-Database-Management/
│
├── 📂 backend/
│   ├── server.js               ← Express REST API server
│   ├── package.json
│   └── node_modules/
│
├── 📂 database/
│   ├── schema.sql              ← 127-table ERP schema (MySQL 8.0)
│   ├── seed_data.sql           ← Sample data for all modules
│   ├── views.sql               ← 10 reusable database views
│   ├── procedures.sql          ← 8 stored procedures + 6 triggers
│   └── queries.sql             ← 15 sample SQL queries
│
├── 📂 frontend/
│   ├── index.html              ← Dashboard
│   ├── students.html           ← Student management
│   ├── courses.html            ← Course catalog & schedule
│   ├── transcript.html         ← Transcript viewer
│   └── style.css
│
├── 📂 screenshots/
│   ├── dashboard.png
│   ├── students.png
│   ├── courses.png
│   └── transcript.png
│
├── 📂 diagrams/
│   └── University_ERP_ERD.drawio
│
└── README.md
```

---

## ⚙ Backend API

| Method | Endpoint | Description |
|:---|:---|:---|
| `GET` | `/api/students` | Retrieve all students with program info |
| `GET` | `/api/courses` | Retrieve full course catalog |
| `GET` | `/api/departments` | Retrieve all departments with stats |
| `GET` | `/api/enrollments` | Retrieve enrollment records |
| `GET` | `/api/instructors` | Retrieve instructor list |
| `GET` | `/api/schedule` | Retrieve full section timetable |
| `GET` | `/api/transcript/:student_id` | Student transcript (calls `sp_get_student_transcript`) |
| `GET` | `/api/employees` | Retrieve employee list |
| `POST` | `/api/enroll` | Enroll student (calls `sp_enroll_student`) |
| `PUT` | `/api/grade` | Update grade (calls `sp_update_grade`) |

---

## 🖥 Frontend Pages

| Page | Route | Key Features |
|:---|:---|:---|
| **Dashboard** | `index.html` | Live module stats, top-CGPA students, quick navigation |
| **Students** | `students.html` | Search by name/reg no, enrollment list, CGPA display |
| **Courses** | `courses.html` | Course catalog, section timetable, enrolled counts |
| **Transcript** | `transcript.html` | Full per-student transcript with grade point breakdown |

---

## 🚀 Getting Started

### Prerequisites

Ensure the following are installed:

- [XAMPP](https://www.apachefriends.org/) (Apache + MySQL)
- [Node.js](https://nodejs.org/) v18+
- A modern web browser

---

### Step 1 — Clone the Repository

```bash
git clone https://github.com/Malik-Sanaullah/University-Database-Management-.git
cd University-Database-Management-
```

---

### Step 2 — Set Up the Database

1. Open **XAMPP** and start **Apache** and **MySQL**
2. Open **phpMyAdmin** at `http://localhost/phpmyadmin`
3. Create a new database:

```sql
CREATE DATABASE university_erp;
```

4. Import SQL files **in this exact order**:

```
1.  schema.sql          ← Creates all 127 tables with constraints and indexes
2.  seed_data.sql       ← Populates all modules with sample data
3.  views.sql           ← Creates 10 analytical views
4.  procedures.sql      ← Creates 8 stored procedures and 6 triggers
```

---

### Step 3 — Configure Backend

Open `backend/server.js` and confirm the DB connection matches your XAMPP setup:

```js
const db = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : '',               // default XAMPP has no password
  database : 'university_erp'
});
```

---

### Step 4 — Install Dependencies & Start Server

```bash
cd backend
npm install
node server.js
```

Expected output:

```
🚀 Server running at http://localhost:3000
✅ Connected to MySQL database!
```

---

### Step 5 — Launch Frontend

Simply open in your browser:

```
frontend/index.html
```

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

The `queries.sql` file contains **15 production-quality SQL queries** demonstrating advanced MySQL features:

| # | Query | Concepts Used |
|:---:|:---|:---|
| 1 | Top 5 students by CGPA per department | `RANK()`, window function, subquery |
| 2 | Courses with highest failure rate | `GROUP BY`, `HAVING`, aggregate |
| 3 | Students with attendance below 75% | Multi-table JOIN, percentage calculation |
| 4 | Monthly fee collection summary | `DATE_FORMAT`, `SUM`, GROUP BY date |
| 5 | Instructors teaching overloaded sections | Self-join on section, `COUNT` with `HAVING` |
| 6 | Books overdue in library with fine amount | DATEDIFF, conditional JOIN |
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

### 🏠 Dashboard

<p align="center">
  <img width="700" alt="Dashboard" src="https://github.com/user-attachments/assets/af2f3cb5-a141-475b-85fb-df80b5c0007f" />
</p>

---

### 👨‍🎓 Students Management

<p align="center">
  <img width="700" alt="Students" src="https://github.com/user-attachments/assets/64f9b253-8eb4-4641-b8e3-fdb916899d54" />
</p>

---

### 📚 Courses & Schedule

<p align="center">
  <img width="700" alt="Course Catalogue" src="https://github.com/user-attachments/assets/de4f8eab-cac1-40c6-8646-7dd7513f027a" />
</p>

<p align="center">
  <img width="420" alt="Class Schedule" src="https://github.com/user-attachments/assets/31feee3d-85da-4706-8cdf-afdff67e9bf9" />
  &nbsp;&nbsp;
  <img width="420" alt="All Courses" src="https://github.com/user-attachments/assets/495eb1ad-b97d-4a33-ab6e-5278d4c76be8" />
</p>

---

### 📄 Transcript Viewer

<p align="center">
  <img width="700" alt="Transcript" src="https://github.com/user-attachments/assets/89040b62-304f-4395-88e6-14a3492e0805" />
</p>

---

## 🛠 Tech Stack

<div align="center">

| Layer | Technology | Purpose |
|:---|:---|:---|
| 🎨 **Frontend** | HTML5, CSS3, Vanilla JavaScript | UI, dashboard, dynamic data rendering |
| ⚙️ **Backend** | Node.js, Express.js | REST API server, route handling |
| 🗄️ **Database** | MySQL 8.0, phpMyAdmin | Relational data, procedures, triggers, views |
| 🔌 **DB Driver** | mysql2 | Parameterized queries from Node.js |
| 🧪 **API Testing** | Postman | Endpoint validation during development |
| 🧠 **ER Modeling** | draw.io | Entity-relationship diagram design |
| 💻 **IDE** | VS Code | Development environment |
| 🌐 **Server** | XAMPP | Local Apache + MySQL stack |

<br/>

<img src="https://skillicons.dev/icons?i=html,css,js,nodejs,express,mysql,vscode,github" />

</div>

---

## 🤝 Contribution

This project was developed as part of the **Database Systems Lab** course at **FAST-NUCES**, Spring 2025.

Contributions and suggestions are welcome for educational purposes.

```bash
# Fork the repository
git fork https://github.com/Malik-Sanaullah/University-Database-Management-.git

# Create a feature branch
git checkout -b feature/your-feature-name

# Commit changes
git commit -m "feat: describe your change"

# Push and open a pull request
git push origin feature/your-feature-name
```

---

## 📜 License

This project is developed strictly for **academic and educational purposes**.  
Redistribution or commercial use without permission is not permitted.

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
![MySQL](https://img.shields.io/badge/127%20Tables-7%20Modules-4479A1?style=for-the-badge&logo=mysql&logoColor=white)

</div>
