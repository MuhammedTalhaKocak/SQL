/* 
Amaç: Her ürün kategorisinde en çok gelir getiren ürünü bulmak (kategori bazında "şampiyon" ürün)
Kullanılan teknikler: CTE (çoklu), Window Function (RANK, PARTITION BY)
*/
WITH CategoryRevenue AS (
    SELECT 
        pc.Name AS CategoryName, 
        p.Name AS ProductName, 
        SUM(sod.LineTotal) AS Revenue
    FROM SalesLT.Product p
    INNER JOIN SalesLT.SalesOrderDetail sod ON p.ProductID = sod.ProductID
    INNER JOIN SalesLT.ProductCategory pc ON p.ProductCategoryID = pc.ProductCategoryID
    GROUP BY pc.Name, p.Name
),
[Category Rank] AS
(
SELECT 
    CategoryName,
    ProductName,
    Revenue,
    RANK() OVER (PARTITION BY CategoryName ORDER BY Revenue DESC) AS CategoryRank
FROM CategoryRevenue)
SELECT * FROM [Category Rank]
WHERE CategoryRank = 1
ORDER BY Revenue DESC
/*
Yorum: Her kategorinin lider ürünü listelendi. Üç ana bisiklet kategorisinde (Touring, Mountain, Road) en çok satan modeller birbirine yakın gelir üretiyor 
(~37K), bu da şirketin bu üç segmentte dengeli ve güçlü flagship ürünlere sahip olduğunu gösteriyor. Aksesuar kategorilerindeki (Chains, Tires, Bottles) 
lider ürünler ise çok düşük gelir üretiyor bu kategoriler ana gelir kaynağı değil, tamamlayıcı/ek satış ürünleri olarak konumlanıyor.
*/