------------------------------------------------------------
/* Geographical locations */
------------------------------------------------------------

DROP TABLE IF EXISTS analytics.dim_customers;
CREATE TABLE analytics.dim_customers AS
SELECT DISTINCT
    customer_id,
    customer_city,
    customer_state
FROM staging.customers;

DROP TABLE IF EXISTS analytics.dim_sellers;
CREATE TABLE analytics.dim_sellers AS
SELECT DISTINCT
    seller_id,
    seller_city,
    seller_state
FROM staging.sellers;

SELECT * FROM analytics.dim_customers
SELECT * FROM analytics.dim_sellers