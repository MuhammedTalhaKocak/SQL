/*
Problem: Belirli bir StockItemID'ye ait sipariş kalemlerini bulurken 
performansı ölçmek ve index ile iyileştirmek
Kullanılan teknikler: Execution Plan analizi, Covering Index (NONCLUSTERED + INCLUDE)
*/

-- ÖNCESİ: Index yok, mevcut Columnstore Index kullanılıyor
SELECT OrderID, StockItemID, Quantity, UnitPrice
FROM Sales.OrderLines
WHERE StockItemID = 10;
-- Execution Plan: Columnstore Index Scan, 231412 satır okunuyor (tüm tablo)

-- İYİLEŞTİRME: Covering Index oluştur
CREATE NONCLUSTERED INDEX IX_StockItemID
ON Sales.OrderLines (StockItemID)
INCLUDE (OrderID, Quantity, UnitPrice);

-- SONRASI: Yeni index kullanılıyor
SELECT OrderID, StockItemID, Quantity, UnitPrice
FROM Sales.OrderLines
WHERE StockItemID = 10;
-- Execution Plan: Index Seek, sadece 1068 satır okunuyor

/*
Yorum: Index eklenmeden önce SQL Server, tablonun mevcut Columnstore 
Index'ini kullanarak 231412 satırın tamamını tarıyordu (%0.46'lık bir 
filtre için bile). Covering Index eklendikten sonra SQL Server Index 
Seek'e geçti, sadece filtrelenen 1068 satırı okudu — I/O maliyeti 
ciddi oranda azaldı. Not: İlk denemede execution plan cache'i eski 
planı gösterdiği için değişiklik görünmedi; ALTER DATABASE SCOPED 
CONFIGURATION CLEAR PROCEDURE_CACHE ile cache temizlenince gerçek 
kazanım gözlemlenebildi — bu, gerçek ortamlarda index performans 
testi yaparken dikkat edilmesi gereken önemli bir detay.
*/