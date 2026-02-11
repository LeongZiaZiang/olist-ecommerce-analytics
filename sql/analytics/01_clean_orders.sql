--------------------------------------------------------
/* Data cleaning */
--------------------------------------------------------

/* Clean customer data */

SELECT * FROM staging.customers

SELECT COUNT(*) FROM staging.customers

-- Check duplicates
SELECT *
FROM (
SELECT *,
 ROW_NUMBER() OVER (
	PARTITION BY customer_id, LOWER(customer_state)
	ORDER BY customer_id
 ) AS rn
FROM staging.customers 
)
WHERE rn > 2

-- Check missing values
SELECT 
COUNT(*)
FROM staging.customers
WHERE customer_state IS NULL

-- Check typos
SELECT * 
FROM staging.customers
WHERE UPPER(customer_state) != customer_state

-- Check special characters
SELECT customer_city
FROM staging.customers
WHERE LOWER(customer_city) like '%[^a-zA-Z0-9]%'

-------------------------------------------------------------------------------

/*Clean seller data*/

SELECT * FROM staging.sellers

SELECT COUNT(*) FROM staging.sellers

-- Check duplicates
SELECT *
FROM (
SELECT *,
 ROW_NUMBER() OVER (
	PARTITION BY seller_id, LOWER(seller_state)
	ORDER BY seller_id
 ) AS rn
FROM staging.sellers 
)
WHERE rn > 2

-- Check missing values
SELECT 
COUNT(*)
FROM staging.sellers
WHERE seller_state IS NULL

-- Check typos
SELECT * 
FROM staging.sellers
WHERE UPPER(seller_state) != seller_state

--Check special characters
SELECT seller_city
FROM staging.sellers
WHERE LOWER(seller_city) like '%[^a-zA-Z0-9]%'

---------------------------------------------------------------
/* Data is clean */