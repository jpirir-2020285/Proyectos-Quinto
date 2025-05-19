/*
* Jose Miguel Pirir Perez
* 2020285
* IN5AM
* Fecha De Creación:
* 20-02-2024
*/

-- actualizacion de stock

drop database if exists DBControlVentas2020285;
Create database DBControlVentas2020285;

use DBControlVentas2020285;
Create table Productos(
	codigoProducto int not null auto_increment,
    nombreProducto varchar(50) not null,
    existencia int not null,
    precioUnitario float(10,2) default 0.00,
    precioDocena float(10,2) default 0.00,
    precioMayor float(10,2) default 0.00,
    primary key PK_codigoProducto(codigoProducto)
);

Create table Ventas(
	codigoVenta int not null auto_increment,
    fechaVenta date not null,
    primary key PK_codigoVenta(codigoVenta)
);


Create table Compras(
	codigoCompra int not null auto_increment,
    fechaCompra date not null,
    primary key PK_codigoCompra(codigoCompra)
);

Create table DetalleVenta(
	codigoDetalleVenta int not null auto_increment,
    codigoVenta int not null,
    codigoProducto int not null,
    cantidadVender int not null,
    primary key PK_codigoDetalleVenta(codigoDetalleVenta),
    constraint FK_DetalleVenta_codigoVenta foreign key (codigoVenta)
		references Ventas(codigoVenta),
	constraint FK_DetalleVenta_codigoProducto foreign key (codigoProducto)
		references Productos(codigoProducto)
);

Create table DetalleCompra(
	codigoDetalleCompra int not null auto_increment,
    codigoCompra int not null,
    cantidadCompra int not null,
    decripcionProducto varchar(150) not null,
    totalCompra float(10,2) not null,
    codigoProducto int not null,
    primary key PK_codigoDetalleCompra(codigoDetalleCompra),
	constraint FK_DetalleCompra_codigoCompra foreign key (codigoCompra)
		references Compras(codigoCompra),
	constraint FK_DetalleCompra_codigoProducto foreign key (codigoProducto)
		references Productos(codigoProducto)
);

-- Agregar producto
Delimiter $$
	Create procedure sp_AgregarProducto(in nombreProducto varchar(50), in existencia int)
    Begin
		Insert into Productos(nombreProducto, existencia)
			values(nombreProducto , existencia);
    End$$
Delimiter ;
call sp_AgregarProducto('Televisor 50 LG',10);
call sp_AgregarProducto('Laptop Alienware 19',5);
call sp_AgregarProducto('Lavadora Mabe20kg',20);
call sp_AgregarProducto('Equipo de sonido Aiwa',7);
call sp_AgregarProducto('Bocina Bose SoundLink Revolve II',3);
select * from Productos;

-- Agregar Ventas
Delimiter $$
	Create procedure sp_AgregarVentas(in fechaVenta date)
    Begin
		Insert Into Ventas(fechaVenta)
			Value(fechaVenta);
	End$$
Delimiter ;

call sp_AgregarVentas(now());
call sp_AgregarVentas('2020-01-01');
call sp_AgregarVentas('2018-12-01');
call sp_AgregarVentas('2010-09-11');
call sp_AgregarVentas('2003-03-01');
Select * from Ventas;


-- Trigger 1 ventas
Delimiter $$
	Create trigger tr_DetalleVenta_After_Insert
		After Insert on DetalleVenta
        for each row
        Begin
			Update Productos P
				set
					P.existencia = P.existencia - new.cantidadVender
                    where P.codigoProducto = new.codigoProducto;
        End$$
Delimiter ;

Select * from DetalleVenta where codigoVenta = 1;
select * from Productos;

insert into DetalleVenta(codigoVenta,codigoProducto,cantidadVender) 
	value (1,3,5);
insert into DetalleVenta(codigoVenta,codigoProducto,cantidadVender) 
	value (2,2,3);
    
-- ---------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------

-- Datos Almacenados

-- Agregar Compras
Delimiter $$
	Create procedure sp_AgregarCompras(in fechaCompra date)
    Begin
		Insert Into Compras(fechaCompra)
			Value(fechaCompra);
	End$$
Delimiter ;

call sp_AgregarCompras(now());
call sp_AgregarCompras('2020-09-11');
call sp_AgregarCompras('2019-11-11');
call sp_AgregarCompras('2024-01-01');
call sp_AgregarCompras('2006-10-13');
Select * from Compras;


-- Agregar datos de detalle compra
Delimiter $$
	Create Procedure sp_AgregarDetalleCompra(in codigoCompra int, in cantidadCompra int,
		in decripcionProducto varchar(150),in totalCompra float(10,2), in codigoProducto int)
	Begin 
		Insert Into DetalleCompra(codigoDetalleCompra, codigoCompra, cantidadCompra, decripcionProducto, totalCompra, codigoProducto)
			Values (codigoDetalleCompra, codigoCompra, cantidadCompra, decripcionProducto, totalCompra, codigoProducto);
    End$$
Delimiter ;

-- Triger tarea
Delimiter $$
	Create trigger tr_DetalleCompra_After_Insert
		After Insert on DetalleCompra
        for each row
        Begin
			Update Productos P
				set
					P.existencia = P.existencia + new.cantidadCompra
                    where P.codigoProducto = new.codigoProducto;
        End$$
Delimiter ;



-- Calcular Precios Unitarios, Por docena y por mayor
Delimiter $$
	Create trigger tr_DetalleCompraprecios_After_Insert
		after Insert on DetalleCompra
        for each row
        begin
			Update Productos P
				set 
					P.PrecioUnitario = new.totalCompra / new.cantidadCompra,
                    P.PrecioUnitario = P.PrecioUnitario + (P.PrecioUnitario*0.40),
                    P.PrecioDocena = new.totalCompra / new.cantidadCompra,
                    P.PrecioDocena = P.PrecioDocena + (P.PrecioDocena*0.35),
                    P.PrecioMayor = new.totalCompra / new.cantidadCompra,
                    P.PrecioMayor = P.PrecioMayor + (P.PrecioMayor*0.25)
				Where P.codigoProducto = new.codigoProducto;
        end$$
Delimiter ;

-- Insertar datos

Call sp_AgregarDetalleCompra(1, 5, 'Labadora Potente buena y rapida.', 1500.00,3);
Call sp_AgregarDetalleCompra(2, 15, 'Equipo de sonido con alta calidad y potente.', 45000.35, 4);
Call sp_AgregarDetalleCompra(3, 20, 'Televisor de 50 pulgadas, alta definicion 4k.', 68540.45,1);
Call sp_AgregarDetalleCompra(4, 7, 'Laptop Gamer, 16G Ram, 1 Tera de espacio.', 73610.86,2 );
Call sp_AgregarDetalleCompra(5, 3, 'Bocina resistente al agua, con sonido envolvente', 13000.14,5);


-- Mostrar Datos
select * from DetalleCompra;
Select * from Productos;