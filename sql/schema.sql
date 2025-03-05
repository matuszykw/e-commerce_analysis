create table olist_customers_dataset
(
    customer_id              varchar(32) not null
        primary key,
    customer_unique_id       text        null,
    customer_zip_code_prefix int         null,
    customer_city            text        null,
    customer_state           text        null
);

create table olist_geolocation_dataset
(
    geolocation_zip_code_prefix int    null,
    geolocation_lat             double null,
    geolocation_lng             double null,
    geolocation_city            text   null,
    geolocation_state           text   null
);

create table olist_orders_dataset
(
    order_id                      varchar(32) not null
        primary key,
    customer_id                   varchar(32) null,
    order_status                  text        null,
    order_purchase_timestamp      text        null,
    order_approved_at             text        null,
    order_delivered_carrier_date  text        null,
    order_delivered_customer_date text        null,
    order_estimated_delivery_date text        null,
    constraint orders_dataset_customer_id_fk
        foreign key (customer_id) references olist_customers_dataset (customer_id)
);

create table olist_order_payments_dataset
(
    order_id             varchar(32) null,
    payment_sequential   int         null,
    payment_type         text        null,
    payment_installments int         null,
    payment_value        float       null,
    constraint order_payments_order_id_fk
        foreign key (order_id) references olist_orders_dataset (order_id)
);

create table olist_order_reviews_dataset
(
    review_id               varchar(32) null,
    order_id                varchar(32) null,
    review_score            int         null,
    review_comment_title    text        null,
    review_comment_message  text        null,
    review_creation_date    text        null,
    review_answer_timestamp text        null,
    constraint order_reviews_order_id_fk
        foreign key (order_id) references olist_orders_dataset (order_id)
);

create table olist_products_dataset
(
    product_id                 varchar(32) not null
        primary key,
    product_category_name      text        null,
    product_name_lenght        int         null,
    product_description_lenght int         null,
    product_photos_qty         int         null,
    product_weight_g           int         null,
    product_length_cm          int         null,
    product_height_cm          int         null,
    product_width_cm           int         null
);

create table olist_sellers_dataset
(
    seller_id              varchar(32) not null
        primary key,
    seller_zip_code_prefix int         null,
    seller_city            text        null,
    seller_state           text        null
);

create table olist_order_items_dataset
(
    order_id            varchar(32)    null,
    order_item_id       int            null,
    product_id          varchar(32)    null,
    seller_id           varchar(32)    null,
    shipping_limit_date text           null,
    price               decimal(10, 2) null,
    freight_value       decimal(10, 2) null,
    constraint order_item_order_id_fk
        foreign key (order_id) references olist_orders_dataset (order_id),
    constraint order_items_product_id_fk
        foreign key (product_id) references olist_products_dataset (product_id),
    constraint order_items_seller_id_fk
        foreign key (seller_id) references olist_sellers_dataset (seller_id)
);

create table product_category_name_translation
(
    product_category_name         text null,
    product_category_name_english text null
);