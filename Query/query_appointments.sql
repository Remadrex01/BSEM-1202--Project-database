-- Query File for Appointment Table
USE MedicalManagementDB;

-- 1. Get all appointments
SELECT A.AppointmentID, P.FirstName as PatientName, D.FirstName as DoctorName, A.AppointmentDate, A.AppointmentTime, A.Status 
FROM Appointment A
JOIN Patient P ON A.PatientID = P.PatientID
JOIN Doctor D ON A.DoctorID = D.DoctorID;

-- 2. Get scheduled appointments (upcoming)
SELECT A.AppointmentID, P.FirstName, P.LastName, D.Specialization, A.AppointmentDate, A.AppointmentTime
FROM Appointment A
JOIN Patient P ON A.PatientID = P.PatientID
JOIN Doctor D ON A.DoctorID = D.DoctorID
WHERE A.AppointmentDate >= CURDATE() AND A.Status = 'Scheduled'
ORDER BY A.AppointmentDate ASC;

-- 3. Get completed appointments
SELECT A.AppointmentID, P.FirstName, D.FirstName, A.AppointmentDate, A.Reason
FROM Appointment A
JOIN Patient P ON A.PatientID = P.PatientID
JOIN Doctor D ON A.DoctorID = D.DoctorID
WHERE A.Status = 'Completed';

-- 4. Get appointments by doctor
SELECT A.AppointmentID, P.FirstName, P.LastName, A.AppointmentDate, A.AppointmentTime, A.Reason
FROM Appointment A
JOIN Patient P ON A.PatientID = P.PatientID
WHERE A.DoctorID = 1
ORDER BY A.AppointmentDate;

-- 5. Get appointments by patient
SELECT A.AppointmentID, D.FirstName, D.LastName, D.Specialization, A.AppointmentDate, A.AppointmentTime
FROM Appointment A
JOIN Doctor D ON A.DoctorID = D.DoctorID
WHERE A.PatientID = 1
ORDER BY A.AppointmentDate DESC;

-- 6. Count appointments by status
SELECT Status, COUNT(*) as AppointmentCount FROM Appointment GROUP BY Status;

-- 7. Get appointments for specific date
SELECT A.AppointmentID, P.FirstName, P.LastName, D.FirstName, D.LastName, A.AppointmentTime, A.RoomNumber
FROM Appointment A
JOIN Patient P ON A.PatientID = P.PatientID
JOIN Doctor D ON A.DoctorID = D.DoctorID
WHERE A.AppointmentDate = '2024-12-20'
ORDER BY A.AppointmentTime;

-- 8. Get cancelled appointments with reasons
SELECT A.AppointmentID, P.FirstName, D.FirstName, A.CancellationReason
FROM Appointment A
JOIN Patient P ON A.PatientID = P.PatientID
JOIN Doctor D ON A.DoctorID = D.DoctorID
WHERE A.Status = 'Cancelled' AND A.CancellationReason IS NOT NULL;

-- 9. Count appointments per doctor
SELECT D.FirstName, D.LastName, D.Specialization, COUNT(A.AppointmentID) as TotalAppointments
FROM Doctor D
LEFT JOIN Appointment A ON D.DoctorID = A.DoctorID
GROUP BY D.DoctorID, D.FirstName, D.LastName, D.Specialization
ORDER BY TotalAppointments DESC;

-- 10. Get appointments with notes
SELECT A.AppointmentID, P.FirstName, D.FirstName, A.AppointmentDate, A.Notes
FROM Appointment A
JOIN Patient P ON A.PatientID = P.PatientID
JOIN Doctor D ON A.DoctorID = D.DoctorID
WHERE A.Notes IS NOT NULL;

-- 11. Get today's appointments
SELECT A.AppointmentID, P.FirstName, P.LastName, D.FirstName, A.AppointmentTime, A.RoomNumber
FROM Appointment A
JOIN Patient P ON A.PatientID = P.PatientID
JOIN Doctor D ON A.DoctorID = D.DoctorID
WHERE A.AppointmentDate = CURDATE()
ORDER BY A.AppointmentTime;

-- 12. Get appointments by reason
SELECT Reason, COUNT(*) as AppointmentCount FROM Appointment GROUP BY Reason ORDER BY AppointmentCount DESC;

-- 13. Get appointments by room
SELECT RoomNumber, COUNT(*) as Appointments FROM Appointment WHERE RoomNumber IS NOT NULL GROUP BY RoomNumber ORDER BY RoomNumber;

-- 14. Get appointment history for a patient (last 30 days)
SELECT A.AppointmentID, D.FirstName, D.LastName, A.AppointmentDate, A.Status
FROM Appointment A
JOIN Doctor D ON A.DoctorID = D.DoctorID
WHERE A.PatientID = 1 AND A.AppointmentDate >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
ORDER BY A.AppointmentDate DESC;

-- 15. Get all appointments with full details (comprehensive)
SELECT A.AppointmentID, P.FirstName as PatientFirstName, P.LastName as PatientLastName, 
       D.FirstName as DoctorFirstName, D.LastName as DoctorLastName, D.Specialization,
       A.AppointmentDate, A.AppointmentTime, A.Reason, A.Status, A.RoomNumber
FROM Appointment A
JOIN Patient P ON A.PatientID = P.PatientID
JOIN Doctor D ON A.DoctorID = D.DoctorID
ORDER BY A.AppointmentDate DESC;
