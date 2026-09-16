/*
Problem: bazında toplam satış gelirini bulma
Kullanılan Teknikler: INNER JOIN, GROUP BY
*/
SELECT 
    sg.StockGroupName,
    SUM(ol.Quantity * ol.UnitPrice) AS TotalRevenue
FROM Sales.OrderLines ol
INNER JOIN Warehouse.StockItems si ON ol.StockItemID = si.StockItemID
INNER JOIN Warehouse.StockItemStockGroups sisg ON si.StockItemID = sisg.StockItemID
INNER JOIN Warehouse.StockGroups sg ON sisg.StockGroupID = sg.StockGroupID
GROUP BY sg.StockGroupName
ORDER BY TotalRevenue DESC