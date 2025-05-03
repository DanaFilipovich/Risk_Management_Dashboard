"""
generate_synthetic_data.py

This script modifies the exported transaction dataset to create a synthetic version
for demo purposes. It replaces sensitive values, generates randomized metrics,
and ensures anonymization of key fields.
"""

import pandas as pd
import numpy as np

# Load source CSV file (path can be changed as needed)
df = pd.read_csv('/content/transactions.csv')

# --- Step 1: Replace values in TRANSACTION_COUNT column ---
# Generate random number of transactions (10–300 per row)
df['TRANSACTION_COUNT'] = np.random.randint(10, 300, size=len(df))

# --- Step 2: Recalculate TOTAL_AMOUNT_USD based on TRANSACTION_COUNT ---
# Assume average transaction value between $5 and $150
df['TOTAL_AMOUNT_USD'] = df['TRANSACTION_COUNT'] * np.random.uniform(5, 150, size=len(df))

# --- Step 3: Replace some values in the PARTNER column ---
# Convert ~30% of 'Adyen' to 'Checkout' for variation
mask = (df['PARTNER'] == 'Adyen') & (np.random.rand(len(df)) < 0.3)
df.loc[mask, 'PARTNER'] = 'Checkout'

# --- Step 4: Randomize BIN values ---
# Generate random 6-digit BIN numbers
df['BIN'] = np.random.randint(100000, 999999, size=len(df))

# Save modified dataset to CSV
df.to_csv('updated_file.csv', index=False)

print("✅ Synthetic dataset saved as 'updated_file.csv'")
