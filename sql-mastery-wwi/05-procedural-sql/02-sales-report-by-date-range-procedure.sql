/*
Problem: Verilen tarih aralığındaki toplam sipariş sayısı ve toplam geliri 
döndüren, tekrar kullanılabilir bir stored procedure oluşturmak
Kullanılan teknikler: CREATE PROCEDURE, Çoklu Parametre, BETWEEN, JOIN (3 tablo)
*/
--CREATE PROCEDURE GetCustomerOrderSummaryBetweenTwoDates
--    @StartDate DATE,
--    @EndDate DATE
--AS
--BEGIN
--    SELECT 
--        COUNT(DISTINCT o.OrderID) AS TotalOrders,
--        SUM(il.ExtendedPrice) AS TotalSpend
--    FROM Sales.InvoiceLines il
--    INNER JOIN Sales.Invoices i ON il.InvoiceID = i.InvoiceID
--    INNER JOIN Sales.Orders o ON i.OrderID = o.OrderID
--    WHERE o.OrderDate BETWEEN @StartDate AND @EndDate 
--END

-- Çağırma örneği:
-- EXEC GetCustomerOrderSummaryBetweenTwoDates @StartDate = '2013-01-01', @EndDate = '2013-12-31'

/*
Yorum: 2013 yılı için 19012 sipariş, 53M TL toplam gelir hesaplandı. Bu 
prosedür, herhangi bir tarih aralığı için (çeyreklik, aylık, kampanya 
dönemi gibi) hızlı satış raporu almayı sağlıyor — özel bir sorgu 
yazmaya gerek kalmadan. Procedure önceden oluşturulduğu için procedure kısmını yorum satırına aldık.
*/