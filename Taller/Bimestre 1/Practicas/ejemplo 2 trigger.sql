drop database if exists DBEjemploTrigger22020285;
create database DBEjemploTrigger22020285;

use DBEjemploTrigger22020285;

create table Productos(
	codigoProducto int Not null auto_increment,
    nombresProducto varchar(20) not null,
    costo float not null,
    precio float not null,
    primary key PK_codigoProducto(codigoProducto)
);

-- agregar producto
Delimiter $$
	Create procedure sp_AgregarProducto(in nombresProducto varchar(20),
		in costo float, in precio float)
        Begin
			Insert Into Productos(nombresProducto, costo, precio)
				values(nombresProducto, costo, precio);
        End$$
Delimiter ;

call sp_AgregarProducto('Producto 1', 4,2);
call sp_AgregarProducto('Producto 2', 2,5);
call sp_AgregarProducto('Producto 3', 40,20);

select * from Productos;

-- trigger
delimiter $$
	Create Trigger tr_Productos_Before_Update
		Before Update on Productos
        for each row
        begin
			-- dml pl/sql
            if(new.costo<>old.costo) then
				set new.precio=new.costo*2;
			end if;
        End$$
Delimiter ;

-- delimiter $$
-- 	create procedure SP_Actualizar(in codProducto int)
-- 		begin
			Update Productos P
				set
					P.costo = 10
                    where P.codigoProducto = 1;
--. delimiter ;
-- call SP_Actualizar(1)