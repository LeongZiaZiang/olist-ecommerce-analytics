------------------------------------------------------------
/* Fact orders */
------------------------------------------------------------

CREATE SCHEMA analytics

ALTER TABLE staging.products 
ALTER COLUMN product_weight_g TYPE FLOAT;
ALTER TABLE staging.products 
ALTER COLUMN product_length_cm TYPE FLOAT;
ALTER TABLE staging.products 
ALTER COLUMN product_height_cm TYPE FLOAT;
ALTER TABLE staging.products 
ALTER COLUMN product_width_cm TYPE FLOAT;

SELECT * FROM staging.products

-- Core table
DROP TABLE IF EXISTS analytics.fact_orders;
CREATE TABLE analytics.fact_orders AS
SELECT
    o.order_id,
	c.customer_id,
    o.order_purchase_timestamp AS order_date,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
	o.order_status,
    c.customer_state,
	s.seller_state,
	r.review_score,
	pr.product_photos_qty,
	pr.product_weight_g/1000 AS product_weight_kg,
	(pr.product_length_cm * pr.product_height_cm * pr.product_width_cm)/1000000 AS product_volume_m3,
	p.payment_type,
	p.payment_installments,
	COUNT(oi.order_item_id) AS item_count,
    SUM(oi.price + oi.freight_value) AS order_value
FROM staging.orders o
JOIN staging.order_items oi ON o.order_id = oi.order_id
JOIN staging.customers c ON o.customer_id = c.customer_id
JOIN staging.reviews r ON o.order_id = r.order_id
JOIN staging.payments p ON o.order_id = p.order_id
JOIN staging.products pr ON oi.product_id = pr.product_id
JOIN staging.sellers s ON oi.seller_id = s.seller_id
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14;

SELECT * FROM analytics.fact_orders 

---------------------------------------------------------------
/* Local data cleaning */
---------------------------------------------------------------

SELECT COUNT(*) FROM analytics.fact_orders

-- Check typos 
SELECT * 
FROM analytics.fact_orders 
WHERE LOWER(order_status) != order_status

SELECT * 
FROM analytics.fact_orders 
WHERE LOWER(payment_type) != payment_type


-- missing values 
SELECT *
FROM analytics.fact_orders 
WHERE order_delivered_customer_date IS NULL

SELECT *
FROM analytics.fact_orders 
WHERE product_photos_qty IS NULL

SELECT *
FROM analytics.fact_orders 
WHERE product_weight_kg IS NULL

SELECT *
FROM analytics.fact_orders 
WHERE product_volume_m3 IS NULL


-- final clean data
DROP TABLE IF EXISTS analytics.cleaned_fact_orders;
CREATE TABLE analytics.cleaned_fact_orders AS (
SELECT *
FROM analytics.fact_orders
WHERE order_delivered_customer_date IS NOT NULL
	AND product_photos_qty IS NOT NULL
	AND product_weight_kg IS NOT NULL
	AND product_volume_m3 IS NOT NULL
)

SELECT * FROM analytics.cleaned_fact_orders

-- unclean data
DROP TABLE IF EXISTS analytics.uncleaned_fact_orders;
CREATE TABLE analytics.uncleaned_fact_orders AS
SELECT
    o.order_id,
	c.customer_id,
    o.order_purchase_timestamp AS order_date,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
	o.order_status,
    c.customer_state,
	s.seller_state,
	r.review_score,
	pr.product_photos_qty,
	pr.product_weight_g/1000 AS product_weight_kg,
	(pr.product_length_cm * pr.product_height_cm * pr.product_width_cm)/1000000 AS product_volume_m3,
	p.payment_type,
	p.payment_installments,
	COUNT(oi.order_item_id) AS item_count,
    SUM(oi.price + oi.freight_value) AS order_value
FROM staging.orders o
JOIN staging.order_items oi ON o.order_id = oi.order_id
JOIN staging.customers c ON o.customer_id = c.customer_id
JOIN staging.reviews r ON o.order_id = r.order_id
JOIN staging.payments p ON o.order_id = p.order_id
JOIN staging.products pr ON oi.product_id = pr.product_id
JOIN staging.sellers s ON oi.seller_id = s.seller_id
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14;

SELECT * FROM analytics.uncleaned_fact_orders 