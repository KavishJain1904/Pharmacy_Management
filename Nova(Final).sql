DROP DATABASE IF EXISTS nova_pharmacy;
CREATE DATABASE nova_pharmacy;
USE nova_pharmacy;

-- =TABLES=
-- each patient has a primary physician
-- each pharmacy sells at least 10 drugs

CREATE TABLE Doctor (
    AadharID CHAR(12) PRIMARY KEY,
    Name VARCHAR(100),
    Specialty VARCHAR(100),
    YearsExperience INT
);

CREATE TABLE Patient (
    AadharID CHAR(12) PRIMARY KEY,
    Name VARCHAR(100),
    Address TEXT,
    Age INT,
    PrimaryDoctor CHAR(12),
    FOREIGN KEY (PrimaryDoctor) REFERENCES Doctor(AadharID)
);

CREATE TABLE PharmaCompany (
    Name VARCHAR(100) PRIMARY KEY,
    Phone VARCHAR(15)
);

CREATE TABLE Drug (
    TradeName VARCHAR(100),
    Formula TEXT,
    CompanyName VARCHAR(100),
    PRIMARY KEY (TradeName, CompanyName),
    FOREIGN KEY (CompanyName) REFERENCES PharmaCompany(Name) ON DELETE CASCADE
);

CREATE TABLE Pharmacy (
    Name VARCHAR(100) PRIMARY KEY,
    Address TEXT,
    Phone VARCHAR(15)
);

CREATE TABLE Sells (
    PharmacyName VARCHAR(100),
    TradeName VARCHAR(100),
    CompanyName VARCHAR(100),
    Price DECIMAL(10,2),
    PRIMARY KEY (PharmacyName, TradeName, CompanyName),
    FOREIGN KEY (PharmacyName) REFERENCES Pharmacy(Name),
    FOREIGN KEY (TradeName, CompanyName) REFERENCES Drug(TradeName, CompanyName)
);

CREATE TABLE Contract (
    ContractID INT AUTO_INCREMENT PRIMARY KEY,
    PharmaName VARCHAR(100),
    PharmacyName VARCHAR(100),
    StartDate DATE,
    EndDate DATE,
    Content TEXT,
    Supervisor VARCHAR(100),
    FOREIGN KEY (PharmaName) REFERENCES PharmaCompany(Name),
    FOREIGN KEY (PharmacyName) REFERENCES Pharmacy(Name)
);

CREATE TABLE Prescription (
    PrescriptionID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID CHAR(12),
    DoctorID CHAR(12),
    PrescDate DATE,
    UNIQUE(PatientID, DoctorID, PrescDate),
    FOREIGN KEY (PatientID) REFERENCES Patient(AadharID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(AadharID)
);

CREATE TABLE PrescribedDrugs (
    PrescriptionID INT,
    TradeName VARCHAR(100),
    CompanyName VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (PrescriptionID, TradeName, CompanyName),
    FOREIGN KEY (PrescriptionID) REFERENCES Prescription(PrescriptionID),
    FOREIGN KEY (TradeName, CompanyName) REFERENCES Drug(TradeName, CompanyName)
);

-- PROCEDURES 

-- trying to handle "If a doctor gives more than one prescription to a single patient, latest one need to be stored" uncomment later

-- DELIMITER //

-- CREATE TRIGGER ReplaceOldPrescription
-- BEFORE INSERT ON Prescription
-- FOR EACH ROW
-- BEGIN
  -- DELETE FROM Prescription
  -- WHERE PatientID = NEW.PatientID
    -- AND DoctorID = NEW.DoctorID;
-- END;
-- //

-- DELIMITER ;


DELIMITER $$

-- DOCTOR

CREATE PROCEDURE AddNewDoctor (IN did CHAR(12), IN dname VARCHAR(100), IN spec VARCHAR(100), IN exp INT)
BEGIN
    INSERT INTO Doctor VALUES (did, dname, spec, exp);
END $$

CREATE PROCEDURE UPDATE_DOCTOR(
    IN d_aadhar_id CHAR(12),
    IN d_name VARCHAR(100),
    IN d_specialty VARCHAR(100),
    IN d_experience INT
)
BEGIN
    UPDATE Doctor
    SET Name = d_name, Specialty = d_specialty, YearsExperience = d_experience
    WHERE AadharID = d_aadhar_id;
END$$

CREATE PROCEDURE DELETE_DOCTOR(
    IN d_aadhar_id CHAR(12)
)
BEGIN
    DELETE FROM Doctor WHERE AadharID = d_aadhar_id;
END$$

-- PATIENT

CREATE PROCEDURE AddNewPatient (IN pid CHAR(12), IN pname VARCHAR(100), IN paddr TEXT, IN page INT, IN docid CHAR(12))
BEGIN
    INSERT INTO Patient VALUES (pid, pname, paddr, page, docid);
END $$

CREATE PROCEDURE UPDATE_PATIENT(
    IN p_aadhar_id VARCHAR(20),
    IN p_name VARCHAR(100),
    IN p_address VARCHAR(255),
    IN p_age INT,
    IN p_PrimaryDoctor CHAR(12)
)
BEGIN
    UPDATE Patient
    SET Name = p_name, Address = p_address, Age = p_age, PrimaryDoctor = p_PrimaryDoctor
    WHERE AadharID = p_aadhar_id;
END$$

CREATE PROCEDURE DELETE_PATIENT(
    IN p_aadhar_id VARCHAR(20)
)
BEGIN
    DELETE FROM Patient WHERE AadharID = p_aadhar_id;
END$$

-- PHARMA

CREATE PROCEDURE AddNewPharma (IN name VARCHAR(100), IN phone VARCHAR(15))
BEGIN
    INSERT INTO PharmaCompany VALUES (name, phone);
END $$

CREATE PROCEDURE UPDATE_PHARMA_COMPANY(
    IN c_name VARCHAR(100),
    IN c_phone VARCHAR(20)
)
BEGIN
    UPDATE PharmaCompany
    SET Phone = c_phone
    WHERE Name = c_name;
END$$

CREATE PROCEDURE DELETE_PHARMA_COMPANY(
    IN c_name VARCHAR(100)
)
BEGIN
    DELETE FROM PharmaCompany WHERE Name = c_name;
END$$

-- Drugs

CREATE PROCEDURE AddNewDrug (IN tradename VARCHAR(100), IN formula TEXT, IN company VARCHAR(100))
BEGIN
    INSERT INTO Drug VALUES (tradename, formula, company);
END $$

CREATE PROCEDURE UPDATE_DRUG(
    IN d_trade_name VARCHAR(100),
    IN d_formula TEXT,
    IN d_company_name VARCHAR(100)
)
BEGIN
    UPDATE Drug
    SET Formula = d_formula
    WHERE TradeName = d_trade_name AND CompanyName = d_company_name;
END$$

CREATE PROCEDURE DELETE_DRUG(
    IN d_trade_name VARCHAR(100),
    IN d_company_name VARCHAR(100)
)
BEGIN
    DELETE FROM Drug
    WHERE TradeName = d_trade_name AND CompanyName = d_company_name;
END$$

-- Pharmacy

CREATE PROCEDURE AddNewPharmacy (IN pname VARCHAR(100), IN paddr TEXT, IN pphone VARCHAR(15))
BEGIN
    INSERT INTO Pharmacy VALUES (pname, paddr, pphone);
END $$

CREATE PROCEDURE UPDATE_PHARMACY(
    IN p_name VARCHAR(100),
    IN p_address VARCHAR(255),
    IN p_phone VARCHAR(20)
)
BEGIN
    UPDATE Pharmacy
    SET Address = p_address, Phone = p_phone
    WHERE Name = p_name;
END$$

CREATE PROCEDURE DELETE_PHARMACY(
    IN p_name VARCHAR(100)
)
BEGIN
    DELETE FROM Pharmacy WHERE Name = p_name;
END$$

-- Contract

CREATE PROCEDURE AddNewContract (IN pharma VARCHAR(100), IN pharmacy VARCHAR(100), IN sdate DATE, IN edate DATE, IN content TEXT, IN supervisor VARCHAR(100))
BEGIN
    INSERT INTO Contract (PharmaName, PharmacyName, StartDate, EndDate, Content, Supervisor)
    VALUES (pharma, pharmacy, sdate, edate, content, supervisor);
END $$

CREATE PROCEDURE UPDATE_CONTRACT(
    IN p_contractID INT,
    IN p_pharmacy_name VARCHAR(100),
    IN p_company_name VARCHAR(100),
    IN p_start_date DATE,
    IN p_end_date DATE,
    IN p_content TEXT,
    IN p_supervisor VARCHAR(100)
)
BEGIN
    UPDATE Contract
    SET EndDate = p_end_date, Content = p_content, Supervisor = p_supervisor, StartDate = p_start_date, PharmacyName = p_pharmacy_name, PharmaName = p_company_name
    WHERE p_contractID = ContractID;
END$$

CREATE PROCEDURE DELETE_CONTRACT(
    IN p_contractID INT
)
BEGIN
    DELETE FROM Contract
    WHERE p_contractID = ContractID;
END$$

-- Prescription

CREATE PROCEDURE AddNewPrescription (IN pid CHAR(12), IN did CHAR(12), IN prescDate DATE)
BEGIN
    INSERT INTO Prescription (PatientID, DoctorID, PrescDate)
    VALUES (pid, did, prescDate);
END $$

CREATE PROCEDURE UpdatePrescription (IN prescID INT, IN pid CHAR(12), IN did CHAR(12), IN prescDated DATE)
BEGIN
    UPDATE Prescription
    SET PatientID = pid, DoctorID = did, PrescDate = prescDated
    WHERE prescID = PrescriptionID;
END $$

CREATE PROCEDURE DELETE_PRESCRIPTION(
    IN d_aadhar_id VARCHAR(20),
    IN p_aadhar_id VARCHAR(20),
    IN presc_date DATE
)
BEGIN
    DELETE FROM Prescription
    WHERE DoctorID = d_aadhar_id AND PatientID = p_aadhar_id AND PrescDate = presc_date;
END$$

-- PrescribedDrug

CREATE PROCEDURE AddPrescribedDrug (IN prescID INT, IN tradename VARCHAR(100), IN company VARCHAR(100), IN qty INT)
BEGIN
    INSERT INTO PrescribedDrugs (PrescriptionID, TradeName, CompanyName, Quantity)
    VALUES (prescID, tradename, company, qty);
END $$
 
CREATE PROCEDURE UPDATE_QUANTITY(IN prescID INT, IN tradenamed VARCHAR(100), IN company VARCHAR(100), IN qty INT)
BEGIN 
	UPDATE PrescribedDrugs
    SET Quantity = qty
    WHERE PrescriptionID = prescID AND tradenamed = TradeName AND CompanyName = company;
END$$

CREATE PROCEDURE DELETE_PRESC_DRUG(IN prescID INT, IN tradenamed VARCHAR(100), IN company VARCHAR(100))
BEGIN 
	DELETE FROM PrescribedDrugs
    WHERE PrescriptionID = prescID AND tradenamed = TradeName AND CompanyName = company;
END$$

-- Updation and Deletion for Sells

CREATE PROCEDURE UPDATE_PHARMACY_DRUG_PRICE(
    IN p_pharmacy_name VARCHAR(100),
    IN p_trade_name VARCHAR(100),
    IN p_company_name VARCHAR(100),
    IN p_price DECIMAL(10,2)
)
BEGIN
    UPDATE Sells
    SET Price = p_price
    WHERE PharmacyName = p_pharmacy_name AND TradeName = p_trade_name AND CompanyName = p_company_name;
END$$

CREATE PROCEDURE DELETE_PHARMACY_DRUG(
    IN p_pharmacy_name VARCHAR(100),
    IN p_trade_name VARCHAR(100),
    IN p_company_name VARCHAR(100)
)
BEGIN
    DELETE FROM Pharmacy_Drug
    WHERE PharmacyName = p_pharmacy_name AND TradeName = p_trade_name AND CompanyName = p_company_name;
END$$

-- STORED PROCEDURES (Reports)

CREATE PROCEDURE GetPrescriptionsForPatientBetweenDates (
    IN patientID CHAR(12), IN startDate DATE, IN endDate DATE)
BEGIN
    SELECT 
        p.PrescriptionID, p.DoctorID, d.Name AS DoctorName, p.PrescDate
    FROM 
        Prescription p JOIN Doctor d ON p.DoctorID = d.AadharID
    WHERE 
        p.PatientID = patientID AND p.PrescDate BETWEEN startDate AND endDate
    ORDER BY 
        p.PrescDate DESC;
END $$

CREATE PROCEDURE GetPrescriptionDetails (
    IN patientID CHAR(12), IN prescDate DATE)
BEGIN
    SELECT 
        pd.PrescriptionID, pd.TradeName, pd.CompanyName, pd.Quantity
    FROM 
        Prescription p JOIN PrescribedDrugs pd ON p.PrescriptionID = pd.PrescriptionID
    WHERE 
        p.PatientID = patientID AND p.PrescDate = prescDate;
END $$

CREATE PROCEDURE GetDrugsByCompany (
    IN companyName VARCHAR(100))
BEGIN
    SELECT 
        d.TradeName, d.Formula
    FROM 
        Drug d
    WHERE 
        d.CompanyName = companyName;
END $$

CREATE PROCEDURE GetStockAtPharmacy (
    IN pharmacyName VARCHAR(100))
BEGIN
    SELECT 
        s.TradeName, s.CompanyName, s.Price
    FROM 
        Sells s
    WHERE 
        s.PharmacyName = pharmacyName;
END $$

-- is it contact or contract?

CREATE PROCEDURE GetPharmaContractForPharmacy (
    IN pharmacyName VARCHAR(100), IN pharmaName VARCHAR(100))
BEGIN
    SELECT 
	    c.ContractID, c.StartDate, c.EndDate, c.Content, c.Supervisor
    FROM 
        Contract c 
    WHERE 
        c.PharmacyName = pharmacyName AND c.PharmaName=pharmaName;
END $$

CREATE PROCEDURE GetPharmaContactForPharmacy (
    IN pharmacyName VARCHAR(100))
BEGIN
    SELECT 
        pc.Name AS PharmaCompany, pc.Phone, c.Supervisor
    FROM 
        Contract c JOIN PharmaCompany pc ON c.PharmaName = pc.Name
    WHERE 
        c.PharmacyName = pharmacyName;
END $$

CREATE PROCEDURE GetPatientsForDoctor (
    IN doctorID CHAR(12))
BEGIN
    SELECT 
        p.AadharID, p.Name, p.Address, p.Age
    FROM 
        Patient p
    WHERE 
        p.PrimaryDoctor = doctorID;
END $$

DELIMITER ;