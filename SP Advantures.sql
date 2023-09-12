﻿USE AdventureWorks2022
GO 

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_DisplayEmployeesHireYear')
BEGIN
    DROP PROCEDURE sp_DisplayEmployeesHireYear
END
GO

--Tạo một thủ tục lưu trữ lấy ra toàn bộ nhân viên vào làm theo năm có tham số đầu vào là một năm
CREATE PROCEDURE sp_DisplayEmployeesHireYear 
    @HireYear int 
AS 
BEGIN
    SELECT * 
    FROM HumanResources.Employee 
    WHERE DATEPART(YY, HireDate)=@HireYear
END
GO

--Chạy thủ tục này cần phải truyền tham số vào là năm mà nhân viên vào làm
EXECUTE sp_DisplayEmployeesHireYear 2003
GO 

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_EmployeesHireYearCount')
BEGIN
    DROP PROCEDURE sp_EmployeesHireYearCount
END
GO
--Tạo thủ tục lưu trữ đếm số người vào làm trong một năm xác định có tham số đầu vào là một năm,
--tham số đầu ra là số người vào làm trong năm này
CREATE PROCEDURE sp_EmployeesHireYearCount 
    @HireYear int, 
    @Count int OUTPUT 
AS 
BEGIN
    SELECT @Count=COUNT(*) 
    FROM HumanResources.Employee 
    WHERE DATEPART(YY, HireDate)=@HireYear
END
GO 

--Chạy thủ tục lưu trữ cần phải truyền vào 1 tham số đầu vào và một tham số đầu ra.
DECLARE @Number int 
EXECUTE sp_EmployeesHireYearCount 2003, @Number OUTPUT 
PRINT @Number
GO 

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'FN' AND name = 'EmployeesHireYearCount2')
BEGIN
    DROP FUNCTION EmployeesHireYearCount2
END
GO
--Tạo thủ tục lưu trữ đếm số người vào làm trong một năm xác định có tham số đầu vào là một năm, 
--hàm trả về số người vào làm năm đó
CREATE FUNCTION dbo.EmployeesHireYearCount2 
    (@HireYear int) 
RETURNS int 
AS 
BEGIN
    DECLARE @Count int 
    SELECT @Count=COUNT(*) 
    FROM HumanResources.Employee 
    WHERE DATEPART(YY, HireDate)=@HireYear
    RETURN @Count
END
GO 

--Chạy thủ tục lưu trữ cần phải truyền vào 1 tham số đầu và lấy về số người làm trong năm đó.
DECLARE @Number int 
SELECT @Number = dbo.EmployeesHireYearCount2(2003)
PRINT @Number
GO 

IF OBJECT_ID('tempdb..#Students') IS NOT NULL
BEGIN
    DROP TABLE #Students
END
GO
--Tạo bảng tạm #Students
CREATE TABLE #Students 
(
    RollNo varchar(6) CONSTRAINT PK_Students PRIMARY KEY, 
    FullName nvarchar(100), 
    Birthday datetime constraint DF_StudentsBirthday DEFAULT DATEADD(yy, -18, GETDATE())
)
GO 

IF OBJECT_ID('tempdb..#spInsertStudents') IS NOT NULL
BEGIN
    DROP PROCEDURE #spInsertStudents
END
GO
--Tạo thủ tục lưu trữ tạm để chèn dữ liệu vào bảng tạm
CREATE PROCEDURE #spInsertStudents 
    @rollNo varchar(6), 
    @fullName nvarchar(100), 
    @birthday datetime 
AS 
BEGIN
    IF(@birthday IS NULL) 
        SET @birthday=DATEADD(YY, -18, GETDATE()) 
    INSERT INTO #Students(RollNo, FullName, Birthday) 
    VALUES(@rollNo, @fullName, @birthday) 
END
GO 

--Sử dụng thủ tục lưu trữ để chèn dữ liệu vào bảng tạm
EXEC #spInsertStudents 'A12345', 'abc', NULL 
EXEC #spInsertStudents 'A54321', 'abc', '2011-12-24' 
SELECT * FROM #Students

--Tạo thủ tục lưu trữ tạm để xóa dữ liệu từ bảng tạm theo RollNo
CREATE PROCEDURE #spDeleteStudents 
    @rollNo varchar(6) 
AS 
BEGIN
    DELETE FROM #Students 
    WHERE RollNo=@rollNo 
END

--Xóa dữ liệu sử dụng thủ tục lưu trữ
EXECUTE #spDeleteStudents 'A12345'
GO 

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'Cal_Square')
BEGIN
    DROP PROCEDURE Cal_Square
END
GO
--Tạo một thủ tục lưu trữ sử dung lệnh RETURN để trả về một số nguyên
CREATE PROCEDURE Cal_Square 
    @num int=0 
AS 
BEGIN
    RETURN (@num * @num)
END
GO 

--Chạy thủ tục lưu trữ
DECLARE @square int 
EXEC @square = Cal_Square 10 
PRINT @square
GO 

--Xem định nghĩa thủ tục lưu trữ bằng hàm OBJECT_DEFINITION
SELECT OBJECT_DEFINITION(OBJECT_ID('HumanResources.uspUpdateEmployeePersonalInfo')) AS DEFINITION
GO 

--Xem định nghĩa thủ tục lưu trữ bằng 
SELECT definition 
FROM sys.sql_modules 
WHERE object_id=OBJECT_ID('HumanResources.uspUpdateEmployeePersonalInfo')
GO 

--Thủ tục lưu trữ hệ thống xem các thành phần mà thủ tục lưu trữ phụ thuộc
sp_depends 'HumanResources.uspUpdateEmployeePersonalInfo'
GO 

USE AdventureWorks2022 
GO 

--Tạo thủ tục lưu trữ sp_DisplayEmployees
CREATE PROCEDURE sp_DisplayEmployees 
AS 
BEGIN
    SELECT * 
    FROM HumanResources.Employee 
END
GO 

--Thay đổi thủ tục lưu trữ sp_DisplayEmployees
ALTER PROCEDURE sp_DisplayEmployees 
AS 
BEGIN
    SELECT * 
    FROM HumanResources.Employee 
    WHERE Gender='F' 
END
GO 

--Chạy thủ tục lưu trữ sp_DisplayEmployees
EXEC sp_DisplayEmployees
GO 

--Xóa một thủ tục lưu trữ
DROP PROCEDURE sp_DisplayEmployees
GO 

-- CREATE PROCEDURE sp_EmployeeHire
CREATE PROCEDURE new99sp_EmployeeHire 
    @HireYear int 
AS 
BEGIN
    SELECT * 
    FROM HumanResources.Employee 
    WHERE DATEPART(YY, HireDate)=@HireYear
END
GO

    --Hiển thị
EXECUTE sp_DisplayEmployeesHireYear 1999 
DECLARE @Number int 
EXECUTE sp_EmployeesHireYearCount 1999, @Number OUTPUT 
PRINT N'Số nhân viên vào làm năm 1999 là: ' + CONVERT(varchar(3),@Number) 
GO

--Chạy thủ tục lưu trữ
EXEC newsp_EmployeeHire
GO 

--Thay đổi thủ tục lưu trữ sp_EmployeeHire có khối TRY ... CATCH
ALTER PROCEDURE sp_EmployeeHire 
    @HireYear int 
AS 
BEGIN
    BEGIN TRY
        EXECUTE sp_DisplayEmployeesHireYear @HireYear 
        DECLARE @Number int 
        --Lỗi xảy ra ở đây có thủ tục sp_EmployeesHireYearCount chỉ truyền 2 tham số mà ta truyền 3
        EXECUTE sp_EmployeesHireYearCount @HireYear, @Number OUTPUT, '123' 
        PRINT N'Số nhân viên vào làm năm là: ' + CONVERT(varchar(3),@Number) 
    END TRY
    BEGIN CATCH
        PRINT N'Có lỗi xảy ra trong khi thực hiện thủ tục lưu trữ' 
    END CATCH
    PRINT N'Kết thúc thủ tục lưu trữ' 
END
GO 

--Chạy thủ tục sp_EmployeeHire
EXEC sp_EmployeeHire 1999
--Xem thông báo lỗi bên Messages không phải bên Result
GO 

--Thay đổi thủ tục lưu trữ sp_EmployeeHire sử dụng hàm @@ERROR
ALTER PROCEDURE sp_EmployeeHire 
    @HireYear int 
AS 
BEGIN
    EXECUTE sp_DisplayEmployeesHireYear @HireYear 
    DECLARE @Number int 
END

--Lỗi xảy ra ở đây có thủ tục sp_EmployeesHireYearCount chỉ truyền 2 tham số mà ta truyền 3
   DECLARE @HireYear int, @Number int
SET @HireYear = 1999 -- Đặt giá trị cho @HireYear
EXECUTE sp_EmployeesHireYearCount @HireYear, @Number OUTPUT
IF @@ERROR <> 0
    PRINT N'Có lỗi xảy ra trong khi thực hiện thủ tục lưu trữ' 
PRINT N'Số nhân viên vào làm năm là:' + CONVERT(varchar(3),@Number) 

--Chạy thủ tục sp_EmployeeHire
EXEC sp_EmployeeHire 1999
--Xem thông báo lỗi bên Messages không phải bên Result
GO