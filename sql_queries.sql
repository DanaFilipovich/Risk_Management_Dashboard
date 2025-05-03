-- SQL Query to extract monthly transaction data for fraud analysis

WITH monthly_data AS (
    SELECT 
        -- Truncate creation date to the start of the month
        date_trunc('month', to_date(creation_date)) AS month_date,  
        
        -- Count of transactions
        COUNT(*) AS transaction_count,
        
        -- Total amount of transactions in USD
        SUM(amount / usd_rate) AS total_amount_usd, 
        
        -- Currency, issuer country, and shopper country
        currency, 
        issuer_country, 
        shopper_country, 
        
        -- Categorize acquirer response into new categories
        CASE 
            WHEN acquirer_response = 'FRAUD' THEN 'FRAUD'
            WHEN acquirer_response = 'APPROVED' THEN 'APPROVED'
            ELSE 'REFUSED_BY_ISSUER'
        END AS acquirer_response_new, 
        
        -- Blocked scenario based on risk scoring
        CASE
            WHEN acquirer_response = 'FRAUD' AND risk_scoring < 100 THEN 'Unblocked'
            WHEN acquirer_response = 'FRAUD' AND risk_scoring BETWEEN 100 AND 299 THEN 'Risk optimization'
            WHEN acquirer_response = 'FRAUD' AND risk_scoring BETWEEN 300 AND 499 THEN 'Excessive retries'
            WHEN acquirer_response = 'FRAUD' AND risk_scoring >= 500 THEN 'Compliance'  
        END AS Blocked_scenario, 
        
        -- Payment method and response
        payment_method AS scheme, 
        acquirer_response AS blocked_by_risk, 
        
        -- Categorize payment method into shop type
        CASE
            WHEN payment_method = 'igp_credit_card_adyen' THEN 'IGP'
            WHEN payment_method IS NULL THEN 'Not stated'
            ELSE 'WEB'
        END AS shop, 
        
        -- BIN (Issuer ID) information
        issuer_id AS bin, 
        
        -- User interaction (card scenario)
        user_interaction AS card_scenario, 
        
        -- Identify attack scenarios based on shopper email
        CASE 
            WHEN shopper_email LIKE 'attacsemail' THEN 'Attack'
            ELSE 'Not attacks'
        END AS Attack
    FROM report 
    LEFT JOIN rates 
        -- Join with rates table on the creation date, currency, and region code
        ON report.creation_date = rates.DT 
        AND report.currency = rates.currency 
        AND rates.realm_code = 'EU'
    
    -- Group data by month and other relevant attributes
    GROUP BY
        date_trunc('month', to_date(creation_date)),   
        currency, 
        issuer_country, 
        shopper_country, 
        acquirer_response, 
        risk_scoring, 
        payment_method, 
        acquirer_response, 
        payment_method, 
        issuer_id, 
        user_interaction, 
        shopper_email
)

-- Final selection of the relevant data
SELECT 
    partner,
    month_date,
    transaction_count,
    total_amount_usd,
    currency,
    issuer_country,
    shopper_country,
    acquirer_response_new,
    Blocked_scenario,
    scheme,
    blocked_by_risk,
    shop,
    bin,
    card_scenario,
    attack
FROM 
    monthly_data
WHERE 
    -- Filter for selected currencies, countries, and payment methods
    currency IN ('USD', 'EUR', 'GBP', 'JPY', 'AUD', 'CAD') 
    AND issuer_country IN ('US', 'DE', 'FR', 'GB', 'IT', 'ES') 
    AND shopper_country IN ('US', 'DE', 'FR', 'GB', 'IT', 'ES') 
    AND scheme IN ('visa', 'mc', 'alipay', 'amex', 'bcmc') 
    AND month_date >= '2024-01-01' -- Filter for transactions after January 2024
ORDER BY 
    month_date; -- Sort results by month
