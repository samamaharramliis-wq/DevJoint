-- Q1: INNER JOIN (Daxili Birləşmə)
-- İzah: Hər iki cəvdəldə də qarşılığı olan (kəsişən) məlumatları gətirir.
-- Əgər bir məhsulun kateqoriyası yoxdursa və ya kateqoriyanın məhsulu yoxdursa,
-- onlar nəticədə göstərilmir.
SELECT 
    c.CategoryName, 
    p.ProductName, 
    p.UnitPrice
FROM Products p
INNER JOIN Categories c ON p.CategoryID = c.CategoryID;


-- Q2: LEFT JOIN (Sol Xarici Birləşmə)
-- İzah: Sol tərəfdəki cədvəlin (Categories) bütün sətirlərini gətirir.
-- Sağdakı cədvəldə (Products) uyğun gələn məlumat varsa birləşdirir, 
-- yoxdursa, məhsul sütunları üçün ekrana "NULL" (boş) çıxarır.
-- Məsələn: Heç bir məhsulu olmayan yeni bir kateqoriya varsa, burada görünəcək.
SELECT 
    c.CategoryName, 
    p.ProductName
FROM Categories c
LEFT JOIN Products p ON c.CategoryID = p.CategoryID;



-- Q3: RIGHT JOIN (Sağ Xarici Birləşmə)
-- İzah: Sağ tərəfdəki cədvəlin (Products) bütün sətirlərini gətirir.
-- Əgər hansısa məhsulun kateqoriya ID-si tapılmazsa belə, o məhsul siyahıda 
-- görünəcək, kateqoriya adı hissəsi isə "NULL" olacaq.
SELECT 
    c.CategoryName, 
    p.ProductName
FROM Categories c
RIGHT JOIN Products p ON c.CategoryID = p.CategoryID;


-- Q4: FULL OUTER JOIN (Tam Xarici Birləşmə)
-- İzah: Həm sol, həm də sağ cədvəldəki bütün məlumatları gətirir.
-- Uyğunluğu olanları birləşdirir, kəsişməyən məlumatların qarşısına isə 
-- qarşılıqlı olaraq "NULL" yazır. Heç bir məlumat itkisi olmur.
SELECT 
    c.CategoryName, 
    p.ProductName
FROM Categories c
FULL OUTER JOIN Products p ON c.CategoryID = p.CategoryID;


-- Q5: SELF JOIN (Özünə Birləşmə)
-- İzah: Bir cədvəlin özü-özü ilə birləşdirilməsidir.
-- Eyni cədvələ iki fərqli ad (alias - məsələn, e1 və e2) verərək sanki iki 
-- fərqli cədvəlmiş kimi istifadə edirik.
-- Hər işçinin kimə hesabat verdiyini (rəhbərini - ReportsTo) tapmaq üçün istifadə olunur:
SELECT 
    e1.FirstName || ' ' || e1.LastName AS EmployeeName,   -- İşçinin adı
    e2.FirstName || ' ' || e2.LastName AS ManagerName     -- Rəhbərinin adı
FROM Employees e1
LEFT JOIN Employees e2 ON e1.ReportsTo = e2.EmployeeId;