# SQL Business Problems - AdventureWorksLT Database

Bu repository gerçek iş problemlerini SQL ile çözüp, sonuçları yorumladığım sorgu dosyalarını içermektedir.

## Veritabanı
Microsoft AdventureWorksLT (MSSQL / SSMS) — satış, müşteri ve ürün verisi içeren hafifletilmiş örnek veritabanı.
Bu veritabanı'nı aşağıdaki linkten bilgisayarınızdaki MSSQL sürümüne uygun olarak `hafif` seçeneğini seçerek indirebilirsiniz.
- veritabanı indirme linki: https://learn.microsoft.com/tr-tr/sql/samples/adventureworks-install-configure?view=sql-server-ver17&tabs=ssms

## Klasör Yapısı
- `customer-analytics/` → müşteri segmentasyonu, gelir analizi, aktivasyon
- `sales-performance/` → kategori/ürün bazlı satış performansı
- `drafts/` → geliştirme sürecindeki ara denemeler (öğrenme sürecini şeffaf tutmak için)

## Kullanılan Teknikler
JOIN (INNER/LEFT), GROUP BY, Window Functions (RANK, PARTITION BY), 
CTE (çoklu/zincirleme), PERCENTILE_CONT (Çeyreklikler), CASE WHEN, Conditional Aggregation,
Execution Plan analizi, Index optimizasyonu (Covering Index, Key Lookup)

## Format
Her dosya: Problem tanımı → Kullanılan teknikler → Sorgu → İş yorumu şeklinde ilermektedir.

## Öne Çıkan Dosya
[`customer-analytics/03-customer-value-segmentation.sql`](customer-analytics/03-customer-value-segmentation.sql) 
Medyan/quartile tabanlı müşteri segmentasyonu (ortalamanın uç değerlerden 
etkilenme sorununu tespit edip istatistiksel olarak daha sağlam bir çözüme geçiş)

---
**Muhammed Talha Koçak** — [GitHub](https://github.com/MuhammedTalhaKocak)