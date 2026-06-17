-- Create Medication Table
DROP TABLE IF EXISTS Medication;

CREATE TABLE Medication (
    MedicationID INT PRIMARY KEY AUTO_INCREMENT,
    MedicationName VARCHAR(100) NOT NULL,
    GenericName VARCHAR(100),
    Manufacturer VARCHAR(100),
    DrugType VARCHAR(50) NOT NULL,
    Dosage VARCHAR(50) NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    QuantityInStock INT NOT NULL,
    ExpiryDate DATE NOT NULL,
    Batch VARCHAR(50),
    SideEffects TEXT,
    Contraindications TEXT,
    IsApproved BOOLEAN DEFAULT TRUE,
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
