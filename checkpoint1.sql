-- Q1: Müştərilərin şirkət adı, əlaqədar şəxs və ölkə məlumatlarını gətirir.
-- Customers cədvəlindən bizə lazım olan əsas sütunları seçirik.
SELECT 
    CompanyName, 
    ContactName, 
    Country 
FROM Customers;


-- Q2: Yalnız Almaniyada (Germany) olan müştəriləri tapır.
-- WHERE əmri ilə ölkə sütununu sadəcə Almaniya olaraq süzgəcləyirik.
SELECT 
    CompanyName, 
    ContactName, 
    City, 
    Country 
FROM Customers 
WHERE Country = 'Germany';


-- Q3: Satışda olan ən bahalı ilk 10 məhsulu tapır.
-- Qiyməti çoxdan aza sıralamaq üçün ORDER BY DESC, ilk 10 məhsulu götürmək üçün LIMIT istifadə edirik.
SELECT 
    ProductName, 
    UnitPrice, 
    UnitsInStock 
FROM Products 
ORDER BY UnitPrice DESC 
LIMIT 10;


-- Q4: Qiyməti 50 dollardan baha olan və anbarda mövcud olan (stoku bitməyən) məhsulları göstərir.
-- Hər iki şərtin eyni anda ödənməsi üçün araya AND yazırıq.
SELECT 
    ProductName, 
    UnitPrice, 
    UnitsInStock 
FROM Products 
WHERE UnitPrice > 50 
  AND UnitsInStock > 0;


-- Q5: London və ya Seattle-da yaşayan işçilərin siyahısını çıxarır.
-- Şəhər bu iki variantdan biri ola biləcəyi üçün OR operatorundan istifadə edirik.
SELECT 
    FirstName, 
    LastName, 
    Title, 
    City 
FROM Employees 
WHERE City = 'London' 
   OR City = 'Seattle';


-- Q6: Müəyyən kateqoriyalardakı həm baha, həm də əlimizdə olan məhsulları tapır.
-- Bu sorğuda Checkpoint 1-də yazdığım bütün əmrlər eyni anda birlikdə işlədilmişdir.
SELECT 
    ProductName,
    CategoryID,
    UnitPrice,
    UnitsInStock
FROM Products
WHERE (UnitPrice > 30 AND UnitsInStock > 0) 
  AND (CategoryID = 1 OR CategoryID = 2)
ORDER BY UnitPrice DESC
LIMIT 5;
