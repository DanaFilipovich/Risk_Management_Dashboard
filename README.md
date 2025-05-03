# 🛡️ Risk Management Dashboard

This project demonstrates the process of aggregating and visualizing payment transaction data to monitor fraud activities. The workflow includes extracting real production data through SQL queries, modifying and processing the data in Python, and visualizing the results using a dashboard.

📘 **Full project description is available [here](https://www.notion.so/Risk-Management-Dashboard-1e7ed80500f880bfbc6bf1d258c6aa8c?pvs=4).**

---

## 📊 Workflow Overview

### 1. Data Extraction (SQL)
- SQL queries are used to extract raw transaction data from Snowflake.
- Data was retrieved from **3 large tables** (Adyen, Checkout, Chargebacks & Refunds), each containing **12M+ records** since 2022.
- Queries include information such as transaction IDs, amounts, fraud labels, BINs, currencies, and user behavior signals.
- Data was filtered and structured daily.
- Sensitive table and field names were removed for this version.

### 2. Data Modification (Python)
- Extracted data is processed using **Pandas** and **NumPy**.
- Includes value transformations, synthetic fraud label generation, and randomization for safe public sharing.
- Data was simplified to focus on 6 countries, 6 currencies, and data starting from 2024 to make demonstration easier.

### 3. Fraud Analysis & Dashboard
- Final dataset is visualized in a **Tableau Public** dashboard.
- Metrics include fraud rates, blocked transaction volume, approval rates, chargebacks, refunds, and more.
- Filtering added to explore attack behavior separately and analyze trends without fraud impact.

🔗 **[View the dashboard](https://public.tableau.com/views/RiskManagement_17461912652520/Summary)**

---

## 📁 Files in this Repository

- `sql_queries.sql`: SQL queries used for extracting and aggregating transaction data.
- `data_processing.py`: Python script for data transformation and synthetic dataset generation.
- `requirements.txt`: List of required Python libraries.

---

💡 _This project automates what was previously done manually in Excel, helping scale fraud monitoring and reduce operational workload._
  
