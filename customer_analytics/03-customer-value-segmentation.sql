/* 
Problem: Müşterileri Segmentlere ayırmak, öncelikle harcama dağılımını göreceğiz.
Kullanılan teknikler: Subquery (iç sorgu), JOIN, GROUP BY, MIN/MAX/AVG
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