// ============================================================
//  UNIVERSITY ERP — Backend Server
//  Node.js + Express + MySQL2
//  Run: node server.js
// ============================================================
const express  = require('express');
const mysql    = require('mysql2');
const cors     = require('cors');
const path     = require('path');

const app = express();
app.use(cors());
app.use(express.json());
app.use(express.static(path.join(__dirname)));

// ── Database pool ────────────────────────────────────────────
const pool = mysql.createPool({
  host            : 'localhost',
  user            : 'root',
  password        : '',
  database        : 'university_erp',
  waitForConnections: true,
  connectionLimit : 10,
  queueLimit      : 0,
  dateStrings     : true
});

const db = pool.promise();
const q  = (sql, p = []) => db.query(sql, p).then(([r]) => r);

// ── Error handler helper ─────────────────────────────────────
const handle = fn => async (req, res) => {
  try { await fn(req, res); }
  catch (e) { res.status(500).json({ error: e.message }); }
};

// ════════════════════════════════════════════════════════════
//  DASHBOARD
// ════════════════════════════════════════════════════════════
app.get('/api/stats', handle(async (req, res) => {
  const [
    students, instructors, courses, departments,
    sections, enrollments, books,
    byStatus, byProgram, topStudents, monthlyEnrollments
  ] = await Promise.all([
    q('SELECT COUNT(*) c FROM student'),
    q('SELECT COUNT(*) c FROM instructor'),
    q('SELECT COUNT(*) c FROM course'),
    q('SELECT COUNT(*) c FROM department'),
    q('SELECT COUNT(*) c FROM section'),
    q('SELECT COUNT(*) c FROM enrollment'),
    q('SELECT COUNT(*) c FROM book'),
    q('SELECT status, COUNT(*) cnt FROM student GROUP BY status'),
    q(`SELECT p.program_name, p.degree_level, COUNT(s.student_id) cnt
       FROM student s JOIN program p ON s.program_id=p.program_id
       GROUP BY p.program_id ORDER BY cnt DESC LIMIT 6`),
    q(`SELECT CONCAT(s.first_name,' ',s.last_name) name,
              s.registration_no, s.cgpa, p.program_name, d.department_name
       FROM student s
       JOIN program p    ON s.program_id    = p.program_id
       JOIN department d ON p.department_id = d.department_id
       WHERE s.status='Active' AND s.cgpa > 0
       ORDER BY s.cgpa DESC LIMIT 8`),
    q(`SELECT DATE_FORMAT(e.enrollment_date,'%Y-%m') mo, COUNT(*) cnt
       FROM enrollment e
       WHERE e.enrollment_date >= DATE_SUB(NOW(), INTERVAL 12 MONTH)
       GROUP BY mo ORDER BY mo`)
  ]);

  res.json({
    counts: {
      students : students[0].c,
      instructors: instructors[0].c,
      courses  : courses[0].c,
      departments: departments[0].c,
      sections : sections[0].c,
      enrollments: enrollments[0].c,
      books    : books[0].c
    },
    byStatus, byProgram, topStudents, monthlyEnrollments
  });
}));

// ════════════════════════════════════════════════════════════
//  STUDENTS
// ════════════════════════════════════════════════════════════
app.get('/api/students', handle(async (req, res) => {
  const { search, status, program_id } = req.query;
  let sql = `
    SELECT s.student_id, s.registration_no,
           CONCAT(s.first_name,' ',s.last_name) full_name,
           s.gender, s.email, s.phone, s.admission_date,
           s.cgpa, s.status, s.blood_group,
           p.program_name, p.degree_level,
           d.department_name
    FROM student s
    JOIN program p    ON s.program_id    = p.program_id
    JOIN department d ON p.department_id = d.department_id
    WHERE 1=1`;
  const p = [];
  if (search) {
    sql += ` AND (s.first_name LIKE ? OR s.last_name LIKE ? OR s.registration_no LIKE ? OR s.email LIKE ?)`;
    [1,2,3,4].forEach(() => p.push(`%${search}%`));
  }
  if (status) { sql += ` AND s.status=?`; p.push(status); }
  if (program_id) { sql += ` AND s.program_id=?`; p.push(program_id); }
  sql += ` ORDER BY s.student_id DESC LIMIT 500`;
  res.json(await q(sql, p));
}));

app.get('/api/students/:id', handle(async (req, res) => {
  const rows = await q(`
    SELECT s.*, CONCAT(s.first_name,' ',s.last_name) full_name,
           p.program_name, p.degree_level, p.total_credit_hours,
           d.department_name, d.department_code
    FROM student s
    JOIN program p    ON s.program_id    = p.program_id
    JOIN department d ON p.department_id = d.department_id
    WHERE s.student_id=?`, [req.params.id]);
  if (!rows.length) return res.status(404).json({ error: 'Not found' });
  res.json(rows[0]);
}));

// ════════════════════════════════════════════════════════════
//  COURSES
// ════════════════════════════════════════════════════════════
app.get('/api/courses', handle(async (req, res) => {
  const { search, department_id } = req.query;
  let sql = `
    SELECT c.course_id, c.course_code, c.course_title,
           c.credit_hours, c.description,
           d.department_name, d.department_code,
           COUNT(DISTINCT sec.section_id) total_sections,
           COUNT(DISTINCT e.enrollment_id) total_enrolled
    FROM course c
    JOIN department d ON c.department_id=d.department_id
    LEFT JOIN section sec ON c.course_id=sec.course_id
    LEFT JOIN enrollment e ON sec.section_id=e.section_id
    WHERE 1=1`;
  const p = [];
  if (search) {
    sql += ` AND (c.course_title LIKE ? OR c.course_code LIKE ?)`;
    p.push(`%${search}%`, `%${search}%`);
  }
  if (department_id) { sql += ` AND c.department_id=?`; p.push(department_id); }
  sql += ` GROUP BY c.course_id ORDER BY d.department_name, c.course_code`;
  res.json(await q(sql, p));
}));

// ════════════════════════════════════════════════════════════
//  SECTIONS / SCHEDULE
// ════════════════════════════════════════════════════════════
app.get('/api/sections', handle(async (req, res) => {
  const { semester_id } = req.query;
  let sql = `
    SELECT sec.section_id, sec.section_name, sec.capacity,
           c.course_code, c.course_title, c.credit_hours,
           CONCAT(i.first_name,' ',i.last_name) instructor_name,
           sm.semester_name, acad.session_name,
           ts.day_of_week, ts.start_time, ts.end_time,
           b.building_name, cl.room_number,
           COUNT(e.enrollment_id) enrolled_count,
           (sec.capacity - COUNT(e.enrollment_id)) seats_available
    FROM section sec
    JOIN course c         ON sec.course_id    = c.course_id
    JOIN semester sm      ON sec.semester_id  = sm.semester_id
    JOIN academic_session acad ON sm.session_id = acad.session_id
    LEFT JOIN instructor i  ON sec.instructor_id = i.instructor_id
    LEFT JOIN time_slot ts  ON sec.time_slot_id  = ts.time_slot_id
    LEFT JOIN classroom cl  ON sec.classroom_id  = cl.classroom_id
    LEFT JOIN building  b   ON cl.building_id    = b.building_id
    LEFT JOIN enrollment e  ON sec.section_id    = e.section_id
    WHERE 1=1`;
  const p = [];
  if (semester_id) { sql += ` AND sec.semester_id=?`; p.push(semester_id); }
  sql += ` GROUP BY sec.section_id ORDER BY ts.day_of_week, ts.start_time`;
  res.json(await q(sql, p));
}));

// ════════════════════════════════════════════════════════════
//  DEPARTMENTS
// ════════════════════════════════════════════════════════════
app.get('/api/departments', handle(async (req, res) => {
  res.json(await q(`
    SELECT d.*,
           COUNT(DISTINCT p.program_id)    total_programs,
           COUNT(DISTINCT i.instructor_id) total_instructors,
           COUNT(DISTINCT s.student_id)   total_students,
           COUNT(DISTINCT c.course_id)    total_courses
    FROM department d
    LEFT JOIN program    p ON d.department_id = p.department_id
    LEFT JOIN instructor i ON d.department_id = i.department_id
    LEFT JOIN student    s ON p.program_id    = s.program_id
    LEFT JOIN course     c ON d.department_id = c.department_id
    GROUP BY d.department_id ORDER BY d.department_name`));
}));

// ════════════════════════════════════════════════════════════
//  ENROLLMENTS
// ════════════════════════════════════════════════════════════
app.get('/api/enrollments', handle(async (req, res) => {
  const { student_id } = req.query;
  let sql = `
    SELECT e.enrollment_id, e.enrollment_date, e.grade,
           CONCAT(s.first_name,' ',s.last_name) student_name,
           s.registration_no,
           c.course_code, c.course_title, c.credit_hours,
           sec.section_name, sm.semester_name, acad.session_name
    FROM enrollment e
    JOIN student s        ON e.student_id  = s.student_id
    JOIN section sec      ON e.section_id  = sec.section_id
    JOIN course c         ON sec.course_id = c.course_id
    JOIN semester sm      ON sec.semester_id = sm.semester_id
    JOIN academic_session acad ON sm.session_id = acad.session_id
    WHERE 1=1`;
  const p = [];
  if (student_id) { sql += ` AND e.student_id=?`; p.push(student_id); }
  sql += ` ORDER BY e.enrollment_date DESC LIMIT 200`;
  res.json(await q(sql, p));
}));

app.post('/api/enroll', handle(async (req, res) => {
  const { student_id, section_id, enrollment_date } = req.body;
  await q('CALL sp_enroll_student(?,?,?)', [student_id, section_id, enrollment_date]);
  res.json({ success: true, message: 'Student enrolled successfully' });
}));

app.put('/api/grade', handle(async (req, res) => {
  const { student_id, section_id, grade } = req.body;
  await q('CALL sp_update_grade(?,?,?)', [student_id, section_id, grade]);
  res.json({ success: true, message: 'Grade updated successfully' });
}));

// ════════════════════════════════════════════════════════════
//  TRANSCRIPT
// ════════════════════════════════════════════════════════════
app.get('/api/transcript/:id', handle(async (req, res) => {
  const id = req.params.id;
  const students = await q(`
    SELECT s.student_id, s.registration_no,
           CONCAT(s.first_name,' ',s.last_name) full_name,
           s.cgpa, s.admission_date, s.status,
           p.program_name, p.degree_level, p.total_credit_hours,
           d.department_name
    FROM student s
    JOIN program p    ON s.program_id    = p.program_id
    JOIN department d ON p.department_id = d.department_id
    WHERE s.student_id=?`, [id]);
  if (!students.length) return res.status(404).json({ error: 'Student not found' });

  const courses = await q(`
    SELECT acad.session_name, sm.semester_name,
           c.course_code, c.course_title, c.credit_hours, e.grade,
           CASE e.grade
             WHEN 'A'  THEN 4.0 WHEN 'A-' THEN 3.7
             WHEN 'B+' THEN 3.3 WHEN 'B'  THEN 3.0
             WHEN 'B-' THEN 2.7 WHEN 'C+' THEN 2.3
             WHEN 'C'  THEN 2.0 WHEN 'C-' THEN 1.7
             WHEN 'D+' THEN 1.3 WHEN 'D'  THEN 1.0
             WHEN 'F'  THEN 0.0 ELSE NULL
           END gp
    FROM enrollment e
    JOIN section sec      ON e.section_id   = sec.section_id
    JOIN course c         ON sec.course_id  = c.course_id
    JOIN semester sm      ON sec.semester_id = sm.semester_id
    JOIN academic_session acad ON sm.session_id = acad.session_id
    WHERE e.student_id=?
    ORDER BY acad.session_name, sm.semester_name, c.course_code`, [id]);

  res.json({ student: students[0], courses });
}));

// ════════════════════════════════════════════════════════════
//  INSTRUCTORS
// ════════════════════════════════════════════════════════════
app.get('/api/instructors', handle(async (req, res) => {
  res.json(await q(`
    SELECT i.instructor_id, i.employee_no,
           CONCAT(i.first_name,' ',i.last_name) full_name,
           i.email, i.phone, i.designation, i.hire_date,
           d.department_name,
           COUNT(DISTINCT sec.section_id) sections_count
    FROM instructor i
    JOIN department d ON i.department_id = d.department_id
    LEFT JOIN section sec ON i.instructor_id = sec.instructor_id
    GROUP BY i.instructor_id ORDER BY d.department_name, i.last_name`));
}));

// ════════════════════════════════════════════════════════════
//  PROGRAMS & SEMESTERS (helper dropdowns)
// ════════════════════════════════════════════════════════════
app.get('/api/programs', handle(async (req, res) => {
  res.json(await q(`
    SELECT p.*, d.department_name, COUNT(s.student_id) total_students
    FROM program p JOIN department d ON p.department_id=d.department_id
    LEFT JOIN student s ON p.program_id=s.program_id
    GROUP BY p.program_id ORDER BY d.department_name, p.program_name`));
}));

app.get('/api/semesters', handle(async (req, res) => {
  res.json(await q(`
    SELECT sm.*, acad.session_name
    FROM semester sm JOIN academic_session acad ON sm.session_id=acad.session_id
    ORDER BY acad.session_name DESC, sm.semester_name`));
}));

// ════════════════════════════════════════════════════════════
//  LIBRARY
// ════════════════════════════════════════════════════════════
app.get('/api/library/books', handle(async (req, res) => {
  const { search } = req.query;
  let sql = `
    SELECT b.book_id, b.isbn, b.title, b.edition, b.publication_year,
           bc_cat.category_name, pub.publisher_name,
           GROUP_CONCAT(DISTINCT CONCAT(a.first_name,' ',a.last_name) SEPARATOR ', ') authors,
           COUNT(DISTINCT bc.copy_id) total_copies,
           SUM(CASE WHEN bc.status='Available' THEN 1 ELSE 0 END) available_copies,
           SUM(CASE WHEN bc.status='Issued'    THEN 1 ELSE 0 END) issued_copies
    FROM book b
    LEFT JOIN book_category bc_cat ON b.category_id  = bc_cat.category_id
    LEFT JOIN publisher     pub    ON b.publisher_id  = pub.publisher_id
    LEFT JOIN book_copy     bc     ON b.book_id       = bc.book_id
    LEFT JOIN book_author   ba     ON b.book_id       = ba.book_id
    LEFT JOIN author        a      ON ba.author_id    = a.author_id
    WHERE 1=1`;
  const p = [];
  if (search) { sql += ` AND (b.title LIKE ? OR b.isbn LIKE ?)`; p.push(`%${search}%`,`%${search}%`); }
  sql += ` GROUP BY b.book_id ORDER BY b.title LIMIT 200`;
  res.json(await q(sql, p));
}));

app.get('/api/library/issues', handle(async (req, res) => {
  res.json(await q(`
    SELECT bi.issue_id, bi.issue_date, bi.due_date,
           b.title book_title, b.isbn,
           CONCAT(s.first_name,' ',s.last_name) member_name,
           s.registration_no,
           DATEDIFF(NOW(), bi.due_date) days_overdue,
           br.return_date
    FROM book_issue bi
    JOIN book_copy bc ON bi.copy_id = bc.copy_id
    JOIN book b       ON bc.book_id = b.book_id
    JOIN library_member lm ON bi.member_id = lm.member_id
    LEFT JOIN student s    ON lm.student_id = s.student_id
    LEFT JOIN book_return br ON bi.issue_id = br.issue_id
    ORDER BY bi.issue_date DESC LIMIT 100`));
}));

// ════════════════════════════════════════════════════════════
//  FINANCE
// ════════════════════════════════════════════════════════════
app.get('/api/finance/summary', handle(async (req, res) => {
  const [totals] = await q(`
    SELECT COUNT(*) total_invoices,
           SUM(total_amount) total_invoiced,
           SUM(CASE WHEN status='Paid'    THEN total_amount ELSE 0 END) collected,
           SUM(CASE WHEN status='Overdue' THEN total_amount ELSE 0 END) overdue,
           SUM(CASE WHEN status='Pending' THEN total_amount ELSE 0 END) pending
    FROM invoice`);
  const byStatus = await q(`SELECT status, COUNT(*) cnt, SUM(total_amount) amount FROM invoice GROUP BY status`);
  res.json({ totals, byStatus });
}));

app.get('/api/finance/invoices', handle(async (req, res) => {
  res.json(await q(`
    SELECT inv.invoice_id, inv.invoice_date, inv.due_date,
           inv.total_amount, inv.status,
           CONCAT(s.first_name,' ',s.last_name) student_name,
           s.registration_no, sm.semester_name, acad.session_name
    FROM invoice inv
    JOIN student s        ON inv.student_id  = s.student_id
    JOIN semester sm      ON inv.semester_id = sm.semester_id
    JOIN academic_session acad ON sm.session_id = acad.session_id
    ORDER BY inv.invoice_date DESC LIMIT 200`));
}));

// ════════════════════════════════════════════════════════════
//  HOSTEL
// ════════════════════════════════════════════════════════════
app.get('/api/hostel/overview', handle(async (req, res) => {
  const hostels = await q(`
    SELECT h.hostel_id, h.hostel_name, h.hostel_type, h.total_capacity,
           COUNT(DISTINCT b.bed_id) total_beds,
           SUM(CASE WHEN b.status='Available' THEN 1 ELSE 0 END) available,
           SUM(CASE WHEN b.status='Occupied'  THEN 1 ELSE 0 END) occupied,
           SUM(CASE WHEN b.status='Reserved'  THEN 1 ELSE 0 END) reserved
    FROM hostel h
    JOIN hostel_block hb ON h.hostel_id = hb.hostel_id
    JOIN hostel_room  hr ON hb.block_id  = hr.block_id
    LEFT JOIN bed     b  ON hr.room_id   = b.room_id
    GROUP BY h.hostel_id ORDER BY h.hostel_name`);
  const complaints = await q(`
    SELECT hc.complaint_id, hc.complaint_type, hc.complaint_date, hc.status,
           CONCAT(s.first_name,' ',s.last_name) student_name
    FROM hostel_complaint hc
    JOIN student s ON hc.student_id = s.student_id
    ORDER BY hc.complaint_date DESC LIMIT 20`);
  res.json({ hostels, complaints });
}));

// ════════════════════════════════════════════════════════════
//  TRANSPORT
// ════════════════════════════════════════════════════════════
app.get('/api/transport/overview', handle(async (req, res) => {
  const vehicles = await q(`
    SELECT v.vehicle_id, v.vehicle_number, v.vehicle_type,
           v.model, v.seating_capacity, v.status,
           COUNT(DISTINCT str.student_id) registered_students
    FROM vehicle v
    LEFT JOIN vehicle_assignment va ON v.vehicle_id = va.vehicle_id
    LEFT JOIN student_transport_registration str ON va.route_id = str.route_id
    GROUP BY v.vehicle_id ORDER BY v.vehicle_type`);
  const routes = await q(`
    SELECT tr.route_id, tr.route_name, tr.estimated_distance_km,
           COUNT(DISTINCT str.student_id) registered_students
    FROM transport_route tr
    LEFT JOIN student_transport_registration str ON tr.route_id = str.route_id
    GROUP BY tr.route_id ORDER BY tr.route_name`);
  res.json({ vehicles, routes });
}));

// ════════════════════════════════════════════════════════════
//  VIEWS
// ════════════════════════════════════════════════════════════
app.get('/api/view/attendance', handle(async (req, res) => {
  res.json(await q(`
    SELECT student_id, registration_no, student_name,
           course_code, course_title, section_name,
           semester_name, total_classes, present_count,
           absent_count, attendance_percentage, attendance_status
    FROM vw_attendance_summary
    ORDER BY attendance_percentage ASC LIMIT 200`));
}));

app.get('/api/view/instructor-workload', handle(async (req, res) => {
  res.json(await q(`SELECT * FROM vw_instructor_workload ORDER BY total_credit_hours DESC LIMIT 100`));
}));

// ── Serve pages ──────────────────────────────────────────────
app.get('/',            (_, res) => res.sendFile(path.join(__dirname,'index.html')));
app.get('/students',    (_, res) => res.sendFile(path.join(__dirname,'students.html')));
app.get('/courses',     (_, res) => res.sendFile(path.join(__dirname,'courses.html')));
app.get('/transcript',  (_, res) => res.sendFile(path.join(__dirname,'transcript.html')));
app.get('/library',     (_, res) => res.sendFile(path.join(__dirname,'library.html')));
app.get('/finance',     (_, res) => res.sendFile(path.join(__dirname,'finance.html')));
app.get('/hostel',      (_, res) => res.sendFile(path.join(__dirname,'hostel.html')));
app.get('/transport',   (_, res) => res.sendFile(path.join(__dirname,'transport.html')));

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`\n🎓 University ERP running at http://localhost:${PORT}`);
  console.log(`✅ MySQL connected to university_erp\n`);
});
