USE MASTER 
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'QUANLYHANGHOA')
BEGIN
DROP DATABASE QUANLYHANGHOA
END

CREATE DATABASE QUANLYHANGHOA
GO

USE QUANLYHANGHOA
GO

CREATE TABLE NHACUNGCAP
(
  MANCC VARCHAR(10) NOT NULL,
  DIACHI VARCHAR(50) NOT NULL,
  HOTEN VARCHAR(50) NOT NULL,
  PRIMARY KEY (MANCC)
);

CREATE TABLE NSX
(
  MANSX VARCHAR(10) NOT NULL,
  TENNSX VARCHAR(50) NOT NULL,
  QUOCTICH VARCHAR(50) NOT NULL,
  PRIMARY KEY (MANSX)
);

CREATE TABLE QUAYHANG
(
  SOQUAY VARCHAR(10) NOT NULL,
  TENQUAY VARCHAR(50) NOT NULL,
  VITRI VARCHAR(50) NOT NULL,
  PRIMARY KEY (SOQUAY)
);

CREATE TABLE KHACHHANG
(
  MAKHACHHANG VARCHAR(10) NOT NULL,
  TENKHACHHANG VARCHAR(50) NOT NULL,
  DIACHI VARCHAR(50) NOT NULL,
  PRIMARY KEY (MAKHACHHANG)
);

CREATE TABLE PHIEUNHAPHANG
(
  MAPHIEUNHAP VARCHAR(10) NOT NULL,
  NGAYNHAP DATE NOT NULL,
  MANCC VARCHAR(10) NOT NULL,
  PRIMARY KEY (MAPHIEUNHAP),
  FOREIGN KEY (MANCC) REFERENCES NHACUNGCAP(MANCC)
);

CREATE TABLE PHIEUBANHANG
(
  MAPHIEUBANHANG VARCHAR(10) NOT NULL,
  MAKHACHHANG VARCHAR(10) NOT NULL,
  PRIMARY KEY (MAPHIEUBANHANG),
  FOREIGN KEY (MAKHACHHANG) REFERENCES KHACHHANG(MAKHACHHANG)
);

CREATE TABLE MATHANG
(
  MAMATHANG VARCHAR(10) NOT NULL,
  TENHANG VARCHAR(50) NOT NULL,
  DONVITINH VARCHAR(20) NOT NULL,
  SOLUONG INT NOT NULL,
  DONGIA FLOAT NOT NULL,
  MANSX VARCHAR(10) NOT NULL,
  SOQUAY VARCHAR(10) NOT NULL,
  PRIMARY KEY (MAMATHANG),
  FOREIGN KEY (MANSX) REFERENCES NSX(MANSX),
  FOREIGN KEY (SOQUAY) REFERENCES QUAYHANG(SOQUAY)
);

CREATE TABLE PHIEUBANHANG_MATHANG
(
  SOLUONG INT NOT NULL,
  DONGIA FLOAT NOT NULL,
  MAMATHANG VARCHAR(10) NOT NULL,
  MAPHIEUBANHANG VARCHAR(10) NOT NULL,
  PRIMARY KEY (MAMATHANG, MAPHIEUBANHANG),
  FOREIGN KEY (MAMATHANG) REFERENCES MATHANG(MAMATHANG),
  FOREIGN KEY (MAPHIEUBANHANG) REFERENCES PHIEUBANHANG(MAPHIEUBANHANG)
);

CREATE TABLE PHIEUNHAPHANG_MATHANG
(
  SOLUONG INT NOT NULL,
  DONGIA FLOAT NOT NULL,
  MAMATHANG VARCHAR(10) NOT NULL,
  MAPHIEUNHAP VARCHAR(10) NOT NULL,
  PRIMARY KEY (MAMATHANG, MAPHIEUNHAP),
  FOREIGN KEY (MAMATHANG) REFERENCES MATHANG(MAMATHANG),
  FOREIGN KEY (MAPHIEUNHAP) REFERENCES PHIEUNHAPHANG(MAPHIEUNHAP)
);

INSERT INTO NHACUNGCAP (MANCC, DIACHI, HOTEN) 
VALUES
	('NCC01', 'Nha Trang', 'NCCA'),
	('NCC02', 'Da Nang', 'NCCB'),
	('NCC03', 'Hue', 'NCCC'),
	('NCC04', 'Quang Nam', 'NCCD'),
	('NCC05', 'Quang Ngai', 'NCCE'),
	('NCC06', 'Quang Ninh', 'NCCF'),
	('NCC07', 'Quang Tri', 'NCCG'),
	('NCC08', 'Tay Ninh', 'NCCH'),
	('NCC09', 'Tay Ninh', 'NCCI'),
	('NCC10', 'Tay Ninh', 'NCCJ')
GO

INSERT INTO NSX (MANSX, TENNSX, QUOCTICH)
VALUES
	('NSX01', 'NSXA', 'Viet Nam'),
	('NSX02', 'NSXB', 'Viet Nam'),
	('NSX03', 'NSXC', 'Viet Nam'),
	('NSX04', 'NSXD', 'Viet Nam'),
	('NSX05', 'NSXE', 'Viet Nam'),
	('NSX06', 'NSXF', 'Viet Nam'),
	('NSX07', 'NSXG', 'Viet Nam'),
	('NSX08', 'NSXH', 'Viet Nam'),
	('NSX09', 'NSXI', 'Viet Nam'),
	('NSX10', 'NSXJ', 'Viet Nam')
GO

INSERT INTO QUAYHANG (SOQUAY, TENQUAY, VITRI)
VALUES
	('QUYH01', 'QUAYHANGA', 'VT1'),
	('QUYH02', 'QUAYHANGB', 'VT2'),
	('QUYH03', 'QUAYHANGC', 'VT3'),
	('QUYH04', 'QUAYHANGD', 'VT4'),
	('QUYH05', 'QUAYHANGE', 'VT5'),
	('QUYH06', 'QUAYHANGF', 'VT6'),
	('QUYH07', 'QUAYHANGG', 'VT7'),
	('QUYH08', 'QUAYHANGH', 'VT8'),
	('QUYH09', 'QUAYHANGI', 'VT9'),
	('QUYH10', 'QUAYHANGJ', 'VT10')	
GO

INSERT INTO KHACHHANG (MAKHACHHANG, TENKHACHHANG, DIACHI)
VALUES
	('KH01', 'Thomas', 'Nha Trang'),
	('KH02', 'James', 'Da Nang'),
	('KH03', 'John', 'Hue'),
	('KH04', 'Robert', 'Quang Nam'),
	('KH05', 'Michael', 'Quang Ngai'),
	('KH06', 'William', 'Quang Ninh'),
	('KH07', 'David', 'Quang Tri'),
	('KH08', 'Richard', 'Tay Ninh'),
	('KH09', 'Joseph', 'Tay Ninh'),
	('KH10', 'Thomas', 'Tay Ninh')
GO

INSERT INTO PHIEUNHAPHANG (MAPHIEUNHAP, NGAYNHAP, MANCC)
VALUES
	('PN01', '01/01/2019', 'NCC01'),
	('PN02', '02/01/2019', 'NCC02'),
	('PN03', '03/01/2019', 'NCC03'),
	('PN04', '04/01/2019', 'NCC04'),
	('PN05', '05/01/2019', 'NCC05'),
	('PN06', '06/01/2019', 'NCC06'),
	('PN07', '07/01/2019', 'NCC07'),
	('PN08', '08/01/2019', 'NCC08'),
	('PN09', '09/01/2019', 'NCC09'),
	('PN10', '10/01/2019', 'NCC10')
GO

INSERT INTO PHIEUBANHANG (MAPHIEUBANHANG, MAKHACHHANG)
VALUES
	('PB01', 'KH01'),
	('PB02', 'KH02'),
	('PB03', 'KH03'),
	('PB04', 'KH04'),
	('PB05', 'KH05'),
	('PB06', 'KH06'),
	('PB07', 'KH07'),
	('PB08', 'KH08'),
	('PB09', 'KH09'),
	('PB10', 'KH10')
GO

INSERT INTO MATHANG (MAMATHANG, TENHANG, DONVITINH, SOLUONG, DONGIA, MANSX, SOQUAY)
VALUES
	('MH01', 'HANGHOA1', 'THUNG', 20, 2.2, 'NSX01', 'QUYH01'),
	('MH02', 'HANGHOA2', 'THUNG', 20, 2.2, 'NSX02', 'QUYH02'),
	('MH03', 'HANGHOA3', 'THUNG', 20, 2.2, 'NSX03', 'QUYH03'),
	('MH04', 'HANGHOA4', 'THUNG', 20, 2.2, 'NSX04', 'QUYH04'),
	('MH05', 'HANGHOA5', 'THUNG', 20, 2.2, 'NSX05', 'QUYH05'),
	('MH06', 'HANGHOA6', 'THUNG', 20, 2.2, 'NSX06', 'QUYH06'),
	('MH07', 'HANGHOA7', 'THUNG', 20, 2.2, 'NSX07', 'QUYH07'),
	('MH08', 'HANGHOA8', 'THUNG', 20, 2.2, 'NSX08', 'QUYH08'),
	('MH09', 'HANGHOA9', 'THUNG', 20, 2.2, 'NSX09', 'QUYH09'),
	('MH10', 'HANGHOA10', 'THUNG', 20, 2.2, 'NSX10', 'QUYH10')
GO


INSERT INTO PHIEUNHAPHANG_MATHANG (SOLUONG, DONGIA, MAMATHANG, MAPHIEUNHAP)
VALUES
	(10, 2.2, 'MH01', 'PN01'),
	(10, 2.2, 'MH02', 'PN02'),
	(10, 2.2, 'MH03', 'PN03'),
	(10, 2.2, 'MH04', 'PN04'),
	(10, 2.2, 'MH05', 'PN05'),
	(10, 2.2, 'MH06', 'PN06'),
	(10, 2.2, 'MH07', 'PN07'),
	(10, 2.2, 'MH08', 'PN08'),
	(10, 2.2, 'MH09', 'PN09'),
	(10, 2.2, 'MH10', 'PN10')
GO

INSERT INTO PHIEUBANHANG_MATHANG (SOLUONG, DONGIA, MAMATHANG, MAPHIEUBANHANG)
VALUES
	(10, 2.2, 'MH01', 'PB01'),
	(10, 2.2, 'MH02', 'PB02'),
	(10, 2.2, 'MH03', 'PB01'),
	(10, 2.2, 'MH04', 'PB04'),
	(10, 2.2, 'MH05', 'PB01'),
	(10, 2.2, 'MH06', 'PB06'),
	(10, 2.2, 'MH07', 'PB01'),
	(10, 2.2, 'MH08', 'PB08'),
	(10, 2.2, 'MH09', 'PB01'),
	(10, 2.2, 'MH10', 'PB10')
GO

CREATE PROC [DBO].[SP_THEM_MATHANG]
	@MAMATHANG NVARCHAR(50),
	@TENHANG NVARCHAR(50),
	@DONVITINH NVARCHAR(50),
	@SOLUONG INT,
	@DONGIA INT,
	@MANSX NVARCHAR(50),
	@SOQUAY NVARCHAR(50)
AS
BEGIN
	IF (SELECT COUNT(*) FROM MATHANG WHERE MAMATHANG = @MAMATHANG) <> 0
	BEGIN
		RAISERROR ('Mã mặt hàng đã tồn tại', 16, 1)
		RETURN
	END
	ELSE IF (@SOLUONG < 0)
	BEGIN
		RAISERROR ('Số lượng không hợp lệ', 16, 1)
		RETURN
	END
	ELSE IF (@DONGIA < 0) 
	BEGIN
		RAISERROR ('Đơn giá không hợp lệ', 16, 1)
		RETURN
	END
	ELSE IF (SELECT COUNT(*) FROM NSX WHERE MANSX = @MANSX) <> 1
	BEGIN
		RAISERROR ('Mã nhà sản xuất không tồn tại', 16, 1)
		RETURN
	END
	ELSE IF (SELECT COUNT(*) FROM QUAYHANG WHERE SOQUAY = @SOQUAY) <> 1
	BEGIN
		RAISERROR ('Số quầy hàng không tồn tại', 16, 1)
		RETURN
	END
	ELSE
	BEGIN
		INSERT INTO MATHANG (MAMATHANG, TENHANG, DONVITINH, SOLUONG, DONGIA, MANSX, SOQUAY)
		VALUES (@MAMATHANG, @TENHANG, @DONVITINH, @SOLUONG, @DONGIA, @MANSX, @SOQUAY)
	END
END
GO

EXEC SP_THEM_MATHANG 'MH01', 'HANGHOA11', 'THUNG', 20, 2.2, 'NSX11', 'QUYH11'
EXEC SP_THEM_MATHANG 'MH11', 'HANGHOA11', 'THUNG', -20, 2.2, 'NSX11', 'QUYH11'
EXEC SP_THEM_MATHANG 'MH12', 'HANGHOA11', 'THUNG', 20, -2.2, 'NSX11', 'QUYH11'
EXEC SP_THEM_MATHANG 'MH13', 'HANGHOA11', 'THUNG', 20, 2.2, 'NSX11', 'QUYH11'
EXEC SP_THEM_MATHANG 'MH14', 'HANGHOA11', 'THUNG', 20, 2.2, 'NSX01', 'QUYH11'
SELECT * FROM MATHANG
EXEC SP_THEM_MATHANG 'MH15', 'HANGHOA11', 'THUNG', 20, 2.2, 'NSX01', 'QUYH01'
SELECT * FROM MATHANG
GO

CREATE FUNCTION [DBO].[TINHTIEN] (
	@MAPHIEUBAN NVARCHAR(10)
)
RETURNS INT
AS
BEGIN
	RETURN (
		SELECT SUM(SOLUONG * DONGIA) 
		FROM PHIEUBANHANG
		RIGHT JOIN PHIEUBANHANG_MATHANG 
		ON PHIEUBANHANG.MAPHIEUBANHANG = PHIEUBANHANG_MATHANG.MAPHIEUBANHANG
		WHERE PHIEUBANHANG.MAPHIEUBANHANG = @MAPHIEUBAN
		GROUP BY SOLUONG, DONGIA, PHIEUBANHANG.MAPHIEUBANHANG
	)
END
GO

SELECT [DBO].[TINHTIEN]('PB01') AS TONGTIEN
GO

SELECT * FROM PHIEUBANHANG_MATHANG
GO

CREATE TRIGGER [DBO].[CAPNHATMATHANG]
ON [DBO].[PHIEUNHAPHANG_MATHANG]
AFTER INSERT
AS
BEGIN
	UPDATE MATHANG
	SET SOLUONG = SOLUONG + (SELECT SOLUONG FROM INSERTED),
		DONGIA = (SELECT DONGIA FROM INSERTED)
	WHERE MATHANG.MAMATHANG = (SELECT MAMATHANG FROM INSERTED)
END
GO

SELECT MAMATHANG, SOLUONG
FROM MATHANG
WHERE MAMATHANG = 'MH01'

INSERT INTO PHIEUNHAPHANG_MATHANG (SOLUONG, DONGIA, MAMATHANG, MAPHIEUNHAP)
VALUES (10, 3.3, 'MH01', 'PN02')

SELECT MAMATHANG, SOLUONG
FROM MATHANG
WHERE MAMATHANG = 'MH01'
