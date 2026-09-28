# Nova Pharmacy – Pharmacy Management Database

## 📌 Project Overview

**Nova Pharmacy** is a MySQL-based Pharmacy Management Database designed to manage and organize information related to doctors, patients, pharmaceutical companies, drugs, pharmacies, contracts, prescriptions, and pharmacy inventory.

The project uses a **relational database design** with primary keys, foreign keys, composite keys, constraints, and stored procedures to maintain data consistency and provide reusable operations for database management.

---

## 🎯 Objectives

- Manage doctor and patient information.
- Maintain pharmaceutical company and drug details.
- Manage multiple pharmacy branches and their inventory.
- Store pharmacy–pharmaceutical company contracts.
- Manage patient prescriptions and prescribed medicines.
- Track drug prices at different pharmacies.
- Provide reusable CRUD operations through stored procedures.
- Generate useful reports from the database.

---

## 🗃️ Database Structure

The database is named:

```sql
nova_pharmacy
```

### Main Entities

| Table | Purpose |
|---|---|
| `Doctor` | Stores doctor details, specialization and experience |
| `Patient` | Stores patient information and primary doctor |
| `PharmaCompany` | Stores pharmaceutical company information |
| `Drug` | Stores drugs, formulas and associated companies |
| `Pharmacy` | Stores pharmacy branch details |
| `Sells` | Maps pharmacies to drugs and stores their prices |
| `Contract` | Stores contracts between pharmacies and pharmaceutical companies |
| `Prescription` | Stores patient prescriptions issued by doctors |
| `PrescribedDrugs` | Stores drugs and quantities associated with prescriptions |

The database establishes relationships between these entities using foreign keys. For example, each patient can reference a primary doctor, while prescriptions reference both a patient and a doctor.

---

## 🔗 Database Relationships

The major relationships are:

```text
Doctor
  │
  └── Patient
        │
        └── Prescription
                │
                └── PrescribedDrugs
                         │
                         └── Drug
                              │
                              └── PharmaCompany

Pharmacy
  │
  ├── Sells ─── Drug
  │
  └── Contract ─── PharmaCompany
```

### Important Relationships

- A **Patient** has a primary **Doctor**.
- A **Prescription** belongs to a Patient and is issued by a Doctor.
- A **Prescription** can contain multiple drugs through `PrescribedDrugs`.
- A **Drug** belongs to a pharmaceutical company.
- A **Pharmacy** can sell multiple drugs.
- A **Pharmacy** can have contracts with pharmaceutical companies.

---

## ⚙️ Key Database Features

### 1. Primary & Foreign Keys

The project uses primary and foreign keys to maintain relationships and data integrity.

For example, `Drug` uses a composite primary key:

```sql
PRIMARY KEY (TradeName, CompanyName)
```

and references the pharmaceutical company through:

```sql
FOREIGN KEY (CompanyName)
REFERENCES PharmaCompany(Name)
ON DELETE CASCADE
```



---

### 2. Composite Keys

The `Sells` table uses a composite key:

```sql
PRIMARY KEY (PharmacyName, TradeName, CompanyName)
```

This allows the database to uniquely identify a particular drug sold by a particular pharmacy.

---

### 3. Stored Procedures

The project contains stored procedures for database operations instead of requiring raw SQL queries for every operation.

CRUD procedures are implemented for:

- Doctors
- Patients
- Pharmaceutical companies
- Drugs
- Pharmacies
- Contracts
- Prescriptions
- Prescribed drugs
- Pharmacy drug prices

For example:

```sql
CALL AddNewDoctor(...);
CALL UPDATE_DOCTOR(...);
CALL DELETE_DOCTOR(...);
```



---

## 📊 Reporting Procedures

The database also includes procedures for retrieving useful information.

### Prescription History

`GetPrescriptionsForPatientBetweenDates`

Retrieves prescriptions for a patient within a specified date range along with the corresponding doctor's name.

### Prescription Details

`GetPrescriptionDetails`

Retrieves the drugs and quantities associated with a patient's prescription.

### Drugs by Company

`GetDrugsByCompany`

Retrieves drugs manufactured by a particular pharmaceutical company.

### Pharmacy Stock

`GetStockAtPharmacy`

Retrieves drugs available at a pharmacy along with their prices.

### Patients of a Doctor

`GetPatientsForDoctor`

Retrieves patients assigned to a particular doctor.

---

## 🧪 Sample Data

The project includes sample data for testing the database.

The sample dataset contains:

- Doctors from different specialties
- Multiple patients
- Pharmaceutical companies
- Drugs and their formulas
- Multiple pharmacy branches
- Pharmacy-company contracts
- Patient prescriptions
- Prescribed drugs and quantities
- Pharmacy drug prices

For example, the sample data includes pharmaceutical companies such as **Sun Pharma, Cipla Ltd, and Dr Reddys**, along with multiple drugs and pharmacy branches.

---

## 🛠️ Technologies Used

- **MySQL**
- **SQL**
- Relational Database Management System (RDBMS)
- Stored Procedures
- Primary & Foreign Keys
- Composite Keys
- Constraints
- CRUD Operations

---

## 🚀 How to Run

### Prerequisites

Install:

- MySQL Server
- MySQL Workbench or another MySQL client

### Step 1 – Create the Database

Open MySQL Workbench and execute:

```sql
SOURCE Nova(Final).sql;
```

This creates the `nova_pharmacy` database and all required tables and stored procedures.

### Step 2 – Select the Database

```sql
USE nova_pharmacy;
```

### Step 3 – Insert Sample Data

Run:

```sql
SOURCE SampleData.sql;
```

The sample file uses the stored procedures to insert doctors, patients, pharmaceutical companies, drugs, pharmacies, contracts, prescriptions and prescribed drugs.

### Step 4 – Test the Database

Example:

```sql
CALL GetDrugsByCompany('Sun Pharma');
```

or:

```sql
CALL GetStockAtPharmacy('Nova Pharmacy - Gachibowli');
```

---

## 📁 Project Files

```text
Nova-Pharmacy/
│
├── Nova(Final).sql
├── SampleData.sql
└── README.md
```

### `Nova(Final).sql`

Contains:

- Database creation
- Table definitions
- Relationships
- Constraints
- Stored procedures
- Reporting procedures

### `SampleData.sql`

Contains sample records and procedure calls used to populate and test the database.

---

## 🔍 Example Operations

### Add a Doctor

```sql
CALL AddNewDoctor(
    '100000000010',
    'Dr. Example',
    'Cardiology',
    10
);
```

### Add a Patient

```sql
CALL AddNewPatient(
    '200000000010',
    'Example Patient',
    'Jaipur',
    25,
    '100000000010'
);
```

### Get Patient Prescriptions

```sql
CALL GetPrescriptionsForPatientBetweenDates(
    '200000000001',
    '2025-01-01',
    '2025-12-31'
);
```

### Get Pharmacy Stock

```sql
CALL GetStockAtPharmacy(
    'Nova Pharmacy - Gachibowli'
);
```

---

## 📌 Future Improvements

Possible extensions to the project include:

- User authentication and role-based access.
- Pharmacy inventory quantity tracking.
- Automatic low-stock alerts.
- Prescription validation.
- Billing and sales transaction management.
- Expiry-date tracking for medicines.
- Web-based frontend connected to the database.
- Database views and dashboards for analytics.

---

## 👨‍💻 Project Type

**Academic / Database Management System Project**

This project demonstrates practical implementation of relational database concepts, entity relationships, constraints, stored procedures, CRUD operations, and reporting queries using MySQL.
