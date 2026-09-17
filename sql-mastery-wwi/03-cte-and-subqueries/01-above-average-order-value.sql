/*
Problem: Ortalama sipariş tutarının üzerinde olan siparişleri belirlemek
Kullanılan teknikler: CTE, Subquery, AVG
*/
WITH OrderTotals AS (
    SELECT o.OrderID, SUM(il.ExtendedPrice) AS OrderValue
    FROM Sales.Orders o
    INNER JOIN Sales.Invoices i ON o.OrderID = i.OrderID
    INNER JOIN Sales.InvoiceLines il ON i.InvoiceID = il.InvoiceID
    GROUP BY o.OrderID
)
SELECT OrderID, OrderValue
FROM OrderTotals
WHERE OrderValue > (SELECT AVG(OrderValue) FROM OrderTotals)
ORDER BY OrderValue DESC

/*
Yorum: 73595 siparişin sadece 23932'si (%32.5) ortalama sipariş tutarının 
üzerinde. Bu, sipariş değeri dağılımının sağa çarpık olduğunu gösteriyor 
— az sayıda yüksek tutarlı sipariş ortalamayı yukarı çekiyor, "tipik" bir 
sipariş aslında ortalamanın altında kalıyor. Bu yüzden sipariş segmentasyonu 
yapılırken ortalama yerine medyan/quartile bazlı eşikler tercih edilmeli.
*/