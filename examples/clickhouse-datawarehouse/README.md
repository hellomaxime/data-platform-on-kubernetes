## Data models

### MySQL data model

__Users__
- user_id
- username
- age
- email
- gender
- city

__Products__
- product_id
- name
- description
- price
- category_id

__Orders__
- order_id
- user_id
- order_date
- total_amount

__Order_Details__
- order_detail_id
- order_id
- product_id
- quantity
- price_per_unit
- total_price

### ClickHouse data model

Fact Table:

__sales_fact__
- order_id (dimension)
- product_id (dimension)
- user_id (dimension)
- order_date (dimension)
- quantity_sold (measure)
- total_amount (measure)

Dimension Tables:

__users_dim__
- user_id (primary key)
- username
- age
- email
- gender
- city

__products_dim__
- product_id (primary key)
- name
- description
- price
- category_id

__orders_dim__
- order_id (primary key)
- order_date
- total_amount

__order_details_dim__
- order_detail_id (primary key)
- order_id
- product_id
- quantity
- price_per_unit
- total_price