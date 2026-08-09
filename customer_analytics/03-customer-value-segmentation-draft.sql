/*
Bu dosya, customer-analytics/03-customer-value-segmentation.sql sorgusunun geliştirme sürecini içerir (denemeler, ara adımlar, bütün yorumlar).
*/
/* 
Problem: Müşterileri Segmentlere ayırmak, öncelikle harcama dağılımını göreceğiz.
Kullanılan teknikler: Subquery (iç sorgu), JOIN, GROUP BY, MIN/MAX/AVG
*/
/*
WITH harcamalar AS
(
SELECT
	c.CustomerID,
	SUM(soh.TotalDue) AS total_spend
FROM SalesLT.Customer c
INNER JOIN SalesLT.SalesOrderHeader soh
ON c.CustomerID = soh.CustomerID
GROUP BY c.CustomerID)
SELECT
	ROUND(MIN(total_spend),2) AS min_harcama,
	ROUND(MAX(total_spend),2) AS max_harcama,
	ROUND(AVG(total_spend),2) AS avg_harcama
FROM harcamalar */
/* 
Verimizdeki uç değerlerden dolayı aşağıda medyan tabanlı bir segmentasyon yapacağız. Öncelikle çeyreklikleri bulalım.
*/

/*
WITH harcamalar1 AS
(
SELECT
	c.CustomerID,
	SUM(soh.TotalDue) AS total_spend
FROM SalesLT.Customer c
INNER JOIN SalesLT.SalesOrderHeader soh
ON c.CustomerID = soh.CustomerID
GROUP BY c.CustomerID
)
SELECT DISTINCT
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total_spend) OVER () AS Q1,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY total_spend) OVER () AS Median,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY total_spend) OVER () AS Q3
FROM harcamalar1 
*/
/*
Medyan (3714), ortalamadan (29884) çok daha düşük bu, müşterilerin çoğunluğunun aslında düşük-orta seviyede harcadığını, ama az sayıda çok yüksek harcayan müşterinin ortalamayı yukarı çektiğini gösteriyor. Bu yüzden segmentasyon için ortalama yerine medyan/quartile tabanlı eşikler kullanmak daha doğru bir yaklaşım olacak.
*/

WITH TotalSpends AS
(
SELECT
	c.CustomerID,
	SUM(soh.TotalDue) AS total_spend
FROM SalesLT.Customer c
INNER JOIN SalesLT.SalesOrderHeader soh
ON c.CustomerID = soh.CustomerID
GROUP BY c.CustomerID)
,Quartiles AS 
(
SELECT
	*,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total_spend) OVER () AS Q1,
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY total_spend) OVER () AS Median,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY total_spend) OVER () AS Q3
FROM TotalSpends)
,Segments AS 
(
SELECT 
	CustomerID,
	total_spend,
	CASE
		WHEN total_spend < Q1 THEN 'Düsük Degerli'
		WHEN total_spend BETWEEN Q1 AND Q3 THEN 'Orta Degerli'
		ELSE 'Yüksek Degerli'
	END AS CustomerSegment
FROM quartiles)
SELECT 
    'Müşteri Sayisi' AS [Segment], -- Burası sizin "Index" sütununuz olur
    COUNT(CASE WHEN CustomerSegment = 'Düsük Degerli' THEN 1 END) AS [Düsük Degerli],
    COUNT(CASE WHEN CustomerSegment = 'Orta Degerli' THEN 1 END) AS [Orta Degerli],
    COUNT(CASE WHEN CustomerSegment = 'Yüksek Degerli' THEN 1 END) AS [Yüksek Degerli]
FROM Segments

/*
Müşterileri harcama miktarlarına göre çeyrekliklere ayırdığımızda, 8 tane düşük, 16 tane orta ve 8 tane yüksek değerli müşteri olduğu belirlenmiştir.
*/