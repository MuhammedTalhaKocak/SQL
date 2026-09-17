# SQL Mastery - WideWorldImporters

Microsoft'un WideWorldImporters örnek veritabanı üzerinde, ileri seviye SQL tekniklerini gerçek iş problemleri üzerinden gösteren bir pratik repo.

## Veritabanı
Microsoft WideWorldImporters (MSSQL / SSMS)
İndirme: https://github.com/Microsoft/sql-server-samples/releases/tag/wide-world-importers-v1.0
Hatırlatma: Bu repoda yukarıdaki linkteki dosyalardan WideWorldImporters-Full.bak adlı dosyayı kullandık.

## Klasör Yapısı
- `01-fundamentals/` → JOIN, GROUP BY, HAVING temelleri
- `02-aggregation-and-window-functions/` → RANK, LAG/LEAD, NTILE
- `03-cte-and-subqueries/` → CTE, Correlated Subquery
- `04-pivoting-and-reporting/` → PIVOT (tek ve çok boyutlu)
- `05-procedural-sql/` → Stored Procedure
- `06-transactions-and-error-handling/` → Transaction, TRY/CATCH
- `07-performance-optimization/` → Execution Plan, Index optimizasyonu

## Format
Her dosya: Problem tanımı → Kullanılan teknikler → Sorgu → İş yorumu

## Öne Çıkan Dosya
[`07-performance-optimization/01-stockitem-orderlines-lookup.sql`](07-performance-optimization/01-stockitem-orderlines-lookup.sql)
— Covering Index ile query performansını Columnstore Scan'den Index Seek'e 
düşürme süreci, execution plan cache sorunu dahil gerçekçi bir teşhis hikayesi

---
**Muhammed Talha Koçak** — [GitHub](https://github.com/MuhammedTalhaKocak)