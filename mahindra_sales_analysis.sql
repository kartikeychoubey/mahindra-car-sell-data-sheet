
-- Create table
CREATE TABLE Mahindra_Sales (
    Sale_ID INT PRIMARY KEY AUTO_INCREMENT,
    Sale_Date DATE NOT NULL,
    Model VARCHAR(50) NOT NULL,
    Engine_Type VARCHAR(20),
    Dealer_Location VARCHAR(50),
    Units_Sold INT,
    Selling_Price DECIMAL(15,2)
);

-- Insert sample data
INSERT INTO Mahindra_Sales (Sale_Date, Model, Engine_Type, Dealer_Location, Units_Sold, Selling_Price) VALUES
('2024-01-01', 'Thar', 'Diesel', 'Delhi', 180, 1500000),
('2024-01-01', 'XUV700', 'Petrol', 'Mumbai', 220, 1800000),
('2024-01-01', 'Scorpio-N', 'Diesel', 'Bangalore', 150, 1700000),
('2024-01-01', 'Bolero', 'Diesel', 'Hyderabad', 130, 1200000),
('2024-01-01', 'XUV300', 'Petrol', 'Chennai', 170, 1400000);

-- 1. View all data
SELECT * FROM Mahindra_Sales;

-- 2. Filter sales for a specific model
SELECT * FROM Mahindra_Sales
WHERE Model = 'Thar';

-- 3. Sales in a specific date range
SELECT * FROM Mahindra_Sales
WHERE Sale_Date BETWEEN '2024-03-01' AND '2024-06-30';

-- 4. Total units sold by each model
SELECT Model, SUM(Units_Sold) AS Total_Units
FROM Mahindra_Sales
GROUP BY Model
ORDER BY Total_Units DESC;

-- 5. Average selling price by model
SELECT Model, AVG(Selling_Price) AS Avg_Price
FROM Mahindra_Sales
GROUP BY Model;

-- 6. Monthly sales trend
SELECT DATE_FORMAT(Sale_Date, '%Y-%m') AS Month, SUM(Units_Sold) AS Total_Units
FROM Mahindra_Sales
GROUP BY Month
ORDER BY Month;

-- 7. Top 3 best-selling models
SELECT Model, SUM(Units_Sold) AS Total_Units
FROM Mahindra_Sales
GROUP BY Model
ORDER BY Total_Units DESC
LIMIT 3;

-- 8. Dealer generating highest revenue
SELECT Dealer_Location, SUM(Units_Sold * Selling_Price) AS Total_Revenue
FROM Mahindra_Sales
GROUP BY Dealer_Location
ORDER BY Total_Revenue DESC
LIMIT 1;

-- 9. Revenue contribution percentage by model
SELECT Model,
       ROUND(SUM(Units_Sold * Selling_Price) * 100.0 /
       (SELECT SUM(Units_Sold * Selling_Price) FROM Mahindra_Sales), 2) AS Revenue_Percentage
FROM Mahindra_Sales
GROUP BY Model
ORDER BY Revenue_Percentage DESC;

-- 10. Most popular engine type
SELECT Engine_Type, SUM(Units_Sold) AS Total_Units
FROM Mahindra_Sales
GROUP BY Engine_Type
ORDER BY Total_Units DESC;
