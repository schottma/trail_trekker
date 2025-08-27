MODEL (
  name staging.subscriptions,
  kind VIEW, 
  audits (
    not_null(columns := (subscription_id, customer_id, plan_id))
  )
);

SELECT 
    subscription_id,
    customer_id,
    plan_id,
    billing_cycle AS billing_cadence,
    subscription_start_date::timestamp AS subscription_started_at,
    subscription_end_date::timestamp AS subscription_ended_at,
    status AS subscription_status,
    next_billing_date::timestamp AS next_billing_at,
    payment_method
FROM raw.subscriptions