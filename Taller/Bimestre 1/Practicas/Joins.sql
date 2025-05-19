/*
	Jose Miguel Pirir Pérez
	Codigo técnico: IN5AM
    No. Carné: 2020285
    Fecha de creación:
		24-01-2024
*/

drop database if exists DNInnerJoin2020285;
create database DNInnerJoin2020285;

Use DNInnerJoin2020285;

create table clientes(
	codigoCliente int not null auto_increment,
    nombreCliente varchar(50) not null,
    telefonoContacto varchar(8) not null,
    primary key PK_codigoCliente (codigoCliente)
);

create table Pedidos(
	codigoPedido int not null,
    numeroFactura int not null,
    codigoCliente int not null,
    primary key PK_codigoPedido(codigoPedido),
    constraint FK_Pedidos_Clientes foreign key (codigoCliente)
		references Clientes(codigoCliente)
);

insert into clientes(nombreCliente,telefonoContacto)
	Values ('Pedro Armas','25478964');
insert into clientes(nombreCliente,telefonoContacto)
	Values ('Jose Mancilla','58744236');
insert into clientes(nombreCliente,telefonoContacto)
	Values ('Juan Pablo Gutierrez','66985120');
insert into clientes(nombreCliente,telefonoContacto)
	Values ('Juan Pablo Gonzales','24587412');
    
Select
    C.codigoCliente,
    C.nombreCliente,
    C.telefonoContacto
    From Cliente C;
    
insert into Pedidos(codigoPedido,numeroFactura,codigoCliente)
	Values (105,140,4);
insert into Pedidos(codigoPedido,numeroFactura,codigoCliente)
	Values (106,45,2);
insert into Pedidos(codigoPedido,numeroFactura,codigoCliente)
	Values (107,90,3);
insert into Pedidos(codigoPedido,numeroFactura,codigoCliente)
	Values (108,52,4);
    
Select
	P.codigoPedido,
    P.numeroFactura,
    P.codigoCliente
    From Pedidos P;
    
-- inner join

Select * from Clientes C Inner join Pedidos P
	on C.codigoCliente = P.codigoCliente;
    
Select Clientes.nombreCliente, Pedidos.numeroFactura from Clientes
	Inner join Pedidos on Clientes.codigoCLiente = Pedidos.codigoCliente;
    
-- left join
Select * from Clientes C left join Pedidos P
	on C.codigoCliente = P.codigoCliente;
    
Select
	C.telefonoCliente,
    P.numeroFactura
    From Cliente C left join Pedidos P
		On C.codigoCliente = P.codigoCliente;    
-- Right
Select * from Clientes C Right join Pedidos P
	on C.codigoCliente = P.codigoCliente;
    
Select
	C.telefonoCliente,
    P.numeroFactura
    From Cliente C Right join Pedidos P
		On C.codigoCliente = P.codigoCliente;

    