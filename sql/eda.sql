-- count of orders status
SELECT order_status, count(order_status) as num_of_orders
FROM olist_orders_dataset
GROUP BY order_status;

-- average order value
WITH order_values AS (
    SELECT
        o.order_id,
        sum(price) total_price
    FROM olist_orders_dataset o
    JOIN olist_order_items_dataset i
    ON o.order_id = i.order_id
    GROUP BY o.order_id
)
SELECT avg(total_price)
FROM order_values;
-- R$137.7 = +- 23 USD

-- the most popular product categories
SELECT product_category_name, count(*) num_of_orders
FROM olist_order_items_dataset o
JOIN olist_products_dataset p
ON o.product_id = p.product_id
GROUP BY product_category_name
ORDER BY num_of_orders DESC;

-- the biggest sellers
SELECT
    s.seller_id,
    s.seller_city,
    SUM(i.price) total_earnings
FROM olist_order_items_dataset i
JOIN olist_sellers_dataset s
ON s.seller_id = i.seller_id
GROUP BY s.seller_id, s.seller_city
ORDER BY total_earnings DESC;
-- R$229472 = +- 39000 USD

-- most common payment methods
SELECT payment_type, COUNT(payment_type) num_of_payments
FROM olist_order_payments_dataset
GROUP BY payment_type
ORDER BY num_of_payments DESC;

-- actual delivery time vs estimated delivery time
SELECT
    ROUND(AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)), 2) AS avg_actual_days,
    ROUND(AVG(DATEDIFF(order_estimated_delivery_date, order_purchase_timestamp)), 2) AS avg_estimated_days
FROM olist_orders_dataset;


SELECT DISTINCT order_status
FROM olist_orders_dataset;