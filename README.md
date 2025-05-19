# DataAnalytics-Assessment
Accurate, complete, efficient and readable SQL solutions for Cowrywise data analytics assessment, including insights and business recommendations.
🧠 Cowrywise User Behavior & Value Analytics
This project analyzes transactional and behavioral data from Cowrywise, a digital savings and investment platform. The dataset spans four key tables that illuminate user engagement, financial behavior, and product performance.

📊 Data Model Overview
👤 users_customuser
Each row is a unique user with:

Demographics (age, income, etc.)

Financial profile (salary range, risk appetite)

Metadata (signup source, device type)

Use Cases: Segmentation, fraud detection, targeted campaigns

💼 plans_plan
Represents a user's savings or investment plan:

Engagement: start date, status, and next charge

Product type: flags for fixed/investment, savings, and currency

Goal metrics: goal amount, achievement status

Revenue indicators: interest rates, Cowrywise earnings

💰 savings_savingsaccount
Logs daily saving attempts:

Transactions: amount, status, confirmation

Returns: maturity dates, book returns

Costs: payment channel, fee tracking

💸 withdrawals_withdrawal
Captures fund withdrawals:

Flow & Fees: amount withdrawn, fee, channel

Ops & Compliance: response status, withdrawal intent

🔗 How It All Connects
A user → creates plans

Plans → attract savings and withdrawals

Relationships via: owner_id, plan_id, created_on

Supports: churn analysis, goal tracking, revenue modeling, segmentation

❓ Question 1: High-Value Customer Segmentation
🧩 Approach
Filtered users with both confirmed savings and investment plans

Aggregated total confirmed deposits

Segmented into tiers:

Gold: ₦50,000+

Silver: ₦20,000–₦49,999

Bronze: < ₦20,000

📈 Why It Matters
Cross-sell: Financially active users are ideal for premium offers

Personalized Marketing: Target each tier differently

Revenue Insight: Prioritize high-deposit users

Risk Profiling: Multi-plan funding reveals customer intent and trust

🔍 Extra Insight Potential
Plan performance by type

Deposit patterns and withdrawal behaviors

Predict churn via plan drop-offs

CLV modeling by segment

Referral behaviors by tier

✅ Business Actions
Launch tier-based perks and loyalty rewards

Educate and upgrade lower tiers

Bundle products for multi-plan users

Prioritize support for Gold-tier clients

❓ Question 2: Transaction Frequency Segmentation
🧩 Approach
Calculated avg. confirmed transactions per active month

Segmented users into:

High: ≥10 txns/month

Medium: 3–9 txns/month

Low: <3 txns/month

📈 Why It Matters
Engagement Snapshot: Understand usage intensity

Targeted Campaigns: Customize messages by segment

Forecasting: Frequency often predicts revenue

Product Insight: Monitor active product usage

🔍 Extra Insight Potential
Identify churn risks via declining frequency

Tie in CLV for deeper segmentation

Spot seasonal dips or spikes

Understand channel/product preferences

✅ Business Actions
Tailored campaigns for reactivation

Loyalty perks for frequent users

Alerts for frequency drops

Segment-based product development

❓ Question 3: Inactive Account Detection
🧩 Approach
Flagged plans with no inflows in 365+ days

Segmented by savings or investment plan

Joined with user data for targeting

📈 Why It Matters
Retention: Early ID of disengaged users

Revenue Boost: Reactivating accounts raises AUM

Lifecycle Tracking: Spot where users drop off

Compliance: Required dormancy reporting

🔍 Extra Insight Potential
Past value of now-dormant accounts

User traits driving inactivity

Onboarding gaps for early churners

Compare withdrawal patterns before inactivity

✅ Business Actions
Run reactivation campaigns with incentives

Survey to understand inactivity drivers

Add gamification to encourage return

Alert CRM teams weekly

Integrate into retention dashboards

❓ Question 4: Estimating Customer Lifetime Value (CLV)
🧩 Approach
Calculated tenure (months)

Aggregated volume and avg. transaction value

CLV = frequency × avg. value × annualized

Segmented into High / Medium / Low value tiers

📈 Why It Matters
Marketing ROI: Target high-CLV users for referrals or upsells

Support Focus: Retain medium CLV users with potential

Product Design: Reward loyal, high-value users

Finance: Forecast revenue more accurately

📊 Sample Insights
Top CLV contributors

CLV vs. tenure trends

CLV distribution across users

Early behaviors that predict higher CLV

✅ Business Actions
Reward top customers with perks or yields

Re-engage low-CLV users post-onboarding

Analyze CLV by acquisition channel

Track monthly trends for impact analysis

🧠 Bonus: Advanced Ideas
Add investment data to CLV

Cross CLV with demographics

Build predictive CLV models from early behavior

📬 Contact
Victor Adaji
📍 Abuja, Nigeria
📧 victoradaji80@gmail.com
