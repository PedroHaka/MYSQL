#-------------------------Criação dE DATABASE/TABLES----------------------#
CREATE SCHEMA IF NOT EXISTS `departamentoRH`
DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `departamentoRH`;

CREATE TABLE IF NOT EXISTS `cargos` (
	`id_cargo` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Código do Cargo',
	`nome` VARCHAR(45) NOT NULL COMMENT 'Nome do Cargo',
    `salario` NUMERIC(10) NOT NULL COMMENT 'Remuneração do Cargo',
    `beneficios` VARCHAR(45) COMMENT 'Benefícios Concecidos',
	PRIMARY KEY (`id_cargo`)
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `departamentos` (
	`id_departamento` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Código do Departamento',
	`nome` VARCHAR(45) NOT NULL COMMENT 'Nome do Departamento',
    `descricao` VARCHAR(45) NOT NULL COMMENT 'Descrição do Departamento',
    `data_criacao` DATE NOT NULL COMMENT 'Data de criação do Departamento',
	PRIMARY KEY (`id_departamento`)
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `funcionarios` (
	`id_funcionario` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Código do Funcionário',
    `id_cargo` INT UNSIGNED COMMENT 'Código do Cargo',
    `id_departamento` INT UNSIGNED COMMENT 'Código do Departamento',
	`nome` VARCHAR(45) NOT NULL COMMENT 'Nome do Funcionário',
	`dataNasc` DATE NOT NULL COMMENT 'Data de Nascimento do Funcionário', 
    `dataAdm` DATE NOT NULL COMMENT 'Data de Admissão do funcionário',
	`cpf` VARCHAR(11) NOT NULL COMMENT 'Número do CPF',    
	`endereço` VARCHAR(100) NOT NULL COMMENT 'Endereço do Funcionário',
	UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC),
	PRIMARY KEY (`id_funcionario`),
    CONSTRAINT fk_id_cargo
		foreign key(id_cargo) 
		references cargos (id_cargo)
		on delete set null
		on update no action
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `alocacao`(
	`id_alocacao` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Código da Alocação',
    `id_funcionario` INT UNSIGNED COMMENT 'Código do Funcionário',
    `id_departamento` INT UNSIGNED COMMENT 'Código do Departamento',
	`data_inicio` DATE NOT NULL COMMENT 'Data de Início do Funcionário no Departamento', 
    `data_saida` DATE NOT NULL COMMENT 'Data de Desligamento do Funcionário do Departamento',
	PRIMARY KEY (`id_alocacao`),
    CONSTRAINT fk_id_funcionario
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

INSERT INTO cargos(nome,salario,beneficios) VALUES('Gerente',4000,'plano saude/dental');
INSERT INTO cargos(nome,salario,beneficios) VALUES('Operário Técnico',2000,'plano saude/dental');
INSERT INTO cargos(nome,salario,beneficios) VALUES('Auxiliar Técnico',1500,'plano saude');
INSERT INTO cargos(nome,salario) VALUES('Estágio Técnico/Suporte',1000);
INSERT INTO cargos(nome,salario,beneficios) VALUES('Agente de RH',2000,'plano saude/dental');
INSERT INTO cargos(nome,salario) VALUES('Estágio de RH',1000);

INSERT INTO departamentos(nome,descricao,data_criacao) VALUES('ST','Suporte',"2003-05-04");
INSERT INTO departamentos(nome,descricao,data_criacao) VALUES('OT','Operações Técnicas',"2003-05-04");
INSERT INTO departamentos(nome,descricao,data_criacao) VALUES('RH','Recursos Humanos',"2006-06-12");

#Gerentes-ID 1
INSERT INTO funcionarios(id_cargo,id_departamento,nome,dataNasc,dataAdm,cpf,endereco) 
VALUES(1,1,'Gabriel',"1953-05-17","2003-05-04",12345678910,'R,Caetano Andrade,123,São Paulo');
INSERT INTO funcionarios(id_cargo,id_departamento,nome,dataNasc,dataAdm,cpf,endereco) 
VALUES(1,2,'Suzana',"1980-07-23","2003-05-04",23456789110,'R,XV de Nomvembro,234,São Paulo');

#Operários Técnicos-ID 2
INSERT INTO funcionarios(id_cargo,id_departamento,nome,dataNasc,dataAdm,cpf,endereco) 
VALUES(2,2,'Fábio',"1975-10-15","2003-05-04",34567891210,'R,Tavares Silva,345,São Paulo');
INSERT INTO funcionarios(id_cargo,id_departamento,nome,dataNasc,dataAdm,cpf,endereco) 
VALUES(2,2,'Thais',"1953-05-17","2003-05-04",45678912310,'R,das Araras,456,São Paulo');
INSERT INTO funcionarios(id_cargo,id_departamento,nome,dataNasc,dataAdm,cpf,endereco) 
VALUES(2,2,'Fernando',"1953-05-17","2003-05-04",56789123410,'R,do Limoeiro,567,Osasco');

#Auxiliares Técnicos-ID 3
INSERT INTO funcionarios(id_cargo,id_departamento,nome,dataNasc,dataAdm,cpf,endereco) 
VALUES(3,2,'José Thiago',"1971-03-03","2003-05-04",67891234510,'R,Pires Melo,678,São Paulo');
INSERT INTO funcionarios(id_cargo,id_departamento,nome,dataNasc,dataAdm,cpf,endereco) 
VALUES(3,2,'Michael',"1981-11-20","2003-05-04",78912345610,'R,Carlos Gomes,789,São Paulo');

#Estagiários Técnicos/Suporte-ID 4
INSERT INTO funcionarios(id_cargo,id_departamento,nome,dataNasc,dataAdm,cpf,endereco) 
VALUES(4,2,'Gabriel',"1980-05-26","2003-05-04",89123456710,'R,XV de Novembro,234,São Paulo');
INSERT INTO funcionarios(id_cargo,id_departamento,nome,dataNasc,dataAdm,cpf,endereco) 
VALUES(4,1,'Marcelo',"1981-01-17","2003-05-04",91234567810,'R,Jacques Moreira,891,São Paulo');

#Gerente(RH)-ID 1
INSERT INTO funcionarios(id_cargo,id_departamento,nome,dataNasc,dataAdm,cpf,endereco) 
VALUES(1,3,'Alessandro',"1976-07-01","2006-06-12",12345678930,'R,Loureni Paiva,1048,São Paulo');

#Agentes de RH-ID 5
INSERT INTO funcionarios(id_cargo,id_departamento,nome,dataNasc,dataAdm,cpf,endereco) 
VALUES(5,3,'Sabrina',"1967-05-17","2006-05-12",12345678920,'R,Jacques Moreira,123,São Paulo');
INSERT INTO funcionarios(id_cargo,id_departamento,nome,dataNasc,dataAdm,cpf,endereco) 
VALUES(5,3,'Gisele',"1974-05-17","2006-06-12",23456789120,'R,Bang Xi,12,São Paulo');

#Estagiário de RH-ID 6
INSERT INTO funcionarios(id_cargo,id_departamento,nome,dataNasc,dataAdm,cpf,endereco) 
VALUES(6,3,'Maria Clara',"1982-04-13","2006-06-12",34567891220,'R,Liberdade,1245,São Paulo');

#Gerentes-ID 1
INSERT INTO alocacao(id_funcionario,id_departamento,data_inicio,data_saida) 
VALUES(1,1,"2003-05-04",null);
INSERT INTO alocacao(id_funcionario,id_departamento,data_inicio,data_saida) 
VALUES(2,2,"2003-05-04",null);

#Operários Técnicos-ID 2
INSERT INTO alocacao(id_funcionario,id_departamento,data_inicio,data_saida) 
VALUES(3,2,"2003-05-04",null);
INSERT INTO alocacao(id_funcionario,id_departamento,data_inicio,data_saida) 
VALUES(4,2,"2003-05-04",null);
INSERT INTO alocacao(id_funcionario,id_departamento,data_inicio,data_saida) 
VALUES(5,2,"2003-05-04",null);

#Auxiliares Técnicos-ID 3
INSERT INTO alocacao(id_funcionario,id_departamento,data_inicio,data_saida) 
VALUES(6,2,"2003-05-04",null);
INSERT INTO alocacao(id_funcionario,id_departamento,data_inicio,data_saida) 
VALUES(7,2,"2003-05-04",null);

#Estagiários Técnicos/Suporte-ID 4
INSERT INTO alocacao(id_funcionario,id_departamento,data_inicio,data_saida) 
VALUES(8,2,"2003-05-04",null);
INSERT INTO alocacao(id_funcionario,id_departamento,data_inicio,data_saida) 
VALUES(9,1,"2003-05-04",null);

#Gerente(RH)-ID 1
INSERT INTO alocacao(id_funcionario,id_departamento,data_inicio,data_saida) 
VALUES(10,3,"2006-06-12",null);

#Agentes de RH-ID 5
INSERT INTO alocacao(id_funcionario,id_departamento,data_inicio,data_saida) 
VALUES(11,3,"2006-05-12",null);
INSERT INTO alocacao(id_funcionario,id_departamento,data_inicio,data_saida) 
VALUES(12,3,"2006-06-12",null);

#Estagiário de RH-ID 6
INSERT INTO alocacao(id_funcionario,id_departamento,data_inicio,data_saida) 
VALUES(13,3,"2006-06-12",null);