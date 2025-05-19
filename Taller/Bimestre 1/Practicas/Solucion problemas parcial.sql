/* 	Jose Miguel Pirir Pérez
	IN5AM
    2020285
	12-02-2024
*/

drop database if exists DBParcial2020285;
create database DBParcial2020285;

use DBParcial2020285;

Create table Laboratorio(
	codigoLaboratorio int auto_increment not null,
    valor1 int not null,
    valor2 int not null,
    valor3 int not null,
    valor4 int not null,
    valor5 int not null,
    r1 int,
    r2 varchar(100),
    r3 decimal(10,2),
    r4 decimal(10,2),
    r5 decimal(10,2),
    r6 varchar(256),
    primary key PK_codigoLaboratorio (codigoLaboratorio)
);

Delimiter $$
	Create procedure sp_AgregarDatos(in valor1 int, in valor2 int, in valor3 int, in valor4 int, in valor5 int)
		Begin
			Insert into Laboratorio
				(valor1, valor2, valor3, valor4, valor5)
                values (valor1, valor2, valor3, valor4, valor5);
        End$$
Delimiter ;


CALL sp_AgregarDatos(3,5,2,6,8);

Delimiter $$
Create procedure sp_ListarDatos()
	Begin
		Select
			Laboratorio.valor1,
            Laboratorio.valor2,
            Laboratorio.valor3,
            Laboratorio.valor4,
            Laboratorio.valor5,
            Laboratorio.r1,
            Laboratorio.r2,
            Laboratorio.r3,
            Laboratorio.r4,
            Laboratorio.r5,            
            Laboratorio.r6
            from
				Laboratorio;
    End$$
Delimiter ;

Call sp_ListarDatos();



Delimiter $$
	create function fn_vietta1(a int, b int, c int) returns decimal(10,2)
		Reads sql data deterministic
        begin
			declare determinante float default 0.0;
            set determinante = sqrt((b*b)-(4*a*c));
			
        end$$
Delimiter ;



delimiter $$
	create function fn_SumDivisores(n1 int, n2 int , n3 int, n4 int,n5 int ) returns varchar(100)
		reads sql data deterministic
        begin
			declare suma int default 0;
            declare cont int default 0;
            declare divisores varchar(100) default '';
            set suma = n1+n2+n3+n4+n5;
            while (cont < suma) do
				set cont = cont +1;
				if (suma mod cont = 0) then
					set divisores = concat(divisores , ', ', cont);
				end if;
            end while;
            return divisores;
        end$$
Delimiter ; 

select fn_SumDivisores(3,5,2,6,8);

drop function if exists fn_Perfecto;
delimiter $$
	create function fn_Perfecto(n1 int) returns varchar(256)
		reads sql data deterministic
        begin
            declare cont int default 0;
            declare sumas int default 0;
            while (cont < n1-1) do
				set cont = cont +1;
				if (n1 mod cont = 0) then
					set sumas = sumas + cont;
				end if;
            end while;
            if (sumas = n1) then
				return 'Número Perfeto';
			else
				return 'Numero No Perfecto';
			end if;
        end$$
Delimiter ; 

select fn_Perfecto(2);



drop function if exists fn_Factorial;
delimiter $$
	create function fn_Factorial(n1 int) returns int
		reads sql data deterministic
        begin
			declare cont int default 0;
            declare suma int default 1;
            while (cont < n1) do
				set cont = cont +1;
                set suma = suma *cont;
            end while;
            return suma;
        end$$
delimiter ;

select fn_Factorial(8);


delimiter $$
	create procedure sp_ActualizarDatos(in codLabororatorio int)
    begin
		Update Laboratorio L
			set 
				L.r1 = fn_Factorial(L.valor5),
                L.r2 = fn_SumDivisores(L.valor5,L.valor4,L.valor3,L.valor2,L.valor1)
                where 
					L.codigoLaboratorio = codLaboratorio;
    end$$
delimiter ;