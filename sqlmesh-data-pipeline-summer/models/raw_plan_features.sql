MODEL (
  name raw.plan_features,
  kind SEED (
    path '$root/seeds/plan_features.csv'
  ),
  columns (
    plan_feature_id VARCHAR,
    plan_id VARCHAR,
    feature_id VARCHAR,
    included VARCHAR
  )
);
  
  