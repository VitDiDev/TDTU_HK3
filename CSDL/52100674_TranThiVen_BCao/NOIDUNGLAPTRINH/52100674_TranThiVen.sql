USE MASTER
GO
DROP DATABASE IF EXISTS TRANTHIVEN_52100674_ASSIGNMENT
GO
CREATE DATABASE TRANTHIVEN_52100674_ASSIGNMENT
GO

USE TRANTHIVEN_52100674_ASSIGNMENT
GO

IF OBJECT_ID('DM_NHANVIEN') IS NOT NULL
  DROP TABLE DM_NHANVIEN
IF OBJECT_ID('DM_PHONGBAN') IS NOT NULL
  DROP TABLE DM_PHONGBAN
IF OBJECT_ID('DM_BANGCAP') IS NOT NULL
  DROP TABLE DM_BANGCAP
IF OBJECT_ID('DM_TRINHDO') IS NOT NULL
  DROP TABLE DM_TRINHDO
IF OBJECT_ID('DM_NGANH') IS NOT NULL
  DROP TABLE DM_NGANH
IF OBJECT_ID('DM_THUONG') IS NOT NULL
  DROP TABLE DM_THUONG
IF OBJECT_ID('DM_QHGIADINH') IS NOT NULL
  DROP TABLE DM_QHGIADINH
IF OBJECT_ID('DM_KINANG') IS NOT NULL
  DROP TABLE DM_KINANG
IF OBJECT_ID('DM_KINANG_NV') IS NOT NULL
  DROP TABLE DM_KINANG_NV
IF OBJECT_ID('NV_FULLTIME') IS NOT NULL
  DROP TABLE NV_FULLTIME
IF OBJECT_ID('NV_PARTTIME') IS NOT NULL
  DROP TABLE NV_PARTTIME
IF OBJECT_ID('NV_TUVAN') IS NOT NULL
  DROP TABLE NV_TUVAN
GO

--CREATE TABLE
CREATE TABLE DM_NHANVIEN(
	MANV CHAR(6),
	HO VARCHAR (50),
	TENDEM VARCHAR (50),
	TEN VARCHAR (50),
	SODIENTHOAI VARCHAR(20),
	DIACHI VARCHAR(50),
	NGAYSINH DATE,
	MAPB CHAR(6),
	CONSTRAINT PK_NHANVIEN PRIMARY KEY (MANV)
)
GO

CREATE TABLE DM_PHONGBAN(
	MAPB CHAR(6),
	TENPB VARCHAR(50),
	DIACHIPB INT NOT NULL,
	CONSTRAINT PK_PHONGBAN PRIMARY KEY (MAPB)
)
GO

CREATE TABLE DM_BANGCAP(
	LOAIBANG VARCHAR(50),
	NGAYCAPBANG DATE,
	MANV CHAR(6),
	MATRINHDO VARCHAR(50),
	MANGANH CHAR(6)
)
GO

CREATE TABLE DM_TRINHDO(
	MATRINHDO VARCHAR(50),
	TENTRINHDO VARCHAR(50),
	CONSTRAINT PK_TRINHDO PRIMARY KEY (MATRINHDO)
)
GO

CREATE TABLE DM_NGANH(
	MANGANH CHAR(6),
	TENNGANH VARCHAR(50),
	CONSTRAINT PK_NGANH PRIMARY KEY (MANGANH)
)
GO

CREATE TABLE DM_THUONG(
	TIENTHUONG INT NOT NULL,
	MUCDOTHUONG INT NOT NULL,
	MANV CHAR(6),
)
GO

CREATE TABLE DM_QHGIADINH(
	STT INT NOT NULL,
	TENNGUOIQH VARCHAR(50),
	DIACHI VARCHAR(50),
	NGAYSINH DATE,
	MANV CHAR(6),
)
GO

CREATE TABLE DM_KINANG(
	MAKINANG CHAR(6),
	TENKINANG VARCHAR (50),
	MOTA VARCHAR (50),
	CONSTRAINT PK_KINANG PRIMARY KEY (MAKINANG)
)
GO

CREATE TABLE DM_KINANG_NV(
	MUCDO INT NOT NULL,
	MANV CHAR(6),
	MAKINANG CHAR(6),
)
GO

CREATE TABLE NV_FULLTIME(
	MANV CHAR(6),
	LUONGNAM INT,
)
GO

CREATE TABLE NV_PARTTIME(
	MANV CHAR(6),
	LUONGGIO INT,
)
GO

CREATE TABLE NV_TUVAN(
	MANV CHAR(6),
	LUONGTHEOCAPBAC INT,
)
GO

--ADD FOREIGN KEY
--DM_NHANVIEN
ALTER TABLE DM_NHANVIEN ADD CONSTRAINT FK_PHONGBAN FOREIGN KEY (MAPB) REFERENCES DM_PHONGBAN(MAPB)
GO
   
--DM_BANGCAP
ALTER TABLE DM_BANGCAP ADD CONSTRAINT FR_NHANVIEN FOREIGN KEY (MANV) REFERENCES DM_NHANVIEN(MANV)
ALTER TABLE DM_BANGCAP ADD CONSTRAINT FR_TRINHDO FOREIGN KEY (MATRINHDO) REFERENCES DM_TRINHDO(MATRINHDO)
ALTER TABLE DM_BANGCAP ADD CONSTRAINT FR_NGANH FOREIGN KEY (MANGANH) REFERENCES DM_NGANH(MANGANH)
GO

--DM_THUONG
ALTER TABLE DM_THUONG ADD CONSTRAINT FR_NHANVIEN_THUONG FOREIGN KEY (MANV) REFERENCES DM_NHANVIEN(MANV)

--DM_QHGIADINH
ALTER TABLE DM_QHGIADINH ADD CONSTRAINT FR_NHANVIEN_GD FOREIGN KEY (MANV) REFERENCES DM_NHANVIEN(MANV)

--NV FULLTIME, PARTTIME,NV_TUVAN
ALTER TABLE NV_FULLTIME ADD CONSTRAINT FR_NHANVIEN_FULL FOREIGN KEY (MANV) REFERENCES DM_NHANVIEN(MANV)
ALTER TABLE NV_PARTTIME ADD CONSTRAINT FR_NHANVIEN_PART FOREIGN KEY (MANV) REFERENCES DM_NHANVIEN(MANV)
ALTER TABLE NV_TUVAN ADD CONSTRAINT FR_NHANVIEN_TV FOREIGN KEY (MANV) REFERENCES DM_NHANVIEN(MANV)
 
--DM_KINANG_NV
ALTER TABLE DM_KINANG_NV ADD CONSTRAINT FR_KINANG FOREIGN KEY (MAKINANG) REFERENCES DM_KINANG(MAKINANG)
ALTER TABLE DM_KINANG_NV ADD CONSTRAINT FR_NHANVIEN_KN FOREIGN KEY (MANV) REFERENCES DM_NHANVIEN(MANV)

--ADD CHECK_ DIA CHI PHONG BAN VA LUONGTHEOCAPDO
ALTER TABLE DM_PHONGBAN
ADD CONSTRAINT CHK_DIACHIPB CHECK (DIACHIPB >= 1 AND DIACHIPB <=5);

ALTER TABLE DM_THUONG
ADD CONSTRAINT CHK_MUCDOTHUONG CHECK (MUCDOTHUONG >= 1 AND MUCDOTHUONG <=5);

ALTER TABLE DM_KINANG_NV
ADD CONSTRAINT CHK_MUCDO CHECK (MUCDO >= 1 AND MUCDO <=5);

---------------------------
--FUNCTION 1
DROP FUNCTION IF EXISTS MA_PB
GO

CREATE FUNCTION MA_PB()
RETURNS CHAR(6)
AS
BEGIN
	DECLARE @ID_PB CHAR(2)
	SET @ID_PB = 'PB'
	DECLARE @SLPB INT 
	SET @SLPB  = 1+ (SELECT COUNT(MAPB) FROM DM_PHONGBAN)
	IF (@SLPB < 10)
		RETURN @ID_PB + '000' + CAST(@SLPB AS CHAR)
	IF (@SLPB  < 100)
		RETURN @ID_PB + '00' + CAST(@SLPB AS CHAR)
	IF (@SLPB < 1000)
		RETURN @ID_PB + '0' + CAST(@SLPB AS CHAR)
	RETURN @ID_PB + CAST(@SLPB AS CHAR)
END
GO

--PRINT DBO.MA_PB()
--GO

DROP PROCEDURE IF EXISTS THEM_MAPB
GO 

CREATE PROCEDURE THEM_MAPB(
	@TENPB VARCHAR(50),
	@DIACHIPB INT
)
AS
BEGIN
	INSERT INTO DM_PHONGBAN
	VALUES
			(DBO.MA_PB(),@TENPB,@DIACHIPB)
END
GO
--print truoc khi exec
SELECT * FROM DM_PHONGBAN
GO

--FUNCTION 2
SET DATEFORMAT DMY
DROP FUNCTION IF EXISTS MA_NV
GO

CREATE FUNCTION MA_NV()
RETURNS CHAR(6)
AS
BEGIN
	DECLARE @ID_NV CHAR(2)
	SET @ID_NV = 'NV'
	DECLARE @SOLUONG INT 
	SET @SOLUONG = 1+ (SELECT COUNT(MANV) FROM DM_NHANVIEN)
	IF (@SOLUONG < 10)
		RETURN @ID_NV + '000' + CAST(@SOLUONG AS CHAR)
	IF (@SOLUONG < 100)
		RETURN @ID_NV + '00' + CAST(@SOLUONG AS CHAR)
	IF (@SOLUONG < 1000)
		RETURN @ID_NV + '0' + CAST(@SOLUONG AS CHAR)
	RETURN @ID_NV + CAST(@SOLUONG AS CHAR)
END
GO

--PRINT DBO.MA_NV()
--GO

DROP PROCEDURE IF EXISTS THEM_NV
GO 

CREATE PROCEDURE THEM_NV(
	@HO VARCHAR (50),
	@TENDEM VARCHAR (50),
	@TEN VARCHAR (50),
	@SODIENTHOAI VARCHAR(20),
	@DIACHI VARCHAR(50),
	@NGAYSINH DATE,
	@MAPB CHAR(6)
)
AS
BEGIN
	INSERT INTO DM_NHANVIEN
	VALUES
			(DBO.MA_NV(),@HO,@TENDEM,@TEN,@SODIENTHOAI, @DIACHI,@NGAYSINH,@MAPB)
END
GO
--print truoc khi exec
SELECT * FROM DM_NHANVIEN
GO
--TRIGGER 1 CHECK KHOA NGOAI
DROP TRIGGER IF EXISTS CHK_KHOANGOAI_NV 
GO 

CREATE TRIGGER CHK_KHOANGOAI_NV
ON DM_NHANVIEN
INSTEAD OF INSERT 
AS
BEGIN
	DECLARE @MA_PBB CHAR(6)
	SET @MA_PBB = (SELECT MAPB FROM INSERTED);

	IF @MA_PBB IN (SELECT MAPB FROM DM_PHONGBAN)
		INSERT INTO DM_NHANVIEN SELECT * FROM INSERTED;
	ELSE
		PRINT 'ERROR'
END
GO

EXEC THEM_MAPB 'KETOAN','1'
EXEC THEM_MAPB 'NHANSU','2'
EXEC THEM_MAPB 'KINHDOANH','3'
EXEC THEM_MAPB 'MARKETING','4'
EXEC THEM_MAPB 'EDIT','5'
--print sau khi exec
SELECT * FROM DM_PHONGBAN

EXEC THEM_NV 'PHAM','QUANG','HUY','0447364834', 'VUNG TAU','15/02/1995','PB0001'
EXEC THEM_NV 'TRAN','THUY','LINH','0346364234', 'BINH DINH','20/07/2002','PB0002'
EXEC THEM_NV 'DOAN','MINH','ANH','0973743644', 'NINH BINH','02/07/2000','PB0003'
EXEC THEM_NV 'TRINH','HUNG','CUONG','0943472473', 'AN GIANG','20/12/2002','PB0004'
EXEC THEM_NV 'VO','HOANG','OANH','0843463244', 'HA GIANG','17/10/2001','PB0005'
EXEC THEM_NV 'HOANG','MINH','ANH','0843463244', 'DA NANG','17/12/1995','PB0002'
--print sau khi exec
SELECT * FROM DM_NHANVIEN
EXEC THEM_NV 'PHAM','NHAT','ANH',0843463244, 'DA LAT','17/10/1995','PB0006'
--TRIGGER 2 CHECK MIEN GIA TRI
DROP TRIGGER IF EXISTS CHK_LUONG_PARTTIME
GO 

CREATE TRIGGER CHK_LUONG_PARTTIME
ON NV_PARTTIME
INSTEAD OF INSERT 
AS
BEGIN
	DECLARE @LUONG_GIO INT
	SET @LUONG_GIO = (SELECT LUONGGIO FROM INSERTED);

	IF @LUONG_GIO > 0
		INSERT INTO NV_PARTTIME SELECT * FROM INSERTED;
	ELSE
		PRINT 'ERROR'
END
GO

INSERT INTO NV_PARTTIME 
VALUES
	('NV0001',20)
GO

SELECT * FROM NV_PARTTIME

INSERT INTO NV_PARTTIME 
VALUES
	('NV0002',-5)
GO 
--print sau khi exec
SELECT * FROM NV_PARTTIME