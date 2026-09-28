-- ==========================
-- SAMPLE DATA
-- ==========================

-- Doctors
CALL AddNewDoctor('100000000001', 'Dr. Aditi Sharma', 'Dermatology', 12);
CALL AddNewDoctor('100000000002', 'Dr. Rajesh Khanna', 'Pediatrics', 20);
CALL AddNewDoctor('100000000003', 'Dr. Neha Verma', 'Oncology', 15);
CALL AddNewDoctor('100000000004', 'Dr. Sameer Joshi', 'Cardiology', 18);
CALL AddNewDoctor('100000000005', 'Dr. Kavita Rao', 'Neurology', 22);

-- Patients
CALL AddNewPatient('200000000001', 'Ananya Rao', 'Kondapur, Hyderabad', 30, '100000000001');
CALL AddNewPatient('200000000002', 'Ravi Patil', 'Jubilee Hills, Hyderabad', 45, '100000000002');
CALL AddNewPatient('200000000003', 'Meera Jain', 'Madhapur, Hyderabad', 29, '100000000003');
CALL AddNewPatient('200000000004', 'Suresh Kumar', 'Ameerpet, Hyderabad', 38, '100000000004');
CALL AddNewPatient('200000000005', 'Neeraj Chopra', 'Banjara Hills, Hyderabad', 50, '100000000005');
CALL AddNewPatient('200000000006', 'Deepika Reddy', 'Secunderabad', 26, '100000000001');
CALL AddNewPatient('200000000007', 'Varun Yadav', 'Hitech City', 33, '100000000002');
CALL AddNewPatient('200000000008', 'Preeti Nair', 'Begumpet', 41, '100000000004');

-- Pharma Companies
CALL AddNewPharma('Sun Pharma', '0401111111');
CALL AddNewPharma('Cipla Ltd', '0402222222');
CALL AddNewPharma('Dr Reddys', '0403333333');

-- Drugs
CALL AddNewDrug('Crocin', 'Paracetamol 500mg', 'Sun Pharma');
CALL AddNewDrug('Cetrizine', 'Cetirizine 10mg', 'Cipla Ltd');
CALL AddNewDrug('Dolo 650', 'Paracetamol 650mg', 'Dr Reddys');
CALL AddNewDrug('Combiflam', 'Ibuprofen + Paracetamol', 'Cipla Ltd');
CALL AddNewDrug('Augmentin', 'Amoxicillin + Clavulanic Acid', 'Sun Pharma');
CALL AddNewDrug('Pantop', 'Pantoprazole 40mg', 'Dr Reddys');
CALL AddNewDrug('Aspirin', 'Acetylsalicylic Acid', 'Cipla Ltd');
CALL AddNewDrug('Zincovit', 'Multivitamin', 'Sun Pharma');
CALL AddNewDrug('Meftal Spas', 'Dicyclomine + Mefenamic Acid', 'Dr Reddys');
CALL AddNewDrug('Metformin', 'Metformin 500mg', 'Sun Pharma');

-- Pharmacies
CALL AddNewPharmacy('Nova Pharmacy - Gachibowli', 'Gachibowli', '0401112223');
CALL AddNewPharmacy('Nova Pharmacy - Hitech City', 'Hitech City', '0401144556');
CALL AddNewPharmacy('Nova Pharmacy - Secunderabad', 'Secunderabad', '0401188990');

-- Contracts
CALL AddNewContract('Sun Pharma', 'Nova Pharmacy - Gachibowli', '2024-01-01', '2025-01-01', 'Annual Supply', 'Anil Reddy');
CALL AddNewContract('Cipla Ltd', 'Nova Pharmacy - Gachibowli', '2024-02-01', '2025-02-01', 'Generic Medicine Contract', 'Rekha Singh');
CALL AddNewContract('Dr Reddys', 'Nova Pharmacy - Hitech City', '2024-03-01', '2025-03-01', 'Antibiotics Contract', 'Vikram Bhat');
CALL AddNewContract('Sun Pharma', 'Nova Pharmacy - Hitech City', '2024-04-01', '2025-04-01', 'Over-the-counter', 'Karan Kapoor');
CALL AddNewContract('Dr Reddys', 'Nova Pharmacy - Secunderabad', '2024-05-01', '2025-05-01', 'Chronic Treatment', 'Priya Rao');
CALL AddNewContract('Cipla Ltd', 'Nova Pharmacy - Secunderabad', '2024-06-01', '2025-06-01', 'Allergy Meds', 'Kavita Das');

-- Prescriptions
CALL AddNewPrescription('200000000001', '100000000001', '2025-04-01');
CALL AddNewPrescription('200000000002', '100000000002', '2025-04-01');
CALL AddNewPrescription('200000000003', '100000000003', '2025-04-02');
CALL AddNewPrescription('200000000004', '100000000004', '2025-04-02');
CALL AddNewPrescription('200000000005', '100000000005', '2025-04-03');
CALL AddNewPrescription('200000000006', '100000000001', '2025-04-04');
CALL AddNewPrescription('200000000007', '100000000002', '2025-04-04');
CALL AddNewPrescription('200000000008', '100000000004', '2025-04-05');
CALL AddNewPrescription('200000000001', '100000000001', '2025-04-07');
CALL AddNewPrescription('200000000003', '100000000003', '2025-04-08');

-- Prescribed Drugs
CALL AddPrescribedDrug(1, 'Crocin', 'Sun Pharma', 2);
CALL AddPrescribedDrug(1, 'Cetrizine', 'Cipla Ltd', 1);
CALL AddPrescribedDrug(2, 'Dolo 650', 'Dr Reddys', 1);
CALL AddPrescribedDrug(3, 'Combiflam', 'Cipla Ltd', 1);
CALL AddPrescribedDrug(4, 'Augmentin', 'Sun Pharma', 2);
CALL AddPrescribedDrug(5, 'Pantop', 'Dr Reddys', 1);
CALL AddPrescribedDrug(6, 'Zincovit', 'Sun Pharma', 1);
CALL AddPrescribedDrug(7, 'Cetrizine', 'Cipla Ltd', 1);
CALL AddPrescribedDrug(8, 'Aspirin', 'Cipla Ltd', 1);
CALL AddPrescribedDrug(9, 'Metformin', 'Sun Pharma', 2);
CALL AddPrescribedDrug(9, 'Pantop', 'Dr Reddys', 1);
CALL AddPrescribedDrug(10, 'Meftal Spas', 'Dr Reddys', 1);

-- Sells (Pharmacy stock with prices)
INSERT INTO Sells VALUES ('Nova Pharmacy - Gachibowli', 'Crocin', 'Sun Pharma', 12.50);
INSERT INTO Sells VALUES ('Nova Pharmacy - Gachibowli', 'Cetrizine', 'Cipla Ltd', 10.00);
INSERT INTO Sells VALUES ('Nova Pharmacy - Gachibowli', 'Dolo 650', 'Dr Reddys', 15.00);
INSERT INTO Sells VALUES ('Nova Pharmacy - Gachibowli', 'Combiflam', 'Cipla Ltd', 18.50);
INSERT INTO Sells VALUES ('Nova Pharmacy - Gachibowli', 'Zincovit', 'Sun Pharma', 22.00);
INSERT INTO Sells VALUES ('Nova Pharmacy - Hitech City', 'Augmentin', 'Sun Pharma', 25.00);
INSERT INTO Sells VALUES ('Nova Pharmacy - Hitech City', 'Pantop', 'Dr Reddys', 11.00);
INSERT INTO Sells VALUES ('Nova Pharmacy - Hitech City', 'Aspirin', 'Cipla Ltd', 8.50);
INSERT INTO Sells VALUES ('Nova Pharmacy - Hitech City', 'Metformin', 'Sun Pharma', 14.00);
INSERT INTO Sells VALUES ('Nova Pharmacy - Hitech City', 'Crocin', 'Sun Pharma', 13.00);
INSERT INTO Sells VALUES ('Nova Pharmacy - Secunderabad', 'Meftal Spas', 'Dr Reddys', 17.50);
INSERT INTO Sells VALUES ('Nova Pharmacy - Secunderabad', 'Combiflam', 'Cipla Ltd', 19.00);
INSERT INTO Sells VALUES ('Nova Pharmacy - Secunderabad', 'Pantop', 'Dr Reddys', 10.00);
INSERT INTO Sells VALUES ('Nova Pharmacy - Secunderabad', 'Cetrizine', 'Cipla Ltd', 9.00);
INSERT INTO Sells VALUES ('Nova Pharmacy - Secunderabad', 'Metformin', 'Sun Pharma', 13.50);
-- call UPDATE_PHARMACY_DRUG_PRICE('Nova Pharmacy - Secunderabad', 'Metformin', 'Sun Pharma', 1000.50);