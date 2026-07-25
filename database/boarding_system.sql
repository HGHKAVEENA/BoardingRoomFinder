-- ==========================================================
-- Boarding Room Finder & Reservation System - MySQL schema
-- ==========================================================
DROP DATABASE IF EXISTS boarding_system;
CREATE DATABASE boarding_system CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE boarding_system;

-- ---------- USERS ----------
CREATE TABLE users (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(60)  NOT NULL,
    last_name  VARCHAR(60)  NOT NULL,
    email      VARCHAR(120) NOT NULL UNIQUE,
    phone      VARCHAR(20),
    password   VARCHAR(255) NOT NULL,
    role       ENUM('Student','Owner') NOT NULL
);

-- ---------- UNIVERSITIES ----------
CREATE TABLE universities (
    university_id   INT AUTO_INCREMENT PRIMARY KEY,
    university_name VARCHAR(150) NOT NULL,
    city            VARCHAR(80)  NOT NULL
);

INSERT INTO universities (university_name, city) VALUES
('University of Colombo',              'Colombo'),
('University of Peradeniya',           'Peradeniya'),
('University of Sri Jayewardenepura',  'Nugegoda'),
('University of Kelaniya',             'Kelaniya'),
('University of Moratuwa',             'Moratuwa'),
('University of Ruhuna',               'Matara'),
('University of Jaffna',               'Jaffna'),
('Eastern University',                 'Batticaloa'),
('Rajarata University',                'Mihintale'),
('Sabaragamuwa University',            'Belihuloya'),
('Wayamba University',                 'Kuliyapitiya'),
('South Eastern University',           'Oluvil'),
('Uva Wellassa University',            'Badulla');

-- ---------- ROOMS ----------
CREATE TABLE rooms (
    room_id       INT AUTO_INCREMENT PRIMARY KEY,
    owner_id      INT NOT NULL,
    university_id INT NOT NULL,
    title         VARCHAR(150) NOT NULL,
    description   TEXT,
    location      VARCHAR(150),
    room_type     ENUM('Single','Shared','Studio') DEFAULT 'Single',
    gender        ENUM('Male','Female','Any')      DEFAULT 'Any',
    price         DECIMAL(10,2) NOT NULL,
    bathroom      BOOLEAN DEFAULT FALSE,
    image         VARCHAR(255),
    status        ENUM('Available','Booked') DEFAULT 'Available',
    FOREIGN KEY (owner_id)      REFERENCES users(id)               ON DELETE CASCADE,
    FOREIGN KEY (university_id) REFERENCES universities(university_id)
);

-- ---------- BOOKINGS ----------
CREATE TABLE bookings (
    booking_id     INT AUTO_INCREMENT PRIMARY KEY,
    student_id     INT NOT NULL,
    room_id        INT NOT NULL,
    booking_date   DATETIME DEFAULT CURRENT_TIMESTAMP,
    booking_status ENUM('Pending','Accepted','Rejected') DEFAULT 'Pending',
    FOREIGN KEY (student_id) REFERENCES users(id)  ON DELETE CASCADE,
    FOREIGN KEY (room_id)    REFERENCES rooms(room_id) ON DELETE CASCADE
);

-- ---------- SAMPLE DATA ----------
INSERT INTO users (first_name,last_name,email,phone,password,role) VALUES
('Kasun','Perera','owner@test.com','0771111111','1234','Owner'),
('Nimal','Silva', 'student@test.com','0772222222','1234','Student');

INSERT INTO rooms (owner_id, university_id, title, description, location, room_type, gender, price, wifi, parking, meals, bathroom, image, status)
VALUES
(1, 5, 'Cozy Single Room near Moratuwa Uni', 'Furnished single room, 5 min walk to campus.', 'Katubedda', 'Single', 'Male',   12000, TRUE, FALSE, TRUE, TRUE, 'uploads/sample1.jpg', 'Available'),
(1, 1, 'Shared Room - Colombo 07',           'Two-share room, quiet neighborhood.',          'Cinnamon Gardens', 'Shared', 'Female', 9500, TRUE, TRUE, FALSE, TRUE, 'uploads/sample2.jpg', 'Available');
