# Risk_Management_Dashboard

This project demonstrates the process of aggregating and visualizing payment transaction data to monitor fraud activities. The workflow involves extracting real production data through SQL queries, modifying and processing the data in Python, and visualizing the results using a dashboard.

📘 Full project description is available [here](https://www.notion.so/Risk-Management-Dashboard-1e7ed80500f880bfbc6bf1d258c6aa8c?pvs=4).

## Workflow Overview

1. **Data Extraction (SQL)**:
   - SQL queries are used to extract raw transaction data from a database. 3 tables (Aydien, Checkout and Chargebacks&Refunds) with more than 12 million records).
   - Data includes transaction IDs, amounts, fraud labels, and other relevant features.
   - The first steps in processing and systematizing data have been taken
   - Queries were designed to filter out any sensitive data and maintain confidentiality.

2. **Data Modification (Python)**:
   - The extracted data is processed and modified in Python using libraries like Pandas and NumPy.
   - This includes cleaning, transforming, and generating synthetic fraud labels based on the data structure.
   - The processed data is used for further analysis and visualization.

3. **Fraud Analysis and Dashboard**:
   - The modified data is visualized in a **risk management dashboard**, which helps monitor fraud patterns, approval rates, chargebacks, and other key metrics.
   - A sample version of the dashboard can be viewed [here](https://public.tableau.com/views/RiskManagement_17461912652520/Summary?:language=en-GB&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link).

## Files in this Repository

- **`sql_queries.sql`**: SQL queries used to extract transaction data from the source database (without sensitive information).
- **`data_processing.py`**: Python code to process and modify the data, including synthetic data generation and transformation.
- **`requirements.txt`**: A list of required Python packages for the project.

  
