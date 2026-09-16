/*
Problem: Aylık bazda toplam sipariş sayısını bulmak
Kullanılan teknikler: YEAR(), MONTH(), GROUP BY
*/
SELECT 
    YEAR(OrderDate) AS OrderYear,
    MONTH(OrderDate) AS OrderMonth,
    COUNT(*) AS TotalOrders
FROM Sales.Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY OrderYear, OrderMonth

/*
Yorum: 2013-2015 yılları tam 12 aylık veri içeriyor, 2016 ise sadece 
5 aya kadar veri barındırıyor (muhtemelen veri seti bu tarihte kesilmiş). 
Yıllık karşılaştırma yapılırken 2016'nın eksik olduğu göz önünde 
bulundurulmalı, aksi halde yanlış bir "düşüş" yorumuna varılabilir.
*/