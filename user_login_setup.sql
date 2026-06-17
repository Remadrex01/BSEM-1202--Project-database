-- User Login Authentication System
-- This file provides a login table and authentication mechanism

USE MedicalManagementDB;

-- =====================================================
-- CREATE LOGIN TABLE
-- =====================================================
DROP TABLE IF EXISTS UserLogin;

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

-- =====================================================
-- INSERT DEFAULT LOGIN USERS
-- =====================================================
INSERT INTO UserLogin (Username, Email, Password, Role, FullName, IsActive, AccountStatus) VALUES
('admin', 'admin@medical.com', MD5('AdminPassword123!'), 'Administrator', 'System Administrator', TRUE, 'Active'),
('doctor001', 'doctor001@medical.com', MD5('DoctorPass123!'), 'Doctor', 'Dr. Arthur Anderson', TRUE, 'Active'),
('doctor002', 'doctor002@medical.com', MD5('DoctorPass123!'), 'Doctor', 'Dr. Barbara Baker', TRUE, 'Active'),
('nurse001', 'nurse001@medical.com', MD5('NursePass123!'), 'Nurse', 'Nurse Sarah Johnson', TRUE, 'Active'),
('nurse002', 'nurse002@medical.com', MD5('NursePass123!'), 'Nurse', 'Nurse Maria Garcia', TRUE, 'Active'),
('pharmacist001', 'pharmacist001@medical.com', MD5('PharmacistPass123!'), 'Pharmacist', 'Pharmacist James Miller', TRUE, 'Active'),
('pharmacist002', 'pharmacist002@medical.com', MD5('PharmacistPass123!'), 'Pharmacist', 'Pharmacist Patricia Davis', TRUE, 'Active'),
('receptionist001', 'receptionist001@medical.com', MD5('ReceptionistPass123!'), 'Receptionist', 'Receptionist Emily Wilson', TRUE, 'Active'),
('receptionist002', 'receptionist002@medical.com', MD5('ReceptionistPass123!'), 'Receptionist', 'Receptionist Karen Thompson', TRUE, 'Active'),
('viewer', 'viewer@medical.com', MD5('ViewerPass123!'), 'Viewer', 'Data Analyst', TRUE, 'Active');

-- =====================================================
-- LOGIN QUERIES
-- =====================================================

-- 1. Verify user login (use this in application)
-- SELECT UserID, Username, Role, FullName FROM UserLogin 
-- WHERE Username = 'admin' AND Password = MD5('AdminPassword123!') AND IsActive = TRUE;

-- 2. Get all active users
SELECT UserID, Username, Email, Role, FullName, IsActive FROM UserLogin WHERE IsActive = TRUE;

-- 3. Get user by username
SELECT UserID, Username, Email, Role, FullName, LastLogin FROM UserLogin WHERE Username = 'admin';

-- 4. Get users by role
SELECT UserID, Username, Email, FullName FROM UserLogin WHERE Role = 'Doctor' AND IsActive = TRUE;

-- 5. Get inactive users (locked accounts)
SELECT UserID, Username, Email, Role FROM UserLogin WHERE IsActive = FALSE OR AccountStatus = 'Locked';

-- 6. Get all admin users
SELECT UserID, Username, Email, FullName FROM UserLogin WHERE Role = 'Administrator';

-- 7. Track login history
SELECT Username, Role, LastLogin FROM UserLogin ORDER BY LastLogin DESC;

-- =====================================================
-- ADDITIONAL AUTHENTICATION PROCEDURES
-- =====================================================

-- Create a procedure to update last login time
DELIMITER //
CREATE PROCEDURE UpdateLastLogin(IN p_username VARCHAR(50))
BEGIN
    UPDATE UserLogin SET LastLogin = NOW() 
    WHERE Username = p_username AND IsActive = TRUE;
END//
DELIMITER ;

-- Create a procedure to authenticate user
DELIMITER //
CREATE PROCEDURE AuthenticateUser(IN p_username VARCHAR(50), IN p_password VARCHAR(255))
BEGIN
    SELECT UserID, Username, Email, Role, FullName, IsActive 
    FROM UserLogin 
    WHERE Username = p_username 
    AND Password = MD5(p_password) 
    AND IsActive = TRUE;
END//
DELIMITER ;

-- Create a procedure to lock user account (after 3 failed attempts)
DELIMITER //
CREATE PROCEDURE LockUserAccount(IN p_username VARCHAR(50))
BEGIN
    UPDATE UserLogin SET AccountStatus = 'Locked', IsActive = FALSE 
    WHERE Username = p_username;
END//
DELIMITER ;

-- Create a procedure to unlock user account
DELIMITER //
CREATE PROCEDURE UnlockUserAccount(IN p_username VARCHAR(50))
BEGIN
    UPDATE UserLogin SET AccountStatus = 'Active', IsActive = TRUE 
    WHERE Username = p_username;
END//
DELIMITER ;

-- =====================================================
-- CREATE AUDIT LOG TABLE (Optional)
-- =====================================================
CREATE TABLE IF NOT EXISTS LoginAuditLog (
    AuditID INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(50),
    LoginTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Action VARCHAR(50),
    IPAddress VARCHAR(45),
    Status VARCHAR(20)
);

-- =====================================================
-- USAGE EXAMPLES
-- =====================================================
-- CALL AuthenticateUser('admin', 'AdminPassword123!');
-- CALL UpdateLastLogin('admin');
-- CALL LockUserAccount('doctor001');
-- CALL UnlockUserAccount('doctor001');
