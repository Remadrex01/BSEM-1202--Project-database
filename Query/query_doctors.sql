-- Query File for Doctor Table
USE MedicalManagementDB;

-- 1. Get all doctors
SELECT * FROM Doctor;

-- 2. Get doctors by specialization
SELECT FirstName, LastName, Specialization, ClinicName FROM Doctor WHERE Specialization = 'Cardiology';

-- 3. Get all active doctors
SELECT FirstName, LastName, Specialization, Email FROM Doctor WHERE IsActive = TRUE;

-- 4. Get doctors by city
SELECT FirstName, LastName, Specialization, City FROM Doctor WHERE City = 'New York';

-- 5. Get doctors with years of experience (15+ years)
SELECT FirstName, LastName, Specialization, YearsOfExperience FROM Doctor WHERE YearsOfExperience >= 15 ORDER BY YearsOfExperience DESC;

-- 6. Count doctors by specialization
SELECT Specialization, COUNT(*) as DoctorCount FROM Doctor GROUP BY Specialization ORDER BY DoctorCount DESC;

-- 7. Search doctor by name
SELECT * FROM Doctor WHERE FirstName LIKE '%Arthur%' OR LastName LIKE '%Anderson%';

-- 8. Get doctor contact information
SELECT FirstName, LastName, Email, PhoneNumber, ClinicName FROM Doctor WHERE IsActive = TRUE;

-- 9. Get doctors by clinic name
SELECT FirstName, LastName, Specialization FROM Doctor WHERE ClinicName = 'Heart Care Clinic';

-- 10. Count active vs inactive doctors
SELECT IsActive, COUNT(*) as DoctorCount FROM Doctor GROUP BY IsActive;

-- 11. Get doctors with qualification details
SELECT FirstName, LastName, Qualification, YearsOfExperience FROM Doctor ORDER BY YearsOfExperience DESC;

-- 12. Get doctors registration trend
SELECT DATE(CreatedDate) as RegistrationDate, COUNT(*) as NewDoctors FROM Doctor GROUP BY DATE(CreatedDate);

-- 13. Find doctors available in specific cities (New York or Los Angeles)
SELECT FirstName, LastName, Specialization, City FROM Doctor WHERE City IN ('New York', 'Los Angeles') ORDER BY City;

-- 14. Get top 10 most experienced doctors
SELECT FirstName, LastName, Specialization, YearsOfExperience FROM Doctor ORDER BY YearsOfExperience DESC LIMIT 10;

-- 15. Get doctors without email (incomplete profile)
SELECT FirstName, LastName, Specialization, PhoneNumber FROM Doctor WHERE Email IS NULL;
