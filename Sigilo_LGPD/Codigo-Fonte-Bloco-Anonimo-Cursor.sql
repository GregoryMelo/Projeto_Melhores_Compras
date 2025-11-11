SET SERVEROUTPUT ON;

DECLARE
    -- item (a) Criação do CURSOR nomeado com todas as colunas solicitadas
    CURSOR c_sac IS
        SELECT 
            s.nr_sac, -- Número da ocorrência do SAC
            s.dt_abertura_sac, -- Data de abertura
            s.hr_abertura_sac, -- Hora de abertura
            s.tp_sac, -- Tipo do SAC
            p.cd_produto, -- Código do produto
            p.ds_produto, -- Nome do produto
            p.vl_unitario, -- Valor unitário
            p.vl_perc_lucro, -- Percentual de lucro
            c.nr_cliente, -- Número do cliente
            c.nm_cliente, -- Nome do cliente
            e.sg_estado, -- Sigla do estado do cliente
            e.nm_estado -- Nome do estado do cliente
        FROM mc_sgv_sac s
        JOIN mc_produto p ON s.cd_produto = p.cd_produto
        JOIN mc_cliente c ON s.nr_cliente = c.nr_cliente
        JOIN mc_end_cli ec ON c.nr_cliente = ec.nr_cliente
        JOIN mc_logradouro l ON ec.cd_logradouro_cli = l.cd_logradouro
        JOIN mc_bairro b ON l.cd_bairro = b.cd_bairro
        JOIN mc_cidade ci ON b.cd_cidade = ci.cd_cidade
        JOIN mc_estado e ON ci.sg_estado = e.sg_estado;

    -- Variável do tipo registro para armazenar uma linha do cursor
    r_sac c_sac%ROWTYPE;

    -- item (b) Variáveis auxiliares
    v_tipo_classificacao VARCHAR2(30); -- Texto convertido do tipo de SAC
    v_lucro_unitario NUMBER(10,2); -- Valor do lucro calculado sobre o produto
    v_icms_produto NUMBER(10,2); -- ICMS do produto vazio por enquanto

    -- Contadores para o resumo final
    v_total_sacs NUMBER := 0;
    v_qtd_sugestoes NUMBER := 0;
    v_qtd_duvidas NUMBER := 0;
    v_qtd_elogios NUMBER := 0;
    v_qtd_invalidos NUMBER := 0;

BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Inserindo dados na tabela "MC_SGV_OCORRENCIA_SAC" ---');

    -- item (b) Loop principal para processar cada linha retornada pelo cursor
    OPEN c_sac;
    LOOP
        FETCH c_sac INTO r_sac;
        EXIT WHEN c_sac%NOTFOUND; -- Sai do loop quando não houver mais registros

        -- item (b) criando as regras de classificação
        IF r_sac.tp_sac = 'S' THEN
            v_tipo_classificacao := 'SUGESTÃO';
            v_qtd_sugestoes := v_qtd_sugestoes + 1;
        ELSIF r_sac.tp_sac = 'D' THEN
            v_tipo_classificacao := 'DÚVIDA';
            v_qtd_duvidas := v_qtd_duvidas + 1;
        ELSIF r_sac.tp_sac = 'E' THEN
            v_tipo_classificacao := 'ELOGIO';
            v_qtd_elogios := v_qtd_elogios + 1;
        ELSE
            v_tipo_classificacao := 'CLASSIFICAÇÃO INVÁLIDA';
            v_qtd_invalidos := v_qtd_invalidos + 1;
        END IF;

        -- item (b) calcular o valor do lucro unitário do produto
        v_lucro_unitario := (r_sac.vl_perc_lucro / 100) * r_sac.vl_unitario;

        -- item (b) deixar o valor de ICMS se manter vazio
        v_icms_produto := NULL;

        -- item (b) inserir os dados processados na tabela destino
        INSERT INTO mc_sgv_ocorrencia_sac (
            nr_ocorrencia_sac,
            dt_abertura_sac,
            hr_abertura_sac,
            ds_tipo_classificacao_sac,
            cd_produto,
            ds_produto,
            vl_unitario_produto,
            vl_perc_lucro,
            vl_unitario_lucro_produto,
            sg_estado,
            nm_estado,
            nr_cliente,
            nm_cliente,
            vl_icms_produto
        ) VALUES (
            r_sac.nr_sac,
            r_sac.dt_abertura_sac,
            r_sac.hr_abertura_sac,
            v_tipo_classificacao,
            r_sac.cd_produto,
            r_sac.ds_produto,
            r_sac.vl_unitario,
            r_sac.vl_perc_lucro,
            v_lucro_unitario,
            r_sac.sg_estado,
            r_sac.nm_estado,
            r_sac.nr_cliente,
            r_sac.nm_cliente,
            v_icms_produto
        );

        -- Incrementa contador total para o resumo
        v_total_sacs := v_total_sacs + 1;

        DBMS_OUTPUT.PUT_LINE('Inserido SAC Nº ' || r_sac.nr_sac || ' (' || v_tipo_classificacao || ')');
    END LOOP;

    CLOSE c_sac;

    -- item (b) Finaliza as transações no banco de dados
    COMMIT;  -- Confirma todas as inserções realizadas

    -- item (c) Exibe o resumo final dos resultados e testes do bloco para que esteja de acordo com as regras de negocio
    DBMS_OUTPUT.PUT_LINE('--- RESUMO FINAL ---');
    DBMS_OUTPUT.PUT_LINE('Total de SACs inseridos: ' || v_total_sacs);
    DBMS_OUTPUT.PUT_LINE('Sugestões: ' || v_qtd_sugestoes);
    DBMS_OUTPUT.PUT_LINE('Dúvidas: ' || v_qtd_duvidas);
    DBMS_OUTPUT.PUT_LINE('Elogios: ' || v_qtd_elogios);
    DBMS_OUTPUT.PUT_LINE('Classificações Inválidas: ' || v_qtd_invalidos);
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM);
        ROLLBACK;  -- Desfaz inserções se houver falha
END;
/

SELECT * FROM MC_SGV_OCORRENCIA_SAC ORDER BY NR_OCORRENCIA_SAC;
