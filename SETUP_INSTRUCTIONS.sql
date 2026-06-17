-- Complete Database Setup Script
-- Execute this script to set up the entire database with tables, data, and users

-- =====================================================
-- STEP 1: CREATE DATABASE
-- =====================================================
DROP DATABASE IF EXISTS MedicalManagementDB;
CREATE DATABASE MedicalManagementDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE MedicalManagementDB;

-- =====================================================
-- STEP 2: INCLUDE TABLE DEFINITIONS
-- =====================================================
-- Execute the following files in order:
-- 1. Creating Database/patient.sql
-- 2. Creating Database/doctor.sql
-- 3. Creating Database/medication.sql
-- 4. Creating Database/appointment.sql
-- 5. Creating Database/prescription.sql
-- 6. Creating Database/prescription_Item.sql

-- =====================================================
-- STEP 3: INSERT SAMPLE DATA
-- =====================================================
-- Execute the following files in order:
-- 1. Inserting database/insert_patients.sql
-- 2. Inserting database/insert_doctors.sql
-- 3. Inserting database/insert_medications.sql
-- 4. Inserting database/insert_appointments.sql
-- 5. Inserting database/insert_prescriptions.sql
-- 6. Inserting database/insert_prescription_items.sql

-- =====================================================
-- STEP 4: CREATE USERS AND GRANT PERMISSIONS
-- =====================================================
-- Execute: database_setup.sql
-- Execute: user_login_setup.sql

-- =====================================================
-- STEP 5: RUN QUERIES
-- =====================================================
-- Execute query files from Query folder:
-- 1. Query/query_patients.sql
-- 2. Query/query_doctors.sql
-- 3. Query/query_medications.sql
-- 4. Query/query_appointments.sql
-- 5. Query/query_prescriptions.sql
-- 6. Query/query_prescription_items.sql

-- =====================================================
-- SETUP COMMANDS FOR MYSQL CLI
-- =====================================================
-- 1. Create and populate database:
--    mysql -u root -p < creating_database.sql
-- 
-- 2. Set up users:
--    mysql -u root -p < database_setup.sql
--
-- 3. Insert data:
--    mysql -u root -p MedicalManagementDB < inserting_database.sql
--
-- 4. Run queries:
--    mysql -u admin -p MedicalManagementDB < query_patients.sql

-- =====================================================
-- QUICK START GUIDE
-- =====================================================
-- 1. Open MySQL Command Line or MySQL Workbench
-- 2. Run: source C:/path/to/database_setup.sql;
-- 3. Run: source C:/path/to/user_login_setup.sql;
-- 4. Run table creation scripts from Creating Database folder
-- 5. Run insert scripts from Inserting database folder
-- 6. Run query scripts from Query folder

-- =====================================================
-- DEFAULT USERS AND PASSWORDS
-- =====================================================
-- Admin: admin / AdminPassword123!
-- Doctor: doctor / DoctorPass123!
-- Nurse: nurse / NursePass123!
-- Pharmacist: pharmacist / PharmacistPass123!
-- Receptionist: receptionist / ReceptionistPass123!
-- Viewer: viewer / ViewerPass123!

-- =====================================================
-- VERIFY INSTALLATION
-- =====================================================
-- Run this to verify everything is set up correctly:
-- SHOW TABLES;
-- SELECT COUNT(*) as PatientCount FROM Patient;
-- SELECT COUNT(*) as DoctorCount FROM Doctor;
-- SELECT COUNT(*) as MedicationCount FROM Medication;
-- SELECT USER();
