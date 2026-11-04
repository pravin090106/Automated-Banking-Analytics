# Automated Banking Data Analytics and Reporting System

## Project Overview

The **Automated Banking Data Analytics and Reporting System** is a data analytics project developed using Python and MySQL.

The project extracts banking data from a MySQL database, performs data cleaning and transformation using Pandas, integrates related tables, and generates visual reports using Matplotlib.

The reporting process is automated to generate updated reports daily.

## Technologies Used

- **Python** – Data processing and automation
- **MySQL** – Database storage and management
- **Pandas** – Data cleaning, transformation, and analysis
- **Matplotlib** – Data visualization and report generation
- **Schedule** – Automating daily report generation

## Database Tables

The project uses five main tables:

1. Branches
2. Customers
3. Accounts
4. Transactions
5. Loans

## Project Workflow

1. Create and store banking data in MySQL.
2. Connect Python with the MySQL database.
3. Extract data from the database using Pandas.
4. Perform data cleaning and transformation.
5. Merge related banking tables for analysis.
6. Generate visual reports using Matplotlib.
7. Schedule the reporting process to run daily.

## Data Cleaning and Transformation

The following operations are performed:

- Check missing values and duplicate records.
- Remove duplicate records.
- Convert date columns into datetime format.
- Calculate customer age.
- Create customer age groups.
- Categorize account balances.
- Categorize transaction amounts.
- Categorize loan amounts.

## Data Visualizations

The project generates four major reports:

### 1. Daily Transaction Trend
Displays daily transaction amounts to identify transaction patterns over time.

### 2. Transaction Amount by Type
Shows the total transaction amount for each transaction type.

### 3. Transactions by Mode
Displays the percentage distribution of transactions across different payment modes.

### 4. Top 5 Customers by Transaction Amount
Identifies the top five customers based on their total transaction amount.

## Automation

The Python Schedule library is used to automate the reporting process.

The program generates reports immediately when executed and then runs the scheduled job daily at the configured time.

Generated charts are saved as PNG files in the `bank_charts` folder.

## Project Folder Structure

```text
Automated-Banking-Analytics/
│
├── README.md
│
├── SQL/
│   └── banking_database.sql
│
├── Python/
│   └── banking_analytics.py
│
└── bank_charts/
    └── Generated Reports
```

## Installation and Execution

### Step 1: Install Python Libraries

```bash
pip install mysql-connector-python pandas matplotlib schedule
```

### Step 2: Create the MySQL Database

1. Open MySQL.
2. Execute the SQL file.
3. Create the `banking_db` database and its tables.

### Step 3: Configure Database Connection

Update the MySQL connection details in the Python file using your local database credentials.

**Do not upload your actual database password to GitHub.**

### Step 4: Run the Python Program

```bash
python banking_analytics.py
```

### Step 5: View Generated Reports

After execution, check the `bank_charts` folder for the generated PNG reports.

## Project Outcome

- Automated banking data extraction from MySQL.
- Improved data quality through cleaning and transformation.
- Integrated related banking information for analysis.
- Generated four visual reports.
- Automated daily report generation.

## Author

**Pravin R**

**GitHub:** [https://github.com/pravin090106](https://github.com/pravin090106)

**Project Repository:** [Automated-Banking-Analytics](https://github.com/pravin090106/Automated-Banking-Analytics)
