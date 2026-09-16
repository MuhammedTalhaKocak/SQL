/*
Problem: Tedarikçi kategorisi bazında toplam satın alma maliyetini bulmak
Kullanılan teknikler: JOIN (4 tablo), GROUP BY, SUM, COUNT
*/
SELECT 
    sc.SupplierCategoryName,
    COUNT(*) AS LineCount,
    SUM(pol.OrderedOuters * pol.ExpectedUnitPricePerOuter) AS TotalPurchaseCost
FROM Purchasing.SupplierCategories sc
INNER JOIN Purchasing.Suppliers s ON sc.SupplierCategoryID = s.SupplierCategoryID
INNER JOIN Purchasing.PurchaseOrders po ON s.SupplierID = po.SupplierID
INNER JOIN Purchasing.PurchaseOrderLines pol ON po.PurchaseOrderID = pol.PurchaseOrderID
GROUP BY sc.SupplierCategoryName
ORDER BY TotalPurchaseCost DESC

/*
Yorum: Clothing Supplier kategorisi hem satır sayısında (5802) hem toplam 
maliyette (679M) açık ara lider — bu, şirketin tedarik hacminin büyük 
kısmının giyim kategorisinde yoğunlaştığını gösteriyor. İlk bakışta 
Clothing/Packaging'in rakamları anormal büyük görünse de, satır sayısı 
kontrolü bunun gerçek hacim farkından kaynaklandığını doğruluyor — 
tekil bir veri hatası değil.
*/