MODEL (
  name core.dim_plans,
  kind full,
  cron '@daily'
);

WITH 
-- only want to find the billing cadence for each plan id
unique_subscription_plans AS (
    SELECT DISTINCT 
        plan_id, 
        COALESCE(billing_cadence, 'unknown') AS billing_cadence
    FROM staging.subscriptions
),

plans_billing_cadences AS (
SELECT 
    plans.plan_id, 
    plans.plan_name, 
    plans.plan_level, 
    subs.billing_cadence, 
    plans.price_usd_cents,
    plans.max_hikes_per_month,
    plans.photo_storage_gb,
    plans.plan_description,
    plans.plan_created_at
FROM staging.plans plans
LEFT JOIN unique_subscription_plans subs 
    ON plans.plan_id = subs.plan_id
)

SELECT 
    plan_id, 
    plan_name, 
    plan_level, 
    billing_cadence,
    CASE 
        WHEN billing_cadence='annual' THEN 12 
        WHEN billing_cadence='monthly' THEN 1 
        WHEN billing_cadence='unknown' THEN 0
        ELSE 99999
    END AS n_payments, 
    CASE 
        WHEN billing_cadence='annual' THEN (price_usd_cents * 1.0)/12
        WHEN billing_cadence='monthly' THEN 1 
        WHEN billing_cadence='unknown' THEN 0
        ELSE 99999
    END AS monthly_price_usd_cents,  
    price_usd_cents,
    max_hikes_per_month,
    photo_storage_gb,
    plan_description,
    plan_created_at
FROM plans_billing_cadences