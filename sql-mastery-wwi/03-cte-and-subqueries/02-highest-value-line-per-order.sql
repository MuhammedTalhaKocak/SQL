/*
Problem: Her faturanın en yüksek tutarlı kalemini (satırını) bulmak
Kullanılan teknikler: Correlated Subquery
*/
SELECT il.InvoiceID, il.StockItemID, il.ExtendedPrice
FROM Sales.InvoiceLines il
WHERE il.ExtendedPrice = (
    SELECT MAX(il2.ExtendedPrice)
    FROM Sales.InvoiceLines il2
    WHERE il2.InvoiceID = il.InvoiceID
)

/*
Yorum: 70510 benzersiz fatura için 71273 satır döndü — aradaki 763 
satırlık fark, bazı faturalarda birden fazla kalemin aynı (en yüksek) 
tutara sahip olmasından (eşitlik/tie durumu) kaynaklanıyor. Bu, 
correlated subquery'nin "eşit olan tüm satırları" getirdiğini, 
sadece tekil bir kayıt garantisi vermediğini gösteren önemli bir detay.
*/