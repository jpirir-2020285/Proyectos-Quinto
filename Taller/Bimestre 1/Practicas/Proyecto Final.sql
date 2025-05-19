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


-- /-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
-- /-/- Procedimientos almacenados para departamentos -/-/
-- /-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
-- /-/-/-/ Agregar /-/-/-/
Delimiter $$
	Create procedure sp_AgregarDepartamentos (in codigoDepartamento int, nombreDepartamento varchar(45))
    Begin
		Insert Into Departamentos (codigoDepartamento,nombreDepartamento)
			Values (codigoDepartamento,nombreDepartamento);
    End$$
Delimiter ;

-- /-/-/-/ Listar /-/-/-/
Delimiter $$
	Create procedure sp_ListarDepartamentos ()
    Begin
		Select
			D.codigoDepartamento, 
            D.nombreDepartamento
		From Departamentos D;
    End$$
Delimiter ;

-- /-/-/-/ Buscar /-/-/-/
Delimiter $$
	Create procedure sp_BuscarDepartamentos (in codDepartamento int)
    Begin
		Select
			D.codigoDepartamento, 
            D.nombreDepartamento
		From Departamentos D 
			where codigoDepartamento = codDepartamento;
    End$$
Delimiter ;

-- /-/-/-/ Editar /-/-/-/
Delimiter $$
	Create procedure sp_EditarDepartamentos(in codDepartamento int, in nomDepartamento varchar(45))
    Begin
		Update Departamentos D
			Set
				D.nombreDepartamento = nomDepartamento
			Where codigoDepartamento = codDepartamento;
	End$$
Delimiter ;

-- /-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
-- /-/-/-/ Procedimientos almacenados para Cargos /-/-/-/
-- /-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
-- /-/-/-/ Agregar /-/-/-/
Delimiter $$
	Create procedure sp_AgregarCargos (in codigoCargo int, nombreCargo varchar(45))
    Begin
		Insert Into Cargos(codigoCargo,nombreCargo)
			Values (codigoCargo,nombreCargo);
    End$$
Delimiter ;

-- /-/-/-/ Listar /-/-/-/
Delimiter $$
	Create procedure sp_ListarCargos ()
    Begin
		Select
			C.codigoCargo, 
            C.nombreCargo
		From Cargos C;
    End$$
Delimiter ;

-- /-/-/-/ Buscar /-/-/-/
Delimiter $$
	Create procedure sp_BuscarCargos (in codCargo int)
    Begin
		Select
			C.codigoCargo, 
            C.nombreCargo
		From Cargos C
			Where codigoCargo = codCargo;
    End$$
Delimiter ;

-- /-/-/-/ Editar /-/-/-/
Delimiter $$
	Create procedure sp_EditarCargos(in codCargo int, in nomCargo varchar(45))
    Begin
		Update Cargos C
			Set
				C.nombreCargo = nomCargo
			Where codigoCargo = codCargo;
	End$$
Delimiter ;

-- /-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
-- /-/-/- Procedimientos almacenados para Horarios -/-/-/
-- /-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
-- /-/-/-/ Agregar /-/-/-/
Delimiter $$
	Create Procedure sp_AgregarHorarios (in codigoHorario int, in horarioEntrada varchar(5), in horarioSalida varchar(5), 
		in lunes boolean, in martes boolean, in miercoles boolean, in jueves boolean, in viernes boolean)
    Begin
		Insert Into Horarios (codigoHorario, horarioEntrada, horarioSalida, tunes, martes, miercoles, jueves, viernes)
			Values (codigoHorario, horarioEntrada, horarioSalida, tunes, martes, miercoles, jueves, viernes);
    End$$
Delimiter ;

-- /-/-/-/ Listar /-/-/-/
Delimiter $$
	Create procedure sp_ListarHorarios ()
    Begin
		Select
			H.codigoHorario, 
            H.horarioEntrada, 
            H.horarioSalida, 
            H.lunes, 
            H.martes, 
            H.miercoles, 
            H.jueves, 
            H.viernes
		From Horarios H;
    End$$
Delimiter ;

-- /-/-/-/ Buscar /-/-/-/
Delimiter $$
	Create procedure sp_BuscarHorarios (in codHorario int)
    Begin
		Select
			H.codigoHorario, 
            H.horarioEntrada, 
            H.horarioSalida, 
            H.lunes, 
            H.martes, 
            H.miercoles, 
            H.jueves, 
            H.viernes
		From Horarios H
			Where codigoHorario = codHorario;
    End$$
Delimiter ;

-- /-/-/-/ Editar /-/-/-/
Delimiter $$
	Create procedure sp_EditarHorarios(in codHorario int, in horEntrada varchar(5), in horSalida varchar(5), 
		in lun boolean, in mar boolean, in mie boolean, in jue boolean, in vie boolean)
    Begin
		Update Horarios H
			Set
				H.horarioEntrada = horEntrada, 
				H.horarioSalida = horSalida, 
				H.lunes = lun, 
				H.martes = mar, 
				H.miercoles = mie, 
				H.jueves = jue, 
				H.viernes = vie
			Where codigoHorario = codHorario;
	End$$
Delimiter ;

-- /-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
-- /-/-/ Procedimientos almacenados para TipoCliente /-/-/
-- /-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/

-- /-/-/-/ Agregar/-/-/-/
Delimiter $$
	Create procedure sp_AgragarTipoCliente (in codigoTipoCliente int, in nombreTipoCliente varchar(45))
    Begin
		Insert Into TipoCliente (codigoTipoCliente, nombreTipoCliente)
			Values (codigoTipoCliente, nombreTipoCliente);
    End$$
Delimiter ;

-- /-/-/-/ Listar /-/-/-/
Delimiter $$
	Create procedure sp_ListarTipoCliente ()
    Begin
		Select
			TC.codigoTipoCliente, 
            TC.nombreTipoCliente
		From TipoCliente TC;
    End$$
Delimiter ;

-- /-/-/-/ Buscar /-/-/-/
Delimiter $$
	Create procedure sp_BuscarTipoCliente (in codTipoCliente int)
    Begin
		Select
			TC.codigoTipoCliente, 
            TC.nombreTipoCliente
		From TipoCliente TC
			where codigoTipoCliente = codTipoCliente;
    End$$
Delimiter ;

-- /-/-/-/ Editar /-/-/-/
Delimiter $$
	Create procedure sp_EditarTipoCliente(in codTipoCliente int, in nomTipoCliente varchar(45))
    Begin
		Update TipoCliente TC
			Set 
				TC.nombreTipoCliente = nomTipoCliente
			Where codigoTipoCliente = codTipoCliente;
	End$$
Delimiter ;


-- /-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
-- /-/-/-/ Procedimientos almacenados para Locales /-/-/-/
-- /-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
-- /-/-/-/ Agregar/-/-/-/
Delimiter $$
	Create procedure sp_AgragarLocales (in codigoLocal int, in saldoFavor double, in saldoContra double, 
		in mesasPendientes int, in disponibilidad boolean, in valorLocal double, in valorAdministracion double)
    Begin
		Insert Into TipoCliente (codigoTipoCliente, nombreTipoCliente)
			Values (codigoTipoCliente, nombreTipoCliente);
    End$$
Delimiter ;

-- /-/-/-/ Listar /-/-/-/
Delimiter $$
	Create procedure sp_ListarLocales ()
    Begin
		Select
			L.codigoLocal, 
            L.saldoFavor, 
            L.saldoContra, 
            L.mesasPendientes, 
            L.disponibilidad, 
            L.valorLocal, 
            L.valorAdministracion
		From Locales L;
    End$$
Delimiter ;

-- /-/-/-/ Buscar /-/-/-/
Delimiter $$
	Create procedure sp_BuscarLocales (in codLocal int)
    Begin
		Select
			L.codigoLocal, 
            L.saldoFavor, 
            L.saldoContra, 
            L.mesasPendientes, 
            L.disponibilidad, 
            L.valorLocal, 
            L.valorAdministracion
		From Locales L
			Where codigoLocal = codLocal;
    End$$
Delimiter ;

-- /-/-/-/ Editar /-/-/-/
Delimiter $$
	Create procedure sp_EditarLocales(in codLocal int, in salFavor double, in salContra double, 
		in mePendientes int, in disponi boolean, in valLocal double, in valAdministracion double)
    Begin
		Update Locales L
			Set
				L.saldoFavor = salFavor, 
				L.saldoContra = salContra, 
				L.mesasPendientes = mePendientes, 
				L.disponibilidad = disponi, 
				L.valorLocal = valLocal, 
				L.valorAdministracion = valAdministracion
			Where codigoLocal = codLocal;
	End$$
Delimiter ;

-- /-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
-- /-/- Procedimientos almacenados para Administracion -/-/
-- /-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
-- /-/-/-/ Agregar /-/-/-/
Delimiter $$
	Create procedure sp_AgregarAdministracion (in codigoAdministracion int, in direccion varchar(45), in telefono varchar(8))
    Begin
		Insert into Administracion (codigoAdministracion, direccion, telefono)
			Values (codigoAdministracion, direccion, telefono);
    End$$
Delimiter ;

-- /-/-/-/ Listar /-/-/-/
Delimiter $$
	Create procedure sp_ListarAdministracion ()
    Begin
		Select
			A.codigoAdministracion, 
            A.direccion, 
            A.telefono
		From Administracion A;
    End$$
Delimiter ;

-- /-/-/-/ Buscar /-/-/-/
Delimiter $$
	Create procedure sp_BuscarAdministracion (in codAdministracion int)
    Begin
		Select
			A.codigoAdministracion, 
            A.direccion, 
            A.telefono
		From Administracion A
			where codigoAdministracion = codAdministracion;
    End$$
Delimiter ;

-- /-/-/-/ Editar /-/-/-/
Delimiter $$
	Create procedure sp_EditarAdministracion(in codAdministracion int, in direc varchar(45), in fon varchar(8))
    Begin
		Update Administracion A
			Set
				A.direccion = direc, 
				A.telefono = fon
			Where codigoAdministracion = codAdministracion;
	End$$
Delimiter ;



-- /-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
-- /-/-/ Procedimientos almacenados para Proveedores /-/-/
-- /-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
-- /-/-/-/ Agregar /-/-/-/
Delimiter $$
	Create procedure sp_AgregarProveedor (in codigoProveedor int, in NITProveedor varchar(45), in servicioPrestado varchar(45), 
		in telefonoProveedor varchar(45), in direccionProveedor varchar(60), in saldoFavor double, in saldoContra double, in codigoAdministracion int)
	Begin
		Insert into Proveedores (codigoProveedor, NITProveedor, servicioPrestado, telefonoProveedor, direccionProveedor, saldoFavor, saldoContra, codigoAdministracion)
			Values (codigoProveedor, NITProveedor, servicioPrestado, telefonoProveedor, direccionProveedor, saldoFavor, saldoContra, codigoAdministracion);
    End$$
Delimiter ;

-- /-/-/-/ Listar /-/-/-/
Delimiter $$
	Create procedure sp_ListarProveedores ()
    Begin
		Select
			P.codigoProveedor, 
            P.NITProveedor, 
            P.servicioPrestado, 
            P.telefonoProveedor, 
            P.direccionProveedor, 
            P.saldoFavor, 
            P.saldoContra, 
            P.codigoAdministracion
		From Proveedores P;
    End$$
Delimiter ;

-- /-/-/-/ Buscar /-/-/-/
Delimiter $$
	Create procedure sp_BuscarProveedores (in codProveedor int)
    Begin
		Select
			P.codigoProveedor, 
            P.NITProveedor, 
            P.servicioPrestado, 
            P.telefonoProveedor, 
            P.direccionProveedor, 
            P.saldoFavor, 
            P.saldoContra, 
            P.codigoAdministracion
		From Proveedores P
			Where codigoProveedor = codProveedor;
    End$$
Delimiter ;

-- /-/-/-/ Editar /-/-/-/
Delimiter $$
	Create procedure sp_EditarProveedores (in codProveedor int, in NITProve varchar(45), in serPrestado varchar(45), 
		in fonProveedor varchar(45), in direcProveedor varchar(60), in salFavor double, in salContra double, in codAdministracion int)
    Begin
		Update Proveedores P
			Set
				P.NITProveedor = NITProve, 
				P.servicioPrestado = serPrestado, 
				P.telefonoProveedor = fonProveedor, 
				P.direccionProveedor = direcProveedor, 
				P.saldoFavor = salFavor, 
				P.saldoContra = salContra, 
				P.codigoAdministracion = codAdministracion
			Where codigoProveedor = codProveedor;
	End$$
Delimiter ;



-- /-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
-- /-/-/- Procedimientos almacenados para Empleados -/-/-/
-- /-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
-- /-/-/-/ Agregar /-/-/-/
Delimiter $$
	Create procedure sp_AgregarEmpleado (in codigoEmpleado int, in nombreEmpleado varchar(45), in apellidoEmpleado varchar(45), in correoElectronico varchar(45), 
		in telefonoEmpleado varchar(8), in fechaContratacion date, in sueldo double, in codigoDepartamento double, in codigoCargo int, codigoHorario int, in codigoAdministracion int)
	Begin
		Insert into Empleados (codigoEmpleado, nombreEmpleado, apellidoEmpleado, correoElectronico, telefonoEmpleado, fechaContratacion, sueldo, codigoDepartamento, codigoCargo, codigoHorario, codigoAdministracion)
			Values (codigoEmpleado, nombreEmpleado, apellidoEmpleado, correoElectronico, telefonoEmpleado, fechaContratacion, sueldo, codigoDepartamento, codigoCargo, codigoHorario, codigoAdministracion);
    End$$
Delimiter ;

-- /-/-/-/ Listar /-/-/-/
Delimiter $$
	Create procedure sp_ListarEmpleados ()
    Begin
		Select
			E.codigoEmpleado, 
            E.nombreEmpleado, 
            E.apellidoEmpleado, 
            E.correoElectronico, 
            E.telefonoEmpleado, 
            E.fechaContratacion, 
            E.sueldo, 
            E.codigoDepartamento, 
            E.codigoCargo, 
            E.codigoHorario, 
            E.codigoAdministracion
		From Empleados E;
    End$$
Delimiter ;

-- /-/-/-/ Buscar /-/-/-/
Delimiter $$
	Create procedure sp_BuscarEmpleados (in codEmpleado int)
    Begin
		Select
			E.codigoEmpleado, 
            E.nombreEmpleado, 
            E.apellidoEmpleado, 
            E.correoElectronico, 
            E.telefonoEmpleado, 
            E.fechaContratacion, 
            E.sueldo, 
            E.codigoDepartamento, 
            E.codigoCargo, 
            E.codigoHorario, 
            E.codigoAdministracion
		From Empleados E
			where codigoEmpleado = codEmpleado;
    End$$
Delimiter ;

-- /-/-/-/ Editar /-/-/-/
Delimiter $$
	Create procedure sp_EditarEmpleado(in codEmpleado int, in nomEmpleado varchar(45), in apeEmpleado varchar(45), in correoElec varchar(45), 
		in fonEmpleado varchar(8), in fechContratacion date, in suel double, in codDepartamento double, in codCargo int, codHorario int, in codAdministracion int)
    Begin
		Update Empleados E
			Set
				E.nombreEmpleado = nomEmpleado, 
				E.apellidoEmpleado = apeEmpleado, 
				E.correoElectronico = correoElec, 
				E.telefonoEmpleado = fonEmpleado, 
				E.fechaContratacion = fechContratacion, 
				E.sueldo = suel, 
				E.codigoDepartamento = codDepartamento, 
				E.codigoCargo = codCargo, 
				E.codigoHorario = codHorario, 
				E.codigoAdministracion = codAdministracion
			Where codigoEmpleado = codEmpleado;
	End$$
Delimiter ;


-- /-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
-- /-/-/-/ Procedimientos almacenados para Clientes /-/-/-/
-- /-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
-- /-/-/-/ Agregar /-/-/-/
Delimiter $$
	Create procedure sp_AgregarCliente (in codigoCliente int, in nombresCliente varchar(45), in apellidosCliente varchar(45), in telefonoCliente varchar(8), 
		in direccionCliente varchar(45), in email varchar(45), in codigoLocal int, in codigoAdministracion int, in codigoTipoCliente int)
	Begin
		Insert into Clientes (codigoCliente, nombresCliente, apellidosCliente, telefonoCliente, direccionCliente, email, codigoLocal, codigoAdministracion, codigoTipoCliente)
			Values (codigoCliente, nombresCliente, apellidosCliente, telefonoCliente, direccionCliente, email, codigoLocal, codigoAdministracion, codigoTipoCliente);
    End$$
Delimiter ;

-- /-/-/-/ Listar /-/-/-/
Delimiter $$
	Create procedure sp_ListarClientes ()
    Begin
		Select
			C.codigoCliente, 
            C.nombresCliente, 
            C.apellidosCliente, 
            C.telefonoCliente, 
            C.direccionCliente, 
            C.email, 
            C.codigoLocal, 
            C.codigoAdministracion,
            C.codigoTipoCliente
		From Clientes C;
    End$$
Delimiter ;

-- /-/-/-/ Buscar /-/-/-/
Delimiter $$
	Create procedure sp_BuscarClientes (in codCliente int)
    Begin
		Select
			C.codigoCliente, 
            C.nombresCliente, 
            C.apellidosCliente, 
            C.telefonoCliente, 
            C.direccionCliente, 
            C.email, 
            C.codigoLocal, 
            C.codigoAdministracion,
            C.codigoTipoCliente
		From Clientes C
			Where codigoCliente = codCliente;
    End$$
Delimiter ;

-- /-/-/-/ Editar /-/-/-/
Delimiter $$
	Create procedure sp_EditarCliente (in codCliente int, in nomCliente varchar(45), in apeCliente varchar(45), in fonCliente varchar(8), 
		in direcCliente varchar(45), in mail varchar(45), in codLocal int, in codAdministracion int, in codTipoCliente int)
    Begin
		Update Cliente C
			Set
				C.nombresCliente = nomCliente, 
				C.apellidosCliente = apeCliente, 
				C.telefonoCliente = fonCliente, 
				C.direccionCliente = direcCliente, 
				C.email = mail, 
				C.codigoLocal = codLocal, 
                C.codigoAdministracion = codAdministracion,
				C.codigoTipoCliente = codTipoCliente
			Where codigoCliente = codCliente;
	End$$
Delimiter ;


-- /-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
-- /-/-/ Procedimientos almacenados para CuentasPorCobrar /-/-/
-- /-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
-- /-/-/-/ Agregar /-/-/-/
Delimiter $$
	Create procedure sp_AgregarCuentasPorCobrar (in codigoCuentaPorCobrar int, in numeroFactura varchar(45), in anio year(4), in mes int(2), in valorNetoPago double, 
		in estadoPago varchar(45), in codigoAdministracion int)
	Begin
		Insert into CuentasPorCobrar (codigoCuentaPorCobrar, numeroFactura, anio, mes, valorNetoPago, estadoPago, codigoAdministracion)
			Values (codigoCuentaPorCobrar, numeroFactura, anio, mes, valorNetoPago, estadoPago, codigoAdministracion);
    End$$
Delimiter ;

-- /-/-/-/ Listar /-/-/-/
Delimiter $$
	Create procedure sp_ListarCuentasPorCobrar ()
    Begin
		Select
			CPC.codigoCuentasPorCobrar,
            CPC.anio,
            CPC.mes,
			CPC.valorNetoPago,
			CPC.estadoPago, 
            CPC.codigoAdministracion,
            CPC.numeroFactura, 
            CPC.fechaLimitePago, 

 
            CPC.codigoLocal
		From CuentasPorCobrar CPC;
    End$$
Delimiter ;

-- /-/-/-/ Buscar /-/-/-/
Delimiter $$
	Create procedure sp_BuscarCuentasPorCobrar (in codigoCuentasPorCobrar int)
    Begin
		Select
			CPC.codigoCuentasPorCobrar, 
            CPC.numeroFactura, 
            CPC.fechaLimitePago, 
            CPC.estadoPago, 
            CPC.valorNetoPago, 
            CPC.codigoLocal
		From CuentasPorCobrar CPC
			Where codigoCuentasPorCobrar = codCuentasPorCobrar;
    End$$
Delimiter ;

-- /-/-/-/ Editar /-/-/-/
Delimiter $$
	Create procedure sp_EditarCuentasPorCobrar(in codCuentaPorCobrar int, in numFactura varchar(45), in anionuevo year(4), in mesnueva int(2), in valNetoPago double, 
		in estPago varchar(45), in codAdministracion int)
    Begin
		Update CuentasPorCobrar CPC
			Set
				CPC.numeroFactura = numFactura, 
				CPC.fechaLimitePago = , 
				CPC.estadoPago = , 
				CPC.valorNetoPago = , 
				CPC.codigoLocal = 
			Where ;
	End$$
Delimiter ;


-- /-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
-- /-/- Procedimientos almacenados para CuentasPorPagar -/-/
-- /-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
-- /-/-/-/ Agregar /-/-/-/
Delimiter $$
	Create procedure sp_AgregarCuentasPorPagar (in codigoCuentaPorPagar int, in numeroFactura varchar(45), in fechaLimitePago date, in estadoPago varchar(45), 
		in valorNetoPago double, in codigoAdministracion int, in codigoProveedor int)
	Begin
		Insert into CuentasPorPagar (codigoCuentaPorPagar, numeroFactura, fechaLimitePago, estadoPago, valorNetoPago, codigoAdministracion, codigoProveedor)
			Values (codigoCuentaPorPagar, numeroFactura, fechaLimitePago, estadoPago, valorNetoPago, codigoAdministracion, codigoProveedor);
    End$$
Delimiter ;

-- /-/-/-/ Listar /-/-/-/
Delimiter $$
	Create procedure sp_ListarCuentasPorPagar ()
    Begin
		Select
			CPP.codigoCuentasPorPagar, 
            CPP.numeroFactura, 
            CPP.fechaLimitePago, 
            CPP.estadoPago, 
            CPP.valorNetoPago, 
            CPP.codigoAdministracion, 
            CPP.codigoProveedor
		From CuentasPorPagar CPP;
    End$$
Delimiter ;

-- /-/-/-/ Buscar /-/-/-/
Delimiter $$
	Create procedure sp_BuscarCuentasPorPagar (in codCuentasPorPagar int)
    Begin
		Select
			CPP.codigoCuentasPorPagar, 
            CPP.numeroFactura, 
            CPP.fechaLimitePago, 
            CPP.estadoPago, 
            CPP.valorNetoPago, 
            CPP.codigoAdministracion, 
            CPP.codigoProveedor
		From CuentasPorPagar CPP
			Where codigoCuentasPorPagar = codCuentasPorPagar;
    End$$
Delimiter ;

-- /-/-/-/ Editar /-/-/-/
Delimiter $$
	Create procedure sp_EditarCuentasPorPagar()
    Begin
		Update 
			Set
				
			Where ;
	End$$
Delimiter ;
