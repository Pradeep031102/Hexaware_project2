
-- 1.Count Total Orders by Carrier
SELECT Carrier, COUNT(OrderID) AS TotalOrders
FROM Orders
GROUP BY Carrier;

-- 2.Average Transport Day Count by Carrier
SELECT Carrier, AVG(TransportDayCount) AS AvgTransportDays
FROM CarrierRates
GROUP BY Carrier;

-- 3.get products from plant
SELECT P.PlantCode, P.ProductID
FROM PlantProducts P
ORDER BY P.PlantCode, P.ProductID;

-- 4.aggregate functions
SELECT Carrier, MinWeightQuantity, MaxWeightQuantity, MIN(MinimumCost) AS MinCost
FROM CarrierRates
GROUP BY Carrier, MinWeightQuantity, MaxWeightQuantity;


--5.correlated subquery
SELECT *
FROM Orders
WHERE Weight > (SELECT AVG(Weight) FROM Orders);

-- 6.ship late count

SELECT OrderID, OrderDate, ShipLateDayCount
FROM Orders
WHERE ShipLateDayCount > 0;

-- 7.join

SELECT PC.PlantCode, PC.Customer, PP.ProductID
FROM PlantCustomers PC
JOIN PlantProducts PP ON PC.PlantCode = PP.PlantCode
ORDER BY PC.PlantCode, PC.Customer;

-- 8.joining

SELECT O.OrderID, O.OrderDate, C.Rate
FROM Orders O
JOIN CarrierRates C ON O.Carrier = C.Carrier
AND O.OriginPort = C.OriginPort
AND O.DestinationPort = C.DestinationPort
WHERE O.OrderDate BETWEEN '2013-01-01' AND '2013-12-31';

-- 9.carrier rate analysis
SELECT Carrier, 
       AVG(Rate) AS AvgRate, 
       MinWeightQuantity, 
       MaxWeightQuantity
FROM CarrierRates
GROUP BY Carrier, MinWeightQuantity, MaxWeightQuantity;

-- 10.high vol customers

SELECT Customer, SUM(UnitQuantity) AS TotalUnits
FROM Orders
GROUP BY Customer
HAVING SUM(UnitQuantity) > 1000; 

-- 11.orders with servicelevel
SELECT *
FROM Orders
WHERE ServiceLevel = 'CRF'; 


--12. order above certain threshold

SELECT O.OrderID, O.OrderDate, C.Rate
FROM Orders O
JOIN CarrierRates C ON O.Carrier = C.Carrier
WHERE C.Rate > 0;


-- 13. Total cost
SELECT PC.PlantCode, SUM(PC.CostPerUnit * O.UnitQuantity) AS TotalCost
FROM Orders O
JOIN PlantCosts PC ON O.PlantCode = PC.PlantCode
GROUP BY PC.PlantCode;


-- 14. ordering by date
SELECT OrderDate, COUNT(OrderID) AS TotalOrders
FROM Orders
GROUP BY OrderDate
ORDER BY OrderDate;

-- 15. no active orders

SELECT C.Carrier
FROM CarrierRates C
LEFT JOIN Orders O ON C.Carrier = O.Carrier
WHERE O.OrderID IS NULL;

--16. Orders within specific range

SELECT *
FROM Orders
WHERE Weight BETWEEN 100 AND 500;

-- 17. Data within specific ports

SELECT *
FROM CarrierRates
WHERE OriginPort = 'Port08' AND DestinationPort = 'Port09'; 

-- 18. Customers with Multiple products

SELECT Customer, COUNT(DISTINCT ProductID) AS ProductCount
FROM Orders
GROUP BY Customer
HAVING  COUNT(DISTINCT ProductID) > 1;

-- 19. Aggregating

SELECT ServiceLevel, SUM(Weight) AS TotalWeight, SUM(UnitQuantity) AS TotalUnits
FROM Orders
GROUP BY ServiceLevel;


-- 20. High daily capacity

SELECT PlantCode, DailyCapacity
FROM PlantCapacities
WHERE DailyCapacity > 1000; 
