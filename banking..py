import mysql.connector
import pandas as pd
import matplotlib.pyplot as plt
import os
from datetime import datetime

# 1.my sql to pyhton
def fetch_data():
    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password="root123",
        database="banking_db"
    )
    branches_df = pd.read_sql("select * from branches", conn)
    customers_df = pd.read_sql("select * from customers", conn)
    accounts_df = pd.read_sql("select * from accounts", conn)
    transactions_df = pd.read_sql("select * from transactions", conn)
    loans_df = pd.read_sql("select * from loans", conn)

    conn.close()
    #data transformation
# 1.BRANCHES TABLE
    print(branches_df.head())
    print(branches_df.shape)
    print(branches_df.info())
    print(branches_df.describe())
    print(branches_df.isnull().sum())
    branches_df = branches_df.drop_duplicates()

# 2.CUSTOMERS TABLE
    customers_df['date_of_birth'] = pd.to_datetime(
        customers_df['date_of_birth'], errors='coerce'
    )

    customers_df['registration_date'] = pd.to_datetime(
        customers_df['registration_date'], errors='coerce'
    )

    print(customers_df.head())
    print(customers_df.shape)
    print(customers_df.info())
    print(customers_df.describe())
    print(customers_df.isnull().sum())
    customers_df = customers_df.drop_duplicates()
    print(customers_df['customer_id'].duplicated().sum())

# enrichment
    customers_df['customer_type'] = 'Regular'

    today = pd.Timestamp.today().normalize()

    customers_df['date_of_birth'] = pd.to_datetime(
        customers_df['date_of_birth'], errors='coerce')

    customers_df['age'] = (today - customers_df['date_of_birth'] ).dt.days // 365

    customers_df['age_group'] = customers_df['age'].apply(
        lambda age: 'Young' if age >= 25 else 'Adult'
    )
    print(customers_df.head())

# 3.ACCOUNTS TABLE
    print(accounts_df.head())
    print(accounts_df.shape)
    print(accounts_df.info())
    print(accounts_df.describe())
    print(accounts_df.isnull().sum())
    accounts_df = accounts_df.drop_duplicates()
    accounts_df['opening_date'] = pd.to_datetime(
        accounts_df['opening_date'], errors='coerce'
    )

# enrichment
    accounts_df['min_bal'] = accounts_df['balance']
    accounts_df['highest'] = accounts_df['min_bal'].apply(
    lambda lowest: 'low' if lowest <= 500000 else 'super'
)
    print(accounts_df.head())

# 4.TRANSACTIONS TABLE
    print(transactions_df.head())
    print(transactions_df.shape)
    print(transactions_df.info())
    print(transactions_df.describe())
    print(transactions_df.isnull().sum())
    transactions_df = transactions_df.drop_duplicates()
    transactions_df['transaction_date'] = pd.to_datetime(
        transactions_df['transaction_date'], errors='coerce'
    )
# enrichment
    transactions_df['high_amt'] = transactions_df['amount']

    transactions_df['highest'] = transactions_df['high_amt'].apply(
        lambda amount: 'low' if amount <= 45000 else 'super'
    )
    print(transactions_df.head())

# 5.LOANS TABLE
    print(loans_df.head())
    print(loans_df.shape)
    print(loans_df.info())
    print(loans_df.describe())
    print(loans_df.isnull().sum())
    loans_df = loans_df.drop_duplicates()
    loans_df['loan_date'] = pd.to_datetime(
        loans_df['loan_date'], errors='coerce'
    )
# enrichment
    loans_df['total_amount'] = loans_df['loan_amount']

    loans_df['highest'] = loans_df['total_amount'].apply(
        lambda loan_amount: 'low' if loan_amount <= 550000 else 'super'
    )
    print(loans_df.head())


    return branches_df, customers_df, accounts_df, transactions_df, loans_df

    # stored in fetch_data
branches_df, customers_df, accounts_df, transactions_df, loans_df = fetch_data()

    # Display the data
print("branches data")
print(branches_df)

print("\ncustomers data")
print(customers_df)

print("\naccounts data")
print(accounts_df)

print("\ntransactions data")
print(transactions_df)

print("\nloans data")
print(loans_df)

fetch_data()


# 2. CREATE CHARTS

def create_charts(df):

    folder = "bank_charts"
    os.makedirs(folder, exist_ok=True)

    today = datetime.now().strftime("%Y%m%d")

    # Convert transaction_date into datetime format
    df["transaction_date"] = pd.to_datetime(
        df["transaction_date"], errors="coerce"
    )

    # 1. Daily Transaction Trend
    daily = (
        df.groupby("transaction_date")["amount"].sum()
        .reset_index()
        .sort_values("transaction_date")
    )

    plt.figure(figsize=(8, 5))
    plt.plot(
        daily["transaction_date"],
        daily["amount"],
        marker="o"
    )
    plt.title("Daily Transaction Trend")
    plt.xlabel("Transaction Date")
    plt.ylabel("Total Transaction Amount (₹)")
    plt.xticks(rotation=45)
    plt.tight_layout()

    plt.savefig(os.path.join(folder, f"daily_transaction_{today}.png"))
    plt.close()
    print("Chart 1 saved: Daily Transactions")

    # 2. Transaction Amount by Type
    type_amount = (
        df.groupby("transaction_type")["amount"]
        .sum()
        .reset_index()
    )

    plt.figure(figsize=(7, 5))
    plt.bar(
        type_amount["transaction_type"],
        type_amount["amount"],
        color="green"
    )
    plt.title("Transaction Amount by Type")
    plt.xlabel("Transaction Type")
    plt.ylabel("Total Transaction Amount (₹)")
    plt.tight_layout()

    plt.savefig(os.path.join(folder, f"transaction_type_{today}.png"))
    plt.close()
    print("Chart 2 saved: Transaction Type")

    # 3. Transactions by Mode
    mode_count = (
        df.groupby("transaction_mode")["transaction_id"]
        .count()
        .reset_index()
    )

    plt.figure(figsize=(7, 5))
    plt.pie(
        mode_count["transaction_id"],
        labels=mode_count["transaction_mode"],
        autopct="%1.1f%%",
        startangle=90
    )
    plt.title("Transactions by Mode")
    plt.tight_layout()

    plt.savefig(os.path.join(folder, f"transaction_mode_{today}.png"))
    plt.close()
    print("Chart 3 saved: Transaction Mode")

    # 4. Top 5 Customers by Transaction Amount
    top_5 = (
        df.groupby("customer_name")["amount"]
        .sum()
        .reset_index()
        .sort_values(by="amount", ascending=False)
        .head(5)
    )

    plt.figure(figsize=(9, 5))
    plt.bar(
        top_5["customer_name"],
        top_5["amount"],
        color="orange"
    )
    plt.title("Top 5 Customers by Transaction Amount")
    plt.xlabel("Customer Name")
    plt.ylabel("Total Transaction Amount (₹)")
    plt.xticks(rotation=30, ha="right")
    plt.tight_layout()

    plt.savefig(os.path.join(folder, f"top_5_customers_{today}.png"))
    plt.close()
    print("Chart 4 saved: Top 5 Customers")

    print("All 4 charts generated and saved in bank_charts folder")


# Fetch all five DataFrames
branches_df, customers_df, accounts_df, transactions_df, loans_df = fetch_data()

# Merge all five DataFrames
data = (
    transactions_df
    .merge(accounts_df, on="account_id", how="left")
    .merge(customers_df, on="customer_id", how="left")
    .merge(branches_df, on="branch_id", how="left")
    .merge(loans_df, on="customer_id", how="left", suffixes=("", "_loan"))
)

# Display the combined data

print("Combined DataFrame:")
print(data.head())

print("\nColumns:")
print(data.columns)

print("\nShape:")
print(data.shape)

create_charts(data)




# 3. SCHEDULE

import schedule
import time

def run_job():
    print("Banking analytics job started.")

    branches_df, customers_df, accounts_df, transactions_df, loans_df = fetch_data()

    data = (
        transactions_df
        .merge(accounts_df, on="account_id", how="left")
        .merge(customers_df, on="customer_id", how="left")
        .merge(branches_df, on="branch_id", how="left")
    )

    create_charts(data)

    print("Banking analytics job completed.")

# Run once immediately
run_job()

# Schedule daily at 9:00 AM
schedule.every().day.at("15:04").do(run_job)

print("Automatic schedule started: Daily at 3:04 PM.")

while True:
    schedule.run_pending()
    time.sleep(1)
