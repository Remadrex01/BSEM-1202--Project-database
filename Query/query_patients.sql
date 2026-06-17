-- Query File for Patient Table
USE MedicalManagementDB;

-- 1. Get all patients
SELECT * FROM Patient;

-- 2. Get patients by city
SELECT FirstName, LastName, City, PhoneNumber FROM Patient WHERE City = 'New York';

-- 3. Get patients with specific blood type
SELECT FirstName, LastName, BloodType FROM Patient WHERE BloodType = 'O+';

-- 4. Search patient by name
SELECT * FROM Patient WHERE FirstName LIKE '%John%' OR LastName LIKE '%Smith%';

-- 5. Get patient count by city
SELECT City, COUNT(*) as PatientCount FROM Patient GROUP BY City ORDER BY PatientCount DESC;

-- 6. Get patients by age range (born after 1990)
SELECT FirstName, LastName, DateOfBirth, YEAR(CURDATE()) - YEAR(DateOfBirth) as Age FROM Patient WHERE YEAR(DateOfBirth) > 1990;

-- 7. Get patients with email addresses
SELECT FirstName, LastName, Email FROM Patient WHERE Email IS NOT NULL;

-- 8. Get patients and their emergency contacts
SELECT FirstName, LastName, EmergencyContact, EmergencyPhone FROM Patient WHERE EmergencyContact IS NOT NULL;

-- 9. Count patients by gender
SELECT Gender, COUNT(*) as Count FROM Patient GROUP BY Gender;

-- 10. Get all blood type statistics
SELECT BloodType, COUNT(*) as PatientCount FROM Patient WHERE BloodType IS NOT NULL GROUP BY BloodType ORDER BY PatientCount DESC;

-- 11. Get patient registration trend (by creation date)
SELECT DATE(CreatedDate) as RegistrationDate, COUNT(*) as NewPatients FROM Patient GROUP BY DATE(CreatedDate);

-- 12. Find patients with complete profile information
SELECT * FROM Patient WHERE FirstName IS NOT NULL AND LastName IS NOT NULL AND Email IS NOT NULL AND PhoneNumber IS NOT NULL AND Address IS NOT NULL;

-- 13. Get top 10 patients (most recent)
SELECT * FROM Patient ORDER BY CreatedDate DESC LIMIT 10;

-- 14. Search patients by phone number
SELECT FirstName, LastName, PhoneNumber FROM Patient WHERE PhoneNumber LIKE '%555-01%';

-- 15. Get patients without email
SELECT FirstName, LastName, PhoneNumber FROM Patient WHERE Email IS NULL;
