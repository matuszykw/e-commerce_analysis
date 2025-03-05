-- changing product category name to english names

SELECT p.product_id, p.product_category_name, t.product_category_name_english
FROM olist_products_dataset p
JOIN product_category_name_translation t
    ON p.product_category_name = t.product_category_name
WHERE t.product_category_name_english IS NOT NULL;

UPDATE olist_products_dataset p
SET product_category_name = (
    SELECT t.product_category_name_english
    FROM product_category_name_translation t
    WHERE p.product_category_name = t.product_category_name
)
WHERE exists(
    SELECT 1 FROM product_category_name_translation t
    WHERE p.product_category_name = t.product_category_name
);