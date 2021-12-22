
/*===================================================
 SUBQUERIES
====================================================*/

/* albums tablosundaki Title sutunu ‘Faceless’ olan kaydın albumid'si elde ederek 
tracks tablosunda bu değere eşit olan kayıtların bilgilerini SUBQUERY yazarak listeyiniz.
Listelemede trackid, name ve albumid bilgilerini bulunmalıdır. */

SELECT trackid, name, albumid
FROM tracks
WHERE albumid = (SELECT albumid FROM albums WHERE title = 'Faceless');
					
/* albums tablosundaki Title sutunu ‘Faceless’ olan kaydın albumid'si elde ederek 
tracks tablosunda bu değere eşit olan kayıtların bilgilerini JOIN kullanarak listeyiniz.
Listelemede trackid, name ve albumid bilgileri bulunmalıdır. */				
	
SELECT t.TrackId,  t.Name,  t.AlbumId
FROM tracks t
JOIN albums a 
ON t.AlbumId = a.AlbumId
WHERE a.Title = 'Faceless';
	
/* albums tablosundaki Title sutunu Faceless veya Let There Be Rock olan kayıtların 
albumid'lerini elde ederek tracks tablosunda bu id'lere eşit olan kayıtların bilgilerini 
SUBQUERY kullanarak listeyiniz. Listelemede trackid, name ve albumid bilgileri bulunmalıdır. */			
	
SELECT trackid,name,albumid
FROM tracks
WHERE albumid IN (SELECT AlbumId FROM albums
	WHERE title IN ('Faceless', 'Let There Be Rock'));
	
/* albums tablosundaki Title sutunu Faceless veya Let There Be Rock olan kayıtların 
albumid'lerini elde ederek tracks tablosunda bu id'lere eşit olan kayıtların bilgilerini 
JOIN kullanarak listeyiniz.Listelemede trackid, name ve albumid bilgileri bulunmalıdır. */	
	
SELECT t.trackid, t.name, t.albumid
FROM tracks t
JOIN albums a
ON t.AlbumId=a.AlbumId
WHERE title IN ('Faceless', 'Let There Be Rock');
	
/*===================================================
 DDL COMMANDS (CREATE TABLE, DROP TABLE,ALTER TABLE)
====================================================*/	
	
/*------------------------------------------------------------------------------------------
/*  CREATE TABLE
/*------------------------------------------------------------------------------------------
	
/*personel adinda bir tablo oluşturunuz.  Tabloda first_name, last_name 
age(INT) ve hire_date (Date) sutunuları bulunmalıdır.	*/
CREATE TABLE personel (
	first_name VARCHAR(20),
	last_name VARCHAR(20),
	age INT,
	hire_date DATE
);
	
/* Aynı isimle yeniden bir veritabanı oluşturulmak istenirse hata verir. Bu hatayı
almamak için IF NOT EXISTS keywordu kullanılabilir */
CREATE TABLE IF NOT EXISTS  personel (
	first_name VARCHAR(20),
	last_name VARCHAR(20),
	age INT,
	hire_date DATE
);
	
/*Veritabanında vacation_plan adında yeni bir tablo oluşturunuz.  Sutun isimleri
place_id, country, hotel_name, employee_id, vacation_length,budget 	*/

CREATE TABLE vacation_plan(
	place_id INT,
	country TEXT,
	hotel_name TEXT,
	employee_id INT,
	vacation_lenght INT,
	budget REAL
);

/*------------------------------------------------------------------------------------------
/*  DROP TABLE
/*------------------------------------------------------------------------------------------
/* personel tablosunu siliniz */
DROP TABLE personel;
	
/* Bir tabloyu silerken tablo bulunamazsa hata verir. BU hatayı görememek için
IF EXISTS keywordu kullanılabilir.*/
DROP TABLE IF EXISTS personel;
	
-- NOT: SQL'de TRUNCATE TABLE komutu bulunmasına karşın SQLite bu komutu 
-- desteklememektedir. Truncate komutu  bir tabloyu değil içindeki tüm verileri 
-- silmek için kullanılır.

	
/*------------------------------------------------------------------------------------------
/*  INSERT INTO
/*----------------------------------------------------------------------------------------*/

/* vacation_plan tablosuna 2 kayıt gerçekletiriniz.*/
INSERT INTO vacation_plan VALUES(34, 'Turkey', 'Happy Hotel',134, 7, 3000);
INSERT INTO vacation_plan VALUES(48, 'Turkey', 'Beach Hotel',100, 10, 5000);
	
-- NOT: Aynı komut tekrar çalıştırılırsa herhangi bir kısıt yoksa ise aynı veriler
-- tekrar tabloya girilmiş olur. 
	
/*vacation_plan tablosuna vacation_lenght ve budget sutunlarını eksik olarak veri girişi 
yapınız*/
INSERT INTO vacation_plan (place_id,	country, hotel_name, employee_id ) 
VALUES(35, 'Turkey', 'Comfort Hotel',144);
-- NOT : giriş yapılmayan sutunlara NULL atanır.
	
/*------------------------------------------------------------------------------------------
/*  CONSTRAINTS - KISITLAMALAR 
/*-----------------------------------------------------------------------------------------

NOT NULL - Bir Sütunun NULL içermemesini garanti eder. 

UNIQUE - Bir sütundaki tüm değerlerin BENZERSİZ olmasını garanti eder.  

PRIMARY KEY - Bir sütünün NULL içermemesini ve sütundaki verilerin 
 BENZERSİZ olmasını garanti eder.(NOT NULL ve UNIQUE birleşimi gibi)

FOREIGN KEY - Başka bir tablodaki Primary Key’i referans göstermek için kullanılır. 
 Böylelikle, tablolar arasında ilişki kurulmuş olur. 

 DEFAULT - Herhangi bir değer atanmadığında Başlangıç değerinin atanmasını sağlar.
/*----------------------------------------------------------------------------------------*/
	
CREATE TABLE workers(
	id INTEGER PRIMARY KEY,
	id_number VARCHAR(11) UNIQUE NOT NULL,
	name TEXT DEFAULT 'NONAME',
	salary INTEGER NOT NULL
);
    
INSERT INTO workers VALUES(1, '12345678910','AHMET CAN', 7000 );
INSERT INTO workers VALUES( 2, '12345678910', 'MUSTAFA ALİ', 12000);  -- HATA (UNIQUE)
INSERT INTO workers  (id,	id_number, salary) VALUES(3, '12345223465', 5000);
INSERT INTO workers VALUES(4, '44343323465' , 'AYHAN BAK',NULL) -- HATA (NOT NULL)

/*vacation_plan tablosunu place_id sutunu PK ve employee_id sutununu ise FK olarak  değiştirirek
vacation_plan2 adinda yeni bir tablo oluşturunuz. Bu tablo, employees tablosu ile ilişkili olmalıdır*/ 

CREATE TABLE vacation_plan2(
	place_id INT,
	country TEXT,
	hotel_name TEXT,
	employee_id INT,
	vacation_lenght INT,
	budget REAL,
	PRIMARY KEY(place_id),
	FOREIGN KEY(employee_id) REFERENCES employees(EmployeeId)
);

/* Employees tablosundaki EmployeeId'si 1 olan kişi için bir tatil planı giriniz.*/
INSERT INTO vacation_plan2 VALUES(34,'TR',	'HAPPY HOTEL',1,5,5660);
	
/* Employees tablosunda bulunmayan bir kişi için (EmployeeId=9) olan kişi için bir tatil planı giriniz.*/
INSERT INTO vacation_plan2 VALUES(48,'TR',	'COMFORT HOTEL',9,10,7000);  --HATA
	
/*JOIN işlemi ile 2 tablodan veri çekme*/
SELECT e.FirstName,e.LastName,v.hotel_name, v.vacation_lenght
FROM employees e
JOIN vacation_plan2 v
ON e.EmployeeId=v.employee_id;

/*------------------------------------------------------------------------------------------
/*  ALTER TABLE (ADD, RENAME TO, DROP)
/*  SQLITE MODIFY VE DELETE KOMUTLARINI DOĞRUDAN DESTEKLENMEZ
/*------------------------------------------------------------------------------------------
	
/*vacation_plan2 tablosuna name adında ve DEFAULT değeri noname olan 
yeni bir sutun ekleyelim */
	
ALTER TABLE vacation_plan2
ADD name TEXT DEFAULT 'noname';
	
/*vacation_plan2 tablosundaki name sutununu siliniz*/
ALTER TABLE vacation_plan2
DROP COLUMN name ;					
	
/* workers tablosunun adını people olarak değiştiriniz */
ALTER TABLE workers
RENAME TO people;

/*------------------------------------------------------------------------------------------
/*  UPDATE,DELETE
-- SYNTAX
----------
-- UPDATE tablo_adı
-- SET sutun1 = yeni_deger1, sutun2 = yeni_deger2,...  
-- WHERE koşul;
		
--DELETE tablo_adı
--WHERE koşul;
/*-----------------------------------------------------------------------------------------*/
   
/*vacation_plan2 tablosundaki employee_id=1 olan kaydini  hotel_name'ini Komagene Hotel olarak
güncelleyiniz.*/
   
UPDATE vacation_plan2
SET hotel_name = 'Komagene Hotel'
WHERE employee_id = 1;
   
/* people tablosunda salary sutunu 7000 'den az olanların salary(maaşına)
%10 zam yapacak sorguyu yazınız*/ 
   
UPDATE people
SET salary = salary*1.2
WHERE salary < 7000;
   
/*people tablosundaki tüm kayıtkarın salary sutununu 10000 olarak güncelleyiniz */
UPDATE people
SET salary=10000;
   
/*vacation_plan2 tablosundaki employee_id=1 olan kaydı siliniz*/
DELETE FROM vacation_plan2
WHERE employee_id=1;
  