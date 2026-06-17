-- Query File for PrescriptionItem Table
USE MedicalManagementDB;

-- 1. Get all prescription items
SELECT PI.PrescriptionItemID, P.PrescriptionID, M.MedicationName, PI.Quantity, PI.Dosage, PI.Frequency
FROM PrescriptionItem PI
JOIN Prescription P ON PI.PrescriptionID = P.PrescriptionID
JOIN Medication M ON PI.MedicationID = M.MedicationID;

-- 2. Get prescription items for a specific prescription
SELECT M.MedicationName, PI.Dosage, PI.Quantity, PI.Frequency, PI.Duration, PI.DurationUnit, PI.Instructions
FROM PrescriptionItem PI
JOIN Medication M ON PI.MedicationID = M.MedicationID
WHERE PI.PrescriptionID = 1;

-- 3. Get prescription items with costs
SELECT PI.PrescriptionItemID, M.MedicationName, PI.Quantity, PI.CostPerUnit, PI.TotalCost
FROM PrescriptionItem PI
JOIN Medication M ON PI.MedicationID = M.MedicationID
ORDER BY PI.TotalCost DESC;

-- 4. Get medication usage statistics
SELECT M.MedicationName, COUNT(PI.PrescriptionItemID) as UsageCount, SUM(PI.Quantity) as TotalQuantity
FROM PrescriptionItem PI
JOIN Medication M ON PI.MedicationID = M.MedicationID
GROUP BY PI.MedicationID, M.MedicationName
ORDER BY UsageCount DESC;

-- 5. Get most prescribed medications (top 10)
SELECT M.MedicationName, M.DrugType, COUNT(PI.PrescriptionItemID) as PrescriptionCount
FROM PrescriptionItem PI
JOIN Medication M ON PI.MedicationID = M.MedicationID
GROUP BY PI.MedicationID, M.MedicationName, M.DrugType
ORDER BY PrescriptionCount DESC
LIMIT 10;

-- 6. Get prescription items by medication type
SELECT M.MedicationName, M.DrugType, PI.Dosage, PI.Frequency, COUNT(*) as Prescriptions
FROM PrescriptionItem PI
JOIN Medication M ON PI.MedicationID = M.MedicationID
WHERE M.DrugType = 'Antibiotic'
GROUP BY PI.MedicationID, M.MedicationName, M.DrugType, PI.Dosage, PI.Frequency;

-- 7. Get prescription items with patient information
SELECT Pat.FirstName, Pat.LastName, M.MedicationName, PI.Dosage, PI.Frequency, PI.Instructions
FROM PrescriptionItem PI
JOIN Prescription P ON PI.PrescriptionID = P.PrescriptionID
JOIN Patient Pat ON P.PatientID = Pat.PatientID
JOIN Medication M ON PI.MedicationID = M.MedicationID;

-- 8. Get prescription items total cost by prescription
SELECT P.PrescriptionID, Pat.FirstName, SUM(PI.TotalCost) as PrescriptionTotal
FROM PrescriptionItem PI
JOIN Prescription P ON PI.PrescriptionID = P.PrescriptionID
JOIN Patient Pat ON P.PatientID = Pat.PatientID
GROUP BY P.PrescriptionID, Pat.FirstName
ORDER BY PrescriptionTotal DESC;

-- 9. Get prescription items with duration
SELECT M.MedicationName, PI.Dosage, PI.Frequency, PI.Duration, PI.DurationUnit, PI.Instructions
FROM PrescriptionItem PI
JOIN Medication M ON PI.MedicationID = M.MedicationID
WHERE PI.Duration IS NOT NULL
ORDER BY PI.Duration DESC;

-- 10. Get high-cost prescription items (> $50)
SELECT PI.PrescriptionItemID, M.MedicationName, PI.Quantity, PI.TotalCost, P.PrescriptionID
FROM PrescriptionItem PI
JOIN Medication M ON PI.MedicationID = M.MedicationID
JOIN Prescription P ON PI.PrescriptionID = P.PrescriptionID
WHERE PI.TotalCost > 50
ORDER BY PI.TotalCost DESC;

-- 11. Get average prescription cost per patient
SELECT Pat.FirstName, Pat.LastName, AVG(PI.TotalCost) as AvgMedicationCost, SUM(PI.TotalCost) as TotalCost
FROM PrescriptionItem PI
JOIN Prescription P ON PI.PrescriptionID = P.PrescriptionID
JOIN Patient Pat ON P.PatientID = Pat.PatientID
GROUP BY Pat.PatientID, Pat.FirstName, Pat.LastName
ORDER BY TotalCost DESC;

-- 12. Get medications prescribed with specific frequency
SELECT M.MedicationName, PI.Frequency, COUNT(*) as Count
FROM PrescriptionItem PI
JOIN Medication M ON PI.MedicationID = M.MedicationID
GROUP BY M.MedicationName, PI.Frequency
ORDER BY Count DESC;

-- 13. Get prescription items with special instructions
SELECT M.MedicationName, PI.Dosage, PI.Instructions
FROM PrescriptionItem PI
JOIN Medication M ON PI.MedicationID = M.MedicationID
WHERE PI.Instructions IS NOT NULL AND PI.Instructions != ''
ORDER BY M.MedicationName;

-- 14. Get total medication inventory value by prescription item usage
SELECT M.MedicationName, 
       COUNT(PI.PrescriptionItemID) as TimesPrescribed, 
       SUM(PI.TotalCost) as TotalMoneySpent
FROM PrescriptionItem PI
JOIN Medication M ON PI.MedicationID = M.MedicationID
GROUP BY PI.MedicationID, M.MedicationName
ORDER BY TotalMoneySpent DESC;

-- 15. Get prescription items trend (medications by creation date)
SELECT DATE(PI.CreatedDate) as CreatedDate, COUNT(*) as ItemsCreated, SUM(PI.TotalCost) as DailyCost
FROM PrescriptionItem PI
GROUP BY DATE(PI.CreatedDate)
ORDER BY CreatedDate DESC;
