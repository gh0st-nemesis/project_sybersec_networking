#!/bin/bash

# Create the database
mysql -u root -e "
-- Step 1: Create the Database
CREATE DATABASE IF NOT EXISTS medical_db;

-- Step 2: Use the Database
USE medical_db;

-- Step 3: Create the 'patients' table
CREATE TABLE IF NOT EXISTS patients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    date_of_birth DATE,
    gender ENUM('Male', 'Female', 'Other'),
    email VARCHAR(255) UNIQUE,
    phone_number VARCHAR(15),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Step 4: Create the 'doctors' table
CREATE TABLE IF NOT EXISTS doctors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    specialty VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    phone_number VARCHAR(15),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Step 5: Create the 'appointments' table
CREATE TABLE IF NOT EXISTS appointments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATETIME,
    status ENUM('Scheduled', 'Completed', 'Cancelled'),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(id)
);

-- Step 6: Create the 'prescriptions' table
CREATE TABLE IF NOT EXISTS prescriptions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    medication_name VARCHAR(255) NOT NULL,
    dosage VARCHAR(255) NOT NULL,
    start_date DATE,
    end_date DATE,
    instructions TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(id)
);

-- Step 7: Insert data into the 'patients' table
INSERT INTO patients (first_name, last_name, date_of_birth, gender, email, phone_number, address) 
VALUES
    ('John', 'Doe', '1985-06-15', 'Male', 'john.doe@example.com', '123-456-7890', '123 Main St, Anytown'),
    ('Jane', 'Smith', '1990-11-20', 'Female', 'jane.smith@example.com', '098-765-4321', '456 Oak St, Othertown'),
    ('Emily', 'Jones', '1995-02-05', 'Female', 'emily.jones@example.com', '555-123-4567', '789 Pine St, Smalltown'),
    ('Michael', 'Johnson', '1978-09-10', 'Male', 'michael.johnson@example.com', '777-555-6666', '101 Elm St, Bigcity'),
    ('Chris', 'Williams', '2000-03-25', 'Male', 'chris.williams@example.com', '333-777-8888', '202 Cedar St, Greentown');

-- Step 8: Insert data into the 'doctors' table
INSERT INTO doctors (first_name, last_name, specialty, email, phone_number) 
VALUES
    ('Dr. Emily', 'Brown', 'Cardiologist', 'emily.brown@hospital.com', '111-222-3333'),
    ('Dr. Michael', 'Johnson', 'Pediatrician', 'michael.johnson@clinic.com', '444-555-6666'),
    ('Dr. Sarah', 'Taylor', 'Neurologist', 'sarah.taylor@neurology.com', '777-888-9999'),
    ('Dr. Chris', 'Williams', 'Orthopedist', 'chris.williams@orthopedics.com', '333-444-5555'),
    ('Dr. Patricia', 'Miller', 'Dermatologist', 'patricia.miller@dermatology.com', '666-777-8888');

-- Step 9: Insert data into the 'appointments' table
INSERT INTO appointments (patient_id, doctor_id, appointment_date, status, notes) 
VALUES
    (1, 1, '2024-11-20 09:00:00', 'Scheduled', 'Routine heart check-up'),
    (2, 2, '2024-11-21 10:30:00', 'Scheduled', 'Annual pediatric check-up'),
    (3, 3, '2024-11-22 11:00:00', 'Scheduled', 'Neurology consultation'),
    (4, 4, '2024-11-23 14:00:00', 'Scheduled', 'Orthopedic evaluation'),
    (5, 5, '2024-11-24 15:00:00', 'Scheduled', 'Skin examination');

-- Step 10: Insert data into the 'prescriptions' table
INSERT INTO prescriptions (patient_id, doctor_id, medication_name, dosage, start_date, end_date, instructions) 
VALUES
    (1, 1, 'Aspirin', '50mg', '2024-11-20', '2024-12-20', 'Take one pill daily with food'),
    (2, 2, 'Amoxicillin', '250mg', '2024-11-21', '2024-11-28', 'Take one pill every 8 hours for 7 days'),
    (3, 3, 'Propranolol', '10mg', '2024-11-22', '2024-12-22', 'Take one pill in the morning'),
    (4, 4, 'Ibuprofen', '200mg', '2024-11-23', '2024-11-30', 'Take every 6 hours for pain relief'),
    (5, 5, 'Hydrocortisone Cream', '1%', '2024-11-24', '2024-12-05', 'Apply to affected area twice daily');
"

echo "Database and data have been successfully created and populated."
