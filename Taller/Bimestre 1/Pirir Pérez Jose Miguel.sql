/*
Jose Miguel Pirir Pérez
2020285
06/03/2024
*/

drop database if exists DBPMAFunciones2020285;
create database DBPMAFunciones2020285;
use DBPMAFunciones2020285;


-- Ingresar un numero base 10 y pasar a base 2
Delimiter $$
	create function fn_DecimalABinario(Decimalbase10 int)
		returns varchar(100)
	reads sql data deterministic
    begin
		declare resultado varchar(100) default '';
        declare cont int default Decimalbase10;

        while(cont > 0)do
			if (cont mod 2 = 0) then
				set resultado = concat('0',resultado);
			else
				set resultado = concat('1',resultado);
			end if;
            set cont= cont div 2;
		end while;
        return resultado;
	end$$
Delimiter ;

select fn_DecimalABinario(10);



-- Salario neto de un trabajador dependiendo de las horas trabajas
Delimiter $$
	create function fn_SalarioNeto(Horas int) returns varchar(100)
    reads sql data deterministic
    begin
		declare resultado varchar(100) default '';
        declare cont decimal(10,2) default 0;
        declare pago decimal(10,2) default 40;
        if (Horas<=36) then
			set cont = horas * pago;
            set resultado = concat('Tus horas ',horas,' se pagan en ', cont);
		end if;
        if (Horas>36) then
			set cont = horas * (pago*2);
            set resultado = concat('Tus horas ',horas,' se pagan en ', cont);
            if(horas>=80)then
				set cont = cont - (cont*0.0483);
                set resultado = concat('Tu pago es de ',cont,' se desconto el 4.83%');
            end if;
        end if;
        return resultado;
    end$$
Delimiter ;

select fn_SalarioNeto(80);




-- Numero / factorial de numero   +   Nveces
delimiter $$
	create function fn_factorial(numero int) returns int
    reads sql data deterministic
		begin
			declare cont int default 0;
            declare multi int default 1;
			while(cont<numero)do
				set cont= cont + 1;
                set multi = multi * cont;
            end while;
            return multi;
		end$$
delimiter ;
Delimiter $$
	create function fn_SumarNdivFactorialmasN(numero int) returns decimal(10,2)
    reads sql data deterministic 
    begin
		declare cont int default 0;
		declare sumatoria decimal(10,2) default 0.0;
		while(cont < numero) do
			set cont = cont + 1;
            set sumatoria = sumatoria+(cont/fn_factorial(cont)); 
		end while;
		return sumatoria;
    end$$
Delimiter ;
select fn_SumarNdivFactorialmasN(3);