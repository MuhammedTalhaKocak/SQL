/*
Problem: Aydan aya sipariş sayısındaki büyümeyi hesaplamak ve uç değerleri doğrulamak
Kullanılan teknikler: CTE (çoklu), LAG, Window Function
*/
WITH OrderCounts AS (
    SELECT 
        YEAR(OrderDate) AS OrderYear,
        MONTH(OrderDate) AS OrderMonth,
        COUNT(*) AS TotalOrders
    FROM Sales.Orders
    GROUP BY YEAR(OrderDate), MONTH(OrderDate)
),
WithPreviousMonth AS (
    SELECT 
        *,
        LAG(TotalOrders) OVER (ORDER BY OrderYear, OrderMonth) AS PreviousMonthOrders
    FROM OrderCounts
)
SELECT 
    *,
    CAST((TotalOrders - PreviousMonthOrders) * 100.0 / PreviousMonthOrders AS DECIMAL(5,2)) AS GrowthPercentage
FROM WithPreviousMonth

/*
Yorum: 2013 Mart ayında %47.76'lık dikkat çekici bir artış görüldü. Bunun 
veri eksikliğinden mi yoksa gerçek talepten mi kaynaklandığını doğrulamak 
için günlük ortalama sipariş yoğunluğuna bakıldı: Şubat'ta aktif gün 
başına 47.46 sipariş, Mart'ta 64.73 sipariş. Bu, artışın sadece "daha 
fazla aktif gün" olmasından değil, gerçek bir talep artışından 
kaynaklandığını doğruluyor.
*/
SELECT 
    YEAR(OrderDate) AS OrderYear,
    MONTH(OrderDate) AS OrderMonth,
    COUNT(*) AS TotalOrders,
    COUNT(DISTINCT DAY(OrderDate)) AS DaysWithOrders,
    CAST(COUNT(*) * 1.0 / COUNT(DISTINCT DAY(OrderDate)) AS DECIMAL(5,2)) AS AvgOrdersPerActiveDay
FROM Sales.Orders
WHERE (YEAR(OrderDate) = 2013 AND MONTH(OrderDate) IN (2,3))
GROUP BY YEAR(OrderDate), MONTH(OrderDate)