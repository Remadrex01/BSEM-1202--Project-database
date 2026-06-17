-- Database Setup and Configuration
-- This file contains the database creation and initial setup

-- =====================================================
-- 1. CREATE DATABASE
-- =====================================================
DROP DATABASE IF EXISTS MedicalManagementDB;

CREATE DATABASE MedicalManagementDB
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE MedicalManagementDB;

-- =====================================================
-- 2. CREATE USER ACCOUNTS
-- =====================================================

-- Admin User (Full Access)
DROP USER IF EXISTS 'admin'@'localhost';
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'AdminPassword123!';
GRANT ALL PRIVILEGES ON MedicalManagementDB.* TO 'admin'@'localhost';

-- Doctor User (Read/Write Access to patient data)
DROP USER IF EXISTS 'doctor'@'localhost';
CREATE USER 'doctor'@'localhost' IDENTIFIED BY 'DoctorPass123!';
GRANT SELECT, INSERT, UPDATE ON MedicalManagementDB.* TO 'doctor'@'localhost';

-- Nurse User (Read Access + Limited Write)
DROP USER IF EXISTS 'nurse'@'localhost';
CREATE USER 'nurse'@'localhost' IDENTIFIED BY 'NursePass123!';
GRANT SELECT, INSERT ON MedicalManagementDB.Patient TO 'nurse'@'localhost';
GRANT SELECT, INSERT, UPDATE ON MedicalManagementDB.Appointment TO 'nurse'@'localhost';
GRANT SELECT ON MedicalManagementDB.Doctor TO 'nurse'@'localhost';
GRANT SELECT ON MedicalManagementDB.Medication TO 'nurse'@'localhost';

-- Pharmacist User (Medication Management)
DROP USER IF EXISTS 'pharmacist'@'localhost';
CREATE USER 'pharmacist'@'localhost' IDENTIFIED BY 'PharmacistPass123!';
GRANT SELECT, UPDATE ON MedicalManagementDB.Medication TO 'pharmacist'@'localhost';
GRANT SELECT ON MedicalManagementDB.Patient TO 'pharmacist'@'localhost';
GRANT SELECT ON MedicalManagementDB.Prescription TO 'pharmacist'@'localhost';
GRANT SELECT ON MedicalManagementDB.PrescriptionItem TO 'pharmacist'@'localhost';

-- Receptionist User (Appointment Management)
DROP USER IF EXISTS 'receptionist'@'localhost';
CREATE USER 'receptionist'@'localhost' IDENTIFIED BY 'ReceptionistPass123!';
GRANT SELECT ON MedicalManagementDB.Patient TO 'receptionist'@'localhost';
GRANT SELECT, INSERT, UPDATE ON MedicalManagementDB.Appointment TO 'receptionist'@'localhost';
GRANT SELECT ON MedicalManagementDB.Doctor TO 'receptionist'@'localhost';

-- View-Only User (Read Access Only)
DROP USER IF EXISTS 'viewer'@'localhost';
CREATE USER 'viewer'@'localhost' IDENTIFIED BY 'ViewerPass123!';
GRANT SELECT ON MedicalManagementDB.* TO 'viewer'@'localhost';

-- =====================================================
-- 3. APPLY PRIVILEGES
-- =====================================================
FLUSH PRIVILEGES;

-- =====================================================
-- 4. VERIFY USERS (Optional)
-- =====================================================
-- SELECT User, Host FROM mysql.user WHERE User IN ('admin', 'doctor', 'nurse', 'pharmacist', 'receptionist', 'viewer');

-- =====================================================
-- 5. USER REFERENCE GUIDE
-- =====================================================
-- Admin Account:
--   Username: admin
--   Password: AdminPassword123!
--   Permissions: Full access to all tables and operations
--
-- Doctor Account:
--   Username: doctor
--   Password: DoctorPass123!
--   Permissions: SELECT, INSERT, UPDATE on all tables
--
-- Nurse Account:
--   Username: nurse
--   Password: NursePass123!
--   Permissions: Patient records, Appointments
--
-- Pharmacist Account:
--   Username: pharmacist
--   Password: PharmacistPass123!
--   Permissions: Medication management and prescriptions
--
-- Receptionist Account:
--   Username: receptionist
--   Password: ReceptionistPass123!
--   Permissions: Appointment and patient scheduling
--
-- Viewer Account (Read-Only):
--   Username: viewer
--   Password: ViewerPass123!
--   Permissions: SELECT only on all tables

-- =====================================================
-- 6. CONNECTION COMMANDS (For Reference)
-- =====================================================
-- Admin: mysql -u admin -p MedicalManagementDB (then enter: AdminPassword123!)
-- Doctor: mysql -u doctor -p MedicalManagementDB (then enter: DoctorPass123!)
-- Nurse: mysql -u nurse -p MedicalManagementDB (then enter: NursePass123!)
-- Pharmacist: mysql -u pharmacist -p MedicalManagementDB (then enter: PharmacistPass123!)
-- Receptionist: mysql -u receptionist -p MedicalManagementDB (then enter: ReceptionistPass123!)
-- Viewer: mysql -u viewer -p MedicalManagementDB (then enter: ViewerPass123!)
