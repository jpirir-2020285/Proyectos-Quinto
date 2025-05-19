	/*
	Programador: Jose Miguel Pirir Pérez
    Carné: 2020285
    Fecha de Creación: 17-04-2024
    Fecha de Modificaciones:
*/

-- Drop database if exists DBKinalStore20242020285;
Create database DBKinalStore20242020285;

use DBKinalStore20242020285;

Create table TipoProducto(
	codigoTipoProducto int auto_increment not null,
    descripcion varchar(45) not null,
    primary key PK_codigoProducto(codigoTipoProducto)
);

Create table Proveedores(
	codigoProveedor int not null auto_increment,
    NITProveedor varchar(10) not null,
    nombresProveedor varchar(60) not null,
    apellidosProveedor varchar(60) not null,
    direccionProveedor varchar(150) not null,
    razonSocial varchar(60) not null,
    contactoProveedor varchar(100) not null,
    paginaWeb varchar(50) not null,
    Primary key PK_codigoProveedor(codigoProveedor)
);

Create table Compras(
	numeroDocumento int not null,
    fechaDocumento date not null,
    descripcion varchar(60) not null,
    totalDocumento decimal(10,2) default 0,
    primary key PK_numeroDocumento(numeroDocumento)
);

Create table Clientes(
	codigoCliente int auto_increment not null,
    NITCliente varchar(10) not null,
    nombresCliente varchar(50) not null,
    apellidosCliente varchar(50) not null,
    direccionCliente varchar(150) not null,
    telefonoCliente varchar(8) not null,
    correoCliente varchar(20) not null,
    primary key PK_codigoCliente(codigoCliente)
);

Create table CargoEmpleado(
	codigoCargoEmpleado int not null auto_increment,
    nombreCargo varchar(45) not null,
    descripcionCargo varchar(45) not null,
    primary key PK_codigoCargoEmpleado(codigoCargoEmpleado)
);

Create table telefonoProveedor(
	codigoTelefonoProveedor int not null auto_increment,
    numeroPrincipal varchar(8) not null,
    numeroSecundario varchar(8) not null,
    observaciones varchar(45) not null,
    codigoProveedor int not null,
    primary key PK_codigoTelefonoProveedor(codigoTelefonoProveedor),
    constraint FK_telefonoProveedor_Proveedores foreign key (codigoProveedor)
		references Proveedores(codigoProveedor)
);

Create table Productos(
	codigoProducto varchar(15) not null,
    descripcionProducto varchar(45) not null,
    precioUnitario decimal(10,2) default 0.0,
    precioDocena decimal(10,2) default 0.0,
    precioMayor decimal(10,2) default 0.0,
    imagenProducto varchar(45),
    existencia int default 0,
    codigoTipoProducto int not null,
    codigoProveedor int not null,
    primary key PK_codigoProducto(codigoProducto),
    constraint FK_Productos_TipoProducto foreign key
		(codigoTipoProducto) references TipoProducto (codigoTipoProducto),
	constraint FK_Procutos_Proveedores foreign key
		(codigoProveedor) references Proveedores(codigoProveedor)
);

Create table DetalleCompra(
	codigoDetalleCompra int not null auto_increment,
    costoUnitario decimal(10,2) not null,
    cantidad int not null,
    codigoProducto varchar(15) not null,
    numeroDocumento int not null,
    primary key PK_codigoDetalleCompra(codigoDetalleCompra),
    constraint FK_DetalleCompra_Productos foreign key (codigoProducto)
		references Productos (codigoProducto),
	constraint FK_DetalleCompra_Compras foreign key (numeroDocumento)
		references Compras (numeroDocumento)
);

Create table EmailProveedor(
	codigoEmailProveedor int not null auto_increment,
    emailProveedor varchar(50) not null,
    descripcion varchar(100) not null,
    codigoProveedor int not null,
    primary key PK_codigoEmailProveedor(codigoEmailProveedor),
    constraint FK_EmailProveedor_Proveedores foreign key (codigoProveedor)
		references Proveedores(codigoProveedor)
);

Create table Empleados(
	codigoEmpleado int not null,
    nombresEmpleado varchar(50) not null,
    apellidosEmpleado varchar(50) not null,
    sueldo decimal(10,2) not null,
    direccionEmpleado varchar(150) not null,
    turno varchar(15) not null,
    codigoCargoEmpleado int not null,
    primary key PK_codigoEmpleado (codigoEmpleado),
    constraint FK_Empleados_CargoEmpleado foreign key (codigoCargoEmpleado)
		references CargoEmpleado(codigoCargoEmpleado)
);


Create table Factura(
	numeroFactura int not null,
    estado varchar(50) not null,
    totalFactura decimal(10,2) default 0.0,
    fechaFactura date not null,
    codigoCliente int not null,
    codigoEmpleado int not null,
    primary key PK_numeroFactura(numeroFactura),
    constraint FK_Factura_Cliente foreign key (codigoCliente)
		references Clientes(codigoCliente),
	constraint FK_Factura_Empleados foreign key (codigoEmpleado)
		references Empleados (codigoEmpleado)
);

Create table DetalleFactura(
	codigoDetalleFactura int not null auto_increment,
    precioUnitario decimal(10,2),
    cantidad int not null,
    numeroFactura int not null,
    codigoProducto varchar(15) not null,
    primary key PK_codigoDetalleFactura(codigoDetalleFactura),
    constraint FK_DetalleFactura_Factura foreign key (numeroFactura)
		references Factura (numeroFactura),
	constraint FK_DetalleFactura_Productos foreign key (codigoProducto)
		references Productos (codigoProducto)
);

-- -------------------- Procedimientos Almacenados ---------------------------

-- TipoProducto
-- Agregar
Delimiter $$
	Create procedure sp_AgregarTipoProducto (in descripcion varchar(45))
    Begin
		Insert into  TipoProducto(descripcion)
			values (descripcion);
    End$$
Delimiter ;
call sp_AgregarTipoProducto('productos Frios');
call sp_AgregarTipoProducto('productos calientes');

-- Listar
Delimiter $$
	Create procedure sp_ListarTipoProducto ()
    Begin
		Select
			TP.codigoTipoProducto, 
            TP.descripcion
        From  TipoProducto TP;
    End$$
Delimiter ;

-- Buscar
Delimiter $$
	Create procedure sp_BuscarTipoProducto (in codTipoProducto int)
    Begin
		Select
			TP.codigoTipoProducto, 
            TP.descripcion
        From  TipoProducto TP
			Where  codigoTipoProducto=codTipoProducto ;
    End$$
Delimiter ;

-- Editar
Delimiter $$
	Create procedure sp_EditarTipoProducto (in codTipoProducto int, in descrip varchar(45) )
    Begin
		Update TipoProducto TP 
			Set 
				descripcion = descrip
			Where codigoTipoProducto = codTipoProducto ;
    End$$
Delimiter ;

-- Eliminar
Delimiter $$
	Create procedure sp_EliminarTipoProducto (in codTipoProducto int)
    Begin
		Delete from TipoProducto
			Where codigoTipoProducto = codTipoProducto;
    End$$
Delimiter ;


-- Proveedores
-- Agregar
Delimiter $$
	Create procedure sp_AgregarProveedor (in NITProveedor varchar(10), in nombresProveedor varchar(60), 
		in apellidosProveedor varchar(60), in direccionProveedor varchar(150), in razonSocial varchar(60), 
		in contactoProveedor varchar(100), in paginaWeb varchar(50))
    Begin
		Insert into Proveedores ( NITProveedor, nombresProveedor, apellidosProveedor, direccionProveedor, razonSocial, contactoProveedor, paginaWeb)
			values ( NITProveedor, nombresProveedor, apellidosProveedor, direccionProveedor, razonSocial, contactoProveedor, paginaWeb);
    End$$
Delimiter ;
call sp_AgregarProveedor('1231231','Miguel','Pirir','calle 13','Libre Sociedad','telefono casa:14124323','KinalAcademy');

-- Listar
Delimiter $$
	Create procedure sp_ListarProveedores ()
    Begin
		Select
			P.codigoProveedor, 
            P.NITProveedor, 
            P.nombresProveedor, 
            P.apellidosProveedor, 
            P.direccionProveedor, 
            P.razonSocial, 
            P.contactoProveedor, 
            P.paginaWeb
        From Proveedores P ;
    End$$
Delimiter ;
call sp_ListarProveedores ();

-- Buscar
Delimiter $$
	Create procedure sp_BuscarProveedores (in codProveedor int)
    Begin
		Select
			P.codigoProveedor, 
            P.NITProveedor, 
            P.nombresProveedor, 
            P.apellidosProveedor, 
            P.direccionProveedor, 
            P.razonSocial, 
            P.contactoProveedor, 
            P.paginaWeb
        From  Proveedores P
			Where codigoProveedor = codProveedor;
    End$$
Delimiter ;




-- Editar
Delimiter $$
	Create procedure sp_EditarProveedores (in codProveedor int, in NITProv varchar(10), in nomProveedor varchar(60), 
		in apeProveedor varchar(60), in direcProveedor varchar(150), in razon varchar(60), 
		in contProveedor varchar(100), in pagina varchar(50))
    Begin
		Update Proveedores P
			Set 
				P.NITProveedor = NITProv, 
				P.nombresProveedor = nomProveedor, 
				P.apellidosProveedor = apeProveedor, 
				P.direccionProveedor = direcProveedor, 
				P.razonSocial = razon, 
				P.contactoProveedor = contProveedor, 
				P.paginaWeb = pagina
			Where codigoProveedor = codProveedor;
    End$$
Delimiter ;



-- Eliminar
Delimiter $$
	Create procedure sp_EliminarProveedor (in codProveedor int)
    Begin
		Delete from Proveedores
			Where codigoProveedor = codProveedor;
    End$$
Delimiter ;

-- Compras
-- Agregar
Delimiter $$
	Create procedure sp_AgregarCompra (in numeroDocumento int ,in fechaDocumento date, 
		in descripcion varchar(60))
    Begin
		Insert into Compras (numeroDocumento, fechaDocumento, descripcion)
			values (numeroDocumento, fechaDocumento, descripcion);
    End$$
Delimiter ;
call sp_AgregarCompra(1,'2024-05-08','Pago en efectivo');

-- Listar
Delimiter $$
	Create procedure sp_ListarCompras ()
    Begin
		Select
			C.numeroDocumento, 
            C.fechaDocumento, 
            C.descripcion, 
            C.totalDocumento
        From Compras C;
    End$$
Delimiter ;

-- Buscar
Delimiter $$
	Create procedure sp_BuscarCompra (in numDocumento int)
    Begin
		Select
			C.numeroDocumento, 
            C.fechaDocumento, 
            C.descripcion, 
            C.totalDocumento
        From Compras C
			Where numeroDocumento = numDocumento;
    End$$
Delimiter ;

-- Editar
Delimiter $$
	Create procedure sp_EditarCompra (in numDocumento int, in fechDocumento date, 
		in descrip varchar(60))
    Begin
		Update  Compras C
			Set 
				C.fechaDocumento = fechDocumento, 
				C.descripcion = descrip
			Where numeroDocumento = numDocumento;
    End$$
Delimiter ;

-- Eliminar
Delimiter $$
	Create procedure sp_EliminarCompra (in numDocumento int)
    Begin
		Delete from  Compras
			Where numeroDocumento = numDocumento;
    End$$
Delimiter ;


-- Cliente
-- Agregar
Delimiter $$
	Create procedure sp_AgregarCliente (in NITCliente varchar(10), 
		in nombresCliente varchar(50), in apellidosCliente varchar(50), in direccionCliente varchar(150),
        in telefonoCliente varchar(8), in correoCliente varchar(20))
    Begin
		Insert into Clientes (NITCliente, nombresCliente, apellidosCliente, direccionCliente, telefonoCliente, correoCliente)
			values (NITCliente, nombresCliente, apellidosCliente, direccionCliente, telefonoCliente, correoCliente);
    End$$
Delimiter ;
call sp_AgregarCliente('213412','Jose Miguel','Pirir Perez','Zona 16 sant','123412','josemigue@gmail.com');


-- Listar
Delimiter $$
	Create procedure sp_ListarClientes ()
    Begin
		Select
			C.codigoCliente, 
            C.NITCliente, 
            C.nombresCliente, 
            C.apellidosCliente, 
            C.direccionCliente, 
            C.telefonoCliente, 
            C.correoCliente
        From Clientes C;
    End$$
Delimiter ;
call sp_ListarClientes();


-- Buscar
Delimiter $$
	Create procedure sp_BuscarCliente (in codCliente int)
    Begin
		Select
			C.codigoCliente, 
            C.NITCliente, 
            C.nombresCliente, 
            C.apellidosCliente, 
            C.direccionCliente, 
            C.telefonoCliente, 
            C.correoCliente
        From Clientes C
			Where codigoCliente = codCliente;
    End$$
Delimiter ;

-- Editar
Delimiter $$
	Create procedure sp_EditarCliente (in codCliente int, in NIT varchar(10), 
		in nomCliente varchar(50), in apeCliente varchar(50), in direcCliente varchar(150), 
        in telCliente varchar(8), in correo varchar(20)) 
    Begin
		Update Clientes C
			Set 
				C.NITCliente = NIT, 
				C.nombresCliente = nomCliente, 
				C.apellidosCliente = apeCliente, 
				C.direccionCliente = direcCliente, 
				C.telefonoCliente = telCliente, 
				C.correoCliente = correo
			Where codigoCliente = codCliente;
    End$$
Delimiter ;

-- Eliminar
Delimiter $$
	Create procedure sp_EliminarCliente (in codCliente int)
    Begin
		Delete from  Clientes
			Where codigoCliente = codCliente;
    End$$
Delimiter ;


-- CargoEmpleado
-- Agregar
-- drop procedure sp_AgregarCargoEmpleado;
Delimiter $$
	Create procedure sp_AgregarCargoEmpleado ( 
		in nombreCargo varchar(45), in descripcionCargo varchar(45))
    Begin
		Insert into CargoEmpleado ( nombreCargo, descripcionCargo)
			values ( nombreCargo, descripcionCargo);
    End$$
Delimiter ;

call sp_AgregarCargoEmpleado('Jeve de ventas','Es el encargado de las ventas');

-- Listar
Delimiter $$
	Create procedure sp_ListarCargoEmpleados ()
    Begin
		Select
			CE.codigoCargoEmpleado, 
            CE.nombreCargo, 
            CE.descripcionCargo
        From  CargoEmpleado CE;
    End$$
Delimiter ;

-- Buscar
Delimiter $$
	Create procedure sp_BuscarCargoEmpleado (in codigoCargoEmpleado int)
    Begin
		Select
			CE.codigoCargoEmpleado, 
            CE.nombreCargo, 
            CE.descripcionCargo
        From  CargoEmpleado CE
			Where CodigoCargoEmpleado = codigoCargoEmpleado;
    End$$
Delimiter ;

-- Editar
Delimiter $$
	Create procedure sp_EditarCargoEmpleado (in codCargoEmpleado int, 
		in nomCargo varchar(45), in descripCargo varchar(45))
    Begin
		Update CargoEmpleado CE
			Set 
				CE.nombreCargo = nomCargo, 
				CE.descripcionCargo = descripCargo
			Where codigoCargoEmpleado = codCargoEmpleado;
    End$$
Delimiter ;

-- Eliminar
Delimiter $$
	Create procedure sp_EliminarCargoEmpleado (in codCargoEmpleado int)
    Begin
		Delete from CargoEmpleado
			Where codigoCargoEmpleado = codCargoEmpleado;
    End$$
Delimiter ;


-- telefonoProveedor
-- Agregar
Delimiter $$
	Create procedure sp_AgregartelefonoProveedor ( in numeroPrincipal varchar(8), 
		in numeroSecundario varchar(8), in observaciones varchar(45), in codigoProveedor int)
    Begin
		Insert into telefonoProveedor ( numeroPrincipal, numeroSecundario, observaciones, codigoProveedor)
			values ( numeroPrincipal, numeroSecundario, observaciones, codigoProveedor);
    End$$
Delimiter ;

call sp_AgregartelefonoProveedor('12343','4321321','Se tarda en contestar',1);

-- Listar
Delimiter $$
	Create procedure sp_ListartelefonoProveedor ()
    Begin
		Select
			tP.codigoTelefonoProveedor, 
            tP.numeroPrincipal, 
            tP.numeroSecundario, 
            tP.observaciones, 
            tP.codigoProveedor
        From telefonoProveedor tP;
    End$$
Delimiter ;

-- Buscar
Delimiter $$
	Create procedure sp_BuscartelefonoProveedor (in codTelefonoProveedor int)
    Begin
		Select
			tP.codigoTelefonoProveedor, 
            tP.numeroPrincipal, 
            tP.numeroSecundario, 
            tP.observaciones, 
            tP.codigoProveedor
        From telefonoProveedor tP
			Where codigoTelefonoProveedor = codTelefonoProveedor;
    End$$
Delimiter ;

-- Editar
Delimiter $$
	Create procedure sp_EditartelefonoProveedor (in codTelefonoProveedor int, in numPrincipal varchar(8), 
		in numSecundario varchar(8), in obser varchar(45))
    Begin
		Update  telefonoProveedor tP
			Set 
				tP.numeroPrincipal = numPrincipal, 
				tP.numeroSecundario = numSecundario, 
				tP.observaciones = obser
			Where codigoTelefonoProveedor = codTelefonoProveedor;
    End$$
Delimiter ;

-- Eliminar
Delimiter $$
	Create procedure sp_EliminartelefonoProveedor (in codTelefonoProveedor int)
    Begin
		Delete from  telefonoProveedor
			Where codigoTelefonoProveedor = codTelefonoProveedor;
    End$$
Delimiter ;


-- Productos
-- Agregar
-- drop procedure sp_AgregarProductos;
Delimiter $$
	Create procedure sp_AgregarProductos (in codigoProducto varchar(15), in descripcionProducto varchar(45), 
		in imagenProducto varchar(45), in codigoTipoProducto int, in codigoProveedor int)
    Begin
		Insert into Productos (codigoProducto,descripcionProducto,imagenProducto, codigoTipoProducto, codigoProveedor)
			values (codigoProducto, descripcionProducto,imagenProducto, codigoTipoProducto, codigoProveedor);
    End$$
Delimiter ;
call sp_AgregarProductos('1ab','Carton de leche','',1,1);
call sp_AgregarProductos('2ab','Carton de huevos','',2,1);

-- Listar
Delimiter $$
	Create procedure sp_ListarProductos ()
    Begin
		Select
			P.codigoProducto, 
            P.descripcionProducto, 
            P.precioUnitario, 
            P.precioDocena, 
            P.precioMayor, 
            P.imagenProducto, 
            P.existencia, 
            P.codigoTipoProducto, 
            P.codigoProveedor
        From Productos P;
    End$$
Delimiter ;

-- Buscar
Delimiter $$
	Create procedure sp_BuscarProductos (in codProducto varchar(15))
    Begin
		Select
			P.codigoProducto, 
            P.descripcionProducto, 
            P.precioUnitario, 
            P.precioDocena, 
            P.precioMayor, 
            P.imagenProducto, 
            P.existencia, 
            P.codigoTipoProducto, 
            P.codigoProveedor
        From Productos P
			Where codigoProducto = codProducto;
    End$$
Delimiter ;

-- Editar
Delimiter $$
	Create procedure sp_EditarProductos (in codProducto varchar(15), in descripProducto varchar(45))
    Begin
		Update  Productos P
			Set 
				P.descripcionProducto = descripProducto
			Where codigoProducto = codProducto;
    End$$
Delimiter ;

-- Eliminar
Delimiter $$
	Create procedure sp_EliminarProductos (in codProducto varchar(15))
    Begin
		Delete from Productos
			Where codigoProducto = codProducto;
    End$$
Delimiter ;


-- DetalleCompra
-- Agregar
Delimiter $$
	Create procedure sp_AgregarDetalleCompra (in costoUnitario decimal(10,2), 
		in cantidad int, in codigoProducto varchar(45), in numeroDocumento int)
    Begin
		Insert into DetalleCompra ( costoUnitario, cantidad, codigoProducto, numeroDocumento)
			values ( costoUnitario, cantidad, codigoProducto, numeroDocumento);
    End$$
Delimiter ;
 call sp_AgregarDetalleCompra(20.99,4,'1ab',1);
-- call sp_AgregarDetalleCompra(412.99,6,'2ab',1);

-- Listar
Delimiter $$
	Create procedure sp_ListarDetalleCompra ()
    Begin
		Select
			DC.codigoDetalleCompra, 
            DC.costoUnitario, 
            DC.cantidad, 
            DC.codigoProducto, 
            DC.numeroDocumento
        From DetalleCompra DC;
    End$$
Delimiter ;
call sp_ListarDetalleCompra;

-- Buscar
Delimiter $$
	Create procedure sp_BuscarDetalleCompra (in codDetalleCompra int)
    Begin
		Select
			DC.codigoDetalleCompra, 
            DC.costoUnitario, 
            DC.cantidad, 
            DC.codigoProducto, 
            DC.numeroDocumento
        From DetalleCompra DC
			Where codigoDetalleCompra = codDetalleCompra;
    End$$
Delimiter ;

-- Editar
Delimiter $$
	Create procedure sp_EditarDetalleCompra (in codDetalleCompra int, 
		in costUnitario decimal(10,2), in cant int)
    Begin
		Update DetalleCompra DC
			Set 
				DC.costoUnitario = costUnitario, 
				DC.cantidad = cant
			Where codigoDetalleCompra = codDetalleCompra;
    End$$
Delimiter ;

-- Eliminar
Delimiter $$
	Create procedure sp_EliminarDetalleCompra (in codDetalleCompra int)
    Begin
		Delete from DetalleCompra
			Where codigoDetalleCompra = codDetalleCompra;
    End$$
Delimiter ;


-- EmailProveedor
-- Agregar
Delimiter $$
	Create procedure sp_AgregarEmailProveedor ( in emailProveedor varchar(50), 
		in descripcion varchar(100), in codigoProveedor int)
    Begin
		Insert into EmailProveedor ( emailProveedor, descripcion, codigoProveedor)
			values ( emailProveedor, descripcion, codigoProveedor);
    End$$
Delimiter ;
call sp_AgregarEmailProveedor('Miguelpirir123@gamil.com','Correo para ventas',1);

-- Listar
Delimiter $$
	Create procedure sp_ListarEmailProveedor ()
    Begin
		Select
			EP.codigoEmailProveedor, 
            EP.emailProveedor, 
            EP.descripcion, 
            EP.codigoProveedor
        From EmailProveedor EP;
    End$$
Delimiter ;

-- Buscar
Delimiter $$
	Create procedure sp_BuscarEmailProveedor (in codEmailProveedor int)
    Begin
		Select
			EP.codigoEmailProveedor, 
            EP.emailProveedor, 
            EP.descripcion, 
            EP.codigoProveedor
        From EmailProveedor EP
			Where codigoEmailProveedor = codEmailProveedor;
    End$$
Delimiter ;

-- Editar
Delimiter $$
	Create procedure sp_EditarEmailProveedor (in codEmailProveedor int, 
		in email varchar(50), in descrip varchar(100))
    Begin
		Update EmailProveedor EP
			Set 
				EP.emailProveedor = email, 
				EP.descripcion = descrip
			Where codigoEmailProveedor = codEmailProveedor;
    End$$
Delimiter ;

-- Eliminar
Delimiter $$
	Create procedure sp_EliminarEmailProveedor (in codEmailProveedor int)
    Begin
		Delete from  EmailProveedor
			Where codigoEmailProveedor = codEmailProveedor;
    End$$
Delimiter ;


-- Empleados
-- Agregar
Delimiter $$
	Create procedure sp_AgregarEmpleado (in codigoEmpleado int, in nombresEmpleado varchar(50), 
		in apellidosEmpleado varchar(50), in sueldo decimal(10,2), in direccionEmpleado varchar(150), 
        in turno varchar(15), in codigoCargoEmpleado int)
    Begin
		Insert into Empleados (codigoEmpleado, nombresEmpleado, apellidosEmpleado, sueldo, direccionEmpleado, turno, codigoCargoEmpleado)
			values (codigoEmpleado, nombresEmpleado, apellidosEmpleado, sueldo, direccionEmpleado, turno, codigoCargoEmpleado);
    End$$
Delimiter ;
call sp_AgregarEmpleado(1,'Yeison','Pérez',2000.99,'Zona 6','Matutino',1);
-- Listar
Delimiter $$
	Create procedure sp_ListarEmpleados ()
    Begin
		Select
			E.codigoEmpleado, 
            E.nombresEmpleado, 
            E.apellidosEmpleado, 
            E.sueldo, 
            E.direccionEmpleado, 
            E.turno, 
            E.codigoCargoEmpleado
        From Empleados E;
    End$$
Delimiter ;

-- Buscar
Delimiter $$
	Create procedure sp_BuscarEmpleado (in codEmpleado int)
    Begin
		Select
			E.codigoEmpleado, 
            E.nombresEmpleado, 
            E.apellidosEmpleado, 
            E.sueldo, 
            E.direccionEmpleado, 
            E.turno, 
            E.codigoCargoEmpleado
        From Empleados E
			Where codigoEmpleado = codEmpleado;
    End$$
Delimiter ;

-- Editar
Delimiter $$
	Create procedure sp_EditarEmpleado (in codEmpleado int, in nomEmpleado varchar(50), 
		in apeEmpleado varchar(50), in sueld decimal(10,2), 
        in direcEmpleado varchar(150), in turn varchar(15))
    Begin
		Update Empleados E 
			Set 
				E.nombresEmpleado = nomEmpleado, 
				E.apellidosEmpleado = apeEmpleado, 
				E.sueldo = sueld, 
				E.direccionEmpleado = direcEmpleado, 
				E.turno = turn
			Where codigoEmpleado = codEmpleado;
    End$$
Delimiter ;

-- Eliminar
Delimiter $$
	Create procedure sp_EliminarEmpleados (in codEmpleado int)
    Begin
		Delete from  Empleados
			Where codigoEmpleado = codEmpleado;
    End$$
Delimiter ;


-- Factura
-- Agregar
Delimiter $$
	Create procedure sp_AgregarFactura (in numeroFactura int,in estado varchar(50), 
		in totalFactura decimal(10,2), in fechaFactura date, in codigoCliente int, 
        in codigoEmpleado int)
    Begin
		Insert into Factura (numeroFactura, estado, totalFactura, fechaFactura, codigoCliente, codigoEmpleado)
			values (numeroFactura, estado, totalFactura, fechaFactura, codigoCliente, codigoEmpleado);
    End$$
Delimiter ;
call sp_AgregarFactura(1,'Activo',19.99,'2024-04-09',1,1);

-- Listar
Delimiter $$
	Create procedure sp_ListarFactura ()
    Begin
		Select
			F.numeroFactura, 
            F.estado, 
            F.totalFactura, 
            F.fechaFactura, 
            F.codigoCliente, 
            F.codigoEmpleado
        From Factura F;
    End$$
Delimiter ;
call sp_ListarFactura;

-- Buscar
Delimiter $$
	Create procedure sp_BuscarFactura (in numFactura int)
    Begin
		Select
			F.numeroFactura, 
            F.estado, 
            F.totalFactura, 
            F.fechaFactura, 
            F.codigoCliente, 
            F.codigoEmpleado
        From Factura F
			Where numeroFactura = numFactura;
    End$$
Delimiter ;

-- Editar
Delimiter $$
	Create procedure sp_EditarFactura (in numFactura int, in est varchar(50), 
		in totFactura decimal(10,2), in fechFactura date)
    Begin
		Update Factura F
			Set 
				F.estado = est, 
                F.totalFactura = totFactura, 
                F.fechaFactura = fechFactura
			Where numeroFactura = numFactura;
    End$$
Delimiter ;

-- Eliminar
Delimiter $$
	Create procedure sp_EliminarFactura (in numFactura int)
    Begin
		Delete from Factura
			Where numeroFactura = numFactura;
    End$$
Delimiter ;


-- DetalleFactura
-- Agregar
Delimiter $$
	Create procedure sp_AgregarDetalleFactura (in cantidad int, 
        in numeroFactura int, in codigoProducto varchar(15))
    Begin
		Insert into DetalleFactura (cantidad, numeroFactura, codigoProducto)
			values (cantidad, numeroFactura, codigoProducto);
    End$$
Delimiter ;
call sp_AgregarDetalleFactura(4,1,'1ab');

-- Listar
Delimiter $$
	Create procedure sp_ListarDetalleFactura ()
    Begin
		Select
			DF.codigoDetalleFactura, 
            DF.precioUnitario, 
            DF.cantidad, 
            DF.numeroFactura, 
            DF.codigoProducto
        From DetalleFactura DF;
    End$$
Delimiter ;

-- Buscar
Delimiter $$
	Create procedure sp_BuscarDetalleFactura (in codDetalleFactura int)
    Begin
		Select
			DF.codigoDetalleFactura, 
            DF.precioUnitario, 
            DF.cantidad, 
            DF.numeroFactura, 
            DF.codigoProducto
        From DetalleFactura DF
			Where codigoDetalleFactura = codDetalleFactura;
    End$$
Delimiter ;

-- Editar
Delimiter $$
	Create procedure sp_EditarDetalleFactura (in codDetalleFactura int, in cant int)
    Begin
		Update DetalleFactura DF
			Set 
                DF.cantidad = cant
			Where codigoDetalleFactura = codDetalleFactura;
    End$$
Delimiter ;

-- Eliminar
Delimiter $$
	Create procedure sp_EliminarDetalleFactura (in codDetalleFactura int)
    Begin
		Delete from DetalleFactura
			Where codigoDetalleFactura = codDetalleFactura;
    End$$
Delimiter ;



-- TRIGGERS
Delimiter $$
	Create trigger tr_PreciosProductos_After_Insert
    After Insert on DetalleCompra
    for each row
    begin
		update Productos P
				set
					P.precioUnitario =  (new.costoUnitario)+(new.costoUnitario*0.40),
                    P.precioDocena = (new.costoUnitario)+(new.costoUnitario*0.35),
                    P.precioMayor = (new.costoUnitario)+(new.costoUnitario*0.25),
                    P.existencia = P.existencia + new.Cantidad
                where P.codigoProducto = new.codigoProducto;
    end$$
Delimiter ;

Delimiter $$
	Create trigger tr_TotalDocumento_After_Insert
		after Insert on DetalleCompra
        for each row
        begin
			update Compras
				set
					Compras.totalDocumento = Compras.totalDocumento + (new.costoUnitario*new.cantidad)
                where Compras.numeroDocumento = new.numeroDocumento;    
            
        end$$
Delimiter ;


Delimiter $$
	Create Trigger tr_PrecioDetalleFactura_After_Insert
    After update on Productos
    for each row
    Begin
		Update DetalleFactura DF
			set DF.DetalleFactura = (new.precioUnitario)
		where DF.codigoProducto = new.codigoProducto;
    End$$
Delimiter ;


Delimiter $$
	Create trigger tr_TotalFactura_After_Insert
    After Insert on DetalleFactura
    for each row
    begin
		update Factura F
				set
					F.totalFactura = new.precioUnitario * new.cantidad
                where F.numeroFactura = new.numeroFactura;
    end$$
Delimiter ;
