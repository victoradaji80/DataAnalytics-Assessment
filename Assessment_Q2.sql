-- Transaction Frequency Analysis per customer per active month
-- Purpose: Segment customers by how often they transact to inform marketing and retention strategies

WITH monthly_transactions AS (
    -- Step 1: Count number of funded transactions per customer per calendar month
    SELECT 
        owner_id,
        DATE_FORMAT(transaction_date, '%Y-%m') AS txn_month,
        COUNT(*) AS txn_count
    FROM savings_savingsaccount
    WHERE confirmed_amount > 0
    GROUP BY owner_id, txn_month
),

customer_avg_txns AS (
    -- Step 2: Calculate average transactions per active month for each customer
    SELECT 
        owner_id,
        AVG(txn_count) AS avg_txn_per_month,
        COUNT(DISTINCT txn_month) AS active_months
    FROM monthly_transactions
    GROUP BY owner_id
),

frequency_labels AS (
    -- Step 3: Categorize customers based on their average transaction frequency
    SELECT 
        owner_id,
        CASE
            WHEN ROUND(avg_txn_per_month, 2) >= 10 THEN 'High Frequency'
            WHEN avg_txn_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category,
        avg_txn_per_month,
        active_months
    FROM customer_avg_txns
),

summary AS (
    -- Step 4: Aggregate total customers and average transactions by frequency category
    SELECT 
        frequency_category,
        COUNT(*) AS customer_count,
        ROUND(AVG(avg_txn_per_month), 1) AS avg_transactions_per_month,
        ROUND(AVG(active_months), 1) AS avg_active_months
    FROM frequency_labels
    GROUP BY frequency_category
)

-- Final output ordered by business priority: High > Medium > Low frequency
SELECT 
    frequency_category,
    customer_count,
    avg_transactions_per_month,
    avg_active_months
FROM summary
ORDER BY 
    CASE frequency_category
        WHEN 'High Frequency' THEN 1
        WHEN 'Medium Frequency' THEN 2
        WHEN 'Low Frequency' THEN 3
    END;
