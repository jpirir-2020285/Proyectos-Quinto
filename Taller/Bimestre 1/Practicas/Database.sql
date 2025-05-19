/*
	Jose Miguel Pirir Pérez
	Codigo técnico: IN5AM
    No. Carné: 2020285
    Fecha de creación:
		23-01-2024
*/

Drop  database if exists DBKinal2020285;
create database DBKinal2020285;

Use DBKinal2020285;

Create table Directores(
	DPI bigint(13) not null,
    nombresDirector varchar(60) not null,
    apellidosDirector varchar(60) not null,
    telefonoLaboral varchar(8) not null,
    primary key PK_DPI (DPI)
);

Create table Asignaturas(
	codigoAsignatura varchar(20) not null ,
    nombreAsignatura varchar(40) not null,
    cantidadDeCreditos int(1) ,
    primary key PK_codigoAsignatura (codigoAsignatura)
);

Create table EquiposTecnicos(
	codigoEquiposTecnico int not null auto_increment,
    nombreEquipoTecnico varchar(45) not null,
    edificio char not null,
    numeroOficina int(2) not null,
    DPI bigint(13) not null,
    primary key PK_EquiposTecnicos(codigoEquiposTecnico),
	constraint FK_EquiposTecnicos_Directores foreign key (DPI)
		references Directores (DPI)
);

create table Profesores(
	DPI bigint(13) not null,
    nombreProfesor varchar(60) not null,
    apellidosProfesor varchar(60) not null,
    tituloUniversitario varchar(60),
    codigoEquiposTecnico int not null,
	primary key PK_DPI (DPI),
    constraint FK_Profesres_EquiposTecnicos foreign key (codigoEquiposTecnico)
		references EquiposTecnicos(codigoEquiposTecnico)
);

create table Estudiantes (
	numeroCarne int not null,
    nombresEstudiante Varchar(60) not null,
    apellidoEstudiante varchar(60) not null,
    direccionEstudiante varchar(150) not null,
    nombreEncargado varchar(100) not null,
    DPI bigint(13) not null,
    codigoAsignatura varchar(20) not null,
    primary key PK_numeroCarne(numeroCarne),
    constraint FK_Estudiantes_Profesores foreign key (DPI)
		references Profesores(DPI),
	constraint FK_Estudiantes_Asignaturas foreign key (codigoAsignatura)
		references Asignaturas(codigoAsignatura)
);

-- ----- Instruccion DML -------

-- -- insert -- --

-- Directores
Insert into Directores (DPI, nombresDirector, apellidosDirector, telefonoLaboral) 
	values (1534567482501,'Angel Rodrigo', 'Pirir Pérez','54561794');
Insert into Directores (DPI, nombresDirector, apellidosDirector, telefonoLaboral) 
	values (1563563563201,'Julio Rene','Alvarado Herrera','54237582');
Insert into Directores (DPI, nombresDirector, apellidosDirector, telefonoLaboral) 
	values (1550973008501,'Diego Andres','Reyes Revolorio','5493002');
Insert into Directores (DPI, nombresDirector, apellidosDirector, telefonoLaboral) 
	values (1598076845101,'Ana Lucia','Gomez Lopez','54678923');
Insert into Directores (DPI, nombresDirector, apellidosDirector, telefonoLaboral) 
	values (1512345678901,'Roberto Carlos','Mendez Garcia','54871234');--
Insert into Directores (DPI, nombresDirector, apellidosDirector, telefonoLaboral) 
	values (1523456789001,'Maria Fernanda','Soto Sandoval','54123456');
Insert into Directores (DPI, nombresDirector, apellidosDirector, telefonoLaboral) 
	values (1587654321001,'Juan Carlos','Cruz Velasquez','54456789');
Insert into Directores (DPI, nombresDirector, apellidosDirector, telefonoLaboral) 
	values (1543210987601,'Luisa Gabriela','Gutierrez Perez','54789012');-- -----
Insert into Directores (DPI, nombresDirector, apellidosDirector, telefonoLaboral) 
	values (1576543210901,'Ricardo Alejandro','Lara Ramirez','54012345');
Insert into Directores (DPI, nombresDirector, apellidosDirector, telefonoLaboral) 
	values (1509876543201,'Gabriela Sofia','Rojas Estrada','54345678');
Insert into Directores (DPI, nombresDirector, apellidosDirector, telefonoLaboral) 
	values (1590123456701,'Carlos Alberto','Ortiz Lopez','54678901');-- --
Insert into Directores (DPI, nombresDirector, apellidosDirector, telefonoLaboral) 
	values (1554321098001,'Diana Patricia','Jimenez Mendoza','54901234');
Insert into Directores (DPI, nombresDirector, apellidosDirector, telefonoLaboral) 
	values (1512348678901,'Jorge Alberto','Castillo Ramirez','54234567');
Insert into Directores (DPI, nombresDirector, apellidosDirector, telefonoLaboral) 
	values (1523447789001,'Fernanda Alejandra','Rodriguez Paz','54567890');
Insert into Directores (DPI, nombresDirector, apellidosDirector, telefonoLaboral) 
	values (1587657321001,'Miguel Angel','Vasquez Gonzalez','54890123');
Insert into Directores (DPI, nombresDirector, apellidosDirector, telefonoLaboral) 
	values (1523210987601,'Paola Andrea','Hernandez Aguilar','54123456');
Insert into Directores (DPI, nombresDirector, apellidosDirector, telefonoLaboral) 
	values (1576540210901,'Hector Antonio','Torres Contreras','54456789');
Insert into Directores (DPI, nombresDirector, apellidosDirector, telefonoLaboral) 
	values (1509870543210,'Lorena Isabel','Chavez Mendez','54789012');
Insert into Directores (DPI, nombresDirector, apellidosDirector, telefonoLaboral) 
	values (1590128456701,'Oscar Alejandro','Sosa Mejia','54012345');

    
-- Asignaturas
Insert Into Asignaturas (codigoAsignatura, nombreAsignatura, cantidadDeCreditos) 
	values ('MA101AM','Cálculo I',4);
Insert Into Asignaturas (codigoAsignatura, nombreAsignatura, cantidadDeCreditos) 
	values ('LI102PM','Literatura Universal',3);
Insert Into Asignaturas (codigoAsignatura, nombreAsignatura, cantidadDeCreditos) 
	values ('EA103AM','Arte Contemporáneo',2);
Insert Into Asignaturas (codigoAsignatura, nombreAsignatura, cantidadDeCreditos) 
	values ('QI104PM','Química Orgánica',4);
Insert Into Asignaturas (codigoAsignatura, nombreAsignatura, cantidadDeCreditos) 
	values ('RE105AM','Ética y Valores',3);
Insert Into Asignaturas (codigoAsignatura, nombreAsignatura, cantidadDeCreditos) 
	values ('MA201PM','Álgebra Lineal',4);
Insert Into Asignaturas (codigoAsignatura, nombreAsignatura, cantidadDeCreditos) 
	values ('LI202AM','Teoría Literaria',3);
Insert Into Asignaturas (codigoAsignatura, nombreAsignatura, cantidadDeCreditos) 
	values ('EA203PM','Historia del Arte',2);
Insert Into Asignaturas (codigoAsignatura, nombreAsignatura, cantidadDeCreditos) 
	values ('QI204AM','Química Analítica',4);
Insert Into Asignaturas (codigoAsignatura, nombreAsignatura, cantidadDeCreditos) 
	values ('RE205PM','Filosofía Contemporánea',3);
Insert Into Asignaturas (codigoAsignatura, nombreAsignatura, cantidadDeCreditos) 
	values ('MA301AM','Ecuaciones Diferenciales',4);
Insert Into Asignaturas (codigoAsignatura, nombreAsignatura, cantidadDeCreditos) 
	values ('LI302PM','Poesía Moderna',3);
Insert Into Asignaturas (codigoAsignatura, nombreAsignatura, cantidadDeCreditos) 
	values ('EA303AM','Diseño Gráfico',2);
Insert Into Asignaturas (codigoAsignatura, nombreAsignatura, cantidadDeCreditos) 
	values ('QI304PM','Química Física',4);
Insert Into Asignaturas (codigoAsignatura, nombreAsignatura, cantidadDeCreditos) 
	values ('RE305AM','Teología Comparada',3);
Insert Into Asignaturas (codigoAsignatura, nombreAsignatura, cantidadDeCreditos) 
	values ('MA401PM','Estadística Avanzada',4);
Insert Into Asignaturas (codigoAsignatura, nombreAsignatura, cantidadDeCreditos) 
	values ('LI402AM','Novela Contemporánea',3);
Insert Into Asignaturas (codigoAsignatura, nombreAsignatura, cantidadDeCreditos) 
	values ('EA403PM','Fotografía Artística',2);
Insert Into Asignaturas (codigoAsignatura, nombreAsignatura, cantidadDeCreditos) 
	values ('QI404AM','Química Inorgánica',4);
Insert Into Asignaturas (codigoAsignatura, nombreAsignatura, cantidadDeCreditos) 
	values ('RE405PM','Ética Profesional',3);


-- EquiposTecnicos
Insert Into EquiposTecnicos (nombreEquipoTecnico, Edificio, numeroOficina, DPI) 
	Values ('Ciencias Exactas','A','23',1534567482501);
Insert Into EquiposTecnicos ( nombreEquipoTecnico, Edificio, numeroOficina, DPI) 
	Values ('Tecnología','B','14',1563563563201);
Insert Into EquiposTecnicos ( nombreEquipoTecnico, Edificio, numeroOficina, DPI) 
	Values ('Administración de Empresas','C','43',1550973008501);
Insert Into EquiposTecnicos ( nombreEquipoTecnico, Edificio, numeroOficina, DPI) 
	Values ('Arquitectura','D','34',1598076845101);
Insert Into EquiposTecnicos ( nombreEquipoTecnico, Edificio, numeroOficina, DPI) 
	Values ('Comunicación','A','12',1523456789001);
Insert Into EquiposTecnicos ( nombreEquipoTecnico, Edificio, numeroOficina, DPI) 
	Values ('Biología','B','25',1587654321001);
Insert Into EquiposTecnicos ( nombreEquipoTecnico, Edificio, numeroOficina, DPI) 
	Values ('Psicología','C','32',1543210987601);
Insert Into EquiposTecnicos ( nombreEquipoTecnico, Edificio, numeroOficina, DPI) 
	Values ('Ingeniería','D','41',1576543210901);
Insert Into EquiposTecnicos ( nombreEquipoTecnico, Edificio, numeroOficina, DPI) 
	Values ('Medicina','A','14',1509876543201);
Insert Into EquiposTecnicos ( nombreEquipoTecnico, Edificio, numeroOficina, DPI) 
	Values ('Derecho','B','22',1590123456701);
Insert Into EquiposTecnicos ( nombreEquipoTecnico, Edificio, numeroOficina, DPI) 
	Values ('Matemáticas','C','35',1554321098001);
Insert Into EquiposTecnicos ( nombreEquipoTecnico, Edificio, numeroOficina, DPI) 
	Values ('Física','D','45',1512348678901);
Insert Into EquiposTecnicos ( nombreEquipoTecnico, Edificio, numeroOficina, DPI) 
	Values ('Química','A','11',1523447789001);
Insert Into EquiposTecnicos ( nombreEquipoTecnico, Edificio, numeroOficina, DPI) 
	Values ('Economía','B','26',1512348678901);--
Insert Into EquiposTecnicos ( nombreEquipoTecnico, Edificio, numeroOficina, DPI) 
	Values ('Sociología','C','42',1523447789001);
Insert Into EquiposTecnicos ( nombreEquipoTecnico, Edificio, numeroOficina, DPI) 
	Values ('Arte','D','32',1587657321001);
Insert Into EquiposTecnicos ( nombreEquipoTecnico, Edificio, numeroOficina, DPI) 
	Values ('Historia','A','15',1523210987601);
Insert Into EquiposTecnicos ( nombreEquipoTecnico, Edificio, numeroOficina, DPI) 
	Values ('Ciencias Políticas','B','21',1576540210901);
Insert Into EquiposTecnicos ( nombreEquipoTecnico, Edificio, numeroOficina, DPI) 
	Values ('Español','C','34',1509870543210);
Insert Into EquiposTecnicos ( nombreEquipoTecnico, Edificio, numeroOficina, DPI) 
	Values ('Educación','D','43',1590128456701);


-- Profesores
Insert Into Profesores (DPI, nombreProfesor, apellidosProfesor, tituloUniversitario, codigoEquiposTecnico) 
	Values (4285061286001,'Carlos Eduardo','Gomez Rodriguez','Licenciado en Matemáticas',1);
Insert Into Profesores (DPI, nombreProfesor, apellidosProfesor, tituloUniversitario, codigoEquiposTecnico) 
	Values (3678901234501,'Ana Maria','Lopez Alvarez','Doctor en Física',2);
Insert Into Profesores (DPI, nombreProfesor, apellidosProfesor, tituloUniversitario, codigoEquiposTecnico) 
	Values (2546789012345,'Pedro Jose','Velasquez Chavez','Ingeniero Civil',3);
Insert Into Profesores (DPI, nombreProfesor, apellidosProfesor, tituloUniversitario, codigoEquiposTecnico) 
	Values (3590123456789,'Martha Isabel','Cruz Paredes','Licenciada en Ciencias de la Computación',4);
Insert Into Profesores (DPI, nombreProfesor, apellidosProfesor, tituloUniversitario, codigoEquiposTecnico) 
	Values (4567890123456,'Luis Alberto','Ramirez Diaz','Doctor en Economía',5);
Insert Into Profesores (DPI, nombreProfesor, apellidosProfesor, tituloUniversitario, codigoEquiposTecnico) 
	Values (5678901234567,'Karen Michelle','Garcia Castillo','Licenciada en Derecho',6);
Insert Into Profesores (DPI, nombreProfesor, apellidosProfesor, tituloUniversitario, codigoEquiposTecnico) 
	Values (6789012345678,'Ricardo Andres','Martinez Flores','Ingeniero en Electricidad',7);
Insert Into Profesores (DPI, nombreProfesor, apellidosProfesor, tituloUniversitario, codigoEquiposTecnico) 
	Values (7890123456789,'Fernanda Alejandra','Mendez Perez','Doctor en Psicología',8);
Insert Into Profesores (DPI, nombreProfesor, apellidosProfesor, tituloUniversitario, codigoEquiposTecnico) 
	Values (8901234567890,'David Alejandro','Rojas Mejia','Licenciado en Historia',9);
Insert Into Profesores (DPI, nombreProfesor, apellidosProfesor, tituloUniversitario, codigoEquiposTecnico) 
	Values (9012345678901,'Sofia Carolina','Lara Hernandez','Doctora en Biología',10);
Insert Into Profesores (DPI, nombreProfesor, apellidosProfesor, tituloUniversitario, codigoEquiposTecnico) 
	Values (1234567890123,'Juan Manuel','Castro Soto','Licenciado en Comunicación',11);
Insert Into Profesores (DPI, nombreProfesor, apellidosProfesor, tituloUniversitario, codigoEquiposTecnico) 
	Values (2345678901234,'Gabriela Patricia','Perez Galvez','Doctora en Química',12);
Insert Into Profesores (DPI, nombreProfesor, apellidosProfesor, tituloUniversitario, codigoEquiposTecnico) 
	Values (3456789012345,'Daniel Antonio','Torres Gutierrez','Ingeniero en Electrónica',13);
Insert Into Profesores (DPI, nombreProfesor, apellidosProfesor, tituloUniversitario, codigoEquiposTecnico) 
	Values (4467890123456,'Lorena Alejandra','Gonzalez Jimenez','Licenciada en Educación',14);
Insert Into Profesores (DPI, nombreProfesor, apellidosProfesor, tituloUniversitario, codigoEquiposTecnico) 
	Values (5578901234567,'Oscar Alberto','Diaz Sosa','Doctor en Sociología',15);
Insert Into Profesores (DPI, nombreProfesor, apellidosProfesor, tituloUniversitario, codigoEquiposTecnico) 
	Values (6689012345678,'Paola Fernanda','Herrera Vargas','Licenciada en Arte',16);
Insert Into Profesores (DPI, nombreProfesor, apellidosProfesor, tituloUniversitario, codigoEquiposTecnico) 
	Values (7790123456789,'Miguel Angel','Paz Vasquez','Ingeniero Agrónomo',17);
Insert Into Profesores (DPI, nombreProfesor, apellidosProfesor, tituloUniversitario, codigoEquiposTecnico) 
	Values (8801234567890,'Diana Carolina','Ortiz Ramirez','Licenciada en Psicopedagogía',18);


-- Estudiantes
Insert Into Estudiantes (numeroCarne, nombresEstudiante, apellidoEstudiante, direccionEstudiante, nombreEncargado, DPI, codigoAsignatura) 
	values (2020132, 'Ana Lucia', 'Gomez Lopez', '15 Avenida 7-43, Zona 3, Colonia Los Pinos, Guatemala','Carlos Alberto',4285061286001,'MA101AM');
Insert Into Estudiantes (numeroCarne, nombresEstudiante, apellidoEstudiante, direccionEstudiante, nombreEncargado, DPI, codigoAsignatura) 
	values (2020245, 'Roberto Carlos', 'Mendez Garcia', '12 Calle 5-28, Zona 4, Barrio San Francisco, Guatemala','Maria Fernanda',3678901234501,'LI102PM');
Insert Into Estudiantes (numeroCarne, nombresEstudiante, apellidoEstudiante, direccionEstudiante, nombreEncargado, DPI, codigoAsignatura) 
	values (2020315, 'Luisa Gabriela', 'Gutierrez Perez', '18 Avenida 10-15, Zona 2, Colonia El Rosario, Guatemala','Ricardo Alejandro',2546789012345,'EA103AM');
Insert Into Estudiantes (numeroCarne, nombresEstudiante, apellidoEstudiante, direccionEstudiante, nombreEncargado, DPI, codigoAsignatura) 
	values (2020428, 'Diego Andres', 'Reyes Revolorio', '25 Calle 15-82, Zona 5, Barrio La Reforma, Guatemala','Sofia Carolina',3590123456789,'QI104PM');
Insert Into Estudiantes (numeroCarne, nombresEstudiante, apellidoEstudiante, direccionEstudiante, nombreEncargado, DPI, codigoAsignatura) 
	values (2020512, 'Maria Fernanda', 'Soto Sandoval', '22 Avenida 9-33, Zona 6, Colonia San Marcos, Guatemala','Daniel Antonio',4567890123456,'RE105AM');
Insert Into Estudiantes (numeroCarne, nombresEstudiante, apellidoEstudiante, direccionEstudiante, nombreEncargado, DPI, codigoAsignatura) 
	values (2020625, 'Carlos Alberto', 'Ortiz Lopez', '14 Calle 4-78, Zona 7, Barrio El Carmen, Guatemala','Gabriela Patricia',5678901234567,'MA201PM');
Insert Into Estudiantes (numeroCarne, nombresEstudiante, apellidoEstudiante, direccionEstudiante, nombreEncargado, DPI, codigoAsignatura) 
	values (2020732, 'Diana Patricia', 'Jimenez Mendoza', '17 Avenida 8-21, Zona 8, Colonia La Esperanza, Guatemala','Juan Manuel',6789012345678,'LI202AM');
Insert Into Estudiantes (numeroCarne, nombresEstudiante, apellidoEstudiante, direccionEstudiante, nombreEncargado, DPI, codigoAsignatura) 
	values (2020817, 'Jorge Alberto', 'Castillo Ramirez', '19 Calle 11-46, Zona 9, Barrio Los Olivos, Guatemala','Ana Maria',7890123456789,'EA203PM');
Insert Into Estudiantes (numeroCarne, nombresEstudiante, apellidoEstudiante, direccionEstudiante, nombreEncargado, DPI, codigoAsignatura) 
	values (2020922, 'Fernanda Alejandra', 'Rodriguez Paz', '13 Avenida 6-57, Zona 10, Colonia San Jose, Guatemala','Pedro Jose',8901234567890,'QI204AM');
Insert Into Estudiantes (numeroCarne, nombresEstudiante, apellidoEstudiante, direccionEstudiante, nombreEncargado, DPI, codigoAsignatura) 
	values (2021025, 'Miguel Angel', 'Vasquez Gonzalez', '16 Calle 12-78, Zona 11, Barrio El Progreso, Guatemala','Karen Michelle',9012345678901,'RE205PM');
Insert Into Estudiantes (numeroCarne, nombresEstudiante, apellidoEstudiante, direccionEstudiante, nombreEncargado, DPI, codigoAsignatura) 
	values (2021132, 'Paola Andrea', 'Hernandez Aguilar', '20 Avenida 7-35, Zona 12, Colonia Las Rosas, Guatemala','Luis Alberto',1234567890123,'MA301AM');
Insert Into Estudiantes (numeroCarne, nombresEstudiante, apellidoEstudiante, direccionEstudiante, nombreEncargado, DPI, codigoAsignatura) 
	values (2021245, 'Hector Antonio', 'Torres Contreras', '11 Calle 5-19, Zona 13, Barrio San Carlos, Guatemala','Diana Carolina',2345678901234,'LI302PM');
Insert Into Estudiantes (numeroCarne, nombresEstudiante, apellidoEstudiante, direccionEstudiante, nombreEncargado, DPI, codigoAsignatura) 
	values (2021315, 'Oscar Alejandro', 'Sosa Mejia', '18 Avenida 10-42, Zona 14, Colonia El Bosque, Guatemala','Sofia Alejandra',3456789012345,'EA303AM');
Insert Into Estudiantes (numeroCarne, nombresEstudiante, apellidoEstudiante, direccionEstudiante, nombreEncargado, DPI, codigoAsignatura) 
	values (2021428, 'Lorena Isabel', 'Chavez Mendez', '25 Calle 15-70, Zona 15, Barrio La Montaña, Guatemala','Ricardo Andres',4467890123456,'QI304PM');
Insert Into Estudiantes (numeroCarne, nombresEstudiante, apellidoEstudiante, direccionEstudiante, nombreEncargado, DPI, codigoAsignatura) 
	values (2021512, 'Julio Rene', 'Alvarado Herrera', '22 Avenida 9-20, Zona 16, Colonia Los Heroes, Guatemala','Gabriela Sofia',5578901234567,'RE305AM');
Insert Into Estudiantes (numeroCarne, nombresEstudiante, apellidoEstudiante, direccionEstudiante, nombreEncargado, DPI, codigoAsignatura) 
	values (2021625, 'Diego Andres', 'Reyes Revolorio', '14 Calle 4-62, Zona 17, Barrio San Miguel, Guatemala','Carlos Eduardo',6689012345678,'MA401PM');
Insert Into Estudiantes (numeroCarne, nombresEstudiante, apellidoEstudiante, direccionEstudiante, nombreEncargado, DPI, codigoAsignatura) 
	values (2021732, 'Gabriela Sofia', 'Rojas Estrada', '17 Avenida 8-36, Zona 1, Colonia La Candelaria, Guatemala','Luis Alberto',7790123456789,'LI402AM');
Insert Into Estudiantes (numeroCarne, nombresEstudiante, apellidoEstudiante, direccionEstudiante, nombreEncargado, DPI, codigoAsignatura) 
	values (2021817, 'Carlos Alberto', 'Ortiz Lopez', '19 Calle 11-23, Zona 2, Barrio El Rosario, Guatemala','Ana Maria',8801234567890,'RE405PM');


-- Mostrar datos con select

Select 
	D.DPI,
    D.nombresDirector,
	D.apellidosDirector,
    D.telefonoLaboral
    from Directores D;
    
select 
	A.codigoAsignatura,
    A.nombreAsignatura,
    A.cantidadDeCreditos
    from Asignaturas A;
	
Select 
	E.codigoEquiposTecnico,
    E.nombreEquipoTecnico,
    E.edificio,
    E.numeroOficina,
    E.DPI
    from EquiposTecnicos E;
    
Select
	P.DPI,
    P.nombreProfesor,
    P.apellidosProfesor,
    P.tituloUniversitario,
    P.codigoEquiposTecnico
    from Profesores P;
    
Select
	E.numeroCarne as carne,
    E.nombresEstudiante,
    E.apellidoEstudiante,
    E.direccionEstudiante,
    E.nombreEncargado,
    E.DPI
    From Estudiantes E;
    
-- Selec con encapsulamiento Where

Select 
	D.DPI,
    D.nombresDirector,
	D.apellidosDirector,
    D.telefonoLaboral
    from Directores D
    where nombresDirector = 'Angel Rodrigo';
Select 
	D.DPI,
    D.nombresDirector,
	D.apellidosDirector,
    D.telefonoLaboral
    from Directores D
    where DPI = 1512345678901;
Select 
	D.DPI,
    D.nombresDirector,
	D.apellidosDirector,
    D.telefonoLaboral
    from Directores D
    where apellidosDirector = 'Jimenez Mendoza';
Select 
	D.DPI,
    D.nombresDirector,
	D.apellidosDirector,
    D.telefonoLaboral
    from Directores D
    where telefonoLaboral = '54890123';
Select
    D.DPI,
    D.nombresDirector,
	D.apellidosDirector,
    D.telefonoLaboral
    from Directores D
    where nombresDirector = 'Oscar Alejandro';
    
select 
	A.codigoAsignatura,
    A.nombreAsignatura,
    A.cantidadDeCreditos
    from Asignaturas A
    where cantidadDeCreditos = 3;
select 
	A.codigoAsignatura,
    A.nombreAsignatura,
    A.cantidadDeCreditos
    from Asignaturas A
    where nombreAsignatura = 'Química Física';
select 
	A.codigoAsignatura,
    A.nombreAsignatura,
    A.cantidadDeCreditos
    from Asignaturas A
    where cantidadDeCreditos = 4;
select 
	A.codigoAsignatura,
    A.nombreAsignatura,
    A.cantidadDeCreditos
    from Asignaturas A
    where nombreAsignatura = 'Historia del Arte';  
select 
	A.codigoAsignatura,
    A.nombreAsignatura,
    A.cantidadDeCreditos
    from Asignaturas A
    where nombreAsignatura = 'Diseño Gráfico';  
    
Select 
	E.codigoEquiposTecnico,
    E.nombreEquipoTecnico,
    E.edificio,
    E.numeroOficina,
    E.DPI
    from EquiposTecnicos E
    where nombreEquipoTecnico = 'Tecnología';
Select 
	E.codigoEquiposTecnico,
    E.nombreEquipoTecnico,
    E.edificio,
    E.numeroOficina,
    E.DPI
    from EquiposTecnicos E
    where edificio = 'A';
Select 
	E.codigoEquiposTecnico,
    E.nombreEquipoTecnico,
    E.edificio,
    E.numeroOficina,
    E.DPI
    from EquiposTecnicos E
    where edificio = '12';
Select 
	E.codigoEquiposTecnico,
    E.nombreEquipoTecnico,
    E.edificio,
    E.numeroOficina,
    E.DPI
    from EquiposTecnicos E
    where edificio = 'C';
Select 
	E.codigoEquiposTecnico,
    E.nombreEquipoTecnico,
    E.edificio,
    E.numeroOficina,
    E.DPI
    from EquiposTecnicos E
    where codigoEquiposTecnico = 18;

Select
	P.DPI,
    P.nombreProfesor,
    P.apellidosProfesor,
    P.tituloUniversitario,
    P.codigoEquiposTecnico
    from Profesores P
    where nombreProfesor = 'Martha Isabel';
Select
	P.DPI,
    P.nombreProfesor,
    P.apellidosProfesor,
    P.tituloUniversitario,
    P.codigoEquiposTecnico
    from Profesores P
    where apellidosProfesor = 'Mendez Perez';
Select
	P.DPI,
    P.nombreProfesor,
    P.apellidosProfesor,
    P.tituloUniversitario,
    P.codigoEquiposTecnico
    from Profesores P
    where tituloUniversitario = 'Doctor en Psicología';
Select
	P.DPI,
    P.nombreProfesor,
    P.apellidosProfesor,
    P.tituloUniversitario,
    P.codigoEquiposTecnico
    from Profesores P
    where nombreProfesor = 'Gabriela Patricia';
Select
	P.DPI,
    P.nombreProfesor,
    P.apellidosProfesor,
    P.tituloUniversitario,
    P.codigoEquiposTecnico
    from Profesores P
    where tituloUniversitario = 'Licenciada en Educación';

Select
	E.numeroCarne as carne,
    E.nombresEstudiante,
    E.apellidoEstudiante,
    E.direccionEstudiante,
    E.nombreEncargado,
    E.DPI
    From Estudiantes E
    where carne = 2021315;
Select
	E.numeroCarne as carne,
    E.nombresEstudiante,
    E.apellidoEstudiante,
    E.direccionEstudiante,
    E.nombreEncargado,
    E.DPI
    From Estudiantes E
    where nombresEstudiante = 'Carlos Alberto';
Select
	E.numeroCarne as carne,
    E.nombresEstudiante,
    E.apellidoEstudiante,
    E.direccionEstudiante,
    E.nombreEncargado,
    E.DPI
    From Estudiantes E
    where apellidoEstudiante = 'Hernandez Aguilar';
Select
	E.numeroCarne as carne,
    E.nombresEstudiante,
    E.apellidoEstudiante,
    E.direccionEstudiante,
    E.nombreEncargado,
    E.DPI
    From Estudiantes E
    where direccionEstudiante = '20 Avenida 7-35, Zona 12, Colonia Las Rosas, Guatemala';
Select
	E.numeroCarne as carne,
    E.nombresEstudiante,
    E.apellidoEstudiante,
    E.direccionEstudiante,
    E.nombreEncargado,
    E.DPI
    From Estudiantes E
    where nombreEncargado = 'Ricardo Andres';



-- Drop table if exists Directores;
-- Drop table if exists Asignaturas;
-- Drop table if exists EquiposTecnicos;
-- Drop table if exists Profesores;
-- Drop table if exists Estudiantes;

-- Delete para tablas
Delete from Directores where nombresDirector = 'Ana Lucia';
Delete from Directores where apellidosDirector = 'Reyes Revolorio';
Delete from Directores where DPI = 1587654321001;
Delete from Directores where telefonoLaboral = '54012345';
Delete from Directores where nombresDirector = 'Luisa Gabriela';

Delete from Asignatura where codigoAsignatura = 'QI104PM';
Delete from Asignatura where nombreAsignatura = 'Teoría Literaria';
Delete from Asignatura where cantidadDeCreditos = 4;
Delete from Asignatura where nombreAsignatura = 'Arte Contemporáneo';
Delete from Asignatura where codigoAsignatura = 'MA101AM';

Delete from EquiposTecnicos where codigoEquiposTecnico = 3;
Delete from EquiposTecnicos where nombreEquipoTecnico = 'Ciencias Exactas';
Delete from EquiposTecnicos where edificio = 'C';
Delete from EquiposTecnicos where numeroOficina = '22';
Delete from EquiposTecnicos where DPI = 1523210987601;

Delete from Profesores where DPI = 7790123456789;
Delete from Profesores where nombreProfesor = 'Miguel Angel';
Delete from Profesores where apellidosProfesor = 'Velasquez Chavez';
Delete from Profesores where tituloUniversitario = 'Ingeniero en Electrónica';
Delete from Profesores where codigoEquiposTecnico = 14;

Delete from Estudiantes where numeroCarne = 2020428;
Delete from Estudiantes where nombresEstudiante = 'Martha Isabel';
Delete from Estudiantes where apellidoEstudiante = 'Torres Contreras';
Delete from Estudiantes where direccionEstudiante = '14 Calle 4-78, Zona 7, Barrio El Carmen, Guatemala';
Delete from Estudiantes where nombreEncargado = 'Karen Michelle';
