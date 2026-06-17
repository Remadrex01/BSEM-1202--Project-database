-- Query File for Medication Table
USE MedicalManagementDB;

-- 1. Get all medications
SELECT * FROM Medication;

-- 2. Get approved medications
SELECT MedicationName, GenericName, Dosage, UnitPrice FROM Medication WHERE IsApproved = TRUE;

-- 3. Get medications by drug type
SELECT MedicationName, DrugType, Dosage, UnitPrice FROM Medication WHERE DrugType = 'Antibiotic';

-- 4. Get medications in stock (quantity > 100)
SELECT MedicationName, QuantityInStock, UnitPrice FROM Medication WHERE QuantityInStock > 100;

-- 5. Get low stock medications (quantity < 200)
SELECT MedicationName, QuantityInStock, DrugType FROM Medication WHERE QuantityInStock < 200 ORDER BY QuantityInStock ASC;

-- 6. Get expired medications
SELECT MedicationName, ExpiryDate, Batch FROM Medication WHERE ExpiryDate < CURDATE();

-- 7. Get medications expiring soon (within 60 days)
SELECT MedicationName, ExpiryDate, QuantityInStock FROM Medication WHERE ExpiryDate BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 60 DAY);

-- 8. Count medications by drug type
SELECT DrugType, COUNT(*) as MedicationCount FROM Medication GROUP BY DrugType ORDER BY MedicationCount DESC;

-- 9. Search medication by name
SELECT * FROM Medication WHERE MedicationName LIKE '%Aspirin%' OR GenericName LIKE '%Aspirin%';

-- 10. Get medication cost information
SELECT MedicationName, UnitPrice, QuantityInStock, (UnitPrice * QuantityInStock) as TotalInventoryValue FROM Medication ORDER BY TotalInventoryValue DESC;

-- 11. Get medications by manufacturer
SELECT MedicationName, Manufacturer, DrugType, UnitPrice FROM Medication WHERE Manufacturer = 'Pfizer' ORDER BY MedicationName;

-- 12. Get medications with side effects and contraindications
SELECT MedicationName, SideEffects, Contraindications FROM Medication WHERE SideEffects IS NOT NULL AND Contraindications IS NOT NULL;

-- 13. Get generic medications available
SELECT MedicationName, GenericName, Manufacturer FROM Medication WHERE GenericName IS NOT NULL;

-- 14. Get all available inventory quantity
SELECT SUM(QuantityInStock) as TotalInventory FROM Medication;

-- 15. Get most expensive medications (top 10)
SELECT MedicationName, UnitPrice, Manufacturer FROM Medication ORDER BY UnitPrice DESC LIMIT 10;
