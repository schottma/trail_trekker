MODEL (
  name staging.features,
  kind VIEW,
  audits (
    not_null(columns := (feature_id))
  )
);

SELECT 
    feature_id,
    feature_name,
    feature_description,
    feature_category
FROM raw.features