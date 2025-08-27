MODEL (
  name raw.subscriptions,
  kind SEED (
    path '$root/seeds/subscriptions.csv'
  ),
  columns (
    subscription_id VARCHAR,
    customer_id VARCHAR,
    plan_id VARCHAR,
    billing_cycle VARCHAR,
    subscription_start_date TIMESTAMP,
    subscription_end_date TIMESTAMP,
    status VARCHAR,
    next_billing_date TIMESTAMP,
    payment_method VARCHAR

  )
);

-- want to model subscription changes
-- one record for every change in subscription a user makes 
-- from_plan_id 
-- to_plan_id
-- atomic grain: customer_id, subscription_id, subscription_changed_at 
-- assume the same customer will always retain their subscription_id, unless they cancel and start a new subscription 
-- address the fact that a plan_id needs to be created as a plan dimension that represents a NULL or N/A plan_id value 
-- should have a new record for every change which means it can be built incrementally
