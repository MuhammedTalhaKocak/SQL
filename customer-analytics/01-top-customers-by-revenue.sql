/*
Problem: En çok gelir getiren ilk 10 müşteriyi bulma (isim, toplam harcama, sipariş sayısı)
Kullanılan teknikler: JOIN, GROUP BY, SUM, COUNT, ORDER BY
*/
SELECT TOP 10
	c.CompanyName, -- Customer tablosundan şirket ismi 
	SUM(soh.TotalDue) AS TotalRevenue,
	COUNT(*) AS OrderCount
FROM 
SalesLT.Customer c
INNER JOIN SalesLT.SalesOrderHeader soh
ON c.CustomerID = soh.CustomerID
GROUP BY c.CompanyName
ORDER BY TotalRevenue DESC
/*
Not: Aynı isimli farklı şirketler varsa (nadir ama teorik olarak mümkün), bu şirketler yanlışlıkla birleştirilmiş olabilir.
*/