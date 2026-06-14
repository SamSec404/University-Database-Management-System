// ============================================================
//  University ERP — Basic API Tests
//  Run: npm test
//  Requires: MySQL running with university_erp database loaded
// ============================================================
const request = require('supertest');

// NOTE: server.js calls app.listen() directly. For testing, either:
//   1) export `app` from server.js (recommended), or
//   2) run the server separately and point BASE_URL at it.
//
// This test file assumes server.js has been updated to:
//   module.exports = app;
// and that app.listen() is wrapped in `if (require.main === module)`.

const app = require('../server');

describe('University ERP API', () => {

  test('GET /api/stats returns dashboard counts', async () => {
    const res = await request(app).get('/api/stats');
    expect(res.statusCode).toBe(200);
    expect(res.body).toHaveProperty('counts');
    expect(res.body.counts).toHaveProperty('students');
    expect(res.body.counts).toHaveProperty('courses');
    expect(res.body.counts).toHaveProperty('departments');
  });

  test('GET /api/students returns an array of students', async () => {
    const res = await request(app).get('/api/students');
    expect(res.statusCode).toBe(200);
    expect(Array.isArray(res.body)).toBe(true);
    if (res.body.length) {
      expect(res.body[0]).toHaveProperty('registration_no');
      expect(res.body[0]).toHaveProperty('cgpa');
    }
  });

  test('GET /api/students with search filter works', async () => {
    const res = await request(app).get('/api/students?search=Ali');
    expect(res.statusCode).toBe(200);
    expect(Array.isArray(res.body)).toBe(true);
  });

  test('GET /api/students/:id returns 404 for non-existent student', async () => {
    const res = await request(app).get('/api/students/999999');
    expect(res.statusCode).toBe(404);
  });

  test('GET /api/courses returns course catalog with department info', async () => {
    const res = await request(app).get('/api/courses');
    expect(res.statusCode).toBe(200);
    expect(Array.isArray(res.body)).toBe(true);
    if (res.body.length) {
      expect(res.body[0]).toHaveProperty('course_code');
      expect(res.body[0]).toHaveProperty('department_name');
    }
  });

  test('GET /api/departments returns all departments', async () => {
    const res = await request(app).get('/api/departments');
    expect(res.statusCode).toBe(200);
    expect(Array.isArray(res.body)).toBe(true);
  });

  test('GET /api/instructors returns instructor list', async () => {
    const res = await request(app).get('/api/instructors');
    expect(res.statusCode).toBe(200);
    expect(Array.isArray(res.body)).toBe(true);
  });

  test('GET /api/library/books returns book catalog', async () => {
    const res = await request(app).get('/api/library/books');
    expect(res.statusCode).toBe(200);
    expect(Array.isArray(res.body)).toBe(true);
  });

  test('GET /api/finance/summary returns invoice totals', async () => {
    const res = await request(app).get('/api/finance/summary');
    expect(res.statusCode).toBe(200);
    expect(res.body).toHaveProperty('totals');
    expect(res.body).toHaveProperty('byStatus');
  });

  test('GET /api/hostel/overview returns hostels and complaints', async () => {
    const res = await request(app).get('/api/hostel/overview');
    expect(res.statusCode).toBe(200);
    expect(res.body).toHaveProperty('hostels');
    expect(res.body).toHaveProperty('complaints');
  });

  test('GET /api/transport/overview returns vehicles and routes', async () => {
    const res = await request(app).get('/api/transport/overview');
    expect(res.statusCode).toBe(200);
    expect(res.body).toHaveProperty('vehicles');
    expect(res.body).toHaveProperty('routes');
  });

});
