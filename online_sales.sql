-- Create table
CREATE TABLE mahindra_sales (
    order_id INT PRIMARY KEY,
    order_date DATE,
    model_name VARCHAR(50),
    units_sold INT,
    unit_price DECIMAL(10, 2)
);

-- Insert sample data
INSERT INTO mahindra_sales (order_id, order_date, model_name, units_sold, unit_price) VALUES
(1, '2025-01-05', 'Scorpio N', 5, 1500000),
(2, '2025-01-12', 'Thar', 3, 1450000),
(3, '2025-02-02', 'XUV700', 4, 1800000),
(4, '2025-02-14', 'Bolero', 6, 950000),
(5, '2025-03-08', 'Scorpio Classic', 2, 1300000),
(6, '2025-03-21', 'Marazzo', 3, 1400000),
(7, '2025-04-10', 'XUV300', 4, 1100000),
(8, '2025-04-15', 'Thar', 5, 1450000),
(9, '2025-05-04', 'Bolero', 7, 950000),
(10, '2025-05-19', 'Scorpio N', 3, 1500000);

-- Monthly Revenue & Order Volume Analysis
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    COUNT(order_id) AS total_orders,
    SUM(units_sold * unit_price) AS total_revenue,
    ROUND(AVG(units_sold * unit_price), 2) AS avg_order_value
FROM 
    mahindra_sales
GROUP BY 
    DATE_FORMAT(order_date, '%Y-%m')
ORDER BY 
    month;
