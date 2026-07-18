--Q1: Korrelyasiya olunmuş Alt Sorğunun (Correlated Subquery) JOIN-ə Çevrilməsi
-- PROBLEM (Qeyri-effektiv variant):
-- Aşağıdakı sorğu hər bir məhsul üçün alt sorğunu yenidən işlədir (O(N^2) mürəkkəblik).
-- Bu da böyük verilənlər bazalarında ciddi gecikmələrə səbəb olur:
--DIQQET! BU SORĞU O(n^2) MÜRƏKKƏBLİKDƏ İCRA OLUNARAQ YADDAŞI ZƏİFLƏDƏCƏK
SELECT p.ProductName, 
(SELECT c.CategoryName FROM Categories c WHERE c.CategoryID = p.CategoryID)
FROM Products p;
-- HƏLL (Optimallaşdırılmış variant - JOIN):
-- Eyni məntiqi INNER JOIN ilə yazdıqda verilənlər bazası cədvəlləri bir dəfə oxuyur
-- və kəsişən indekslər üzərindən çox sürətlə birləşdirir.
SELECT 
    p.ProductName AS MehsulAdi,
    c.CategoryName AS KateqoriyaAdi
FROM Products p
INNER JOIN Categories c ON p.CategoryID = c.CategoryID;


-- Q2: İndekslərin Yaradılması və Performansın Artırılması (Index Optimization)
-- İzahı:
-- Əgər biz tez-tez Orders (Sifarişlər) cədvəlində "OrderDate" (Sifariş Tarixi) 
-- sütununa görə filtrləmə (WHERE) və ya sıralama (ORDER BY) ediriksə, SQL mühərriki 
-- hər dəfə bütün cədvəli başdan ayağa skan etməli olur (Table Scan).
-- Aşağıdakı əmr "OrderDate" sütunu üzərində bir indeks (B-Tree strukturu) yaradır.
-- Bu indeks kitabın arxasındakı "mündəricat" kimi işləyərək axtarış sürətini minlərlə dəfə artırır.
CREATE INDEX IF NOT EXISTS idx_orders_orderdate 
ON Orders(OrderDate);


-- Q3: İndeks Yaradıldıqdan Sonra Sürətli İşləyən Nümunə Sorğu
-- İzahı: 
-- Artıq yuxarıda yaratdığımız indeks sayəsində verilənlər bazası bu tarixi 
-- bütün cədvəli axtarmadan, birbaşa nöqtə satışı olaraq (Index Seek) tapacaq.
SELECT 
    OrderID, 
    CustomerID, 
    OrderDate 
FROM Orders
WHERE OrderDate >= '1997-01-01'
ORDER BY OrderDate DESC;