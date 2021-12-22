	
/*===================================================
LIMIT
====================================================*/
/*invoices tablosunda Total değeri 10$'dan büyük olan ilk 4 kayıt'ın InvoiceId, 
InvoiceDate ve total bilgilerini sorgulayiniz */
SELECT InvoiceId, InvoiceDate,total
FROM invoices
WHERE total >10
LIMIT 4;
	
/*===================================================
ORDER BY
====================================================*/
	
/*invoices tablosunda Total değeri 10$'dan büyük olan kayıtları Total değerine göre 
ARTAN sırada sıralayarak sorgulayiniz */
SELECT *
FROM invoices
WHERE total >10
ORDER BY total ASC;  -- ORder By komutunu default değeri ASC dir.
	
/*invoices tablosunda Total değeri 10$'dan büyük olan kayıtlardan işlem tarihi 
(InvoiceDate) en yeni olan 10 kaydın tüm bilgilerini listeyiniz */ 
	
SELECT *
FROM invoices
WHERE total >10
ORDER BY InvoiceDate DESC
LIMIT 10;
	
/*===================================================
LOGICAL OPERATORS (AND,OR,NOT)
====================================================*/

/* invoices tablosunda ülkesi (BillingCountry) USA olmayan kayıtları total değerine
göre  AZALAN sırada listeyiniz */ 
	
SELECT * 
FROM invoices
WHERE NOT BillingCountry = 'USA'  -- WHERE BillingCountry <> 'USA'
ORDER BY total DESC;
	
/* invoices tablosunda, ülkesi (BillingCountry) USA veya Germany olan kayıtları, 
InvoiceId sırasına göre artan sırada listeyiniz */ 
	
SELECT *
FROM invoices
WHERE BillingCountry = "USA" OR  BillingCountry="Germany"
ORDER BY InvoiceId ASC;
	
/* invoices tablosunda fatura tarihi (InvoiceDate) 01-01-2012 ile 02-01-2013 
tarihleri arasındaki faturaların tüm bilgilerini listeleyiniz */ 
SELECT *
FROM invoices
WHERE InvoiceDate >= '2012-01-01' AND InvoiceDate <= '2013-01-02 00:00:00';
	
/* invoices tablosunda fatura tarihi (InvoiceDate) 2009 ila 2011 tarihleri arasındaki
en yeni faturayı listeleyen sorguyu yazınız */ 
	
SELECT *
FROM invoices
WHERE InvoiceDate  BETWEEN '2009-01-01 00:00:00'  AND  '2011-12-31 00:00:00'  
ORDER BY InvoiceDate DESC
LIMIT 1;
	
/*===================================================
IN
====================================================*/
/* customers tablosunda Belgium, Norway veya  Canada ,USA  ülkelerinden sipariş veren
müşterilerin FirstName, LastName, country bilgilerini listeyiniz	*/
	
SELECT FirstName, LastName,country
FROM customers
WHERE country IN('Belgium', 'USA', 'Norway', 'Canada');
	
/*===================================================
LIKE
====================================================*/
/* tracks tablosunda Composer sutunu Bach ile biten kayıtların Name bilgilerini 
listeyen sorguyu yazınız*/
SELECT name, Composer
FROM tracks
WHERE Composer LIKE '%Bach';
	
	
/* albulms tablosunda Title (başlık) sutununda Greatest içeren kayıtların tüm bilgilerini 
listeyen sorguyu yazınız*/
SELECT *
FROM albums
WHERE Title LIKE '%Greatest%';
	
/* invoices tablosunda, 2010 ve 2019 arası bir tarihte (InvoiceDate) Sadece şubat
aylarında gerçekleşmiş olan faturaların	tüm bilgilerini listeleyen sorguyu yazınız*/
	
SELECT *
FROM invoices
WHERE InvoiceDate like '201_-02%';
	
/* customers tablosunda, isimleri (FirstName) üç harfli olan müşterilerin FirstName, 
LastName ve City bilgilerini	listeleyen sorguyu yazınız*/
SELECT FirstName, LastName,City
FROM customers
WHERE FirstName like "___";
	
/* customers tablosunda, soyisimleri Sch veya Go ile başlayan müşterilerin FirstName, 
LastName ve City bilgilerini listeleyen sorguyu yazınız*/
SELECT FirstName, LastName,City
FROM customers
WHERE LastName LIKE 'Sch%' OR LastName LIKE 'Go%';
	