/* 
Amaç: Hiç sipariş vermemiş müşterileri bulmak (aktive olmamış potansiyel müşteri listesi)
Kullanılan teknikler: LEFT JOIN, IS NULL
*/

SELECT 
	c.CompanyName
FROM SalesLT.Customer c
LEFT JOIN SalesLT.SalesOrderHeader soh
ON c.CustomerID = soh.CustomerID
WHERE soh.SalesOrderID IS NULL

/*
Hiç sipariş vermemiş 815 Şirket bulunmaktadır. Bu şirketlere özel indirim mesajları, mailler atılarak bu şirketlerin sipariş vermesi sağlanabilir.
*/