SELECT
    cp.cd_categoria,     -- Código da Categoria
    cp.ds_categoria,     -- Descrição da Categoria
    cp.tp_categoria,     -- Tipo da Categoria (P/V)
    -- Usa NVL para substituir NULL por 0
    NVL(COUNT(s.nr_sac), 0) AS qtd_atendimento_realizado
FROM 
    mc_categoria_prod cp -- Tabela base (Todas as categorias)
LEFT JOIN 
    mc_produto p ON p.cd_categoria = cp.cd_categoria -- Relaciona Categoria → Produto
LEFT JOIN 
    mc_sgv_sac s ON s.cd_produto = p.cd_produto     -- Relaciona Produto → SAC
GROUP BY
    cp.cd_categoria,
    cp.ds_categoria,
    cp.tp_categoria
ORDER BY
    qtd_atendimento_realizado DESC,
    cp.ds_categoria;
