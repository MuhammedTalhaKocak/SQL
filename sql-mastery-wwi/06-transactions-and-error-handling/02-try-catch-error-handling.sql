/*
Problem: Bir güncelleme işlemini hata durumuna karşı güvenli hale getirmek 
— hata oluşursa otomatik geri alma (rollback) yapılmasını sağlamak
Kullanılan teknikler: TRY/CATCH, TRANSACTION, ERROR_MESSAGE()
*/
BEGIN TRY
    BEGIN TRANSACTION;
    
    UPDATE Warehouse.StockItems
    SET UnitPrice = UnitPrice * 1.05
    WHERE StockItemID = 1;
    
    SELECT 1/0;  -- Kasıtlı hata (test amaçlı)
    
    COMMIT;
    PRINT 'İşlem başarılı, değişiklik kaydedildi.';
END TRY
BEGIN CATCH
    ROLLBACK;
    PRINT 'Hata oluştu, değişiklik geri alındı: ' + ERROR_MESSAGE();
END CATCH

/*
Yorum: SELECT 1/0 ile kasıtlı olarak "divide by zero" hatası üretildi. 
TRY bloğu hatayı yakaladı, CATCH bloğu otomatik olarak devreye girdi, 
ROLLBACK ile fiyat değişikliği geri alındı ve hata mesajı ekrana yazdırıldı. 
Bu yapı, çok adımlı işlemlerde (örn. stok güncelleme + sipariş oluşturma) 
veri bütünlüğünü garanti altına almak için kritik.
*/