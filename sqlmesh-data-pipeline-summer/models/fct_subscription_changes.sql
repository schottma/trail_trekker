MODEL (
  name core.fct_subscription_changes,
  kind full, 
  cron '@hourly'
);

WITH 
subscription_events AS (
    SELECT 
        subscription_id, 
        customer_id, 
        subscription_started_at, 
        subscription_ended_at, 
        subscription_status, 
        plan_id, 
        LEAD(plan_id) OVER(PARTITION BY subscription_id, customer_id ORDER BY subscription_started_at ASC) AS next_plan_id, 
        LEAD(subscription_started_at) OVER(PARTITION BY subscription_id, customer_id ORDER BY subscription_started_at ASC) AS next_plan_subscription_started_at
    FROM staging.subscriptions
)
SELECT 
    @GENERATE_SURROGATE_KEY(subscription_id, subscription_ended_at) AS subscription_change_id, 
    subscription_id, 
    customer_id, 
    plan_id AS from_plan_id, 
    -- if None, assign 0000000 as plan_id 
    COALESCE(next_plan_id, '0000000') AS to_plan_id, 
    ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY subscription_started_at ASC) AS n_subscription_change,
    subscription_ended_at AS subscription_changed_at
FROM subscription_events  
WHERE 
    -- current subscription plan canceled and new plan started 
    subscription_ended_at = next_plan_subscription_started_at
    -- will include subscriptions that have been cancelled and don't have another subscription 
    OR (next_plan_subscription_started_at IS NULL AND subscription_status='cancelled')