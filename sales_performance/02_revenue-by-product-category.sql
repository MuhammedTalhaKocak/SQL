/* 
Problem: Ürün Kategorisi Bazında Toplam Satış Geliri ve satılan ürün adedini bulma
*/

SELECT 
	pc.Name,
	SUM(sod.LineTotal) AS [TotalRevenue],
	SUM(sod.OrderQty) AS [TotalUnitsSold] 
FROM 
SalesLT.Product p
INNER JOIN SalesLT.SalesOrderDetail sod
ON p.ProductID = sod.ProductID
INNER JOIN SalesLT.ProductCategory pc
ON p.ProductCategoryID = pc.ProductCategoryID 
GROUP BY pc.Name
ORDER BY TotalRevenue DESC 

/* 
Tam bisikletler (Touring, Road, Mountain Bikes), sadece kadro satan kategorilere (Frames) göre çok daha fazla gelir ve adet üretiyor. 
Bu, müşterilerin büyük çoğunluğunun hazır/komple ürün tercih ettiğini, kendi bisikletini parça parça oluşturma (custom build) talebinin düşük olduğunu gösteriyor. 
Touring Bikes'in lider olması, şirketin uzun mesafe/konfor odaklı ürün hattının en güçlü segmenti olduğuna işaret ediyor pazarlama ve stok önceliği bu kategoriye verilebilir.
*/
