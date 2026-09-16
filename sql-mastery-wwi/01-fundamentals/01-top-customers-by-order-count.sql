-- Problem: Şirketin en çok sipariş veren ilk 10 müşterisini bulma (müşteri adı + sipariş sayısı).
SELECT TOP 10
	c.CustomerName,
	COUNT(*) AS 'Order Count'
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName, c.CustomerID
ORDER BY [Order Count] DESC