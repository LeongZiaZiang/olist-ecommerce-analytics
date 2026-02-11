--------------------------------------------------------
/* Data Importing */
--------------------------------------------------------

COPY staging.orders
FROM 'C:/Users/leong/Desktop/Career/SQL projects/Brazilian_Ecom_Public/dataset/olist_orders_dataset.csv'
DELIMITER ','
CSV HEADER;

COPY staging.reviews
FROM 'C:/Users/leong/Desktop/Career/SQL projects/Brazilian_Ecom_Public/dataset/olist_order_reviews_dataset.csv'
DELIMITER ','
CSV HEADER;

COPY staging.payments
FROM 'C:/Users/leong/Desktop/Career/SQL projects/Brazilian_Ecom_Public/dataset/olist_order_payments_dataset.csv'
DELIMITER ','
CSV HEADER;

COPY staging.customers
FROM 'C:/Users/leong/Desktop/Career/SQL projects/Brazilian_Ecom_Public/dataset/olist_customers_dataset.csv'
DELIMITER ','
CSV HEADER;

COPY staging.sellers
FROM 'C:/Users/leong/Desktop/Career/SQL projects/Brazilian_Ecom_Public/dataset/olist_sellers_dataset.csv'
DELIMITER ','
CSV HEADER;

COPY staging.products
FROM 'C:/Users/leong/Desktop/Career/SQL projects/Brazilian_Ecom_Public/dataset/olist_products_dataset.csv'
DELIMITER ','
CSV HEADER;

COPY staging.order_items
FROM 'C:/Users/leong/Desktop/Career/SQL projects/Brazilian_Ecom_Public/dataset/olist_order_items_dataset.csv'
DELIMITER ','
CSV HEADER;

