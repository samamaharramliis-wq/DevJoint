-- Q1: Gəlirə görə Top 5 Müştəri (Top 5 Customers by Revenue)
-- İzahı: 
-- 1. SUM(...) -> Hər bir müştərinin etdiyi sifarişlərin ümumi məbləğini hesablayır.
-- 2. GROUP BY -> Hesablamanı hər müştəriyə görə ayrı-ayrı qruplaşdırır.
-- 3. ORDER BY ... DESC -> Ən çox gəlir gətirən müştəridən azana doğru sıralayır.
-- 4. LIMIT 5 -> Siyahıdan yalnız ən yaxşı 5 müştərini seçib çıxarır.
SELECT 
    c.CustomerID AS MusteriID,
    c.CompanyName AS SirketAdi,
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) AS UmumiGelir
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CompanyName
ORDER BY UmumiGelir DESC
LIMIT 5;


-- Q2: Satış Həcmi Yüksək Olan İşçilər (HAVING Filtrinin İstifadəsi)
-- İzahı:
-- 1. WHERE operatoru qruplaşdırmadan əvvəl filtrləmə edir və SUM() ilə işləmir.
-- 2. HAVING operatoru isə GROUP BY-dan sonra yaranan ümumi cəmi filtrləyir.
-- 3. Bu sorğu yalnız cəmi satışı 50,000,000-dən çox olan uğurlu işçiləri gətirir.
SELECT 
    e.EmployeeID AS IsciID,
    e.FirstName || ' ' || e.LastName AS IsciAdSoyad,
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) AS CamiSatis
FROM Employees e
INNER JOIN Orders o ON e.EmployeeID = o.EmployeeID
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY e.EmployeeID, IsciAdSoyad
HAVING CamiSatis > 50000000
ORDER BY CamiSatis DESC;