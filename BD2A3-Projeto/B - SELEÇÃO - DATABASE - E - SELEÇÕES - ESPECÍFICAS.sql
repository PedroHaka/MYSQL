#Seleção completa de todos os dados de todas as tabelas:
SELECT * FROM alocacao;
SELECT * FROM departamentos;
SELECT * FROM cargos;
SELECT * FROM funcionarios;

#Nome e data de nascimento de todos os estagiários.
SELECT nome, dataNasc FROM funcionarios 
WHERE id_cargo = 4 OR id_cargo = 6;

#Nome, CPF e data de admissão de todos os funcionários que 
#trabalham na empresa desde sua criação (2003-05-04).
SELECT nome,cpf, dataAdm FROM funcionarios
WHERE dataAdm = "2003-05-04";

#Nome, CPF, ID do cargo e endereço de todos os funcionários do 
#departamento de Operações Técnicas.
SELECT nome,cpf, id_cargo, endereco FROM funcionarios
WHERE id_departamento = 2;

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
SELECT funcionarios.nome, cargos.salario, cargos.beneficios
FROM funcionarios INNER JOIN cargos
WHERE funcionarios.id_cargo = 1 AND cargos.id_cargo = 1;

#ID da alocação e data de início de todos os funcionários do 
#departamento de suporte;
SELECT distinct alocacao.id_alocacao, alocacao.data_inicio 
FROM alocacao INNER JOIN funcionarios
WHERE funcionarios.id_departamento = 1;

#ID do cargo, nome do cargo, salário, benefícios e ID do 
#departamento dos funcionários Suzana, Fernando, Sabrina e #Maria Clara.
SELECT cargos.id_cargo, cargos.nome, cargos.salario, cargos.beneficios, funcionarios.id_departamento 
FROM cargos INNER JOIN funcionarios
WHERE funcionarios.id_cargo = cargos.id_cargo 
AND funcionarios.nome IN ("Suzana","Fernando","Sabrina","Maria Clara");

#ID da alocação, ID do cargo, ID do funcionário e ID do 
#departamento de todos os funcionários admitidos desde 2006.
SELECT alocacao.id_alocacao, funcionarios.id_cargo, funcionarios.id_funcionario, funcionarios.id_departamento 
FROM alocacao JOIN funcionarios 
WHERE funcionarios.id_funcionario = alocacao.id_funcionario 
AND funcionarios.dataAdm >= "2006-01-01";