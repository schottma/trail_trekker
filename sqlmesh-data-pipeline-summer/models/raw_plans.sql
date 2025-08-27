MODEL (
  name raw.plans,
  kind SEED (
    path '$root/seeds/plans.csv'
  ),
  columns (
    plan_id VARCHAR,
    plan_name VARCHAR,
    plan_level INTEGER,
    price DECIMAL,
    max_hikes_per_month DECIMAL,
    photo_storage_gb DECIMAL,
    description VARCHAR,
    created_at DATE
  )
);
  