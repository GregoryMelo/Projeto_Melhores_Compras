-- POPULAR DADOS a) parte 1 - Cadastrar no mínimo 1 cliente pessoa física
INSERT INTO mc_cliente (nm_cliente, qt_estrelas, st_cliente, ds_email, nr_telefone, nm_login, ds_senha)
VALUES ('Maria Costa', 5, 'A', 'maria.costa@email.com', '(11) 98877-6655', 'maria.costa', 'senha123');

/*
-- RESULTADO DA EXECUÇÃO:
1 linha inserido.
*/

INSERT INTO mc_cli_fisica (nr_cliente, dt_nascimento, fl_sexo_biologico, ds_genero, nr_cpf)
VALUES ((SELECT nr_cliente FROM mc_cliente WHERE nm_login = 'maria.costa'), TO_DATE('1992-08-20', 'YYYY-MM-DD'), 'F', 'Feminino', '111.222.333-44');

/*
-- RESULTADO DA EXECUÇÃO:
1 linha inserido.
*/

-- POPULAR DADOS a) parte 2 - Cadastrar no mínimo 1 cliente pessoa jurídica
INSERT INTO mc_cliente (nm_cliente, qt_estrelas, st_cliente, ds_email, nr_telefone, nm_login, ds_senha)
VALUES ('Soluções Web Ltda', 4, 'A', 'contato@solucoesweb.com', '(11) 4455-6677', 'solucoes.web', 'senhaforte');

/*
-- RESULTADO DA EXECUÇÃO:
1 linha inserido.
*/

INSERT INTO mc_cli_juridica (nr_cliente, dt_fundacao, nr_cnpj, nr_inscr_est)
VALUES ((SELECT nr_cliente FROM mc_cliente WHERE nm_login = 'solucoes.web'), TO_DATE('2018-02-12', 'YYYY-MM-DD'), '98.765.432/0001-11', '987.654.321.110');

/*
-- RESULTADO DA EXECUÇÃO:
1 linha inserido.
*/

-- POPULAR DADOS a) parte 3 - Cadastrar no mínimo 1 endereço para cada cliente

-- Endereço para Maria Costa na "Alameda Campinas" (cd_logradouro = 1)
INSERT INTO mc_end_cli (nr_cliente, cd_logradouro_cli, nr_end, ds_complemento_end, dt_inicio, st_end)
VALUES ((SELECT nr_cliente FROM mc_cliente WHERE nm_login = 'maria.costa'), 1, 500, 'Apto 82', SYSDATE, 'A');

/*
-- RESULTADO DA EXECUÇÃO:
1 linha inserido.
*/

-- Endereço para Soluções Web Ltda na "Avenida Senador Vergueiro" (cd_logradouro = 3)
INSERT INTO mc_end_cli (nr_cliente, cd_logradouro_cli, nr_end, ds_complemento_end, dt_inicio, st_end)
VALUES ((SELECT nr_cliente FROM mc_cliente WHERE nm_login = 'solucoes.web'), 3, 1200, 'Conjunto 3', SYSDATE, 'A');

/*
-- RESULTADO DA EXECUÇÃO:
1 linha inserido.
*/

-- POPULAR DADOS b) Cadastrar um cliente que já tenha um login criado
INSERT INTO mc_cliente (nm_cliente, nm_login, ds_senha)
VALUES ('Outra Maria', 'maria.costa', 'outrasenha');

/*
-- RESULTADO DA EXECUÇÃO:
ORA-00001: restrição exclusiva (SEU_USUARIO.UK_MC_CLIENTE_MM_LOGIN) violada

-- EXPLICAÇÃO:
Não foi possível incluir esse novo cliente porque a coluna nm_login possui uma restrição de chave única (UNIQUE constraint) que impede a inserção de valores duplicados.
*/

-- ALTERAR DADOS c) Selecionar um funcionário específico, atualizar o cargo e aplicar 12% de aumento no salário
UPDATE mc_funcionario
SET
    ds_cargo = 'Vendedora Especialista',
    vl_salario = vl_salario * 1.12
WHERE
    nm_funcionario = 'Rachel Karen Green';

/*
-- RESULTADO DA EXECUÇÃO:
1 linha atualizado.
*/

-- ALTERAR DADOS d) Inativar um endereço de cliente e colocar a data término como sendo a data limite de entrega do trabalho
UPDATE mc_end_cli
SET
    st_end = 'I',
    dt_termino = TO_DATE('14/10/2025', 'DD/MM/YYYY')
WHERE
    nr_cliente = (SELECT nr_cliente FROM mc_cliente WHERE nm_login = 'solucoes.web');

/*
-- RESULTADO DA EXECUÇÃO:
1 linha atualizado.
*/

-- ALTERAR DADOS e) Tentar eliminar um estado que tenha uma cidade cadastrada
DELETE FROM mc_estado WHERE sg_estado = 'MG';

/*
-- RESULTADO DA EXECUÇÃO:
ORA-02292: restrição de integridade (SEU_USUARIO.FK_MC_CIDADE_ESTADO) violada - registro filho localizado

-- EXPLICAÇÃO:
Não foi possível eliminar o estado, pois existem cidades na tabela mc_cidade que fazem referência a ele. A chave estrangeira (foreign key) impede a exclusão para manter a integridade dos dados.
*/

-- ALTERAR DADOS f) Tentar atualizar o status do produto com o valor 'X'
UPDATE mc_produto SET st_produto = 'X' WHERE ds_produto = 'IPhone 13 256GB';

/*
-- RESULTADO DA EXECUÇÃO:
ORA-02290: restrição de verificação (SEU_USUARIO.MC_PRODUTO_CK_ST_PROD) violada

-- EXPLICAÇÃO:
Não foi possível atualizar o status, pois a coluna st_produto possui uma restrição de verificação (CHECK) que permite apenas os valores 'A' (Ativo) ou 'I' (Inativo).
*/

-- ALTERAR DADOS g) Confirmar todas as transações pendentes
COMMIT;

/*
-- RESULTADO DA EXECUÇÃO:
Commit concluído.
*/




