#-------------------------Criação dE DATABASE/TABLES----------------------#
CREATE SCHEMA IF NOT EXISTS `departamentoRH`
DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `departamentoRH`;

CREATE TABLE IF NOT EXISTS `beneficios` (
	`id_beneficio` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Código do Benefício',
	`tipo` VARCHAR(45) NOT NULL COMMENT 'Tipo do Benefício',
    `valor` NUMERIC(10) NOT NULL COMMENT 'Valor do Benefício',
	PRIMARY KEY (`id_beneficio`)
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `cargos` (
	`id_cargo` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Código do Cargo',
    `id_beneficio` INT UNSIGNED COMMENT 'Código do Benefício',
	`nome` VARCHAR(45) NOT NULL COMMENT 'Nome do Cargo',
    `salario` NUMERIC(10) NOT NULL COMMENT 'Remuneração do Cargo',
	PRIMARY KEY (`id_cargo`),
    CONSTRAINT fk_id_beneficio
		foreign key(id_beneficio) 
		references beneficios (id_beneficio)
		on delete set null
		on update no action
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `departamentos` (
	`id_departamento` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Código do Departamento',
	`nome` VARCHAR(45) NOT NULL COMMENT 'Nome do Departamento',
    `descricao` VARCHAR(45) NOT NULL COMMENT 'Descrição do Departamento',
    `data_criacao` DATE NOT NULL COMMENT 'Data de criação do Departamento',
	PRIMARY KEY (`id_departamento`)
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `enderecos` (
	`id_endereco` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Código do Endereço',
	`rua` VARCHAR(45) NOT NULL COMMENT 'Nome da Rua',
    `numero` NUMERIC(10) NOT NULL COMMENT 'Número da Residência',
    `cidade` VARCHAR(45) NOT NULL COMMENT 'Cidade',
    `estado` VARCHAR(5) NOT NULL COMMENT 'Estado',
	PRIMARY KEY (`id_endereco`)
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `funcionarios` (
	`id_funcionario` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Código do Funcionário',
    `id_cargo` INT UNSIGNED COMMENT 'Código do Cargo',
    `id_departamento` INT UNSIGNED COMMENT 'Código do Departamento',
    `id_endereco` INT UNSIGNED COMMENT 'Código do Endereço',
	`nome` VARCHAR(45) NOT NULL COMMENT 'Nome do Funcionário',
	`dataNasc` DATE NOT NULL COMMENT 'Data de Nascimento do Funcionário', 
    `dataAdm` DATE NOT NULL COMMENT 'Data de Admissão do funcionário',
	`cpf` VARCHAR(11) NOT NULL COMMENT 'Número do CPF',    
	UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC),
	PRIMARY KEY (`id_funcionario`),
    CONSTRAINT fk_id2_cargo
		foreign key(id_cargo) 
		references cargos (id_cargo)
		on delete set null
		on update no action,
	CONSTRAINT fk_id_endereco
		foreign key(id_endereco) 
		references enderecos (id_endereco)
		on delete set null
		on update no action
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `contratos` (
	`id_contrato` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Código do Endereço',
    `id_funcionario` INT UNSIGNED COMMENT 'Código do Funcionário',
	`tipo`  VARCHAR(45) NOT NULL COMMENT 'Tipo de Contrato',
    `data_Inicio` DATE COMMENT 'Data de ínicio',
    `data_Fim` DATE COMMENT 'Data de término',
	PRIMARY KEY (`id_contrato`),
     CONSTRAINT fk_id1_funcionario
		foreign key(id_funcionario) 
		references funcionarios (id_funcionario)
		on delete set null
		on update no action
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `dependentes` (
	`id_dependente` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Código do Dependente',
    `id_funcionario` INT UNSIGNED COMMENT 'Código do Funcionário',
	`nome` VARCHAR(45) NOT NULL COMMENT 'Nome do Dependente',
    `tipo` VARCHAR(45) COMMENT 'Tipo do Dependente',
    `cpf` varchar(11) COMMENT 'CPF do Dependente',
    `data_Nasc` DATE COMMENT 'Data de Nascimento do Dependente',
	PRIMARY KEY (`id_dependente`),
     CONSTRAINT fk_id2_funcionario
		foreign key(id_funcionario) 
		references funcionarios (id_funcionario)
		on delete set null
		on update no action
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `alocacoes`(
	`id_alocacao` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Código da Alocação',
    `id_funcionario` INT UNSIGNED COMMENT 'Código do Funcionário',
    `id_departamento` INT UNSIGNED COMMENT 'Código do Departamento',
	`data_inicio` DATE NOT NULL COMMENT 'Data de Início do Funcionário no Departamento', 
    `data_saida` DATE COMMENT 'Data de Desligamento do Funcionário do Departamento',
	PRIMARY KEY (`id_alocacao`),
    CONSTRAINT fk_id3_funcionario
		foreign key(id_funcionario) 
		references funcionarios (id_funcionario)
		on delete cascade
		on update cascade,
	CONSTRAINT fk_id_departamento
		foreign key(id_departamento) 
		references departamentos (id_departamento)
		on delete cascade
		on update cascade
)ENGINE=InnoDB;

#-----------------------------Inserção dos dados--------------------------#
#Beneficios
INSERT INTO beneficios(tipo,valor) VALUES('vale_refeicao',500);
INSERT INTO beneficios(tipo,valor) VALUES('vale_alimentacao',500);
INSERT INTO beneficios(tipo,valor) VALUES('vale_refeicao/alimentacao',1000);

#Cargos
INSERT INTO cargos(id_beneficio,nome,salario) VALUES(3,'Gerente',4000);
INSERT INTO cargos(id_beneficio,nome,salario) VALUES(3,'Operário Técnico',2000);
INSERT INTO cargos(id_beneficio,nome,salario) VALUES(2,'Auxiliar Técnico',1500);
INSERT INTO cargos(id_beneficio,nome,salario) VALUES(1,'Estágio Técnico/Suporte',1000);
INSERT INTO cargos(id_beneficio,nome,salario) VALUES(2,'Agente de RH',2000);
INSERT INTO cargos(id_beneficio,nome,salario) VALUES(1,'Estágio de RH',1000);

#Departamentos
INSERT INTO departamentos(nome,descricao,data_criacao) VALUES('ST','Suporte',"2003-05-04");
INSERT INTO departamentos(nome,descricao,data_criacao) VALUES('OT','Operações Técnicas',"2003-05-04");
INSERT INTO departamentos(nome,descricao,data_criacao) VALUES('RH','Recursos Humanos',"2006-06-12");

#Endereços
INSERT INTO enderecos(rua,numero,cidade,estado) VALUES('R,Caetano Andrade',123,'São Paulo','SP');
INSERT INTO enderecos(rua,numero,cidade,estado) VALUES('R,XV de Nomvembro',234,'São Paulo','SP');
INSERT INTO enderecos(rua,numero,cidade,estado) VALUES('R,Loureni Paiva',1048,'São Paulo','SP');
INSERT INTO enderecos(rua,numero,cidade,estado) VALUES('R,Tavares Silva',345,'São Paulo','SP');
INSERT INTO enderecos(rua,numero,cidade,estado) VALUES('R,das Araras',456,'São Paulo','SP');
INSERT INTO enderecos(rua,numero,cidade,estado) VALUES('R,do Limoeiro',567,'Osasco','SP');
INSERT INTO enderecos(rua,numero,cidade,estado) VALUES('R,Pires Melo',678,'São Paulo','SP');
INSERT INTO enderecos(rua,numero,cidade,estado) VALUES('R,Carlos Gomes',789,'São Paulo','SP');
INSERT INTO enderecos(rua,numero,cidade,estado) VALUES('R,XV de Novembro',234,'São Paulo','SP');
INSERT INTO enderecos(rua,numero,cidade,estado) VALUES('R,Jacques Moreira',891,'São Paulo','SP');
INSERT INTO enderecos(rua,numero,cidade,estado) VALUES('R,Jacques Moreira',123,'São Paulo','SP');
INSERT INTO enderecos(rua,numero,cidade,estado) VALUES('R,Bang Xi',12,'São Paulo','SP');
INSERT INTO enderecos(rua,numero,cidade,estado) VALUES('R,Liberdade',1245,'São Paulo','SP');

#Funcionários
#Gerentes-ID 1
INSERT INTO funcionarios(id_cargo,id_departamento,id_endereco,nome,dataNasc,dataAdm,cpf) 
VALUES(1,1,1,'Gabriel',"1953-05-17","2003-05-04",12345678910);
INSERT INTO funcionarios(id_cargo,id_departamento,id_endereco,nome,dataNasc,dataAdm,cpf) 
VALUES(1,2,2,'Suzana',"1980-07-23","2003-05-04",23456789110);
#Operários Técnicos-ID 2
INSERT INTO funcionarios(id_cargo,id_departamento,id_endereco,nome,dataNasc,dataAdm,cpf) 
VALUES(2,2,3,'Fábio',"1975-10-15","2003-05-04",34567891210);
INSERT INTO funcionarios(id_cargo,id_departamento,id_endereco,nome,dataNasc,dataAdm,cpf) 
VALUES(2,2,4,'Thais',"1953-05-17","2003-05-04",45678912310);
INSERT INTO funcionarios(id_cargo,id_departamento,id_endereco,nome,dataNasc,dataAdm,cpf) 
VALUES(2,2,5,'Fernando',"1953-05-17","2003-05-04",56789123410);
#Auxiliares Técnicos-ID 3
INSERT INTO funcionarios(id_cargo,id_departamento,id_endereco,nome,dataNasc,dataAdm,cpf) 
VALUES(3,2,6,'José Thiago',"1971-03-03","2003-05-04",67891234510);
INSERT INTO funcionarios(id_cargo,id_departamento,id_endereco,nome,dataNasc,dataAdm,cpf) 
VALUES(3,2,7,'Michael',"1981-11-20","2003-05-04",78912345610);
#Estagiários Técnicos/Suporte-ID 4
INSERT INTO funcionarios(id_cargo,id_departamento,id_endereco,nome,dataNasc,dataAdm,cpf) 
VALUES(4,2,8,'Gabriel',"1980-05-26","2003-05-04",89123456710);
INSERT INTO funcionarios(id_cargo,id_departamento,id_endereco,nome,dataNasc,dataAdm,cpf) 
VALUES(4,1,9,'Marcelo',"1981-01-17","2003-05-04",91234567810);
#Gerente(RH)-ID 1
INSERT INTO funcionarios(id_cargo,id_departamento,id_endereco,nome,dataNasc,dataAdm,cpf) 
VALUES(1,3,10,'Alessandro',"1976-07-01","2006-06-12",12345678930);
#Agentes de RH-ID 5
INSERT INTO funcionarios(id_cargo,id_departamento,id_endereco,nome,dataNasc,dataAdm,cpf) 
VALUES(5,3,11,'Sabrina',"1967-05-17","2006-05-12",12345678920);
INSERT INTO funcionarios(id_cargo,id_departamento,id_endereco,nome,dataNasc,dataAdm,cpf) 
VALUES(5,3,12,'Gisele',"1974-05-17","2006-06-12",23456789120);
#Estagiário de RH-ID 6
INSERT INTO funcionarios(id_cargo,id_departamento,id_endereco,nome,dataNasc,dataAdm,cpf) 
VALUES(6,3,13,'Maria Clara',"1982-04-13","2006-06-12",34567891220);

#Contratos
INSERT INTO contratos(id_funcionario,tipo,data_Inicio,data_Fim) VALUES(1,'CLT',"2003-05-04",null);
INSERT INTO contratos(id_funcionario,tipo,data_Inicio,data_Fim) VALUES(2,'CLT',"2003-05-04",null);
INSERT INTO contratos(id_funcionario,tipo,data_Inicio,data_Fim) VALUES(3,'CLT',"2003-05-04",null);
INSERT INTO contratos(id_funcionario,tipo,data_Inicio,data_Fim) VALUES(4,'CLT',"2003-05-04",null);
INSERT INTO contratos(id_funcionario,tipo,data_Inicio,data_Fim) VALUES(5,'PJ',"2003-05-04",null);
INSERT INTO contratos(id_funcionario,tipo,data_Inicio,data_Fim) VALUES(6,'CLT',"2003-05-04",null);
INSERT INTO contratos(id_funcionario,tipo,data_Inicio,data_Fim) VALUES(7,'esporadico',"2003-05-04",null);
INSERT INTO contratos(id_funcionario,tipo,data_Inicio,data_Fim) VALUES(8,'CLT',"2003-05-04",null);
INSERT INTO contratos(id_funcionario,tipo,data_Inicio,data_Fim) VALUES(9,'CLT',"2003-05-04",null);
INSERT INTO contratos(id_funcionario,tipo,data_Inicio,data_Fim) VALUES(10,'PJ',"2006-06-12",null);
INSERT INTO contratos(id_funcionario,tipo,data_Inicio,data_Fim) VALUES(11,'CLT',"2006-06-12",null);
INSERT INTO contratos(id_funcionario,tipo,data_Inicio,data_Fim) VALUES(12,'PJ',"2006-06-12",null);
INSERT INTO contratos(id_funcionario,tipo,data_Inicio,data_Fim) VALUES(13,'CLT',"2006-06-12",null);

#Dependentes
INSERT INTO dependentes(id_funcionario,nome,cpf,data_Nasc) VALUES(1,'Joana',1597426510,"2000-08-21");
INSERT INTO dependentes(id_funcionario,nome,cpf,data_Nasc) VALUES(2,'Guilherme',1597426511,"1090-09-02");
INSERT INTO dependentes(id_funcionario,nome,cpf,data_Nasc) VALUES(2,'João Pedro',1597426512,"1994-10-30");
INSERT INTO dependentes(id_funcionario,nome,cpf,data_Nasc) VALUES(3,'Clarice',1597426513,"1997-11-21");
INSERT INTO dependentes(id_funcionario,nome,cpf,data_Nasc) VALUES(5,'Giusepe',1597426514,"1992-02-12");
INSERT INTO dependentes(id_funcionario,nome,cpf,data_Nasc) VALUES(6,'Ernesto',1597426515,"1994-03-23");
INSERT INTO dependentes(id_funcionario,nome,cpf,data_Nasc) VALUES(6,'Agatha',1597426516,"2003-07-27");
INSERT INTO dependentes(id_funcionario,nome,cpf,data_Nasc) VALUES(11,'Antonela',1597426517,"2002-12-16");
INSERT INTO dependentes(id_funcionario,nome,cpf,data_Nasc) VALUES(11,'Malu',1597426518,"2000-05-04");
INSERT INTO dependentes(id_funcionario,nome,cpf,data_Nasc) VALUES(11,'Maju',1597426519,"2000-05-04");

#Alocações
#Gerentes-ID 1
INSERT INTO alocacoes(id_funcionario,id_departamento,data_inicio,data_saida) 
VALUES(1,1,"2003-05-04",null);
INSERT INTO alocacoes(id_funcionario,id_departamento,data_inicio,data_saida) 
VALUES(2,2,"2003-05-04",null);
#Operários Técnicos-ID 2
INSERT INTO alocacoes(id_funcionario,id_departamento,data_inicio,data_saida) 
VALUES(3,2,"2003-05-04",null);
INSERT INTO alocacoes(id_funcionario,id_departamento,data_inicio,data_saida) 
VALUES(4,2,"2003-05-04",null);
INSERT INTO alocacoes(id_funcionario,id_departamento,data_inicio,data_saida) 
VALUES(5,2,"2003-05-04",null);
#Auxiliares Técnicos-ID 3
INSERT INTO alocacoes(id_funcionario,id_departamento,data_inicio,data_saida) 
VALUES(6,2,"2003-05-04",null);
INSERT INTO alocacoes(id_funcionario,id_departamento,data_inicio,data_saida) 
VALUES(7,2,"2003-05-04",null);
#Estagiários Técnicos/Suporte-ID 4
INSERT INTO alocacoes(id_funcionario,id_departamento,data_inicio,data_saida) 
VALUES(8,2,"2003-05-04",null);
INSERT INTO alocacoes(id_funcionario,id_departamento,data_inicio,data_saida) 
VALUES(9,1,"2003-05-04",null);
#Gerente(RH)-ID 1
INSERT INTO alocacoes(id_funcionario,id_departamento,data_inicio,data_saida) 
VALUES(10,3,"2006-06-12",null);
#Agentes de RH-ID 5
INSERT INTO alocacoes(id_funcionario,id_departamento,data_inicio,data_saida) 
VALUES(11,3,"2006-05-12",null);
INSERT INTO alocacoes(id_funcionario,id_departamento,data_inicio,data_saida) 
VALUES(12,3,"2006-06-12",null);
#Estagiário de RH-ID 6
INSERT INTO alocacoes(id_funcionario,id_departamento,data_inicio,data_saida) 
VALUES(13,3,"2006-06-12",null);

#-----------------------------Seleção dos dados--------------------------#
#Seleção completa de todos os dados de todas as tabelas:
SELECT * FROM alocacoes;
SELECT * FROM departamentos;
SELECT * FROM cargos;
SELECT * FROM funcionarios;
SELECT * FROM beneficios;
SELECT * FROM dependentes;
SELECT * FROM enderecos;
SELECT * FROM contratos;

#Seleções específicas:
#Nome e data de nascimento de todos os estagiários.
SELECT nome, dataNasc FROM funcionarios 
WHERE id_cargo = 4 OR id_cargo = 6;
#Nome, CPF e data de admissão de todos os funcionários que 
#trabalham na empresa desde sua criação (2003-05-04).
SELECT nome,cpf, dataAdm FROM funcionarios
WHERE dataAdm = "2003-05-04";
#Nome, CPF, ID do cargo e endereço de todos os funcionários do 
#departamento de Operações Técnicas.
SELECT f.nome,f.cpf, f.id_cargo, e.rua, e.numero, e.cidade, e.estado FROM funcionarios as f
LEFT JOIN enderecos as e
ON f.id_endereco = e.id_endereco where f.id_departamento = 2;
#Nome, CPF e ID de todos os funcionários com até 30 anos.
#(2006)
SELECT nome,cpf, id_funcionario FROM funcionarios
WHERE dataNasc <= "1976-01-01";
#Nome, ID do cargo e ID do departamento de todos os 
#funcionários cujos nomes começam com a letra 'A' ou 'G'.
SELECT nome,id_cargo, id_departamento FROM funcionarios
WHERE nome LIKE 'A%' OR nome LIKE 'G%';
#ID, Nome e Descrição dos departamentos criados antes de #2006.
SELECT id_departamento, nome, descricao FROM departamentos
WHERE data_criacao <= "2004-01-01";
#Nome, Salário e Benefícios dos Gerentes de Departamentos.
SELECT distinct funcionarios.nome, cargos.salario, beneficios.tipo as beneficios
FROM funcionarios JOIN cargos ON funcionarios.id_cargo = cargos.id_cargo 
left JOIN beneficios ON cargos.id_beneficio = beneficios.id_beneficio
WHERE funcionarios.id_cargo = 1 AND cargos.id_cargo = 1
order by funcionarios.nome;
#ID da alocação e data de início de todos os funcionários do 
#departamento de suporte;
SELECT distinct alocacoes.id_alocacao, alocacoes.data_inicio 
FROM alocacoes INNER JOIN funcionarios 
ON alocacoes.id_funcionario = funcionarios.id_funcionario
WHERE funcionarios.id_departamento = 1;
#ID do cargo, nome do cargo, salário, benefícios e ID do 
#departamento dos funcionários Suzana, Fernando, Sabrina e #Maria Clara.
SELECT distinct cargos.id_cargo, cargos.nome, cargos.salario, beneficios.tipo, funcionarios.id_departamento 
FROM cargos INNER JOIN funcionarios ON funcionarios.id_cargo = cargos.id_cargo 
INNER JOIN beneficios ON cargos.id_beneficio = beneficios.id_beneficio
WHERE funcionarios.nome IN ("Suzana","Fernando","Sabrina","Maria Clara")
order by cargos.id_cargo;
#ID da alocação, ID do cargo, ID do funcionário e ID do 
#departamento de todos os funcionários admitidos desde 2006.
SELECT alocacoes.id_alocacao, funcionarios.id_cargo, funcionarios.id_funcionario, funcionarios.id_departamento 
FROM alocacoes JOIN funcionarios 
WHERE funcionarios.id_funcionario = alocacoes.id_funcionario 
AND funcionarios.dataAdm >= "2006-01-01";
#Nome, valor do salário, tipo e valor do beneficio, e tipo de contrato de todos os funcionários
#que possuem dependentes.
SELECT distinct f.nome, c.salario, b.tipo as beneficio, 
b.valor as valor_beneficio, t.tipo as tipo_contrato
FROM funcionarios as f JOIN cargos as c ON f.id_cargo = c.id_cargo
JOIN beneficios as b ON c.id_beneficio = b.id_beneficio
JOIN contratos as t ON f.id_funcionario = t.id_funcionario
JOIN dependentes as d ON f.id_funcionario = d.id_funcionario
WHERE f.id_funcionario = d.id_funcionario;
#Os ids, nomes e datas de nascimento de todos os funcionarios, e os ids,
# nomes e datas de nascimento correspondentes dos dependentes associados.
SELECT f.id_funcionario,f.nome,f.dataNasc, d.id_dependente, 
d.nome, d.data_Nasc FROM funcionarios as f 
LEFT JOIN dependentes as d 
ON f.id_funcionario = d.id_funcionario;
#Valor do salario, valor do beneficio, e data de inicio do contrato
#para todos os funcionários que sejam estagiários.
SELECT distinct c.salario as valor_salario, b.valor as valor_beneficio, 
t.data_Inicio as inicio_contrato FROM funcionarios as f 
JOIN cargos as c ON f.id_cargo = c.id_cargo
JOIN beneficios as b ON c.id_beneficio = b.id_beneficio
JOIN contratos as t ON f.id_funcionario = t.id_funcionario
WHERE f.id_cargo in (4,6);
#Os dados dos departamentos e seus correspondentes cargos e nomes de funcionários.
SELECT distinct A.*, B.cargo, B.nome FROM (SELECT id_departamento, 
	nome, descricao, data_criacao FROM departamentos
) AS A JOIN (SELECT funcionarios.id_departamento, funcionarios.id_funcionario, cargos.nome as cargo,
funcionarios.nome as nome FROM funcionarios join cargos on funcionarios.id_cargo = cargos.id_cargo
) AS B ON A.id_departamento = B.id_departamento
WHERE A.id_departamento = B.id_departamento
ORDER BY id_departamento;
#Nomes de dependentes que tenham responsáveis com nomes que comecem com 
#as letras 'M' ou 'G' ou 'J' ou 'A'.
SELECT nome FROM dependentes d WHERE EXISTS (
	SELECT * FROM funcionarios WHERE nome LIKE 'M%' 
    OR nome LIKE 'G%' OR nome LIKE 'J%' OR nome LIKE 'A%'
    AND id_funcionario = d.id_funcionario
)
ORDER BY nome;

#-----------------------------Views--------------------------#
CREATE VIEW dados_pessoais_func AS
SELECT f.id_funcionario, f.nome, f.cpf, f.dataNasc, e.rua, e.numero, e.cidade, e.estado
FROM funcionarios f JOIN enderecos e ON f.id_endereco = e.id_endereco
ORDER BY id_funcionario;
#drop view dados_pessoais_func;
#SELECT * FROM dados_pessoais_func;

CREATE VIEW dados_prof_func AS
SELECT f.id_funcionario, f.nome, c.nome AS cargo, c.salario, 
b.tipo AS beneficios, b.valor AS valor_beneficio
FROM cargos c JOIN funcionarios f ON c.id_cargo = f.id_cargo
JOIN beneficios b ON b.id_beneficio = c.id_beneficio
ORDER BY id_funcionario;
#drop view dados_prof_func;
#SELECT * FROM dados_prof_func;

CREATE VIEW contratacoes AS
SELECT t.id_contrato, t.tipo, t.data_Inicio, a.id_alocacao, a.id_departamento, f.id_cargo, 
f.id_funcionario, f.nome AS nome_funcionario FROM funcionarios f 
JOIN alocacoes a ON f.id_funcionario = a.id_funcionario 
JOIN contratos t ON f.id_funcionario = t.id_funcionario;
#drop view contratacoes;
#SELECT * FROM contratacoes;

CREATE VIEW enderecamento AS
SELECT f.nome, e.rua, e.numero, e.cidade, e.estado FROM funcionarios f
JOIN enderecos e ON f.id_endereco = e.id_endereco;
#drop view enderecamento;
#SELECT * FROM enderecamento;

CREATE VIEW gestao AS 
SELECT f.id_departamento, f.id_funcionario, f.nome as nome_func, 
d.nome as nome_depto, d.descricao as descricao_depto FROM funcionarios f
JOIN departamentos d ON f.id_departamento = d.id_departamento;
#drop view gestao;
#SELECT * FROM gestao;

#---------------------------Functions------------------------#
CREATE FUNCTION  calculaImposto(a NUMERIC)
RETURNS NUMERIC DETERMINISTIC
RETURN a * 0.8 ;
#drop function calculaImposto;
#SELECT calculaImposto()

CREATE FUNCTION calculaIdade(d DATE)
RETURNS VARCHAR(45) DETERMINISTIC
RETURN concat(timestampdiff(YEAR, d, curdate()), ' anos');
#drop function calculaIdade;
#SELECT calculaIdade ("1994-10-31");

CREATE FUNCTION calculaTempoTrabalho(t DATE)
RETURNS VARCHAR(45) DETERMINISTIC
RETURN concat(timestampdiff(YEAR, t, curdate()), ' anos');
#drop function calculaTempoTrabalho;
#SELECT calculaTempoTrabalho("2006-06-12");

CREATE FUNCTION calculaAumento(s NUMERIC, p DECIMAL(10,2))
RETURNS DECIMAL(10,2) DETERMINISTIC
RETURN s * p;
#drop function calculaAumento;
#SELECT calculaAumento(4000,1.2) AS novo_salario;

CREATE FUNCTION calculaDuracaoContrato(d_i DATE, d_f DATE)
RETURNS VARCHAR(20) DETERMINISTIC
RETURN concat(timestampdiff(MONTH, d_i, d_f), ' meses');
#drop function calculaDuracaoContrato;
#SELECT calculaDuracaoContrato("2003-05-04","2006-06-12") AS duracao_contrato;

#----------------------Stored Procedures-------------------#
CREATE PROCEDURE mostraSalCargo(a INT) #O parâmetro é o INT id_cargo
SELECT c.nome, c.salario, calculaImposto(c.salario) AS 'salario liquido'
FROM cargos c JOIN funcionarios f ON c.id_cargo = f.id_cargo
WHERE f.id_cargo = a AND c.id_cargo = a;
#call mostraSalCargo(2); #id_cargo = 2
#drop procedure mostraSalCargo;

CREATE PROCEDURE mostraDependentes(i INT)
SELECT d.id_dependente, d.nome, d.data_Nasc, d.cpf FROM dependentes d 
JOIN funcionarios f ON d.id_funcionario = f.id_funcionario
WHERE f.id_funcionario = i;
#drop procedure mostraDependentes;
#call mostraDependentes(2);

CREATE PROCEDURE mostraNmrFuncCargo(n INT)
SELECT c.nome,f.id_funcionario, f.nome FROM cargos c 
JOIN funcionarios f ON c.id_cargo = f.id_cargo
WHERE f.id_cargo = n AND c.id_cargo = n; 
#drop procedure mostraNmrFuncCargo;
#call mostraNmrFuncCargo(3);
    
CREATE PROCEDURE mostraFolhaPagamento ()
SELECT  f.nome, c.nome as cargo, c.salario, b.valor as beneficio, 
sum(c.salario + b.valor) as custo_total FROM cargos c 
JOIN funcionarios f ON c.id_cargo = f.id_cargo
JOIN beneficios b ON c.id_beneficio = b.id_beneficio
WHERE c.id_cargo = f.id_cargo;
#drop procedure mostraFolhaPagamento;
#call mostraFolhaPagamento();

#----------------------Triggers-------------------#
DELIMITER //
CREATE TRIGGER validaNome
BEFORE UPDATE ON funcionarios
FOR EACH ROW
BEGIN
	IF NEW.nome != nome THEN 
		UPDATE funcionarios
		SET nome = NEW.nome;
	END IF;
END; //
#drop trigger validaNome;

CREATE TRIGGER validaDependente
AFTER INSERT ON dependentes
FOR EACH ROW
BEGIN
	IF data_Nasc <= "2000-01-01"
		THEN UPDATE dependentes
		SET tipo = 'nao_emancipado';
    elseif data_Nasc > "2000-01-01"
		THEN UPDATE dependentes
		SET tipo = 'emancipado';
	END IF;    
END; //

CREATE TRIGGER anulaCargo
AFTER DELETE ON cargos
FOR EACH ROW
BEGIN
	IF (id_cargo <> null)	
        THEN UPDATE cargos
		SET id_cargo = null;
	END IF;
END; //
DELIMITER ;