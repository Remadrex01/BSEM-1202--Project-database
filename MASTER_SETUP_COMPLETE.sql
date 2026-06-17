-- =====================================================
-- MASTER SETUP SCRIPT - Complete Database Creation
-- =====================================================
-- This script creates the entire Medical Management Database
-- with all tables, sample data, and user accounts
-- =====================================================

-- Step 1: Create Database
-- =====================================================
DROP DATABASE IF EXISTS MedicalManagementDB;
CREATE DATABASE MedicalManagementDB 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE MedicalManagementDB;

-- =====================================================
-- Step 2: Create All Tables
-- =====================================================

-- Patient Table
CREATE TABLE Patient (
    PatientID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender VARCHAR(10) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    PhoneNumber VARCHAR(15) NOT NULL,
    Address VARCHAR(255),
    City VARCHAR(50),
    State VARCHAR(50),
    ZipCode VARCHAR(10),
    BloodType VARCHAR(5),
    EmergencyContact VARCHAR(100),
    EmergencyPhone VARCHAR(15),
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Doctor Table
CREATE TABLE Doctor (
    DoctorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Specialization VARCHAR(100) NOT NULL,
    LicenseNumber VARCHAR(50) UNIQUE NOT NULL,
    Email VARCHAR(100) UNIQUE,
    PhoneNumber VARCHAR(15) NOT NULL,
    Address VARCHAR(255),
    City VARCHAR(50),
    State VARCHAR(50),
    ZipCode VARCHAR(10),
    ClinicName VARCHAR(100),
    YearsOfExperience INT,
    Qualification VARCHAR(255),
    IsActive BOOLEAN DEFAULT TRUE,
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Medication Table
CREATE TABLE Medication (
    MedicationID INT PRIMARY KEY AUTO_INCREMENT,
    MedicationName VARCHAR(100) NOT NULL,
    GenericName VARCHAR(100),
    Manufacturer VARCHAR(100),
    DrugType VARCHAR(50) NOT NULL,
    Dosage VARCHAR(50) NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    QuantityInStock INT NOT NULL,
    ExpiryDate DATE NOT NULL,
    Batch VARCHAR(50),
    SideEffects TEXT,
    Contraindications TEXT,
    IsApproved BOOLEAN DEFAULT TRUE,
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Appointment Table
CREATE TABLE Appointment (
    AppointmentID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    AppointmentDate DATE NOT NULL,
    AppointmentTime TIME NOT NULL,
    Reason VARCHAR(255),
    Status VARCHAR(20) DEFAULT 'Scheduled',
    RoomNumber INT,
    Notes TEXT,
    CancellationReason VARCHAR(255),
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);

-- Prescription Table
CREATE TABLE Prescription (
    PrescriptionID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    AppointmentID INT,
    PrescriptionDate DATE NOT NULL,
    Diagnosis VARCHAR(255),
    Instructions TEXT,
    RefillAllowed INT DEFAULT 0,
    RefillsRemaining INT,
    ExpiryDate DATE,
    Status VARCHAR(20) DEFAULT 'Active',
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID),
    FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID)
);

-- PrescriptionItem Table
CREATE TABLE PrescriptionItem (
    PrescriptionItemID INT PRIMARY KEY AUTO_INCREMENT,
    PrescriptionID INT NOT NULL,
    MedicationID INT NOT NULL,
    Quantity INT NOT NULL,
    Dosage VARCHAR(50),
    Frequency VARCHAR(100),
    Duration INT NOT NULL,
    DurationUnit VARCHAR(20),
    Instructions TEXT,
    CostPerUnit DECIMAL(10, 2),
    TotalCost DECIMAL(10, 2),
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (PrescriptionID) REFERENCES Prescription(PrescriptionID),
    FOREIGN KEY (MedicationID) REFERENCES Medication(MedicationID)
);

-- User Login Table
CREATE TABLE UserLogin (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(50) UNIQUE NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Role VARCHAR(50) NOT NULL,
    FullName VARCHAR(100),
    IsActive BOOLEAN DEFAULT TRUE,
    LastLogin DATETIME,
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    AccountStatus VARCHAR(20) DEFAULT 'Active'
);

-- Login Audit Log Table
CREATE TABLE IF NOT EXISTS LoginAuditLog (
    AuditID INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(50),
    LoginTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Action VARCHAR(50),
    IPAddress VARCHAR(45),
    Status VARCHAR(20)
);

-- =====================================================
-- Step 3: Create Database Users and Grant Permissions
-- =====================================================

-- Admin User
DROP USER IF EXISTS 'admin'@'localhost';
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'AdminPassword123!';
GRANT ALL PRIVILEGES ON MedicalManagementDB.* TO 'admin'@'localhost';

-- Doctor User
DROP USER IF EXISTS 'doctor'@'localhost';
CREATE USER 'doctor'@'localhost' IDENTIFIED BY 'DoctorPass123!';
GRANT SELECT, INSERT, UPDATE ON MedicalManagementDB.* TO 'doctor'@'localhost';

-- Nurse User
DROP USER IF EXISTS 'nurse'@'localhost';
CREATE USER 'nurse'@'localhost' IDENTIFIED BY 'NursePass123!';
GRANT SELECT, INSERT ON MedicalManagementDB.Patient TO 'nurse'@'localhost';
GRANT SELECT, INSERT, UPDATE ON MedicalManagementDB.Appointment TO 'nurse'@'localhost';
GRANT SELECT ON MedicalManagementDB.Doctor TO 'nurse'@'localhost';
GRANT SELECT ON MedicalManagementDB.Medication TO 'nurse'@'localhost';

-- Pharmacist User
DROP USER IF EXISTS 'pharmacist'@'localhost';
CREATE USER 'pharmacist'@'localhost' IDENTIFIED BY 'PharmacistPass123!';
GRANT SELECT, UPDATE ON MedicalManagementDB.Medication TO 'pharmacist'@'localhost';
GRANT SELECT ON MedicalManagementDB.Patient TO 'pharmacist'@'localhost';
GRANT SELECT ON MedicalManagementDB.Prescription TO 'pharmacist'@'localhost';
GRANT SELECT ON MedicalManagementDB.PrescriptionItem TO 'pharmacist'@'localhost';

-- Receptionist User
DROP USER IF EXISTS 'receptionist'@'localhost';
CREATE USER 'receptionist'@'localhost' IDENTIFIED BY 'ReceptionistPass123!';
GRANT SELECT ON MedicalManagementDB.Patient TO 'receptionist'@'localhost';
GRANT SELECT, INSERT, UPDATE ON MedicalManagementDB.Appointment TO 'receptionist'@'localhost';
GRANT SELECT ON MedicalManagementDB.Doctor TO 'receptionist'@'localhost';

-- Viewer User (Read-Only)
DROP USER IF EXISTS 'viewer'@'localhost';
CREATE USER 'viewer'@'localhost' IDENTIFIED BY 'ViewerPass123!';
GRANT SELECT ON MedicalManagementDB.* TO 'viewer'@'localhost';

FLUSH PRIVILEGES;

-- =====================================================
-- Step 4: Insert 30 Patient Records
-- =====================================================
INSERT INTO Patient (FirstName, LastName, DateOfBirth, Gender, Email, PhoneNumber, Address, City, State, ZipCode, BloodType, EmergencyContact, EmergencyPhone) VALUES
('John', 'Smith', '1985-03-15', 'Male', 'john.smith@email.com', '555-0101', '123 Main St', 'New York', 'NY', '10001', 'O+', 'Sarah Smith', '555-0102'),
('Mary', 'Johnson', '1990-07-22', 'Female', 'mary.johnson@email.com', '555-0103', '456 Oak Ave', 'Los Angeles', 'CA', '90001', 'A+', 'Robert Johnson', '555-0104'),
('Michael', 'Williams', '1978-11-05', 'Male', 'michael.w@email.com', '555-0105', '789 Pine Rd', 'Chicago', 'IL', '60601', 'B+', 'Lisa Williams', '555-0106'),
('Jennifer', 'Brown', '1988-01-30', 'Female', 'jennifer.b@email.com', '555-0107', '321 Elm St', 'Houston', 'TX', '77001', 'AB+', 'David Brown', '555-0108'),
('David', 'Jones', '1992-05-18', 'Male', 'david.jones@email.com', '555-0109', '654 Maple Dr', 'Phoenix', 'AZ', '85001', 'O-', 'Emma Jones', '555-0110'),
('Sarah', 'Garcia', '1987-09-25', 'Female', 'sarah.garcia@email.com', '555-0111', '987 Cedar Ln', 'Philadelphia', 'PA', '19101', 'A-', 'Carlos Garcia', '555-0112'),
('James', 'Miller', '1980-12-10', 'Male', 'james.miller@email.com', '555-0113', '147 Birch St', 'San Antonio', 'TX', '78201', 'B-', 'Patricia Miller', '555-0114'),
('Patricia', 'Davis', '1995-02-14', 'Female', 'patricia.d@email.com', '555-0115', '258 Spruce Ave', 'San Diego', 'CA', '92101', 'AB-', 'Thomas Davis', '555-0116'),
('Robert', 'Rodriguez', '1983-08-28', 'Male', 'robert.r@email.com', '555-0117', '369 Ash Pl', 'Dallas', 'TX', '75201', 'O+', 'Maria Rodriguez', '555-0118'),
('Linda', 'Martinez', '1991-04-12', 'Female', 'linda.m@email.com', '555-0119', '456 Walnut Dr', 'San Jose', 'CA', '95101', 'A+', 'Jose Martinez', '555-0120'),
('Charles', 'Hernandez', '1979-06-20', 'Male', 'charles.h@email.com', '555-0121', '567 Oak Pl', 'Austin', 'TX', '78701', 'B+', 'Rosa Hernandez', '555-0122'),
('Barbara', 'Lopez', '1986-10-03', 'Female', 'barbara.l@email.com', '555-0123', '678 Pine Ave', 'Jacksonville', 'FL', '32099', 'O+', 'Miguel Lopez', '555-0124'),
('William', 'Gonzalez', '1989-03-17', 'Male', 'william.g@email.com', '555-0125', '789 Cedar St', 'Fort Worth', 'TX', '76101', 'AB+', 'Ana Gonzalez', '555-0126'),
('Susan', 'Wilson', '1984-07-09', 'Female', 'susan.w@email.com', '555-0127', '890 Elm Dr', 'Columbus', 'OH', '43085', 'A+', 'Mark Wilson', '555-0128'),
('Joseph', 'Anderson', '1981-11-26', 'Male', 'joseph.a@email.com', '555-0129', '901 Maple Pl', 'Charlotte', 'NC', '28202', 'B-', 'Jennifer Anderson', '555-0130'),
('Jessica', 'Taylor', '1993-05-31', 'Female', 'jessica.t@email.com', '555-0131', '102 Birch Ave', 'San Francisco', 'CA', '94102', 'O-', 'Kevin Taylor', '555-0132'),
('Thomas', 'Thomas', '1982-09-14', 'Male', 'thomas.t@email.com', '555-0133', '213 Spruce Rd', 'Indianapolis', 'IN', '46201', 'AB-', 'Catherine Thomas', '555-0134'),
('Karen', 'Moore', '1987-02-07', 'Female', 'karen.m@email.com', '555-0135', '324 Ash Ave', 'Austin', 'TX', '78701', 'A-', 'Donald Moore', '555-0136'),
('Christopher', 'Jackson', '1986-08-19', 'Male', 'christopher.j@email.com', '555-0137', '435 Walnut Pl', 'Memphis', 'TN', '37501', 'O+', 'Rachel Jackson', '555-0138'),
('Nancy', 'White', '1988-12-02', 'Female', 'nancy.w@email.com', '555-0139', '546 Oak Dr', 'Boston', 'MA', '02101', 'A+', 'Gary White', '555-0140'),
('Daniel', 'Harris', '1990-04-25', 'Male', 'daniel.h@email.com', '555-0141', '657 Pine St', 'Nashville', 'TN', '37201', 'B+', 'Donna Harris', '555-0142'),
('Lisa', 'Martin', '1992-06-11', 'Female', 'lisa.martin@email.com', '555-0143', '768 Cedar Ave', 'Baltimore', 'MD', '21202', 'O+', 'Paul Martin', '555-0144'),
('Matthew', 'Lee', '1985-10-08', 'Male', 'matthew.l@email.com', '555-0145', '879 Elm Pl', 'Louisville', 'KY', '40202', 'A+', 'Rebecca Lee', '555-0146'),
('Betty', 'Perez', '1983-01-22', 'Female', 'betty.p@email.com', '555-0147', '980 Birch St', 'Portland', 'OR', '97201', 'B-', 'Steven Perez', '555-0148'),
('Mark', 'Long', '1991-03-16', 'Male', 'mark.long@email.com', '555-0149', '105 Spruce Ln', 'Las Vegas', 'NV', '89101', 'O-', 'Carol Long', '555-0150'),
('Sandra', 'Short', '1989-07-20', 'Female', 'sandra.s@email.com', '555-0151', '216 Ash Dr', 'Denver', 'CO', '80202', 'AB+', 'Edward Short', '555-0152'),
('Donald', 'High', '1980-09-04', 'Male', 'donald.h@email.com', '555-0153', '327 Walnut Ave', 'Washington', 'DC', '20001', 'A-', 'Cynthia High', '555-0154'),
('Ashley', 'Adams', '1994-02-28', 'Female', 'ashley.a@email.com', '555-0155', '438 Oak Pl', 'Boston', 'MA', '02101', 'O+', 'Joshua Adams', '555-0156'),
('Paul', 'Clark', '1982-05-13', 'Male', 'paul.clark@email.com', '555-0157', '549 Pine Dr', 'New Orleans', 'LA', '70112', 'B+', 'Deborah Clark', '555-0158'),
('Emily', 'Lewis', '1996-08-07', 'Female', 'emily.l@email.com', '555-0159', '650 Cedar St', 'Las Vegas', 'NV', '89101', 'A+', 'Frank Lewis', '555-0160');

-- =====================================================
-- Step 5: Insert 30 Doctor Records
-- =====================================================
INSERT INTO Doctor (FirstName, LastName, Specialization, LicenseNumber, Email, PhoneNumber, Address, City, State, ZipCode, ClinicName, YearsOfExperience, Qualification, IsActive) VALUES
('Arthur', 'Anderson', 'Cardiology', 'LIC001', 'arthur.anderson@med.com', '555-1001', '100 Hospital Ln', 'New York', 'NY', '10001', 'Heart Care Clinic', 15, 'MD, Board Certified', TRUE),
('Barbara', 'Baker', 'Dermatology', 'LIC002', 'barbara.baker@med.com', '555-1002', '200 Medical Dr', 'Los Angeles', 'CA', '90001', 'Skin Health Center', 12, 'MD, Dermatology Specialist', TRUE),
('Charles', 'Campbell', 'Orthopedics', 'LIC003', 'charles.campbell@med.com', '555-1003', '300 Clinic Rd', 'Chicago', 'IL', '60601', 'Bone & Joint Hospital', 18, 'MD, Orthopedic Surgeon', TRUE),
('Diana', 'Davis', 'Pediatrics', 'LIC004', 'diana.davis@med.com', '555-1004', '400 Health Ave', 'Houston', 'TX', '77001', 'Children Medical Center', 10, 'MD, Pediatrician', TRUE),
('Edward', 'Edwards', 'Neurology', 'LIC005', 'edward.edwards@med.com', '555-1005', '500 Medical Pl', 'Phoenix', 'AZ', '85001', 'Brain & Nerve Clinic', 20, 'MD, Neurologist', TRUE),
('Fiona', 'Foster', 'Oncology', 'LIC006', 'fiona.foster@med.com', '555-1006', '600 Research Dr', 'Philadelphia', 'PA', '19101', 'Cancer Treatment Center', 16, 'MD, Oncology Specialist', TRUE),
('George', 'Green', 'Psychiatry', 'LIC007', 'george.green@med.com', '555-1007', '700 Mental Health Rd', 'San Antonio', 'TX', '78201', 'Mental Health Institute', 14, 'MD, Psychiatrist', TRUE),
('Helen', 'Harris', 'Gastroenterology', 'LIC008', 'helen.harris@med.com', '555-1008', '800 Digestive Dr', 'San Diego', 'CA', '92101', 'Digestive Health Clinic', 13, 'MD, Gastroenterologist', TRUE),
('Ian', 'Ingram', 'Urology', 'LIC009', 'ian.ingram@med.com', '555-1009', '900 Urinary Clinic', 'Dallas', 'TX', '75201', 'Urology Specialists', 11, 'MD, Urologist', TRUE),
('Julia', 'Johnson', 'Nephrology', 'LIC010', 'julia.johnson@med.com', '555-1010', '1000 Kidney Dr', 'San Jose', 'CA', '95101', 'Kidney Care Center', 12, 'MD, Nephrologist', TRUE),
('Kevin', 'King', 'Pulmonology', 'LIC011', 'kevin.king@med.com', '555-1011', '1100 Lung Center', 'Austin', 'TX', '78701', 'Respiratory Health', 17, 'MD, Pulmonologist', TRUE),
('Laura', 'Lewis', 'Ophthalmology', 'LIC012', 'laura.lewis@med.com', '555-1012', '1200 Vision Clinic', 'Jacksonville', 'FL', '32099', 'Eye Care Hospital', 14, 'MD, Ophthalmologist', TRUE),
('Michael', 'Miller', 'Rheumatology', 'LIC013', 'michael.miller@med.com', '555-1013', '1300 Joint Care', 'Fort Worth', 'TX', '76101', 'Arthritis Center', 15, 'MD, Rheumatologist', TRUE),
('Nancy', 'Nelson', 'Endocrinology', 'LIC014', 'nancy.nelson@med.com', '555-1014', '1400 Hormone Clinic', 'Columbus', 'OH', '43085', 'Diabetes & Endocrine', 13, 'MD, Endocrinologist', TRUE),
('Oliver', 'Owen', 'Emergency Medicine', 'LIC015', 'oliver.owen@med.com', '555-1015', '1500 Emergency Dept', 'Charlotte', 'NC', '28202', 'Emergency Care Center', 19, 'MD, Emergency Specialist', TRUE),
('Patricia', 'Parker', 'Obstetrics', 'LIC016', 'patricia.parker@med.com', '555-1016', '1600 Maternity Ward', 'San Francisco', 'CA', '94102', 'Women Health Center', 16, 'MD, OB-GYN', TRUE),
('Quentin', 'Quinn', 'General Practice', 'LIC017', 'quentin.quinn@med.com', '555-1017', '1700 Family Medicine', 'Indianapolis', 'IN', '46201', 'Family Health Clinic', 11, 'MD, General Practitioner', TRUE),
('Rachel', 'Roberts', 'Radiology', 'LIC018', 'rachel.roberts@med.com', '555-1018', '1800 Imaging Center', 'Austin', 'TX', '78701', 'Diagnostic Imaging', 12, 'MD, Radiologist', TRUE),
('Samuel', 'Smith', 'Surgery', 'LIC019', 'samuel.smith@med.com', '555-1019', '1900 Surgical Center', 'Memphis', 'TN', '37501', 'General Surgery Hospital', 20, 'MD, Surgical Specialist', TRUE),
('Teresa', 'Taylor', 'Hematology', 'LIC020', 'teresa.taylor@med.com', '555-1020', '2000 Blood Bank', 'Boston', 'MA', '02101', 'Blood Disorders Clinic', 14, 'MD, Hematologist', TRUE),
('Ulysses', 'Underwood', 'Infectious Diseases', 'LIC021', 'ulysses.u@med.com', '555-1021', '2100 Infection Control', 'Nashville', 'TN', '37201', 'Infectious Disease Unit', 15, 'MD, ID Specialist', TRUE),
('Violet', 'Vincent', 'Immunology', 'LIC022', 'violet.v@med.com', '555-1022', '2200 Immune System', 'Baltimore', 'MD', '21202', 'Allergy & Immunology', 13, 'MD, Immunologist', TRUE),
('William', 'Wilson', 'Anesthesiology', 'LIC023', 'william.w@med.com', '555-1023', '2300 Operating Room', 'Louisville', 'KY', '40202', 'Anesthesia Department', 18, 'MD, Anesthesiologist', TRUE),
('Xenia', 'Xavier', 'Pathology', 'LIC024', 'xenia.x@med.com', '555-1024', '2400 Laboratory', 'Portland', 'OR', '97201', 'Pathology Lab', 11, 'MD, Pathologist', TRUE),
('Yolanda', 'Young', 'Dentistry', 'LIC025', 'yolanda.y@med.com', '555-1025', '2500 Dental Clinic', 'Las Vegas', 'NV', '89101', 'Smile Dental Center', 12, 'DDS, Dentist', TRUE),
('Zachary', 'Zimmerman', 'Physical Medicine', 'LIC026', 'zachary.z@med.com', '555-1026', '2600 Rehabilitation', 'Denver', 'CO', '80202', 'Rehab Center', 14, 'MD, PM&R Specialist', TRUE),
('Aaron', 'Adams', 'Psychiatry', 'LIC027', 'aaron.a@med.com', '555-1027', '2700 Mental Health', 'Washington', 'DC', '20001', 'Mental Wellness Clinic', 10, 'MD, Psychiatrist', TRUE),
('Bella', 'Brown', 'Genetics', 'LIC028', 'bella.b@med.com', '555-1028', '2800 Genetic Center', 'Boston', 'MA', '02101', 'Genetic Testing Lab', 9, 'MD, Geneticist', TRUE),
('Cole', 'Clark', 'Veterinary', 'LIC029', 'cole.c@med.com', '555-1029', '2900 Animal Hospital', 'New Orleans', 'LA', '70112', 'Pet Care Clinic', 8, 'DVM, Veterinarian', TRUE),
('Donna', 'Davis', 'Nutrition', 'LIC030', 'donna.d@med.com', '555-1030', '3000 Nutrition Center', 'Las Vegas', 'NV', '89101', 'Nutrition & Wellness', 7, 'MS, Nutritionist', TRUE);

-- =====================================================
-- DATABASE SETUP COMPLETE
-- =====================================================
-- Run the remaining INSERT scripts for:
-- - Medications (30 records)
-- - Appointments (30 records)
-- - Prescriptions (30 records)
-- - PrescriptionItems (30 records)
-- - UserLogin (default accounts)
--
-- Then run the query files to retrieve data

SELECT 'Database setup completed!' as Status;
SELECT COUNT(*) as PatientCount FROM Patient;
SELECT COUNT(*) as DoctorCount FROM Doctor;
SELECT 'All tables created successfully' as Message;
