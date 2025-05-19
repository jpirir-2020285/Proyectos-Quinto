/*
*Jose Miguel Pirir Pérez
*2020285
*IN5AM
*06-02-2024
*/


drop database if exists DNPruebasFuncionesIN5AM;
create database DNPruebasFuncionesIN5AM;
use DNPruebasFuncionesIN5AM;

delimiter $$
create function Fn_Sumanotia(num1 int, num2 int) 
	Returns int
    reads sql data deterministic
    Begin
		declare resp int default 0;
        set resp = num1 + num2;
        return resp;
    End$$
Delimiter ;

select fn_Sumanotia(5,8);

delimiter $$
	Create function fn_Suma2(num1 int, num2 int )
		returns decimal(10,2)
		reads Sql data deterministic
		begin
			return num1+num2;
		end$$
Delimiter ;

select fn_Suma2(5,6);
select fn_Suma2(5+7,8);

delimiter $$
	Create function  fn_Mayor(num1 int, num2 int) returns int
		reads sql data deterministic
        begin
			if(num1>num2) then
				return num1;
			end if;
            if(num2>num1) then
				return num2;
			end if;
            if(num2=num1) then
				return num2;
			end if;
		end$$
delimiter ;

select fn_Mayor(7,7);

delimiter $$
	Create function  fn_Mayores(num1 int, num2 int) returns varchar(200)
		reads sql data deterministic
        begin
			if(num1>num2) then
				return (concat('El mayor es: ', num2));
			end if;
            if(num2>num1) then
				return (concat('El mayor es: ', num2));
			end if;
            if(num2=num1) then
				return (concat('Son iguales'));
			end if;
		end$$
delimiter ;
select fn_Mayores(7,7);

-- drop function fn_Mayor2;
-- if simple
delimiter $$
	Create function  fn_Mayor2(num1 int, num2 int) 
		returns varchar(200)
		reads sql data deterministic
        begin
			declare mensaje varchar(100);
            if (num1>num2) then
				set mensaje = concat('El mayor es ', num1);
			end if;
            if(num2>num1) then
				set mensaje = concat('El mayor es ', num2);
			end if; 
            return mensaje;
		end$$
delimiter ;


select fn_Mayor2(5,3);

-- if compuesto
delimiter $$
	Create function  fn_Mayor3(num1 int, num2 int) 
		returns varchar(200)
		reads sql data deterministic
        begin
			declare mensaje varchar(100);
            if (num1>num2) then
				set mensaje = concat('El mayor es ', num1);
			else 
				set mensaje = concat('El mayor es ', num2);
            end if;
            return mensaje;
		end$$
delimiter ;

select fn_Mayor3(10,100);


-- if anidado
delimiter $$
	Create function  fn_Mayor4(num1 int, num2 int) 
		returns varchar(200)
		reads sql data deterministic
        begin
			declare mensaje varchar(100);
            if (num1>num2) then
				set mensaje = concat('El mayor es ', num1);
			elseif (num2>num1) then
				set mensaje = concat('El mayor es ', num2);
			else
				set mensaje = 'Los valores son iguales';
			end if;
            return mensaje;
		end$$
delimiter ;

select fn_Mayor4(100,100);


-- cociente y residuo
delimiter $$
	Create function fn_cosciente(num1 int, num2 int) 
		returns varchar(100)
		reads sql data deterministic
        begin
			declare cociente int;
			declare residuo int;
            declare respuesta varchar(200);
			set cociente = num1 div num2;
            set residuo = mod(num1, num2);
            set respuesta = concat('El cosiente es ',cociente,', el residuo es ',residuo);
            return respuesta;
		end$$
delimiter ;

select fn_cosciente(100,15);


-- mortrar tecla
delimiter $$
	Create function fn_tecla(teclaso char(1)) 
		returns varchar(100)
		reads sql data deterministic
        begin
			Declare respuesta varchar(100);
            set respuesta = concat('Precionaste la tecla ', '"',teclaso,'"');
            return respuesta;
		end$$
delimiter ;

select fn_tecla('p');


delimiter $$
	create function fn_EjmeploCase (dia int) returns varchar(50)
		reads sql data deterministic 
        begin
			case (dia)
				when 1 then
					return 'Domingo';
				when 2 then
					return 'Lunes';
				when 3 then
					return 'Martes';
				when 4 then
					return 'Miercoles';
				when 5 then
					return 'Jueves';
				when 6 then
					return 'Viernes';
				when 7 then
					return 'Sabado';
				else
					return 'no es dia de la semana';
			end case;
        end$$
delimiter ;

select fn_EjmeploCase(3);


delimiter $$
	create function fn_Par_Impar(num1 int) returns varchar(50)
		reads sql data deterministic
        begin
			case (num1 mod 2)
				when 0 then
					return 'el numero es par';
				when 1 then
					return 'el numero es impar';
			end case;
		end$$
delimiter ;

select fn_Par_Impar(35)



-- de celsius a farenheit
delimiter $$
	create function fn_celsiusafarenheit(celsius decimal(10,4)) 
	Returns varchar(100)
    reads sql data deterministic
    Begin
		declare farenheit decimal(10,4);
        set farenheit = (celsius * 1.8) + 32;
        return concat('La conversion de ',celsius,'C a farenheit es ', farenheit);
    End$$
delimiter ;

select fn_celsiusafarenheit(15.5);

delimiter $$
	create function fn_farenheitscelsius(farenheit decimal(10,4)) 
	Returns varchar(100)
    reads sql data deterministic
    Begin
		declare celsius decimal(10,4);
        set celsius = (farenheit-32)*(5/9);
        return concat('La conversion de ',farenheit,'F a ', celsius,'C');
    End$$
delimiter ;

select fn_farenheitscelsius(30.5);

-- De entero a horas:minutos:segundos

delimiter $$
	create function fn_numeroatiempo(segundos int)
	Returns varchar(100)
    reads sql data deterministic
    Begin
		declare horas INT;
		declare minutos INT;
		declare segundos_residuales INT;
		declare tiempo VARCHAR(100);

		set horas = segundos div 3600;
		set segundos_residuales = segundos mod 3600;
		set minutos = segundos_residuales div 60;
		set segundos_residuales = segundos_residuales mod 60;

		SET tiempo = CONCAT(horas,':',minutos,':',segundos_residuales);

		RETURN tiempo;
    End$$
delimiter ;

select fn_numeroatiempo(5000);


drop function if exists fn_CambioMonedas;
Delimiter $$
    Create function fn_CambioMonedas(Cambio decimal(10,2)) returns varchar (250)
    reads sql data deterministic 
    begin
		declare B200,B100,B50,B10,B20,B5,B1 decimal(10,2);
		declare C50,C25,C10,C5 decimal(10,2);
		declare Respuesta varchar(255);
		SET B200 = Cambio DIV 200;
		SET Cambio = Cambio - 
			(B200 * 200);
		SET B100 = Cambio DIV 100;
		SET Cambio = Cambio - 
			(B100 * 100);
		SET B50 = Cambio DIV 50;
		SET Cambio = Cambio - 
			(B50 * 50);
		set B20 = Cambio div 20;
		set Cambio = Cambio - 
			(B20 * 20);
		SET B10 = Cambio DIV 10;
		SET Cambio = Cambio - 
			(B10 * 10);
		SET B5 = Cambio DIV 5;
		SET Cambio = Cambio - 
			(B5 * 5);
		SET B1 = Cambio DIV 1;
			SET Cambio = Cambio - 
			(B1*1);
            
		SET C50 = Cambio DIV 0.50;
		set Cambio = Cambio - 
			(C50*0.50);
		SET C25 = Cambio DIV 0.25;
		set Cambio = Cambio - 
			(C25*0.25);
		SET C10 = Cambio DIV 0.10;
		set Cambio = Cambio - 
			(C10*0.10);
		SET C5 = Cambio DIV 0.10;
		set Cambio = Cambio - 
			(C5*0.05);
                
		SET Respuesta = concat('Billetes de 200: ',B200,', Billetes de 100: ',B100,', Billetes de 50: ', B50,', Billetes de 20: ',B20,',Billetes de 10: ',B10,', Billetes de 5: ',
			B5,', Monedas de 1: ',B1,'Centavos 50: ',C50,'Centavos 25: ',C25,'Centavos 10: ',C10);
		Return Respuesta;
		end$$
Delimiter ;
Select fn_CambioMonedas(350.10);


drop function if exists fn_ParImpar;
Delimiter $$
    Create function fn_ParImpar(Num int) returns varchar(100)
    reads  sql data deterministic
	begin
	declare Repuesta varchar (100);
		if Num div 2 = 0 then 
			set Repuesta = concat(Num, ' Es Par');
		else 
			set Repuesta = concat(Num, ' Es Impar');
		end if;
	Return Repuesta;
	end$$
Delimiter ;
select  fn_ParImpar(3);
select fn_ParImpar(10);


Delimiter $$
Create function TipoCaracter(caracter CHAR) returns varchar(100)
    reads sql data deterministic
    Begin
        declare tipo varchar(100);
        if ASCII(caracter) between 48 and 57 then
            set tipo = concat(caracter,' Es un Digito');
        elseif (ASCII(caracter) between 65 and 90) or (ASCII(caracter) between 97 and 122) then
            set tipo = concat(caracter,' Es una Letra');
        else
            set tipo = concat(caracter,' Es Un Carácter especial');
       End if;
        return tipo;
    End$$
Delimiter ;
SELECT TipoCaracter('m');


delimiter $$
	create function fn_SumatoriaPares(limite int) returns int
		reads sql data deterministic
        begin
			declare cont int default 0;
            declare acum int default 0;
            while (cont < limite) do
				set acum = acum + cont;
				if (cont mod 2 = 0) then
					set acum =acum + cont;
				end if;
			end while;
            return acum;
		end$$
Delimiter ;

/*
-- sin div y mod, hallar cociente y residuo, primero mayor que el segundo
drop function fn_coeficientesindiv;
delimiter $$
	create function fn_coeficientesindiv(numero1 int, numero2 int) returns varchar(200)
		reads sql data deterministic
        begin
        declare respuesta varchar(200);
        declare residuo int default 0;
        declare cociente int default 0;
        
			while(num1 <> 0) do
				set cociente = cociente + 1 ;
                set num1 = num1 - num2;  
			end while;
            set residuo = dividiendo;
            set respuesta = concat('Residuo es ',residuo, ' y cosiente es ',cociente);
		return respuesta ;
		end$$
Delimiter ;
select fn_coeficientesindiv(20,10);
*/	

drop table Valores;
create table Valores(
	codigoValor int not null auto_increment,
    valor1 int not null,
    valor2 int not null,
	valor3 int not null,
    valor4 int not null,
    valor5 int not null,
    r1 int,
    r2 int,
    r3 float(10,2),
    r4 varchar(100),
    primary key PK_codigoValor(codigoValor)
);

Delimiter $$
	create procedure sp_AgregarValor(in valor1 int, in valor2 int, in valor3 int,
		in valor4 int, in valor5 int)
		Begin
			insert into Valores (valor1, valor2, valor3, valor4, valor5)
				values(valor1,valor2,valor3,valor4,valor5);
		end$$
Delimiter ;


Delimiter $$
	create procedure sp_ListarValores()
		Begin
			Select
				V.codigoValor, 
                V.valor1, 
                V.valor2, 
                V.valor3, 
                V.valor4, 
                V.valor5, 
                V.r1, 
                V.r2, 
                V.r3, 
                V.r4
                from Valores V;
		end$$
Delimiter ;

call sp_ListarValores()


/*


-- multiplicacion sin *
delimiter $$
	create function fn_multiplicacionsinpor(Numero1 int, Numero2 int) returns int
		reads sql data deterministic
        begin
			
            
		end$$
Delimiter ;

-- raiz sin la funcion
delimiter $$
	create function fn_Raiz(Numero1 int, Numero2 int) returns int
		reads sql data deterministic
        begin
			
            
		end$$
Delimiter ;

-- 10 numeros aleatorios, mostrar el mayor

delimiter $$
	create function fn_coeficientesinpar(Numero1 int, Numero2 int) returns int
		reads sql data deterministic
        begin
			
		end$$
Delimiter ;

select floor(rand()*100);

*/