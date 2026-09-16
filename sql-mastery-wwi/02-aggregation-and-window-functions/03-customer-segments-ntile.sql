/*
Problem: Müşterileri toplam harcamalarına göre 5 eşit gruba (segment) ayırmak
Kullanılan teknikler: JOIN (3 tablo), CTE, NTILE, Window Function
*/
WITH CustomerSpend AS
(
SELECT 
	sc.CustomerID,
	SUM(sil.ExtendedPrice) AS TotalSpend
FROM Sales.Customers sc
INNER JOIN Sales.Invoices si
ON sc.CustomerID = si.CustomerID
INNER JOIN Sales.InvoiceLines sil
ON si.InvoiceID = sil.InvoiceID
GROUP BY sc.CustomerID)
SELECT 
	*,
	NTILE(5) OVER (ORDER BY TotalSpend) AS SpendGroup
FROM CustomerSpend
ORDER BY TotalSpend DESC
/*
Yorum: 132 kişi En yüksek harcama yapan grubu oluşturuyor. Bu gruptaki müşterilerin toplam harcamalarının aralığı 346512.7 ile 438689.81 arasındadır.
*/