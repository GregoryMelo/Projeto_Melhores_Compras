-- a) Informações das categorias de produtos e respectivos produtos de cada categoria
SELECT
    cd_categoria AS codigo_categoria,
    cat.ds_categoria AS nome_categoria,
    p.cd_produto AS codigo_produto,
    p.ds_produto AS descricao_produto,
    p.vl_unitario,
    p.tp_embalagem,
    p.vl_perc_lucro
FROM
    mc_categoria_prod cat
LEFT JOIN
    mc_produto p USING (cd_categoria)
WHERE
    cat.tp_categoria = 'P'
ORDER BY
    nome_categoria,
    descricao_produto;

/*
-- RESULTADO DA CONSULTA:

CODIGO_CATEGORIA NOME_CATEGORIA    CODIGO_PRODUTO DESCRICAO_PRODUTO                      VL_UNITARIO TP_EMBALAGEM VL_PERC_LUCRO
---------------- ----------------- -------------- ------------------------------------ ----------- ------------ -------------
               1 Eletrônicos                    2 IPhone 13 256GB                         3879.99    (null)       (null)
               1 Eletrônicos                    1 Notebool Dell Inspiron 15               5879.99    (null)       (null)
               2 Esporte e Lazer                3 Bicicleta Aro 29 KRW Spotlight          809.1      (null)       (null)
               2 Esporte e Lazer                4 Raquete de Tênis Babolat Pure Aero 98   1504.95    (null)       (null)
               3 Pet Shop                       5 Ração Seca Felina Royal Canin G...      288.99     (null)       (null)
*/


-- b) Exibir dados dos clientes Pessoa Física
SELECT
    c.nr_cliente,
    c.nm_cliente,
    c.ds_email,
    c.nr_telefone,
    c.nm_login,
    TO_CHAR(pf.dt_nascimento, 'DD-MM-YYYY') AS data_nascimento,
    TO_CHAR(pf.dt_nascimento, 'Day', 'NLS_DATE_LANGUAGE=PORTUGUESE') AS dia_semana_nascimento,
    TRUNC(MONTHS_BETWEEN(SYSDATE, pf.dt_nascimento) / 12) AS anos_de_vida,
    pf.fl_sexo_biologico,
    pf.nr_cpf
FROM
    mc_cliente c
JOIN
    mc_cli_fisica pf ON c.nr_cliente = pf.nr_cliente;

/*
-- RESULTADO DA CONSULTA:

NR_CLIENTE NM_CLIENTE    DS_EMAIL              NR_TELEFONE      NM_LOGIN      DATA_NASCIMENTO DIA_SEMANA_NASCIMENTO ANOS_DE_VIDA FL_SEXO_BIOLOGICO NR_CPF
---------- ------------- --------------------- ---------------- ------------- --------------- --------------------- ------------ ----------------- ---------------
         1 Maria Costa   maria.costa@email.com (11) 98877-6655  maria.costa   20-08-1992      Quinta-feira                 33 F                 111.222.333-44
*/


-- c) Consultar visualização de vídeos

/*
-- NOTA: Os comandos de teste abaixo foram executados para popular a tabela e gerar o resultado.
-- Eles estão comentados para documentar o processo, conforme sugerido.
INSERT INTO mc_sgv_visualizacao_video 
    (nr_cliente, cd_produto, nr_sequencia, dt_visualizacao, nr_hora_visualizacao)
VALUES 
    ((SELECT nr_cliente FROM mc_cliente WHERE nm_login = 'maria.costa'), 3, 1, SYSDATE - 1, 14);

INSERT INTO mc_sgv_visualizacao_video 
    (nr_cliente, cd_produto, nr_sequencia, dt_visualizacao, nr_hora_visualizacao)
VALUES 
    (null, 3, 2, SYSDATE, 10);

COMMIT;
*/

SELECT
    p.cd_produto,
    p.ds_produto AS nome_produto,
    v.dt_visualizacao,
    v.nr_hora_visualizacao || 'h' AS hora_visualizacao
FROM
    mc_sgv_visualizacao_video v
JOIN
    mc_produto p ON v.cd_produto = p.cd_produto
ORDER BY
    v.dt_visualizacao DESC,
    v.nr_hora_visualizacao DESC;

/*
-- RESULTADO DA CONSULTA:

CD_PRODUTO NOME_PRODUTO                   DT_VISUALIZACAO HORA_VISUALIZACAO
---------- ------------------------------ --------------- -----------------
         3 Bicicleta Aro 29 KRW Spotlight 06/10/25         10h
         3 Bicicleta Aro 29 KRW Spotlight 05/10/25         14h
*/