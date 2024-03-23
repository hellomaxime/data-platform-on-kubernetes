CREATE TABLE IF NOT EXISTS sales_fact (
    order_id UInt32,
    product_id UInt32,
    user_id UInt32,
    order_date Date,
    quantity_sold UInt32,
    total_amount Decimal(10, 2)
) ENGINE = MergeTree()
PARTITION BY toYYYYMM(order_date)
ORDER BY (order_date, order_id);

CREATE TABLE IF NOT EXISTS users_dim (
    user_id UInt32 PRIMARY KEY,
    username String,
    age UInt32,
    email String,
    gender String,
    city String
) ENGINE = MergeTree()
ORDER BY (user_id);

CREATE TABLE IF NOT EXISTS product_dim (
    product_id UInt32 PRIMARY KEY,
    name String,
    description String,
    price Decimal(10, 2),
    category_id UInt32
) ENGINE = MergeTree()
ORDER BY (product_id);

CREATE TABLE IF NOT EXISTS orders_dim (
    order_id UInt32 PRIMARY KEY,
    order_date Date,
    total_amount Decimal(10, 2)
) ENGINE = MergeTree()
PARTITION BY toYYYYMM(order_date)
ORDER BY (order_id, order_date);

CREATE TABLE IF NOT EXISTS order_details_dim (
    order_detail_id UInt32 PRIMARY KEY,
    order_id UInt32,
    product_id UInt32,
    quantity UInt32,
    price_per_unit Decimal(10, 2),
    total_price Decimal(10, 2)
) ENGINE = MergeTree()
ORDER BY (order_detail_id, order_id);