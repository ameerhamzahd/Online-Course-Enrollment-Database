-- Display all students and their phone numbers.
-- If the phone number is NULL, show 'Not Provided' using COALESCE.
SELECT 
  first_name,
  last_name,
  COALESCE(phone, 'Not Provided') AS phone_number
FROM students;

-- Show all courses ordered by price (highest to lowest) and limit the result to 5 courses.
SELECT *
FROM courses
ORDER BY price DESC
LIMIT 5;

-- Display courses for page 2, assuming 3 courses per page, using LIMIT and OFFSET.
-- RULE
-- OFFSET = (page - 1) × limit
--        = (2 - 1) × 3
--        = 3
SELECT *
FROM courses
LIMIT 3 OFFSET 3;

-- Update the price of all courses in the Programming category by increasing it 10%.
UPDATE courses
SET price = price * 1.10
WHERE category = 'Programming';

-- Delete all enrollment records where progress_percentage is NULL.
DELETE FROM enrollments
WHERE progress_percentage IS NULL;

-- Find the total paid amount per course category using GROUP BY.
SELECT 
  c.category,
  SUM(e.paid_amount) AS total_paid
FROM enrollments e
JOIN courses c ON e.course_id = c.course_id
GROUP BY c.category;

-- Show course categories where the average course price is greater than 60 using HAVING.
SELECT 
  category,
  AVG(price) AS avg_price
FROM courses
GROUP BY category
HAVING AVG(price) > 60;

-- Count how many students are enrolled in each course.
SELECT 
  course_id,
  COUNT(student_id) AS total_students
FROM enrollments
GROUP BY course_id;

-- Explain what happens if you try to insert an enrollment with a student_id that does not exist in the students table.
INSERT INTO enrollments (student_id, course_id, paid_amount)
VALUES (999, 1, 49.99);

-- ERROR: insert or update on table "enrollments"
-- violates foreign key constraint

-- Display student full name, course title, and paid amount using an INNER JOIN.
SELECT
  CONCAT(s.first_name, ' ', s.last_name) AS full_name,
  c.course_title,
  e.paid_amount
FROM enrollments e
INNER JOIN students s ON e.student_id = s.student_id
INNER JOIN courses c ON e.course_id = c.course_id;

-- Display all students and their enrolled courses.
-- Include students who have not enrolled in any course using a LEFT JOIN.
SELECT
  CONCAT(s.first_name, ' ', s.last_name) AS full_name,
  c.course_title
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
LEFT JOIN courses c ON e.course_id = c.course_id;

-- Display all courses and their enrolled students.
-- Include courses that have no enrollments using a RIGHT JOIN.
SELECT
  c.course_title,
  CONCAT(s.first_name, ' ', s.last_name) AS student_name
FROM enrollments e
RIGHT JOIN courses c ON e.course_id = c.course_id
LEFT JOIN students s ON e.student_id = s.student_id;

-- Display all students and all courses, even if there is no matching enrollment, using a FULL JOIN.
SELECT
  CONCAT(s.first_name, ' ', s.last_name) AS student_name,
  c.course_title
FROM students s
FULL JOIN enrollments e ON s.student_id = e.student_id
FULL JOIN courses c ON e.course_id = c.course_id;

-- Show the number of enrollments per year based on enrollment_date.
SELECT
  EXTRACT(YEAR FROM enrollment_date) AS year,
  COUNT(*) AS total_enrollments
FROM enrollments
GROUP BY year
ORDER BY year;

-- Find the average progress percentage per course, ignoring NULL values.
SELECT
  course_id,
  AVG(progress_percentage) AS avg_progress
FROM enrollments
GROUP BY course_id;
