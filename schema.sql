-- Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(255)
);

-- Restaurants Table
CREATE TABLE Restaurants (
    restaurant_id INT PRIMARY KEY,
    restaurant_name VARCHAR(255)
);

-- Dishes Table
CREATE TABLE Dishes (
    dish_id INT PRIMARY KEY,
    restaurant_id INT,
    dish_name VARCHAR(255),
    price DECIMAL(10,2),
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id)
);

-- Orders Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    restaurant_id INT,
    order_date DATE,
    total_price DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id)
);

-- Order Items Table
CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    dish_id INT,
    quantity INT,
    price_per_unit DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (dish_id) REFERENCES Dishes(dish_id)
);
