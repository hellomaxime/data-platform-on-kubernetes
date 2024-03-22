CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    age INT NOT NULL,
    email VARCHAR(50) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    city VARCHAR(50) NOT NULL
);

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    category_id INT
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE order_details (
    order_details_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price_per_unit DECIMAL(10, 2) NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO users (user_id, username, age, email, gender, city) VALUES
(1, 'EmilyBrown', 28, 'emily@example.com', 'Female', 'San Francisco'),
(2, 'MichaelLee', 40, 'michael@example.com', 'Male', 'Houston'),
(3, 'AmandaWilson', 35, 'amanda@example.com', 'Female', 'Miami');

INSERT INTO products (product_id, name, description, price, category_id) VALUES
(1, 'Tablet', '10-inch tablet with high-resolution display', 299.99, 1),
(2, 'Smartwatch', 'Fitness tracker with heart rate monitor', 129.99, 3),
(3, 'Wireless Speaker', 'Portable speaker with Bluetooth connectivity', 79.99, 2);

INSERT INTO orders (order_id, user_id, order_date, total_amount) VALUES
(1, 1, '2024-03-13 10:00:00', 299.99),
(2, 2, '2024-03-12 12:30:00', 379.98),
(3, 3, '2024-03-11 14:45:00', 129.99),
(4, 1, '2024-03-10 16:00:00', 259.98),
(5, 2, '2024-03-09 18:20:00', 679.97);

INSERT INTO order_details (order_details_id, order_id, product_id, quantity, price_per_unit, total_price) VALUES
(1, 4, 2, 2, 129.99, 259.98),
(2, 5, 3, 1, 79.99, 79.99),
(3, 2, 1, 1, 299.99, 299.99),
(4, 3, 2, 1, 129.99, 129.99),
(5, 5, 1, 2, 299.99, 599.98),
(6, 2, 3, 1, 79.99, 79.99),
(7, 1, 1, 1, 299.99, 299.99); 