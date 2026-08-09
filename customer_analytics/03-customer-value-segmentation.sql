/* 
Problem: Müşterileri Segmentlere ayırmak, öncelikle harcama dağılımını göreceğiz.
Kullanılan teknikler: Subquery (iç sorgu), JOIN, GROUP BY, MIN/MAX/AVG
*/
WITH TotalSpends AS
(
SELECT
	c.CustomerID,
	SUM(soh.TotalDue) AS TotalSpend
FROM SalesLT.Customer c
INNER JOIN SalesLT.SalesOrderHeader soh
ON c.CustomerID = soh.CustomerID
GROUP BY c.CustomerID)
,Quartiles AS 
(
SELECT
	*,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY TotalSpend) OVER () AS Q1,
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY TotalSpend) OVER () AS Median,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY TotalSpend) OVER () AS Q3
FROM TotalSpends)
,Segments AS 
(
SELECT 
	CustomerID,
	TotalSpend,
	CASE
		WHEN TotalSpend < Q1 THEN 'Düşük Değerli'
		WHEN TotalSpend BETWEEN Q1 AND Q3 THEN 'Orta Değerli'
		ELSE 'Yüksek Değerli'
	END AS CustomerSegment
FROM Quartiles)
SELECT 
    'Müşteri Sayısı' AS [Segment], 
    COUNT(CASE WHEN CustomerSegment = 'Düşük Değerli' THEN 1 END) AS [Düşük Değerli],
    COUNT(CASE WHEN CustomerSegment = 'Orta Değerli' THEN 1 END) AS [Orta Değerli],
    COUNT(CASE WHEN CustomerSegment = 'Yüksek Değerli' THEN 1 END) AS [Yüksek Değerli]
FROM Segments

/*
Müşterileri harcama miktarlarına göre çeyrekliklere ayırdığımızda, 8 tane düşük, 16 tane orta ve 8 tane yüksek değerli müşteri olduğu belirlenmiştir.
*/