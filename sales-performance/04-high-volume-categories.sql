/*
Problem: 50'den fazla sipariş kalemi olan ürün kategorilerini bulmak
Kullanılan Teknikler: JOIN, GROUP BY, HAVING
*/
SELECT 
	pc.Name AS CategoryName,
	COUNT(*) AS OrderCount
FROM SalesLT.Product p
INNER JOIN SalesLT.SalesOrderDetail sod 
ON p.ProductID = sod.ProductID
INNER JOIN SalesLT.ProductCategory pc
ON p.ProductCategoryID = pc.ProductCategoryID
GROUP BY pc.Name
HAVING COUNT(*) > 50

/*
Kategori bazlı sipariş kalemi sayısına baktığımızda, en yüksek hacme sahip kategorinin 81 kalemle Touring Bikes, ikinci sırada 70 kalemle Mountain Bikes olduğu görülmüştür. Bu da müşterilerin bisiklet parçalarını ayrı ayrı almak yerine, özellikle tur ve dağ bisikletlerini komple/bütün halinde tercih ettiğine işaret ediyor. Bu doğrultuda üretim ve stok önceliği bu iki kategoriye verilebilir.
*/