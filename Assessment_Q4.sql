-- Estimate Customer Lifetime Value (CLV) across savings accounts with business-focused insights

WITH user_tenure AS (
    -- Step 1: Calculate tenure in months since each customer's sign-up date
    SELECT 
        id AS customer_id,
        CONCAT(first_name, ' ', last_name) AS name,
        date_joined,
        TIMESTAMPDIFF(MONTH, date_joined, CURDATE()) AS tenure_months
    FROM users_customuser
),

transaction_stats AS (
    -- Step 2: Aggregate inflow transaction stats per customer
    SELECT 
        owner_id,
        COUNT(id) AS total_transactions,
        AVG(confirmed_amount) AS avg_transaction_value_kobo
    FROM savings_savingsaccount
    WHERE confirmed_amount > 0
    GROUP BY owner_id
),

clv_calc AS (
    -- Step 3: Calculate Estimated CLV using the provided formula
    SELECT 
        u.customer_id,
        u.name,
        u.tenure_months,
        t.total_transactions,
        ROUND(
            (t.total_transactions / NULLIF(u.tenure_months, 0)) * 12 * 
            (0.001 * t.avg_transaction_value_kobo / 100), 2
        ) AS estimated_clv_naira
    FROM user_tenure u
    JOIN transaction_stats t ON u.customer_id = t.owner_id
),

clv_segmented AS (
    -- Step 4: Add CLV tier labels for business segmentation
    SELECT *,
        CASE 
            WHEN estimated_clv_naira >= 500 THEN 'High Value'
            WHEN estimated_clv_naira BETWEEN 100 AND 499 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS clv_tier
    FROM clv_calc
)

-- Final Output: Prioritize high CLV customers
SELECT 
    customer_id,
    name,
    tenure_months,
    total_transactions,
    estimated_clv_naira,
    clv_tier
FROM clv_segmented
ORDER BY estimated_clv_naira DESC;
