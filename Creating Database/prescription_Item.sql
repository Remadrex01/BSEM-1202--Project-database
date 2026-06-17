-- Create PrescriptionItem Table
DROP TABLE IF EXISTS PrescriptionItem;

CREATE TABLE PrescriptionItem (
    PrescriptionItemID INT PRIMARY KEY AUTO_INCREMENT,
    PrescriptionID INT NOT NULL,
    MedicationID INT NOT NULL,
    Quantity INT NOT NULL,
    Dosage VARCHAR(50),
    Frequency VARCHAR(100),
    Duration INT NOT NULL,
    DurationUnit VARCHAR(20),
    Instructions TEXT,
    CostPerUnit DECIMAL(10, 2),
    TotalCost DECIMAL(10, 2),
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (PrescriptionID) REFERENCES Prescription(PrescriptionID),
    FOREIGN KEY (MedicationID) REFERENCES Medication(MedicationID)
);
