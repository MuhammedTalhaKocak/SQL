/*
Problem: Bir ürünün fiyatını güncellerken, değişikliği önce kontrol edip istenirse geri alınabilir (rollback) hale getirmek
Kullanılan teknikler: BEGIN TRANSACTION, COMMIT, ROLLBACK
*/

-- Mevcut fiyatı kontrol ediyoruz
SELECT StockItemID, UnitPrice FROM Warehouse.StockItems WHERE StockItemID = 1;

BEGIN TRANSACTION;

UPDATE Warehouse.StockItems
SET UnitPrice = UnitPrice * 1.05
WHERE StockItemID = 1;

-- Değişikliği kontrol ediyoruz (henüz kalıcı değil)
SELECT StockItemID, UnitPrice FROM Warehouse.StockItems WHERE StockItemID = 1

-- Eğer sonuç doğruysa: COMMIT;
-- Eğer yanlışsa: ROLLBACK;
ROLLBACK

SELECT StockItemID, UnitPrice FROM Warehouse.StockItems WHERE StockItemID = 1 
-- ROLLBACK'in yaptığımız işlemi geri alıp almadığı kontrolündeyiz.
/*
Yorum: Transaction kullanmak, bir güncelleme öncesi "deneme" yapıp 
sonucu görüp, ardından karar verme imkanı sağlıyor — özellikle 
fiyatlandırma gibi geri dönüşü riskli işlemlerde veri bütünlüğünü 
korumak için kritik bir güvenlik katmanı.
*/