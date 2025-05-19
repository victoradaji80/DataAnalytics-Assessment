-- ========================================
-- 👀 Business Use Case:
-- Identify active savings or investment accounts with no inflow in the past 365 days
-- to enable re-engagement, churn prevention, or inactivity risk flagging.
-- ========================================

WITH last_inflow_dates AS (
    -- Step 1: Get last inflow per plan (confirmed deposit only)
    SELECT
        s.owner_id,
        s.plan_id,
        MAX(s.transaction_date) AS last_transaction_date
    FROM savings_savingsaccount s
    WHERE s.confirmed_amount > 0
    GROUP BY s.owner_id, s.plan_id
),

inactive_accounts AS (
    -- Step 2: Filter accounts inactive for more than 365 days
    SELECT
        l.plan_id,
        l.owner_id,
        l.last_transaction_date,
        DATEDIFF(CURDATE(), l.last_transaction_date) AS inactivity_days
    FROM last_inflow_dates l
    WHERE DATEDIFF(CURDATE(), l.last_transaction_date) > 365
),

plan_types AS (
    -- Step 3: Attach plan type information
    SELECT 
        id AS plan_id,
        CASE 
            WHEN is_regular_savings = 1 THEN 'Savings'
            WHEN is_a_fund = 1 THEN 'Investment'
            ELSE 'Other'
        END AS plan_type
    FROM plans_plan
)

-- Step 4: Join inactive accounts with plan type and optionally customer names
SELECT
    ia.plan_id,
    ia.owner_id,
    CONCAT(u.first_name, ' ', u.last_name) AS customer_name,
    pt.plan_type AS type,
    DATE_FORMAT(ia.last_transaction_date, '%Y-%m-%d') AS last_transaction_date,
    ia.inactivity_days
FROM inactive_accounts ia
JOIN plan_types pt ON ia.plan_id = pt.plan_id
LEFT JOIN users_customuser u ON ia.owner_id = u.id
ORDER BY ia.inactivity_days DESC;
