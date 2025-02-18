INSERT INTO Customers (customer_id, customer_name) VALUES 
(1, 'Alice'), 
(2, 'Bob'), 
(3, 'Charlie'), 
(4, 'David');

INSERT INTO Restaurants (restaurant_id, restaurant_name) VALUES 
(1, 'Pizza Hut'), 
(2, 'Domino’s'), 
(3, 'Burger King');

INSERT INTO Dishes (dish_id, restaurant_id, dish_name, price) VALUES 
(1, 1, 'Margherita Pizza', 250.00), 
(2, 1, 'Veggie Pizza', 300.00), 
(3, 2, 'Cheese Burst Pizza', 400.00),
(4, 3, 'Whopper Burger', 150.00);

INSERT INTO Orders (order_id, customer_id, restaurant_id, order_date, total_price) VALUES 
(1, 1, 1, '2024-02-01', 550.00), 
(2, 2, 1, '2024-02-05', 300.00), 
(3, 2, 2, '2024-02-10', 400.00);

INSERT INTO Order_Items (order_item_id, order_id, dish_id, quantity, price_per_unit) VALUES 
(1, 1, 1, 2, 250.00), 
(2, 1, 2, 1, 300.00), 
(3, 2, 1, 1, 250.00), 
(4, 3, 3, 1, 400.00);
