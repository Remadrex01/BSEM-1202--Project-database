-- Create Database and Patient Table
CREATE DATABASE IF NOT EXISTS MedicalManagementDB;
USE MedicalManagementDB;

-- Drop table if exists
DROP TABLE IF EXISTS Patient;

-- Create Patient Table
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
