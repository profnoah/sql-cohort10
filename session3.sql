
/*===================================================
	AGGREGATE FUNCTION COUNT,SUM,MIN,MAX, AVG)
====================================================*/
	
-- COUNT
-------------------------------------------------------------------------------------------------	
/* invoices tablosunda kaç adet fatura bulunduğunu döndüren sorgu yazınız */
SELECT COUNT(*)
FROM invoices;
	
SELECT COUNT(InvoiceId) AS num_of_invoice
FROM invoices;
		
/* tracks tablosunda kaç adet farklı Composer bulunduğunu döndüren sorguyu yazınız*/
SELECT COUNT(DISTINCT Composer) AS besteci_sayisi
FROM tracks;
	
/* ÖDEV: invoices tablosunda kaç adet farklı yıl olduğunu hesaplayan sorguyu yazınız*/ 
	
	
-- MIN,MAX
-------------------------------------------------------------------------------------------------	
/* tracks tablosundaki şarkı süresi en kısa olan şarkının adını ve süresi listeleyen
sorguyu yaziniz */
	
SELECT name as Song_Name, min(Milliseconds)/1000.0 as Duration
FROM tracks;
	
/*students tablosundaki en düşük ve en yüksek notu listeleyen sorguyu yazınız */
SELECT MIN(Grade), MAX(Grade)
FROM students;
	
-- SUM,AVG
-------------------------------------------------------------------------------------------------	
/* invoices  tablosundaki faturaların toplam değerini listeyiniz */
	
SELECT SUM(total) AS Toplam_Gelir
FROM invoices;
	
/* ÖDEV: invoices  tablosunda 2009 ile 2013(TAMAMI DAHİL) tarihileri arasındaki faturaların toplam
değerini listeyiniz */
	
/* invoices  tablosundaki faturaların ortalama değerini listeyiniz */
SELECT ROUND(AVG(total),2) as ortalama_gelir
FROM invoices;
	
/* tracks tablosundaki şarkıların ortalama süresinden daha uzun olan 
şarkıların adlarını listeleyiniz */
SELECT ROUND(AVG(Milliseconds))
FROM tracks;
	
SELECT Name, Milliseconds
FROM tracks
WHERE Milliseconds > 393599;
	
/*Bu yöntem hard-coded olduğu için çok mantıklı bir çözüm değil. 
alt-sorgu(sub-query) ile daha doğru bir yaklaşım olacaktır sonraki 
bölümlerde alt-sorguyu ayrıntılı bir şekilde inceleyeceğiz.*/
	
SELECT Name, Milliseconds
FROM tracks
WHERE Milliseconds > (SELECT AVG(Milliseconds) FROM tracks);
					
/*===================================================
 GROUP BY
====================================================*/

/* tracks tablosundaki her bir Bestecisinin (Composer) toplam şarkı sayısını 
Besteci adına göre gruplandırarak listeleyen sorguyu yazınız. */
	
SELECT Composer, COUNT(name) AS Song_Count
FROM tracks
WHERE Composer IS NOT NULL
GROUP BY Composer;
	
/* customers tablosundaki müşterilerin sayılarını Ülkelerine (Country) göre gruplandırarak 
ve müşteri sayısına göre AZALAN şekilde sıralayarak listeleyen sorguyu yazınız*/
SELECT country, COUNT(FirstName) as nu_of_cust
FROM customers
GROUP BY country
ORDER BY nu_of_cust DESC;
	
/* customers tablosundaki müşterilerin sayılarını Ülkelerine (Country) ve Şehirlerine (City) 
göre gruplandırarak listeleyen sorguyu yazınız*/
SELECT country, City, COUNT(FirstName) as nu_of_cust
FROM customers
GROUP BY country, City;
		
/* invoices tablosundaki her bir ülkenin (BillingCountry) fatura ortalamalarını 
hesaplayan ve ülke bilgileri ile listeleyen sorguyu yazınız.*/
SELECT BillingCountry, ROUND(AVG(total)) as ort_fatura
FROM invoices
WHERE InvoiceDate BETWEEN '2009-01-01' AND '2011-12-31 23:59:59'
GROUP BY BillingCountry;
		
/*===================================================
 JOINS
====================================================*/
    
-- Join islemleri farkli tablolardan secilen sutunlar ile yeni bir tablo 
-- olusturmak icin kullanilabilir.
--     
-- JOIN islemleri Iliskisel Veritabanlari icin cok onemli bir ozelliktir. Çunku
-- Foreign Key'ler ile iliskili olan tablolardan istenilen sutunlari cekmek 
-- icin JOIN islemleri kullanilabilir.

-- Standart SQL'de en çok kullanılan Join islemleri:
-- 1) FULL JOIN:  Tablodaki tum sonuclari gosterir
-- 2) INNER JOIN:  Tablolardaki ortak olan sonuc kumesini gosterir
-- 3) LEFT JOIN:  Ilk tabloda (Sol) olup digerinde olmayan sonuclari gosterir
-- 4) RIGHT JOIN: Sadece Ikinci tabloda olan tum sonuclari gosterir.

--	NOT: SQLite Sadece INNER, LEFT VE CROSS JOIN İşlemlerini desteklemektedir.
 
/*===================================================*/   

/* araclar.db adındaki veritabanını kullanarak Markalar ve Siparisler tablolarındaki 
marka_id’si ayni olan kayıtların marka_id, marka_adi, siparis_adedi ve siparis_tarihi   
bilgilerini  listeleyen bir sorgu yaziniz.*/
 
SELECT * FROM markalar;
SELECT * FROM siparisler;
 
SELECT markalar.marka_id,markalar.marka_adi,
siparisler.siparis_adedi, siparisler.siparis_tarihi
FROM markalar
INNER JOIN siparisler 
ON markalar.marka_id = siparisler.marka_id;
 
/* Markalar ve Siparisler tablolarındaki tüm araç markalarının siparis bilgilerini
(marka_id,marka_adi,siparis_adedi,siparis_tarihi) listeleyen bir sorgu yaziniz.*/
	
SELECT m.marka_id, m.marka_adi, s.siparis_adedi, s.siparis_tarihi
FROM markalar m
LEFT JOIN siparisler s ON  s.marka_id = m.marka_id;
	
/* Chinook veritabanındaki tracks tablosunda bulunan her bir şarkının türü'nü (genre)
listeleyiniz.*/

SELECT * FROM tracks; 
SELECT * FROM genres;
	
SELECT t.Name, g.name as Genre
FROM tracks t
JOIN genres g 
ON t.GenreId = g.GenreId;
	 
/* invoice tablosundaki faturaların her birinin müşteri adını (FirstName),
soyadını (lastName), fatura tarihini (InvoiceDate) ve fatura meblağını (total) 
listeleyen sorguyu yazınız */
 
SELECT * FROM invoices;
SELECT * FROM customers;
	 
SELECT c.FirstName, c.LastName, i.InvoiceDate,i.total
FROM invoices i
JOIN customers c 
ON i.CustomerId = c.CustomerId;
	
/* artists tablosunda bulunan tüm kişilerin albums tablosunda 
bulunan albümlerini listeleyen sorguyu yazınız. 
Sorguda ArtistId, Name, Title ve AlbumId olmalıdır */
 
SELECT * FROM artists;
SELECT * from albums;
	
SELECT ar.ArtistId,  ar.Name, al.Title, al.AlbumId 
FROM artists ar
LEFT JOIN albums al
ON al.ArtistId = ar.ArtistId;
 
