-- Advanced Queries and Reporting
-- Complex analytical queries for medical database

USE MedicalManagementDB;

-- =====================================================
-- COMPREHENSIVE REPORTING QUERIES
-- =====================================================

-- 1. PATIENT DEMOGRAPHICS REPORT
-- Get detailed patient statistics
SELECT 
    COUNT(*) as TotalPatients,
    COUNT(DISTINCT Gender) as GenderTypes,
    AVG(YEAR(CURDATE()) - YEAR(DateOfBirth)) as AverageAge,
    COUNT(DISTINCT City) as CitiesRepresented
FROM Patient;

-- 2. DOCTOR UTILIZATION REPORT
-- Show which doctors have the most appointments
SELECT 
    D.DoctorID,
    D.FirstName,
    D.LastName,
    D.Specialization,
    COUNT(A.AppointmentID) as TotalAppointments,
    COUNT(DISTINCT A.PatientID) as UniquePatients,
    DATE(MAX(A.AppointmentDate)) as LastAppointment
FROM Doctor D
LEFT JOIN Appointment A ON D.DoctorID = A.DoctorID
GROUP BY D.DoctorID, D.FirstName, D.LastName, D.Specialization
ORDER BY TotalAppointments DESC;

-- 3. MEDICATION INVENTORY REPORT
-- Show medication stock levels and values
SELECT 
    MedicationName,
    Manufacturer,
    DrugType,
    QuantityInStock,
    UnitPrice,
    (QuantityInStock * UnitPrice) as InventoryValue,
    ExpiryDate,
    CASE 
        WHEN QuantityInStock < 100 THEN 'Low Stock'
        WHEN QuantityInStock < 200 THEN 'Medium Stock'
        ELSE 'Good Stock'
    END as StockStatus,
    CASE
        WHEN ExpiryDate < CURDATE() THEN 'EXPIRED'
        WHEN ExpiryDate <= DATE_ADD(CURDATE(), INTERVAL 30 DAY) THEN 'EXPIRING SOON'
        ELSE 'Valid'
    END as ExpiryStatus
FROM Medication
ORDER BY InventoryValue DESC;

-- 4. PRESCRIPTION ANALYSIS REPORT
-- Show prescription trends and costs
SELECT 
    P.PrescriptionID,
    Pat.FirstName,
    Pat.LastName,
    D.FirstName as DoctorName,
    P.Diagnosis,
    COUNT(PI.PrescriptionItemID) as MedicationCount,
    SUM(PI.TotalCost) as PrescriptionTotal,
    P.Status,
    P.ExpiryDate
FROM Prescription P
JOIN Patient Pat ON P.PatientID = Pat.PatientID
JOIN Doctor D ON P.DoctorID = D.DoctorID
LEFT JOIN PrescriptionItem PI ON P.PrescriptionID = PI.PrescriptionID
GROUP BY P.PrescriptionID, Pat.FirstName, Pat.LastName, D.FirstName, P.Diagnosis, P.Status, P.ExpiryDate
ORDER BY PrescriptionTotal DESC;

-- 5. PATIENT APPOINTMENT HISTORY
-- Show complete appointment and prescription history for each patient
SELECT 
    Pat.PatientID,
    Pat.FirstName,
    Pat.LastName,
    COUNT(A.AppointmentID) as TotalAppointments,
    COUNT(P.PrescriptionID) as TotalPrescriptions,
    MAX(A.AppointmentDate) as LastAppointmentDate,
    MAX(P.PrescriptionDate) as LastPrescriptionDate
FROM Patient Pat
LEFT JOIN Appointment A ON Pat.PatientID = A.PatientID
LEFT JOIN Prescription P ON Pat.PatientID = P.PatientID
GROUP BY Pat.PatientID, Pat.FirstName, Pat.LastName
ORDER BY TotalAppointments DESC;

-- 6. DIAGNOSIS FREQUENCY REPORT
-- Show which diagnoses are most common
SELECT 
    P.Diagnosis,
    COUNT(*) as DiagnosisCount,
    COUNT(DISTINCT P.PatientID) as AffectedPatients,
    COUNT(DISTINCT P.DoctorID) as TreatingDoctors,
    AVG(SUM(PI.TotalCost)) as AverageTreatmentCost
FROM Prescription P
LEFT JOIN PrescriptionItem PI ON P.PrescriptionID = PI.PrescriptionID
WHERE P.Diagnosis IS NOT NULL
GROUP BY P.Diagnosis
ORDER BY DiagnosisCount DESC;

-- 7. FINANCIAL REPORT - MEDICATION COSTS
-- Show total medication costs by patient and doctor
SELECT 
    Pat.FirstName as PatientFirstName,
    Pat.LastName as PatientLastName,
    D.FirstName as DoctorFirstName,
    D.LastName as DoctorLastName,
    SUM(PI.TotalCost) as TotalMedicationCost,
    COUNT(DISTINCT P.PrescriptionID) as PrescriptionCount
FROM PrescriptionItem PI
JOIN Prescription P ON PI.PrescriptionID = P.PrescriptionID
JOIN Patient Pat ON P.PatientID = Pat.PatientID
JOIN Doctor D ON P.DoctorID = D.DoctorID
GROUP BY Pat.PatientID, Pat.FirstName, Pat.LastName, D.DoctorID, D.FirstName, D.LastName
ORDER BY TotalMedicationCost DESC;

-- 8. SPECIALIZATION DEMAND REPORT
-- Show which specializations have highest appointment demand
SELECT 
    D.Specialization,
    COUNT(A.AppointmentID) as TotalAppointments,
    COUNT(DISTINCT A.PatientID) as UniquePatients,
    COUNT(DISTINCT D.DoctorID) as DoctorsInSpecialty,
    ROUND(COUNT(A.AppointmentID) / COUNT(DISTINCT D.DoctorID), 2) as AppointmentsPerDoctor
FROM Doctor D
LEFT JOIN Appointment A ON D.DoctorID = A.DoctorID
GROUP BY D.Specialization
ORDER BY TotalAppointments DESC;

-- 9. PRESCRIPTION REFILL STATUS REPORT
-- Show which prescriptions need renewal soon
SELECT 
    P.PrescriptionID,
    Pat.FirstName,
    Pat.LastName,
    P.Diagnosis,
    P.ExpiryDate,
    P.RefillsRemaining,
    P.Status,
    DATEDIFF(P.ExpiryDate, CURDATE()) as DaysUntilExpiry
FROM Prescription P
JOIN Patient Pat ON P.PatientID = Pat.PatientID
WHERE P.Status = 'Active' AND P.ExpiryDate >= CURDATE()
ORDER BY P.ExpiryDate ASC;

-- 10. APPOINTMENT SCHEDULING EFFICIENCY
-- Show appointment room utilization
SELECT 
    RoomNumber,
    COUNT(*) as AppointmentCount,
    COUNT(DISTINCT PatientID) as UniquePatients,
    COUNT(DISTINCT DoctorID) as UniqueDoctors,
    MIN(AppointmentDate) as FirstAppointment,
    MAX(AppointmentDate) as LastAppointment
FROM Appointment
WHERE RoomNumber IS NOT NULL
GROUP BY RoomNumber
ORDER BY AppointmentCount DESC;

-- =====================================================
-- ADVANCED ANALYTICAL QUERIES
-- =====================================================

-- 11. Patient Health Summary
-- Get comprehensive health information for each patient
SELECT 
    Pat.PatientID,
    CONCAT(Pat.FirstName, ' ', Pat.LastName) as PatientName,
    Pat.BloodType,
    Pat.Gender,
    YEAR(CURDATE()) - YEAR(Pat.DateOfBirth) as Age,
    COUNT(DISTINCT A.AppointmentID) as Appointments,
    GROUP_CONCAT(DISTINCT P.Diagnosis) as Diagnoses,
    COUNT(DISTINCT PI.MedicationID) as Uniquemedications
FROM Patient Pat
LEFT JOIN Appointment A ON Pat.PatientID = A.PatientID
LEFT JOIN Prescription P ON Pat.PatientID = P.PatientID
LEFT JOIN PrescriptionItem PI ON P.PrescriptionID = PI.PrescriptionID
GROUP BY Pat.PatientID, Pat.FirstName, Pat.LastName, Pat.BloodType, Pat.Gender, Pat.DateOfBirth;

-- 12. Doctor Performance Metrics
-- Rate doctors based on appointment volume and patient satisfaction indicators
SELECT 
    D.DoctorID,
    CONCAT(D.FirstName, ' ', D.LastName) as DoctorName,
    D.Specialization,
    D.YearsOfExperience,
    COUNT(A.AppointmentID) as TotalAppointments,
    COUNT(DISTINCT A.PatientID) as UniquePatients,
    COUNT(P.PrescriptionID) as TotalPrescriptions,
    ROUND(AVG((SELECT SUM(PI.TotalCost) FROM PrescriptionItem PI WHERE PI.PrescriptionID = P.PrescriptionID)), 2) as AveragePrescriptionCost
FROM Doctor D
LEFT JOIN Appointment A ON D.DoctorID = A.DoctorID
LEFT JOIN Prescription P ON D.DoctorID = P.DoctorID
GROUP BY D.DoctorID, D.FirstName, D.LastName, D.Specialization, D.YearsOfExperience
ORDER BY TotalAppointments DESC;

-- 13. Medication Usage by Drug Type
-- Analyze medication usage patterns
SELECT 
    DrugType,
    COUNT(*) as MedicationCount,
    AVG(UnitPrice) as AveragePrice,
    SUM(QuantityInStock) as TotalInStock,
    SUM(QuantityInStock * UnitPrice) as TotalInventoryValue,
    COUNT(CASE WHEN QuantityInStock < 200 THEN 1 END) as LowStockCount
FROM Medication
GROUP BY DrugType
ORDER BY TotalInventoryValue DESC;

-- 14. Appointment Status Summary
-- Overview of all appointments by status
SELECT 
    Status,
    COUNT(*) as Count,
    ROUND(COUNT(*) * 100 / (SELECT COUNT(*) FROM Appointment), 2) as Percentage,
    MIN(AppointmentDate) as EarliestDate,
    MAX(AppointmentDate) as LatestDate
FROM Appointment
GROUP BY Status;

-- 15. Top 10 Most Prescribed Medications
-- Shows which medications are prescribed most frequently
SELECT 
    M.MedicationID,
    M.MedicationName,
    M.DrugType,
    COUNT(PI.PrescriptionItemID) as TimesPrescribed,
    SUM(PI.Quantity) as TotalQuantityPrescribed,
    SUM(PI.TotalCost) as TotalCost,
    ROUND(AVG(PI.TotalCost), 2) as AverageCostPerPrescription
FROM Medication M
LEFT JOIN PrescriptionItem PI ON M.MedicationID = PI.MedicationID
GROUP BY M.MedicationID, M.MedicationName, M.DrugType
ORDER BY TimesPrescribed DESC
LIMIT 10;
