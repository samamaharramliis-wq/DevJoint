-- Q1: Subquery (Alt Sorğu) Nümunəsi
-- Tələb: Ortalama məhsul qiymətindən baha olan məhsulların tapılması.
-- İzahı:
-- 1. Mötərizə daxilindəki alt sorğu (SELECT AVG(...) FROM Products) bütün 
--    məhsulların ümumi ortalama qiymətini hesablayır.
-- 2. Əsas sorğu isə həmin tapılan vahid qiymətdən (məsələn, 28.86) böyük olan 
--    məhsulları filtrləyir. Çoxaddımlı məntiqi tək sorğuda birləşdirir.
SELECT 
    p.ProductID AS MehsulID,
    p.ProductName AS MehsulAdi,
    p.UnitPrice AS Qiymet
FROM Products p
WHERE p.UnitPrice > (
    SELECT AVG(UnitPrice) 
    FROM Products
)
ORDER BY p.UnitPrice DESC;


-- Q2: CTE (WITH Klauzulalı Müvəqqəti Cədvəl) Nümunəsi
-- Tələb: Çoxaddımlı məntiqlə müştərilərin ortalama sifariş məbləğini hesablamaq 
-- və bu ortalamanı keçən müştəriləri tapmaq.
-- İzahı:
-- 1. WITH MusteriSatis_CTE AS (...) hissəsində ilk olaraq hər bir müştərinin 
--    etdiyi ümumi alış-veriş məbləğini hesablayıb müvəqqəti virtual cədvələ yazırıq.
-- 2. Altdakı əsas SELECT sorğusunda isə həmin CTE-yə müraciət edərək, ümumi 
--    müştəri ortalamasını tapan alt sorğu vasitəsilə filtr qoyuruq.
WITH MusteriSatis_CTE AS (
    SELECT 
        o.CustomerID,
        ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) AS ToplamXerc
    FROM Orders o
    INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
    GROUP BY o.CustomerID
)
SELECT 
    m.CustomerID AS MusteriID,
    m.ToplamXerc AS MusteriToplamXercleri
FROM MusteriSatis_CTE m
WHERE m.ToplamXerc > (
    SELECT AVG(ToplamXerc) 
    FROM MusteriSatis_CTE
)
ORDER BY m.ToplamXerc DESC;