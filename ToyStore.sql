USE AdventureWorks2022
GO
--Câu 1

IF OBJECT_ID('Toys', 'U') IS NOT NULL 
  DROP TABLE Toys; 

CREATE TABLE Toys (
    ProductCode VARCHAR(5) PRIMARY KEY,
    Name VARCHAR(30),
    Category VARCHAR(30),
    Manufacturer VARCHAR(40),
    AgeRange VARCHAR(15),
    UnitPrice MONEY,
    Netweight INT,
    QtyOnHand INT
);

INSERT INTO Toys VALUES 
('P0002', 'Toy 2', 'Category 2', 'Manufacturer 2', '6-8', 25.00, 600, 25),
('P0003', 'Toy 3', 'Category 3', 'Manufacturer 3', '9-12', 30.00, 700, 30),
('P0004', 'Toy 4', 'Category 4', 'Manufacturer 4', '3-5', 35.00, 800, 35),
('P0005', 'Toy 5', 'Category 5', 'Manufacturer 5', '6-8', 40.00, 900, 40),
('P0006', 'Toy 6', 'Category 6', 'Manufacturer 6', '9-12', 45.00, 1000, 45),
('P0007', 'Toy 7', 'Category 7', 'Manufacturer 7', '3-5', 50.00, 1100, 50),
('P0008', 'Toy 8', 'Category 8', 'Manufacturer 8', '6-8', 55.00, 1200, 55),
('P0009', 'Toy 9', 'Category 9', 'Manufacturer 9', '9-12',60.00,1300,60),
('P0010','Toy10','Category10','Manufacturer10','3-5' ,65.00 ,1400 ,65),
('P0011','Toy11','Category11','Manufacturer11','6-8' ,70.00 ,1500 ,70),
('P0012','Toy12','Category12','Manufacturer12','9-12' ,75.00 ,1600 ,75),
('P0013','Toy13','Category13','Manufacturer13','3-5' ,80.00 ,1700 ,80),
('P0014','Toy14','Category14','Manufacturer14','6-8' ,85.00 ,1800 ,85),
('P0015','Toy15','Category15','Manufacturer15','9-12' ,90.00 ,1900 ,90);

SELECT * FROM Toys;    

IF OBJECT_ID('FieldDescriptions', 'U') IS NOT NULL 
  DROP TABLE FieldDescriptions;

CREATE TABLE FieldDescriptions (
    Têntrường VARCHAR(30),
    KiểuDữLiệu VARCHAR(30),
    Khóa VARCHAR(30),
    MôTả VARCHAR(255)
);

INSERT INTO FieldDescriptions VALUES 
('ProductCode', 'varchar(5)', 'Primary Key', 'ProductCode là khóa duy nhất cho mỗi sản phẩm'),
( 'Name', 'varchar(30)', NULL, 'Tên của đồ chơi'),
( 'Category', 'varchar(30)', NULL, 'Các loại đồ chơi ví dụ như đồ chơi lắp ghép, bộ game, các bộ câu đổ,…'),
( 'Manufacturer', 'varchar(40)', NULL, 'Tên nhà sản xuất'),
( 'AgeRange', 'varchar(15)', NULL, 'Lứa tuổi trẻ em phù hợp với đồ chơi, ví dụ như 3-5 tuổi,..'),
( 'UnitPrice', 'money', NULL, 'Giá của đồ chơi'),
( 'Netweight', 'Int', NULL, 'Trọng lượng của đồ chơi (tính bằng gram)'),
( 'QtyOnHand', 'int', NULL, 'Số lượng mỗi đồ chơi còn trong cửa hàng (đơn vị đo phụ thuộc vào đồ chơi, ví dụ nếu là bộ game đơn vị đo là bộ, búp bê đơn vị đo là chiếc,…)');

SELECT * FROM FieldDescriptions;                        

--Câu 2
IF OBJECT_ID('HeavyToys', 'P') IS NOT NULL 
  DROP PROCEDURE HeavyToys; 

CREATE PROCEDURE HeavyToys AS
BEGIN
    SELECT * FROM Toys WHERE Netweight > 500;
END;

--Câu 3
IF OBJECT_ID('PriceIncrease', 'P') IS NOT NULL 
  DROP PROCEDURE PriceIncrease; 

CREATE PROCEDURE PriceIncrease AS
BEGIN
    UPDATE Toys SET UnitPrice = UnitPrice + 10;
END;

--Câu 4
IF OBJECT_ID('DecreaseQtyOnHand', 'P') IS NOT NULL 
  DROP PROCEDURE DecreaseQtyOnHand; 

CREATE PROCEDURE DecreaseQtyOnHand AS
BEGIN
    UPDATE Toys SET QtyOnHand = QtyOnHand - 5;
END;

--Câu 5
EXEC HeavyToys;
EXEC PriceIncrease;
EXEC DecreaseQtyOnHand;

