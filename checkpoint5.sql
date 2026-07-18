-- Q1: ROW_NUMBER() və RANK() funksiyaları
-- Tələb: Məhsulları kateqoriyalarına görə qruplaşdırıb, qiymətlərinə görə 
-- sıralayaraq həm unikal sətir nömrəsi, həm də reytinq (dərəcə) vermək.
-- İzahı:
-- 1. PARTITION BY c.CategoryID -> Məhsulları kateqoriya üzrə alt pəncərələrə bölür.
-- 2. ORDER BY p.UnitPrice DESC -> Hər kateqoriya daxilində ən baha məhsuldan başlayır.
-- 3. ROW_NUMBER() -> Qiyməti eyni olan məhsullar olsa belə, hər sətirə unikal ardıcıl nömrə verir.
-- 4. RANK() -> Qiyməti eyni olan məhsullara eyni dərəcəni verir (məsələn, iki məhsul 2-ci olarsa, növbətini 4 edir)
SELECT 
    c.CategoryName AS KateqoriyaAdi,
    p.ProductName AS MehsulAdi,
    p.UnitPrice AS Qiymet,
    ROW_NUMBER() OVER(PARTITION BY c.CategoryID ORDER BY p.UnitPrice DESC) AS SetirNomresi,
    RANK() OVER(PARTITION BY c.CategoryID ORDER BY p.UnitPrice DESC) AS QiymetReytinqi
FROM Products p
INNER JOIN Categories c ON p.CategoryID = c.CategoryID;


-- Q2: SUM() OVER ilə Artan Cəm (Running Total) Hesablanması
-- Tələb: Müştəri sifarişlərinin zaman oxu üzrə kumulyativ (artan cəmlə) 
-- gedişatını izləmək.
-- İzahı:
-- 1. PARTITION BY o.CustomerID -> Hesablamanı hər müştəri üçün sıfırlayır və ayrıca aparır.
-- 2. ORDER BY o.OrderDate -> Satışları tarix sırası ilə düzür.
-- 3. SUM(o.Freight) OVER(...) -> Müştərinin hər yeni sifarişində daşıma xərcini 
--    (Freight) əvvəlki sifarişlərin cəminin üzərinə əlavə edərək artan cəm yaradır.
SELECT 
    o.CustomerID AS MusteriID,
    o.OrderID AS SifarisID,
    o.OrderDate AS SifarisTarixi,
    o.Freight AS DasimaXerci,
    ROUND(SUM(o.Freight) OVER(PARTITION BY o.CustomerID ORDER BY o.OrderDate), 2) AS ArtanCemXerc
FROM Orders o
ORDER BY o.CustomerID, o.OrderDate;