MODEL (
  name raw.features,
  kind SEED (
    path '$root/seeds/features.csv'
  ),
  columns (
    feature_id VARCHAR,
    feature_name VARCHAR,
    feature_description VARCHAR,
    feature_category VARCHAR
  )
);
  