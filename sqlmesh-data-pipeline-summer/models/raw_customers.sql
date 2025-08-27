MODEL (
  name raw.customers,
  kind SEED (
    path '$root/seeds/customers.csv'
  ),
  columns (
    customer_id VARCHAR,
    username VARCHAR,
    email VARCHAR,
    phone VARCHAR,
    first_name VARCHAR,
    last_name VARCHAR,
    date_of_birth DATE,
    preferred_difficulty VARCHAR,
    location_city VARCHAR,
    location_state VARCHAR,
    location_country VARCHAR,
    profile_created_date TIMESTAMP,
    total_hikes_logged INTEGER,
    favorite_trail_type VARCHAR
  )
);
  
  