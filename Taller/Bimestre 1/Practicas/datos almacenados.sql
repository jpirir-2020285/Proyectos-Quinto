Drop database if exists DBInformatica2020285;

Create database DBInformatica2020285;
use DBInformatica2020285;

Create table Fabricantes(
	codigoFabricante int not null auto_increment,
    nombreFabricante varchar(100) not null,
    primary key PK_codigoFabricante (codigoFabricante)
);

CREATE TABLE Articulos(
	codigoArticulo int not null auto_increment,
    nombreArticulo varbinary(100) not null,
    precio decimal(10,2) not null,
    codigoFabricante int not null,
    primary key PK_codigoArticulo (codigoArticulo),
    constraint FK_Articulos_Fabricantes foreign key (codigoFabricante)
		references Fabricantes(codigoFabricante)
);

-- -------Procedimiento almacenado
-- --------Fabricantes


-- Agregar

Delimiter $$
	create procedure sp_agregarFabricante(in nombreFabricante varchar(100))
		begin
			insert into Fabricantes(nombreFabricante) values (nombreFabricante);
		end$$
Delimiter ;

-- Listar

Delimiter $$
	Create Procedure sp_ListarFabricantes()
    Begin
		Select
			F.codigoFabricante,
            F.nombreFabricante
            from Fabricantes F;
    End$$
Delimiter ;

-- BUSCAR
Delimiter $$
	Create Procedure sp_BuscarFabricante(in codFabricante int)
    Begin
		select
			F.codigoFabricante,
            F.nombreFabricante
            from Fabricantes F where F.codigoFabricante = codFabricante;
    End$$
Delimiter ;

-- eliminar
Delimiter $$
	Create Procedure sp_EliminarFabricante(in codFabricante int)
    Begin
		Delete from Fabricantes
			Where Fabricantes.codigoFabricante = codFabricante;
    End$$
Delimiter ;

-- Editar
Delimiter $$
	Create Procedure sp_EditarFabricante(in codFabricante int, 
		in nomFabricante varchar(100))
	Begin
		Update Fabricantes F
			Set
				F.nombreFabricante = nomFabricante
            where F.codigoFabricante = codFabricante; 
    End$$
Delimiter ;


-- ------------------------------Articulo
-- agregar
Delimiter $$
	create procedure sp_agregarArticulo(in nomArticulo varchar(100),
    IN p_precio DECIMAL(10,2),
    IN codFabricante INT)
		begin
			INSERT INTO Articulos(nombreArticulo, precio, codigoFabricante)
				VALUES (nomArticulo, p_precio, codFabricante);
		end$$
Delimiter ;

-- Listar
Delimiter $$
	Create Procedure sp_ListarArticulos()
    Begin
		Select
			A.codigoArticulo,
            A.nombreArticulo,
            A.precio,
            A.codigoFabricante
            from Articulos A;
    End$$
Delimiter ;

-- BUSCAR
Delimiter $$
	Create Procedure sp_BuscarArticulo(in codArticulo int)
    Begin
		select
			A.codigoArticulo,
            A.nombreArticulo,
            A.precio,
            A.codigoFabricante
            from Articulo A where A.codigoArticulo = codArticulo;
    End$$
Delimiter ;

-- Eliminar
Delimiter $$
	Create Procedure sp_EliminarArticulo(in codArticulo int)
    Begin
		Delete from Articulo
			Where Articulo.codigoArticulo = codArticulo;
    End$$
Delimiter ;

-- Editar
Delimiter $$
	Create Procedure sp_EditarArticulo(in codArticulo int, 
		in nomArticulo varchar(100))
	Begin
		Update Articulos A
			Set
				a.nombreArticulo = nomArticulo
            where F.codigoArticulo = codArticulo; 
    End$$
Delimiter ;



-- datos

CALL sp_agregarFabricante('Microsoft');
CALL sp_agregarFabricante('Apple');
CALL sp_agregarFabricante('Samsung');
CALL sp_agregarFabricante('Toyota');
CALL sp_agregarFabricante('Sony');
CALL sp_agregarFabricante('LG');
CALL sp_agregarFabricante('Lenovo');
CALL sp_agregarFabricante('HP');
CALL sp_agregarFabricante('Dell');
CALL sp_agregarFabricante('Canon');
CALL sp_agregarFabricante('Nike');
CALL sp_agregarFabricante('Adidas');
CALL sp_agregarFabricante('Coca-Cola');
CALL sp_agregarFabricante('Pepsi');
CALL sp_agregarFabricante('Nestle');
CALL sp_ListarFabricantes;


CALL sp_agregarArticulo('Windows', 600.00,1);
CALL sp_agregarArticulo('MacBook Pro', 1500.00,2);
CALL sp_agregarArticulo('Samsung Galaxy S21', 800.00,3);
CALL sp_agregarArticulo('Toyota Camry', 25000.00,4);
CALL sp_agregarArticulo('Sony Bravia 4K TV', 1000.00,5);
CALL sp_agregarArticulo('LG UltraWide Monitor', 500.00,6);
CALL sp_agregarArticulo('Lenovo ThinkPad', 1200.00,7);
CALL sp_agregarArticulo('HP Pavilion Laptop', 700.00,8);
CALL sp_agregarArticulo('Dell XPS 13', 1300.00,9);
CALL sp_agregarArticulo('Canon EOS R5', 3500.00,10);
CALL sp_agregarArticulo('Nike Air Max', 120.00,11);
CALL sp_agregarArticulo('Adidas Ultraboost', 180.00,12);
CALL sp_agregarArticulo('Coca-Cola 12-Pack', 5.00,13);
CALL sp_agregarArticulo('Pepsi 2-Liter', 2.50,14);
CALL sp_agregarArticulo('Nestle Chocolate Bar', 1.50,15);

-- --------------------------

-- Obtener los nombres de los productos de la tienda
Delimiter $$
	Create procedure sp_ListarNombres()
		Begin
			Select
				A.nombreArticulo
                from Articulos;
		End$$
Delimiter ;

-- Obtener los nombres y los precios de los productos de la tienda

select A.nombreArticulo, A.precio From Articulos A order by precio;

-- obtener el nombre de los productos cuyo precio sea igual o menor que 200
delimiter $$
	Create Procedure sp_ProdMenorA(in menor decimal(10,2))
		Begin
			select
				A.nombreArticulo
                From Articulos A where precio <= menor;
		End$$
Delimiter ;

-- obtener todos los datos cuyo precio este entre los 60 y 120

/*Forma 1 AND*/
Select
	A.codigoArticulo,
    A.nombreArticulo,
    A.precio,
    A.codigoFabricante
    from Articulos A where A.precio >= 60 and A.precio <= 120;
    
/*Between*/
Select
	A.codigoArticulo,
    A.nombreArticulo,
    A.precio,
    A.codigoFabricante
    from Articulos A where 	A.Precio between 60 and 120;
    
/*Obtener el nombre y el precio en dolares(es decir el precio dividido por 7.81)*/
select concat('$',A.precio/7.81) As 'Resultado Dolares' from Articulos A;


-- Mostrar el precio medio de todos los productos

Select avg(A.precio) as Promedio from Articulos A;

-- Obtener el numero de articulos cuyo precio sea mayor a 180

Select count(*) As cantidad from Articulos A where A.precio > 180;

/*Obtener un listado completo de articulos, Incluyendo por cada articulo 
los datos del articulo y de su fabricante  */
-- Inner
Select 
	A.codigoArticulo, 
    A.nombreArticulo, 
    A.precio, 
    A.codigoFabricante,
	F.codigoFabricante, 
    F.nombreFabricante
    from Articulos A inner join Fabricantes F 
		on A.codigoFabricante = F.codigoFabricante;
	

Select 
	A.codigoArticulo, 
    A.nombreArticulo, 
    A.precio, 
    A.codigoFabricante,
	F.codigoFabricante, 
    F.nombreFabricante
    from Articulos A, Fabricantes F
		where A.codigoFabricante = F.codigoFabricante; 


/*
*2
*9
*6
*11
*15
*17
*20
*/
