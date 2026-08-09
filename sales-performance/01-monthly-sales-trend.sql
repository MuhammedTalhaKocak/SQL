/* 
Aylık Bazda satış sayısı ve toplam geliri bulma (zaman serisi analizi)
Kullanılan Teknikler: MIN, MAX, COUNT, DISTINCT gibi betimsel istatistik fonksiyonları
*/

SELECT 
	MIN(OrderDate) AS EnEskiTarih, 
	MAX(OrderDate) AS EnYeniTarih, 
	COUNT(DISTINCT YEAR(OrderDate)) AS YilSayisi, 
	COUNT(DISTINCT MONTH(OrderDate)) AS AySayisi
FROM SalesLT.SalesOrderHeader

/* 
Elimizde zaman serisi analizi yapmak için yeterli veri bulunmadığından dolayı bu analizi gerçekleştiremiyoruz.
*/