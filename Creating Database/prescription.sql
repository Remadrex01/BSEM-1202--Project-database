-- Create Prescription Table
DROP TABLE IF EXISTS Prescription;

CREATE TABLE Prescription (
    PrescriptionID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    AppointmentID INT,
    PrescriptionDate DATE NOT NULL,
    Diagnosis VARCHAR(255),
    Instructions TEXT,
    RefillAllowed INT DEFAULT 0,
    RefillsRemaining INT,
    ExpiryDate DATE,
    Status VARCHAR(20) DEFAULT 'Active',
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID),
    FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID)
);
