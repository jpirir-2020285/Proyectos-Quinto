/*
	Jose Miguel Pirir Pérez
	Codigo técnico: IN5AM
    No. Carné: 2020285
    Fecha de creación:
		19-02-2024
*/

Drop Database If Exists DBProyectoFinal2020285;
Create Database DBProyectoFinal2020285;

Use DBProyectoFinal2020285;

Create Table Departamentos(
	codigoDepartamento int not null,
    nombreDepartamento varchar(45),
    primary key PK_codigoDepartamento(codigoDepartamento)
);

Create Table Cargos(
	codigoCargo int not null,
    nombreCargo varchar(45),
    primary key PK_codigoCargo(codigoCargo)
);

Create Table Horarios(
	codigoHorario int not null,
    horarioEntrada varchar(5),
    horarioSalida varchar(5),
    lunes boolean,
    martes boolean,
    miercoles boolean,
    jueves boolean,
    viernes boolean,
    primary key PK_codigoHorario(codigoHorario)
);

Create Table TipoCliente(
	codigoTipoCliente int not null,
    nombreTipoCliente varchar(45),
    primary key PK_codigoTipoCliente(codigoTipoCliente)
);

Create Table Locales(
	codigoLocal int not null,
    saldoFavor double,
    saldoContra double,
    mesasPendientes int,
    disponibilidad boolean not null,
    valorLocal double not null,
    valorAdministracion double not null,
    primary key PK_codigoLocal(codigoLocal)
);

Create Table Administracion(
	codigoAdministracion int not null,
    direccion varchar(45),
    telefono varchar(8),
    primary key PK_codigoAdministracion(codigoAdministracion)
);

Create Table Proveedores(
	codigoProveedor int not null,
    NITProveedor varchar(45) not null,
    servicioPrestado varchar(45) not null,
    telefonoProveedor varchar(45) not null,
    direccionProveedor varchar(60) not null,
    saldoFavor double not null,
    saldoContra double not null,
    codigoAdministracion int not null,
    primary key PK_codigoProveedor(codigoProveedor),
    constraint FK_Proveedores_codigoAdministracion foreign key (codigoAdministracion)
		references Administracion(codigoAdministracion)
);

Create Table Empleados(
	codigoEmpleado int not null,
    nombreEmpleado varchar(45) not null,
    apellidoEmpleado varchar(45) not null,
    correoElectronico varchar(45) not null,
    telefonoEmpleado varchar(8) not null,
    fechaContratacion date not null,
    sueldo double not null,
    codigoDepartamento int not null,
    codigoCargo int not null,
    codigoHorario int not null,
    codigoAdministracion int not null,
    primary key PK_codigoEmpleado(codigoEmpleado),
    constraint FK_Empleados_codigoDepartamento foreign key (codigoDepartamento)
		references Departamentos(codigoDepartamento),
	constraint FK_Empleados_codigoCargo foreign key (codigoCargo)
		references Cargos (codigoCargo),
	constraint FK_Empleados_codigoHorario foreign key (codigoHorario)
		references Horarios (codigoHorario),
	constraint FK_Empleados_codigoAdministracion foreign key (codigoAdministracion)
		references Administracion (codigoAdministracion)
);

Create Table Clientes(
	codigoCliente int not null,
    nombresCliente varchar(45) not null,
    apellidosCliente varchar(45) not null,
    telefonoCliente varchar(45) not null,
    direccionCliente varchar(45) not null,
    email varchar(45) not null,
    codigoLocal int not null,
    codigoAdministracion int not null,
    codigoTipoCliente int not null,
    primary key PK_codigoCliente(codigoCliente),
    constraint FK_Clientes_codigoLocal foreign key (codigoLocal)
		references Locales (codigoLocal),
	constraint FK_Clientes_codigoAdministracion foreign key (codigoAdministracion)
		references Administracion (codigoAdministracion),
	constraint FK_Clientes_codigoTipoCliente foreign key (codigoTipoCliente)
		references TipoCliente(codigoTipoCliente)
);

Create Table CuentasPorCobrar(
	codigoCuentaPorCobrar int not null,
    numeroFactura varchar(45) not null,
    anio year(4) not null,
    mes int(2) not null,
    valorNetoPago double not null,
    estadoPago varchar(45),
    codigoAdministracion int not null,
    primary key PK_codigoCuentaPorCobrar(codigoCuentaPorCobrar),
    constraint FK_CuentasPorCobrar_codigoAdministracion foreign key (codigoAdministracion)
		references Administracion(codigoAdministracion)
);

Create Table CuentasPorPagar(
	codigoCuentaPorPagar int not null,
    numeroFactura varchar(45) not null,
    fechaLimitePago date not null,
    estadoPago varchar(45) not null,
    valorNetoPago double not null,
    codigoAdministracion int not null,
    codigoProveedor int not null,
    primary key PK_codigoCuentaPorPagar(codigoCuentaPorPagar),
    constraint FK_CuentasPorPagar_codigoAdministracion foreign key (codigoAdministracion)
		references Administracion(codigoAdministracion),
	constraint FK_CuentasPorPagar_codigoProveedor foreign key (codigoProveedor)
		references Proveedores(codigoProveedor)
);

-- Procedimientos almacenados para departamentos

-- Departamentos
-- Agregar
Delimiter $$
	Create procedure sp_AgregarDepartamentos (in codigoDepartamento int, nombreDepartamento varchar(45))
    Begin
		Insert Into Departamentos (codigoDepartamento,nombreDepartamento)
			Values (codigoDepartamento,nombreDepartamento);
    End$$
Delimiter ;


-- Cargos
-- Agregar
Delimiter $$
	Create procedure sp_AgregarCargos (in codigoCargo int, nombreCargo varchar(45))
    Begin
		Insert Into Cargos(codigoCargo,nombreCargo)
			Values (codigoCargo,nombreCargo);
    End$$
Delimiter ;


-- Horarios 
-- Agregar
Delimiter $$
	Create Procedure sp_AgregarHorarios (in codigoHorario int, in horarioEntrada varchar(5), in horarioSalida varchar(5), 
		in lunes boolean, in martes boolean, in miercoles boolean, in jueves boolean, in viernes boolean)
    Begin
		Insert Into Horarios (codigoHorario, horarioEntrada, horarioSalida, tunes, martes, miercoles, jueves, viernes)
			Values (codigoHorario, horarioEntrada, horarioSalida, tunes, martes, miercoles, jueves, viernes);
    End$$
Delimiter ;


-- TipoCliente
-- Agregar
Delimiter $$
	Create procedure sp_AgragarTipoCliente (in codigoTipoCliente int, in nombreTipoCliente varchar(45))
    Begin
		Insert Into TipoCliente (codigoTipoCliente, nombreTipoCliente)
			Values (codigoTipoCliente, nombreTipoCliente);
    End$$
Delimiter ;


-- Locales
-- Agregar
Delimiter $$
	Create procedure sp_AgragarLocales (in codigoLocal int, in saldoFavor double, in saldoContra double, 
		in mesasPendientes int, in disponibilidad boolean, in valorLocal double, in valorAdministracion double)
    Begin
		Insert Into TipoCliente (codigoTipoCliente, nombreTipoCliente)
			Values (codigoTipoCliente, nombreTipoCliente);
    End$$
Delimiter ;

