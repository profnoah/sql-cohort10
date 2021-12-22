/*===================================================
SELECT
===================================================*/
/* tracks tablosundaki track isimlerini (name) sorgulayınız */
SELECT name FROM tracks;
	
/* tracks tablosundaki besteci(Composer) ve şarkı isimlerini (name) sorgulayınız*/
SELECT Composer,name FROM tracks;
	
/*tracks tablosundaki tüm bilgileri sorgulayınız*/
SELECT * FROM tracks;
	
	
/*===================================================
DISTINCT
===================================================*/
/*tracks tablosundaki composer bilgileri sorgulayınız (TEKRARLI OLABİLİR)*/
SELECT Composer FROM tracks;
		
/*tracks tablosundaki composer bilgileri sorgulayınız (TEKRARSIZ) */
SELECT DISTINCT Composer FROM tracks;
	
/*tracks tablosundaki AlbumId ve MediaTypeId bigilerini TEKRARSIZ olarak 
sorgulayınız */
SELECT DISTINCT AlbumId, MediaTypeId FROM tracks;
		
/*===================================================
WHERE
====================================================*/

/*Composer'ı Jimi Hendrix olan şarkıları sorgulayiniz*/
SELECT name 
FROM tracks 
WHERE Composer='Jimi Hendrix';
	
/* invoices tablosunda Total değeri 10$ dan büyük olan faturaların tüm bilgilerini 
sorgulayiniz */
SELECT * 
FROM invoices 
WHERE total>10;
