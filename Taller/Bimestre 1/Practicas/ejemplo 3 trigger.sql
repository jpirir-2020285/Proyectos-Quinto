drop database if exists DBEjemploTrigger32020285;
create database DBEjemploTrigger32020285;

use DBEjemploTrigger32020285;

create table Estudiantes(
	codigoEstudiante int not null,
    nombres varchar(100) not null,
    apellidos varchar(100) not null,
    domicilio varchar(100) not null,
    fechaNacimiento date not null,
    primary key PK_codigoEstudiante(codigoEstudiante)
);

create table Control(
	codigoControl int not null auto_increment,
    usuario varchar(50),
    fechaModificacion datetime,
    primary key PK_codigoControl(codigoControl)
);

Create Table ControlCambios(
	codigoControlCambio int not null auto_increment,
    usuario varchar(100),
    nombreCambio varchar(100),
    apellidosCambio Varchar(100),
    domicilioCambio varchar(150),
    fechaCambio datetime,
    primary key PK_codigoControlCambio(codigoControlCambio)
);

-- trigger 1
delimiter $$
	create trigger tr_Estudiantes_After_Insert
		after insert on Estudiantes
        for each row
        begin
			insert into Control(usuario, fechaModificacion)
				values(current_user(), now());
        end$$
delimiter ;

select * from Estudiantes;
select * from Control;

insert into Estudiantes(codigoEstudiante, nombres, apellidos, domicilio, fechaNacimiento) 
	values (20202850,'Jose','Miguel','Zona 16, Guatemala', '1982-08-17');
    
-- Trigger 2
Delimiter $$
	create Trigger tr_Estudiantes_After_Update
		After update on Estudiantes
        for each row
        begin
			Insert into ControlCambios
				(usuario,NombreCambio,apellidosCambio,domicilioCambio,fechaCambio)
				Values (current_user(), new.nombres, new.apellidos, new.domicilio, now());
        end$$
Delimiter ;

select * from ControlCambios;

update Estudiantes E
	set
		E.nombres = 'Miguelito',
        E.apellidos = 'Pirir Perez',
        E.domicilio = 'Residenciales El Rocal, Mixco',
        E.fechaNacimiento = '2006-10-13'
        where codigoEstudiante = 20202850;