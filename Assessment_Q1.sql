-- Identify high-value customers with at least one funded savings and one funded investment plan
-- Adds segmentation tiers based on total deposits in naira

SELECT 
    cu.id AS owner_id,
    CONCAT(cu.first_name, ' ', cu.last_name) AS name,

    -- Count of funded savings plans
    SUM(CASE 
        WHEN pp.is_regular_savings = 1 THEN 1 
        ELSE 0 
    END) AS savings_count,

    -- Count of funded investment plans
    SUM(CASE 
        WHEN pp.is_a_fund = 1 THEN 1 
        ELSE 0 
    END) AS investment_count,

    -- Total deposits in naira (converted from kobo)
    ROUND(SUM(sa.confirmed_amount) / 100, 2) AS total_deposits,

    -- Tier segmentation based on total deposits
    CASE 
        WHEN SUM(sa.confirmed_amount) / 100 >= 50000 THEN 'Gold'
        WHEN SUM(sa.confirmed_amount) / 100 >= 20000 THEN 'Silver'
        ELSE 'Bronze'
    END AS customer_tier

FROM users_customuser cu

-- Join to link customer savings accounts
JOIN savings_savingsaccount sa ON cu.id = sa.owner_id

-- Join to link associated plans
JOIN plans_plan pp ON sa.plan_id = pp.id

-- Only consider transactions with confirmed inflows
WHERE sa.confirmed_amount > 0

GROUP BY cu.id, cu.first_name, cu.last_name

-- Ensure customers have both at least one savings and one investment plan
HAVING 
    SUM(CASE WHEN pp.is_regular_savings = 1 THEN 1 ELSE 0 END) > 0
    AND 
    SUM(CASE WHEN pp.is_a_fund = 1 THEN 1 ELSE 0 END) > 0

ORDER BY total_deposits DESC;
