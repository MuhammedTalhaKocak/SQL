/*
Problem: Verilen bir CustomerID için toplam sipariş sayısı ve toplam harcamayı 
döndüren, tekrar kullanılabilir bir stored procedure oluşturmak
Kullanılan teknikler: CREATE PROCEDURE, Parametre kullanımı, JOIN (4 tablo)
*/
--CREATE PROCEDURE GetCustomerOrderSummary
--    @CustomerID INT
--AS
--BEGIN
--    SELECT 
--        c.CustomerID,
--        c.CustomerName,
--        COUNT(DISTINCT o.OrderID) AS TotalOrders,
--        SUM(sil.ExtendedPrice) AS TotalSpend
--    FROM Sales.Customers c
--    INNER JOIN Sales.Orders o ON c.CustomerID = o.CustomerID
--    INNER JOIN Sales.Invoices si ON o.OrderID = si.OrderID
--    INNER JOIN Sales.InvoiceLines sil ON si.InvoiceID = sil.InvoiceID
--    WHERE c.CustomerID = @CustomerID
--    GROUP BY c.CustomerID, c.CustomerName
--END

-- Çağırma örneği:
-- EXEC GetCustomerOrderSummary @CustomerID = 1061

/*
Yorum: Bu prosedür, müşteri hizmetleri veya satış ekibinin herhangi bir 
müşteri için hızlıca özet bilgi çekmesini sağlar — her seferinde sorguyu 
yeniden yazmak yerine sadece CustomerID vererek çalıştırılabilir. Procedure'ü biz daha önceden oluşturduğumuz için yorum satırına aldık.
*/
