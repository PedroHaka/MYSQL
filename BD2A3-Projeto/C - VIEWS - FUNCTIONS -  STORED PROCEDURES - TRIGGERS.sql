#views==================================
CREATE view idade AS
SELECT id_funcionario, nome, concat(timestampdiff(YEAR, funcionarios.dataNasc, curdate()), ' anos')
AS idade_funcionario FROM funcionarios;

CREATE view tempo_trabalho AS
SELECT id_funcionario, nome, concat(timestampdiff(MONTH, funcionarios.dataAdm, curdate()), ' meses')
AS tempo_trabalho_meses FROM funcionarios;

SELECT * FROM idade, tempo_trabalho;
#drop view idade, tempo_trabalho;

#functions==============================
CREATE FUNCTION  calculaImposto(a NUMERIC)
RETURNS NUMERIC DETERMINISTIC
RETURN a * 0.8 ;
#drop function calculaImposto;

#stored procedures======================
CREATE PROCEDURE mostraSalCargo(a INT) #O parâmetro é o INT id_cargo
	SELECT cargos.nome, funcionarios.nome, cargos.salario, 
	cargos.beneficios, calculaImposto(cargos.salario) AS 'salario liquido'
	FROM funcionarios INNER JOIN cargos
	WHERE funcionarios.id_cargo = a AND cargos.id_cargo = a;
#drop procedure mostraSalCargo;
call mostraSalCargo(2); #id_cargo = 2

#triggers===============================
DELIMITER //
CREATE TRIGGER validaNome
BEFORE UPDATE ON funcionarios
FOR EACH ROW
BEGIN
	IF NEW.nome != nome THEN 
		UPDATE funcionarios
		SET nome = NEW.nome; 
	END IF;
END
// DELIMITER ;
/*
update funcionarios
set nome = 'Jorginho'
where id_funcionario = 1;
*/