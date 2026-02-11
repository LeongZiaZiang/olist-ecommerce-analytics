--------------------------------------------------------
/*Add metrics*/
--------------------------------------------------------

-- Add delivery delay
ALTER TABLE analytics.cleaned_fact_orders
ADD COLUMN delivery_days INT;

UPDATE analytics.cleaned_fact_orders
SET delivery_days =
    (order_delivered_customer_date::date -
     order_date::date);

SELECT * FROM analytics.cleaned_fact_orders

-- Late delivery flag
ALTER TABLE analytics.cleaned_fact_orders
ADD COLUMN is_late BOOLEAN;

UPDATE analytics.cleaned_fact_orders
SET is_late =
    order_delivered_customer_date >
    order_estimated_delivery_date;

SELECT * FROM analytics.cleaned_fact_orders

-- Monthly order metrics

DROP TABLE IF EXISTS analytics.metrics_orders_monthly;
CREATE TABLE analytics.metrics_orders_monthly AS
SELECT
    date_trunc('month', order_date) AS month,
    COUNT(order_id)                AS total_orders,
    SUM(order_value)             AS gmv,
    AVG(order_value)             AS aov,
    AVG(delivery_days)             AS avg_delivery_days
FROM analytics.cleaned_fact_orders
WHERE order_status = 'delivered'
GROUP BY 1;

SELECT * FROM analytics.metrics_orders_monthly
ORDER BY month









