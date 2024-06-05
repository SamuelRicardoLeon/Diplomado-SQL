CREATE DATABASE Libreria

USE Libreria


-- Esquemas

CREATE SCHEMA Catalogo
GO

CREATE SCHEMA Ventas
GO


-- Tablas

CREATE TABLE Catalogo.Autores
(
	Id_Autor INT IDENTITY(10000,1) PRIMARY KEY,
	Nombre_Autor NVARCHAR(300),
	Apellido_Autor NVARCHAR(300)
)

INSERT INTO Catalogo.Autores (Nombre_Autor, Apellido_Autor, Obras_Publicadas)
VALUES
('Juan', 'Perez',5),
('Jorge','Pedraza',8),
('Karina','Mendoza',9),
('Nadia','Suarez',15),
('Liliana','Rojas', 7),
('Nelson','Mendez', 3),
('Omar','Hernandez', 1),
('Luisa','Tabarez',6),
('Mario','Salazar',13),
('Claudia','Estupiñan',9)

SELECT * FROM Catalogo.Autores



CREATE TABLE Catalogo.Categorias
(
	Id_Categorias INT IDENTITY(11000,1) PRIMARY KEY,
	Nombre_Categoria NVARCHAR(100) NOT NULL
)


INSERT INTO Catalogo.Categorias (Nombre_Categoria)
VALUES
('Terror'),
('Horror'),
('Comedia'),
('Drama'),
('Fantasia'),
('Misterio'),
('Ciencia_Ficcion'),
('Mitologia'),
('Romance'),
('Distopia')


SELECT * FROM Catalogo.Categorias



CREATE TABLE Catalogo.Libros
(
	Id_Libros INT IDENTITY(12000,1) PRIMARY KEY,
	Titulo_Libro NVARCHAR(400) NOT NULL,   --- Nombre_Libro
	Id_Autor INT UNIQUE,
	Id_Categoria INT,
	Precio_Libro NUMERIC
)


INSERT INTO Catalogo.Libros (Nombre_Libro,Id_Autor,Id_Categoria,Precio_Libro)
VALUES
('The Guardian',10000, 11004 ,50000),
('Lolita',10006, 11010 ,55000),
('Tiempo Perdido', 10009, 11006 ,60000),
('Dorian Gray', 10007, 11007 ,40000),
('El proceso', 10001, 11003 ,80000),
('Karenina', 10003, 11005 ,70000),
('Odiseas', 10005, 11009 ,90000),
('Emma', 10002, 11011 ,78000),
('Ficciones', 10004, 11008 ,67000),
('Mordred', 10008, 11012 ,95000)
	
SELECT * FROM Catalogo.Libros

CREATE TABLE Ventas.Clientes  ---Celda insertada -> Edad
(
	Id_Cliente INT IDENTITY(13000,1) PRIMARY KEY,
	Nombre_Cliente NVARCHAR(300),
	Apellido_Cliente NVARCHAR(300),
	Correo_Cliente NVARCHAR(400) UNIQUE   --Email_Cliente
)

INSERT INTO Ventas.Clientes(Nombre_Cliente,Apellido_Cliente,Email_Cliente,Edad)
VALUES
('Hernan','Torres','hernan@correo.com',40),
('Juan','Guerra','Juan@correo.com',35),
('Pedro','Tobon','pedro@correo.com',50),
('Jorge','Fernandez','Jorge@correo.com',26),
('Nicolas','Montaño','Nicolas@correo.com',22),
('Sofia','Surez','sofia@correo.com',28),
('Ivonne','Vargas','Ivonee@correo.com',47),
('Camila','Nuñez','camila@correo.com',19),
('Kevin','Castillo','kevin@correo.com',23),
('Camilo','Campos','camilon@correo.com',46)

SELECT * FROM Ventas.Clientes


CREATE TABLE Ventas.Ventas
(
	Id_Venta INT PRIMARY KEY IDENTITY(1,1),
	Id_Cliente INT,
	Fecha_Venta DATE,
	CONSTRAINT FK_Id_Cliente_De_Clientes_Y_Ventas FOREIGN KEY (Id_Cliente)
	REFERENCES Ventas.Clientes(Id_Cliente)
)

INSERT INTO Ventas.Ventas (Id_Cliente, Fecha_Venta)
VALUES
(13006,'2024-02-04'),
(13000,'2024-03-19'),
(13009,'2024-05-16'),
(13008,'2024-04-26'),
(13002,'2024-08-30'),
(13005,'2024-10-05'),
(13004,'2024-11-06'),
(13001,'2024-02-01'),
(13003,'2024-06-07'),
(13007,'2024-07-15')

SELECT * FROM Ventas.Ventas

CREATE TABLE Ventas.Detalle_Ventas
(
	Id_Detalle INT UNIQUE NOT NULL,
	Id_Venta INT,
	Id_Libros INT,
	Cantidad INT,  ---Libros_Vendidos
	Precio_Venta NUMERIC
)

INSERT INTO Ventas.Detalle_Ventas (Id_Detalle, Id_Venta, Id_Libros, Libros_Vendidos, Precio_Venta)
VALUES
(1514, 1, 12009,5,200000),
(1515, 10, 12008,7,800000),
(1517, 5, 12000,5,600000),
(1519, 6, 12002,5,700000),
(1456, 4, 12006,5,600000),
(1981, 7, 12007,5,550000),
(1124, 9,12001,5,460000),
(1357, 2, 12004,5,280000),
(1347, 3, 12003,5,900000),
(1765, 8, 12005,5,640000)

SELECT * FROM Ventas.Detalle_Ventas

--- Restricciones Faltantes

ALTER TABLE Catalogo.Libros
ADD CONSTRAINT FK_Id_Categoria_De_Categorias_Libros FOREIGN KEY (Id_Categoria)
REFERENCES Catalogo.Categorias(Id_Categorias)

ALTER TABLE Catalogo.Libros
ADD CONSTRAINT FK_Id_Autor_De_Autores_Libros FOREIGN KEY (Id_Autor)
REFERENCES Catalogo.Autores (Id_Autor)

ALTER TABLE Ventas.Detalle_Ventas
ADD CONSTRAINT FK_Id_Venta_De_Detalle_Ventas FOREIGN KEY (Id_Venta)
REFERENCES  Ventas.Ventas (Id_Venta)

ALTER TABLE Ventas.Detalle_Ventas
ADD CONSTRAINT FK_Id_Libros_De_Libros_Detalle FOREIGN KEY (ID_Libros)
REFERENCES Catalogo.Libros (Id_Libros)

--- Cambiar nombre de Columnas

EXEC sp_rename 'Ventas.Clientes.Correo_Cliente', 'Email_Cliente', 'COLUMN';
SELECT * FROM Ventas.Clientes

EXEC sp_rename 'Catalogo.Libros.Titulo_Libro', 'Nombre_Libro', 'COLUMN';
SELECT * FROM Catalogo.Libros

EXEC sp_rename 'Ventas.Detalle_Ventas.Cantidad', 'Libros_Vendidos', 'COLUMN';
SELECT * FROM Ventas.Detalle_Ventas



---- Columnas Insertadas
ALTER TABLE Ventas.Clientes
ADD Edad INT CHECK (EDAD > 0)
SELECT * FROM Ventas.Clientes



ALTER TABLE Catalogo.Autores
ADD Obras_Publicadas INT
SELECT * FROM Catalogo.Autores

