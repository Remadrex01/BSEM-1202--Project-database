-- Query File for Prescription Table
USE MedicalManagementDB;

-- 1. Get all prescriptions
SELECT P.PrescriptionID, Pat.FirstName, Pat.LastName, D.FirstName as DoctorName, P.PrescriptionDate, P.Status
FROM Prescription P
JOIN Patient Pat ON P.PatientID = Pat.PatientID
JOIN Doctor D ON P.DoctorID = D.DoctorID;

-- 2. Get active prescriptions
SELECT P.PrescriptionID, Pat.FirstName, D.FirstName, P.Diagnosis, P.ExpiryDate
FROM Prescription P
JOIN Patient Pat ON P.PatientID = Pat.PatientID
JOIN Doctor D ON P.DoctorID = D.DoctorID
WHERE P.Status = 'Active'
ORDER BY P.ExpiryDate DESC;

-- 3. Get prescriptions by patient
SELECT P.PrescriptionID, D.FirstName, D.LastName, P.Diagnosis, P.PrescriptionDate, P.Status
FROM Prescription P
JOIN Doctor D ON P.DoctorID = D.DoctorID
WHERE P.PatientID = 1
ORDER BY P.PrescriptionDate DESC;

-- 4. Get prescriptions with refills available
SELECT P.PrescriptionID, Pat.FirstName, P.Diagnosis, P.RefillsRemaining, P.ExpiryDate
FROM Prescription P
JOIN Patient Pat ON P.PatientID = Pat.PatientID
WHERE P.RefillsRemaining > 0 AND P.Status = 'Active';

-- 5. Get expired prescriptions
SELECT P.PrescriptionID, Pat.FirstName, D.FirstName, P.Diagnosis, P.ExpiryDate
FROM Prescription P
JOIN Patient Pat ON P.PatientID = Pat.PatientID
JOIN Doctor D ON P.DoctorID = D.DoctorID
WHERE P.ExpiryDate < CURDATE();

-- 6. Get prescriptions expiring soon (30 days)
SELECT P.PrescriptionID, Pat.FirstName, P.Diagnosis, P.ExpiryDate
FROM Prescription P
JOIN Patient Pat ON P.PatientID = Pat.PatientID
WHERE P.ExpiryDate BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY)
ORDER BY P.ExpiryDate;

-- 7. Count prescriptions by status
SELECT Status, COUNT(*) as PrescriptionCount FROM Prescription GROUP BY Status;

-- 8. Get prescriptions by doctor
SELECT P.PrescriptionID, Pat.FirstName, P.Diagnosis, P.PrescriptionDate, P.Status
FROM Prescription P
JOIN Patient Pat ON P.PatientID = Pat.PatientID
WHERE P.DoctorID = 1
ORDER BY P.PrescriptionDate DESC;

-- 9. Get prescriptions with diagnosis information
SELECT P.PrescriptionID, Pat.FirstName, D.FirstName, P.Diagnosis, P.Instructions
FROM Prescription P
JOIN Patient Pat ON P.PatientID = Pat.PatientID
JOIN Doctor D ON P.DoctorID = D.DoctorID
WHERE P.Diagnosis IS NOT NULL
ORDER BY P.PrescriptionDate DESC;

-- 10. Get prescriptions with refill status
SELECT P.PrescriptionID, Pat.FirstName, P.Diagnosis, P.RefillAllowed, P.RefillsRemaining
FROM Prescription P
JOIN Patient Pat ON P.PatientID = Pat.PatientID
WHERE P.RefillAllowed > 0
ORDER BY P.RefillsRemaining DESC;

-- 11. Count prescriptions per doctor
SELECT D.FirstName, D.LastName, COUNT(P.PrescriptionID) as TotalPrescriptions
FROM Doctor D
LEFT JOIN Prescription P ON D.DoctorID = P.DoctorID
GROUP BY D.DoctorID, D.FirstName, D.LastName
ORDER BY TotalPrescriptions DESC;

-- 12. Get prescriptions by appointment
SELECT P.PrescriptionID, Pat.FirstName, P.Diagnosis, A.AppointmentDate
FROM Prescription P
JOIN Patient Pat ON P.PatientID = Pat.PatientID
JOIN Appointment A ON P.AppointmentID = A.AppointmentID
WHERE P.AppointmentID IS NOT NULL;

-- 13. Get recent prescriptions (last 30 days)
SELECT P.PrescriptionID, Pat.FirstName, D.FirstName, P.Diagnosis, P.PrescriptionDate
FROM Prescription P
JOIN Patient Pat ON P.PatientID = Pat.PatientID
JOIN Doctor D ON P.DoctorID = D.DoctorID
WHERE P.PrescriptionDate >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
ORDER BY P.PrescriptionDate DESC;

-- 14. Get prescriptions without medications (orphaned)
SELECT P.PrescriptionID, Pat.FirstName, P.Diagnosis
FROM Prescription P
JOIN Patient Pat ON P.PatientID = Pat.PatientID
LEFT JOIN PrescriptionItem PI ON P.PrescriptionID = PI.PrescriptionID
WHERE PI.PrescriptionItemID IS NULL;

-- 15. Get comprehensive prescription information
SELECT P.PrescriptionID, Pat.FirstName, Pat.LastName, D.FirstName as DoctorName, 
       P.Diagnosis, P.PrescriptionDate, P.ExpiryDate, P.Status, P.RefillsRemaining
FROM Prescription P
JOIN Patient Pat ON P.PatientID = Pat.PatientID
JOIN Doctor D ON P.DoctorID = D.DoctorID
ORDER BY P.PrescriptionDate DESC;
