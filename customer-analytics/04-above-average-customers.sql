/*
Problem: Ortalama müşteri harcamasının üzerinde harcayan müşterileri bulmak.
Kullanılan Teknikler: SUBQUERY, GROUP BY, WHERE, ORDER BY, AVG
*/
WITH TotalExpenditures AS
(SELECT
	CustomerID,
	SUM(TotalDue) AS TotalSpend
FROM SalesLT.SalesOrderHeader
GROUP BY CustomerID)
SELECT * FROM TotalExpenditures
WHERE TotalSpend > (SELECT AVG(TotalSpend) FROM TotalExpenditures)

/*
-- Yöntem 2 (alternatif): Window Function ile
WITH TotalExpenditures AS (
    SELECT CustomerID, SUM(TotalDue) AS TotalSpend
    FROM SalesLT.SalesOrderHeader
    GROUP BY CustomerID
),
TotalAndAverageSpend AS (
    SELECT *, AVG(TotalSpend) OVER() AS AverageTotalSpend
    FROM TotalExpenditures
)
SELECT CustomerID, TotalSpend
FROM TotalAndAverageSpend
WHERE TotalSpend > AverageTotalSpend
*/

/*
Her bir müşterinin önce toplam harcamasını ardından bu toplam harcamalar üzerinden ortalama alıp bu ortalamanın üzerinde harcama yapan müşterileri bulduk. 32 kişiden tam 12 kişi ortalamanın üzerinde harcama yapıyor bu kişiler için şirket özel kampanyalar düzenleyerek gelirini artırabilir.
*/