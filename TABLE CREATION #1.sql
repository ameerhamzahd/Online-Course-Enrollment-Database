-- TABLE CREATION
CREATE TABLE students (
  student_id SERIAL PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(100) UNIQUE,
  phone VARCHAR(20),
  country VARCHAR(50) NOT NULL,
  enrollment_date DATE
);

CREATE TABLE courses (
  course_id SERIAL PRIMARY KEY,
  course_title VARCHAR(150) NOT NULL,
  category VARCHAR(50) NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  instructor VARCHAR(100) NOT NULL,
  published_year INT NOT NULL
);

CREATE TABLE enrollments (
  enrollment_id SERIAL PRIMARY KEY,
  student_id INT REFERENCES students(student_id),
  course_id INT REFERENCES courses(course_id),
  enrollment_date DATE,
  progress_percentage INT,
  paid_amount DECIMAL(10, 2) NOT NULL
);

