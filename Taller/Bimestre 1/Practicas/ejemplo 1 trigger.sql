drop database if exists DBEjemplo1Trigger2020285;
create database DBEjemplo1Trigger2020285;

use DBEjemplo1Trigger2020285;

Create table Usuarios(
	codigoUsuario int not null auto_increment,
    nombres varchar(50) not null,
    primary key PK_codigoUsuario (codigoUsuario)
);

Create table ControlUsuario(
	codigoControlUsuario int not null auto_increment,
    codigoRegistro int,
    nombreUsuario varchar(50),
    nombreNuevo varchar(50),
    nombreAntiguo varchar(50),
    usuario varchar(100),
    modificaciones datetime,
    primary key PK_codigoControlUsuario (codigoControlUsuario)
);

-- agregar Usuario
Delimiter $$
	create procedure sp_AgregarUsuario(in nombres varchar(50))
		begin
			insert into Usuarios(nombres) values (nombres);
        end$$
Delimiter ;

-- trigger 1
Delimiter $$
	Create trigger tr_Usuarios_Before_Update
		Before Update on Usuarios
        For each row
        Begin
			set @nombreAntiguo = old.Nombres;
            set @nombreNuevo = New.Nombres;
        End$$		
Delimiter;

-- Editar Usuario
Delimiter $$
	create procedure sp_EditarUsuario(in codUsuario int, in nom varchar(50))
		Begin
			Update Usuarios U
				Set
					U.nombres = nom
				where U.codigoUsuario = codUsuario;
		End$$
Delimiter ; 

-- Trigger 2
Delimiter $$
	Create trigger tr_Usuarios_Before_Insert
		Before Insert on Usuarios
        for each row
        Begin
			set @activacion = 'Trigger Activado';
            set New.nombres = 'haccking name wuajajaja :)';
        End$$
Delimiter ;

-- trigger 3
Delimiter $$
	Create trigger tr_Usuarios_After_Update
		After Update on Usuarios
        for Each row
        Begin
			Insert into ControlUsuario
				(codigoRegistro, nombreAntiguo, nombreNuevo, usuario, modificaciones)
                values (old.codigoUsuario, old.nombres, new.nombres, current_user(), now());
        End$$
Delimiter ;

Call sp_AgregarUsuario('Jose Miguel');

select * from Usuarios;
select @nombreNuevo;

call sp_EditarUsuario(1,'Jose Miguel');
