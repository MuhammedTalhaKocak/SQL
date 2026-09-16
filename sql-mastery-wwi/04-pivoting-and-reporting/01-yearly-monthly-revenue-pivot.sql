/*
Problem: Yıl bazında (satır), her ay bir sütun olacak şekilde (Jan-Dec) 
toplam geliri göstermek — Excel pivot table mantığında bir rapor
Kullanılan teknikler: PIVOT, JOIN (3 tablo)
*/
SELECT 
    OrderYear,
    [1] AS Jan, [2] AS Feb, [3] AS Mar, [4] AS Apr, [5] AS May, [6] AS Jun,
    [7] AS Jul, [8] AS Aug, [9] AS Sep, [10] AS Oct, [11] AS Nov, [12] AS Dec
FROM (
    SELECT 
        YEAR(so.OrderDate) AS OrderYear,
        MONTH(so.OrderDate) AS OrderMonth, 
        sol.ExtendedPrice
    FROM Sales.Orders so
    INNER JOIN Sales.Invoices si ON si.OrderID = so.OrderID
    INNER JOIN Sales.InvoiceLines sol ON si.InvoiceID = sol.InvoiceID
    WHERE YEAR(so.OrderDate) < 2016
) AS SourceData
PIVOT (
    SUM(ExtendedPrice)
    FOR OrderMonth IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
) AS PivotTable
ORDER BY OrderYear

/*
Yorum: 2015 yılının Temmuz ayı 5903050.86 ile en yüksek gelire sahipken, 2013 yılının şubat ayı 3203985.8 ile en düşük gelire sahiptir.
*/
