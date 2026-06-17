# Medical Management Database - Complete Documentation

## Overview
This comprehensive medical management system database includes patient records, doctor information, medication inventory, appointments, prescriptions, and user authentication system with role-based access control.

---

## 📁 File Structure

### Creating Database/
Contains SQL scripts to create all 6 tables with proper relationships:
- **patient.sql** - Patient information table
- **doctor.sql** - Doctor information and specialization
- **medication.sql** - Medication inventory management
- **appointment.sql** - Appointment scheduling system
- **prescription.sql** - Prescription records
- **prescription_Item.sql** - Individual medication items in prescriptions

### Inserting database/
Contains INSERT statements with 30 sample records for each entity:
- **insert_patients.sql** - 30 patient records
- **insert_doctors.sql** - 30 doctor records
- **insert_medications.sql** - 30 medication records
- **insert_appointments.sql** - 30 appointment records
- **insert_prescriptions.sql** - 30 prescription records
- **insert_prescription_items.sql** - 30 prescription item records

### Query/
Contains comprehensive SQL queries for data retrieval and reporting:
- **query_patients.sql** - 15 patient-related queries
- **query_doctors.sql** - 15 doctor-related queries
- **query_medications.sql** - 15 medication-related queries
- **query_appointments.sql** - 15 appointment-related queries
- **query_prescriptions.sql** - 15 prescription-related queries
- **query_prescription_items.sql** - 15 prescription item queries
- **advanced_queries_reporting.sql** - 15 advanced analytical queries

### Root Files
- **MASTER_SETUP_COMPLETE.sql** - Complete database setup with all tables and first 2 entities' data
- **database_setup.sql** - User account creation and permission management
- **user_login_setup.sql** - Login authentication system with procedures
- **SETUP_INSTRUCTIONS.sql** - Step-by-step setup guide

---

## 🚀 Quick Start Guide

### Method 1: Using MASTER_SETUP_COMPLETE.sql (Recommended)
```sql
-- Open MySQL Command Line or MySQL Workbench
-- Execute the master setup script
source C:\Users\james\Desktop\database project\MASTER_SETUP_COMPLETE.sql;
```

### Method 2: Step-by-Step Setup
1. **Create Database and Tables:**
   ```sql
   source Creating Database\patient.sql;
   source Creating Database\doctor.sql;
   source Creating Database\medication.sql;
   source Creating Database\appointment.sql;
   source Creating Database\prescription.sql;
   source Creating Database\prescription_Item.sql;
   ```

2. **Insert Sample Data:**
   ```sql
   source Inserting database\insert_patients.sql;
   source Inserting database\insert_doctors.sql;
   source Inserting database\insert_medications.sql;
   source Inserting database\insert_appointments.sql;
   source Inserting database\insert_prescriptions.sql;
   source Inserting database\insert_prescription_items.sql;
   ```

3. **Set Up Users and Authentication:**
   ```sql
   source database_setup.sql;
   source user_login_setup.sql;
   ```

4. **Run Queries:**
   ```sql
   source Query\query_patients.sql;
   source Query\query_doctors.sql;
   -- ... and so on for other queries
   ```

---

## 👥 Database User Accounts

### Admin Account
- **Username:** admin
- **Password:** AdminPassword123!
- **Permissions:** Full access to all tables

### Doctor Account
- **Username:** doctor
- **Password:** DoctorPass123!
- **Permissions:** SELECT, INSERT, UPDATE on all tables

### Nurse Account
- **Username:** nurse
- **Password:** NursePass123!
- **Permissions:** Patient records, Appointments management

### Pharmacist Account
- **Username:** pharmacist
- **Password:** PharmacistPass123!
- **Permissions:** Medication management and prescriptions

### Receptionist Account
- **Username:** receptionist
- **Password:** ReceptionistPass123!
- **Permissions:** Appointment and patient scheduling

### Viewer Account (Read-Only)
- **Username:** viewer
- **Password:** ViewerPass123!
- **Permissions:** SELECT only on all tables

---

## 📊 Database Schema

### Patient Table
Stores patient information including demographics, contact details, and emergency contacts.
- PatientID (PK)
- FirstName, LastName
- DateOfBirth, Gender
- Email, PhoneNumber
- Address, City, State, ZipCode
- BloodType
- EmergencyContact, EmergencyPhone

### Doctor Table
Stores doctor information, specialization, and credentials.
- DoctorID (PK)
- FirstName, LastName
- Specialization
- LicenseNumber
- Email, PhoneNumber
- ClinicName
- YearsOfExperience
- Qualification
- IsActive

### Medication Table
Manages medication inventory with pricing and availability.
- MedicationID (PK)
- MedicationName
- GenericName
- Manufacturer
- DrugType
- Dosage
- UnitPrice
- QuantityInStock
- ExpiryDate
- Batch
- SideEffects, Contraindications

### Appointment Table
Records patient appointments with doctors.
- AppointmentID (PK)
- PatientID (FK), DoctorID (FK)
- AppointmentDate, AppointmentTime
- Reason
- Status (Scheduled, Completed, Cancelled)
- RoomNumber
- Notes, CancellationReason

### Prescription Table
Stores prescription records linking patients, doctors, and medications.
- PrescriptionID (PK)
- PatientID (FK), DoctorID (FK)
- AppointmentID (FK)
- PrescriptionDate
- Diagnosis
- Instructions
- RefillAllowed, RefillsRemaining
- ExpiryDate
- Status

### PrescriptionItem Table
Details of individual medications in each prescription.
- PrescriptionItemID (PK)
- PrescriptionID (FK)
- MedicationID (FK)
- Quantity
- Dosage
- Frequency
- Duration, DurationUnit
- Instructions
- CostPerUnit, TotalCost

### UserLogin Table
User authentication and role management.
- UserID (PK)
- Username, Email
- Password (encrypted with MD5)
- Role
- FullName
- IsActive
- LastLogin
- AccountStatus

---

## 📝 Sample Data

### 30 Patients
Includes diverse demographics with various blood types, locations across US major cities, and complete contact information.

### 30 Doctors
Includes specialists across 30 medical specializations (Cardiology, Dermatology, Orthopedics, etc.) with credentials and experience levels.

### 30 Medications
Includes various drug types (Antibiotics, NSAIDs, Antihistamines, etc.) with pricing, stock levels, and expiry dates.

### 30 Appointments
Scheduled appointments with various statuses (Scheduled, Completed, Cancelled).

### 30 Prescriptions
Active and completed prescriptions with various diagnoses.

### 30 Prescription Items
Individual medication items within prescriptions with dosing information and costs.

---

## 🔍 Query Examples

### Get All Patients
```sql
SELECT * FROM Patient;
```

### Get Scheduled Appointments
```sql
SELECT * FROM Appointment 
WHERE AppointmentDate >= CURDATE() AND Status = 'Scheduled'
ORDER BY AppointmentDate ASC;
```

### Get Medication Inventory Status
```sql
SELECT MedicationName, QuantityInStock, 
CASE 
    WHEN QuantityInStock < 100 THEN 'Low Stock'
    WHEN QuantityInStock < 200 THEN 'Medium Stock'
    ELSE 'Good Stock'
END as StockStatus
FROM Medication
ORDER BY QuantityInStock ASC;
```

### Get Patient Appointment History
```sql
SELECT * FROM Appointment 
WHERE PatientID = 1
ORDER BY AppointmentDate DESC;
```

### Get Active Prescriptions
```sql
SELECT * FROM Prescription 
WHERE Status = 'Active' 
ORDER BY ExpiryDate ASC;
```

---

## 🔐 Authentication System

### Login Procedure
The database includes a stored procedure for user authentication:
```sql
CALL AuthenticateUser('admin', 'AdminPassword123!');
```

### Update Last Login
```sql
CALL UpdateLastLogin('admin');
```

### Lock Account (After Failed Attempts)
```sql
CALL LockUserAccount('username');
```

### Unlock Account
```sql
CALL UnlockUserAccount('username');
```

---

## 📊 Available Reports

### Analytical Queries
The `advanced_queries_reporting.sql` file includes 15 comprehensive reports:
1. Patient Demographics Report
2. Doctor Utilization Report
3. Medication Inventory Report
4. Prescription Analysis Report
5. Patient Appointment History
6. Diagnosis Frequency Report
7. Financial Report (Medication Costs)
8. Specialization Demand Report
9. Prescription Refill Status Report
10. Appointment Scheduling Efficiency
11. Patient Health Summary
12. Doctor Performance Metrics
13. Medication Usage by Drug Type
14. Appointment Status Summary
15. Top 10 Most Prescribed Medications

---

## 🛠️ Database Relationships

```
Patient (1) ──────────────── (M) Appointment ──────────── (1) Doctor
    ↓
Prescription ──────────────── PrescriptionItem ──────── Medication
    ↓
  (FK to Appointment)
```

---

## 💾 Backup and Maintenance

### Backup Database
```bash
mysqldump -u admin -p MedicalManagementDB > backup.sql
```

### Restore Database
```bash
mysql -u admin -p MedicalManagementDB < backup.sql
```

---

## ⚙️ Customization

### Adding New Medication
```sql
INSERT INTO Medication (MedicationName, GenericName, Manufacturer, DrugType, Dosage, UnitPrice, QuantityInStock, ExpiryDate, IsApproved)
VALUES ('NewDrug', 'GenericName', 'Manufacturer', 'DrugType', '500mg', 10.00, 100, '2025-12-31', TRUE);
```

### Adding New Patient
```sql
INSERT INTO Patient (FirstName, LastName, DateOfBirth, Gender, Email, PhoneNumber, BloodType, Address, City, State, ZipCode)
VALUES ('John', 'Doe', '1990-01-01', 'Male', 'john@email.com', '555-0000', 'O+', '123 St', 'City', 'ST', '12345');
```

### Scheduling Appointment
```sql
INSERT INTO Appointment (PatientID, DoctorID, AppointmentDate, AppointmentTime, Reason, Status)
VALUES (1, 1, '2024-12-25', '10:00:00', 'Checkup', 'Scheduled');
```

---

## 🔧 Troubleshooting

### Issue: Access Denied
- Verify correct username and password
- Check user permissions with: `SHOW GRANTS FOR 'username'@'localhost';`

### Issue: Foreign Key Constraint Error
- Ensure referenced records exist before inserting
- Verify table relationships are correct

### Issue: Medication Not Found
- Check spelling and exact medication name
- Use wildcards: `WHERE MedicationName LIKE '%Aspirin%'`

---

## 📞 Support

For questions or issues:
1. Review the SETUP_INSTRUCTIONS.sql file
2. Check table relationships in the schema
3. Verify user permissions match the required role
4. Run sample queries to test database functionality

---

## 📋 Checklist Before Going Live

- [ ] All tables created successfully
- [ ] 30 sample records inserted in each table
- [ ] User accounts created with proper permissions
- [ ] Test login with each role account
- [ ] Run sample queries successfully
- [ ] Backup database
- [ ] Document any customizations
- [ ] Review security settings
- [ ] Test appointment scheduling
- [ ] Verify prescription calculations

---

**Database Created:** 2024
**Total Records:** 180 (30 per main entity)
**Total Tables:** 7 (including UserLogin and LoginAuditLog)
**Status:** Ready for Production
