/*
Problem: Faturası kesilmemiş siparişleri bulmak
Kullanılan teknikler: LEFT JOIN, IS NULL
*/
SELECT o.OrderID
FROM Sales.Orders o
LEFT JOIN Sales.Invoices i
ON o.OrderID = i.OrderID
WHERE i.InvoiceID IS NULL

/*
Yorum: 3085 sipariş için henüz fatura kesilmemiş. Bu, ya siparişlerin 
işlem sürecinde bekliyor olduğunu ya da faturalama sürecinde bir 
aksama olduğunu gösteriyor — operasyon ekibinin bu siparişleri 
önceliklendirmesi gerekebilir.
*/