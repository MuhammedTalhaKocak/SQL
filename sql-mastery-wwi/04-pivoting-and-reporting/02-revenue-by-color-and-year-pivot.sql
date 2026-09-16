/*
Problem: Ürün rengi bazında (sütun) ve yıl bazında (satır) toplam satış gelirini 
tek bir tabloda karşılaştırmalı olarak göstermek
Kullanılan teknikler: PIVOT, JOIN (5 tablo), Multi-dimensional Pivot (satır+sütun birlikte)
*/
SELECT 
SalesYear,
[Light Brown], [Yellow], [Black], [Blue], [Steel Gray], [White], [Red]
FROM
(SELECT 
	YEAR(so.OrderDate) AS SalesYear,
	wc.ColorName,
	sil.ExtendedPrice AS LineRevenue
FROM Warehouse.Colors wc
INNER JOIN Warehouse.StockItems si
ON wc.ColorID = si.ColorID
INNER JOIN Sales.InvoiceLines sil
ON si.StockItemID = sil.StockItemID
INNER JOIN Sales.Invoices sinv
ON sil.InvoiceID = sinv.InvoiceID
INNER JOIN Sales.Orders so
ON sinv.OrderID =  so.OrderID
WHERE YEAR(so.OrderDate) <> 2016
) AS KaynakTablo
PIVOT (
	SUM(LineRevenue)
	FOR ColorName IN ([Light Brown], [Yellow], [Black], [Blue], [Steel Gray], [White], [Red])
) AS PivotTable;
/*
Yorum: Mavi rengi bütün yıllarda en çok satışa sahipken, sarı rengi bütün yıllarda en düşük satışa sahiptir.
*/