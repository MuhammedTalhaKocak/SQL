/*
WITH NextOrderDates AS
(
SELECT
	CustomerID,
	OrderDate,
	LEAD(OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS NextOrderDate	
FROM Sales.Orders
)
SELECT
	*,
	DATEDIFF(DAY, OrderDate, NextOrderDate) AS DaysUntilNextOrder
FROM NextOrderDates
*/

/*
Problem: Müşterilerin sipariş sıklığını (art arda siparişler arası ortalama gün farkı) 
hesaplayıp en sık sipariş veren müşterileri belirlemek
Kullanılan teknikler: LEAD, DATEDIFF, CTE, AVG, GROUP BY
*/
WITH OrderGaps AS (
    SELECT 
        CustomerID,
        OrderDate,
        DATEDIFF(DAY, OrderDate, LEAD(OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate)) AS DaysUntilNextOrder
    FROM Sales.Orders
)
SELECT 
    CustomerID,
    AVG(DaysUntilNextOrder * 1.0) AS AvgDaysBetweenOrders
FROM OrderGaps
WHERE DaysUntilNextOrder IS NOT NULL
GROUP BY CustomerID
ORDER BY AvgDaysBetweenOrders ASC

/*
Yorum: CustomerID 1061, 9 sipariş üzerinden ortalama 1.125 günde bir sipariş 
vermiş — şirketin en sık alışveriş yapan müşterilerinden biri. Örneklem 
büyüklüğü (9 sipariş) kesin yargı için ideal olmasa da tekil bir vaka 
olmadığını gösterecek kadar yeterli. Bu tür yüksek frekanslı müşteriler 
için sadakat programı veya öncelikli hizmet değerlendirilebilir.
*/