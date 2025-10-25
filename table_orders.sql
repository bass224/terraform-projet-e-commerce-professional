--code que j'ai exécuté sur azure soit sur eidteur de requetes soit sur azure data studio 
--ça crée la table orders dans notre base de données 

CREATE TABLE orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,   -- clé primaire auto-incrémentée
    customer_id VARCHAR(10) NOT NULL,
    product_id VARCHAR(10) NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    order_date DATE NOT NULL
);

INSERT INTO orders (customer_id, product_id, quantity, price, order_date) VALUES
('C001', 'P001', 2, 15.99, '2025-10-15'),
('C002', 'P002', 1, 45.00, '2025-10-15'),
('C003', 'P003', 3, 12.50, '2025-10-16'),
('C004', 'P004', 1, 9.99, '2025-10-17'),
('C005', 'P005', 5, 25.00, '2025-10-17');
