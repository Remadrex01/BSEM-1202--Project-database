--Create Payment Table
DROP TABLE IF EXISTS Payment;

--Create Payment
CREATE TABLE patient(
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT NOT NULL,
    AppointmentID INT NOT NULL,
    PaymentDate DATE NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentMethod VARCHAR(50) NOT NULL,
    TransactionID VARCHAR(100),
    PaymentStatus VARCHAR(20) DEFAULT 'Pending',
    
)