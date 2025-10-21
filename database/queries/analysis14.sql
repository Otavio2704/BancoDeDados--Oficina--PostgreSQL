-- Análise de peças por fornecedor
SELECT 
    f.nome as fornecedor,
    f.telefone,
    COUNT(DISTINCT p.id_peca) as total_pecas_catalogo,
    SUM(p.estoque_atual) as estoque_total_atual,
    COUNT(osp.id_peca) as total_pecas_vendidas,
    SUM(osp.quantidade) as quantidade_total_vendida,
    SUM(osp.quantidade * osp.preco_praticado) as faturamento_pecas,
    ROUND(
        SUM(osp.quantidade * osp.preco_praticado) / 
        NULLIF(SUM(osp.quantidade * p.preco_unitario), 0) * 100 - 100, 2
    ) as margem_lucro_percentual
FROM FORNECEDOR f
LEFT JOIN PECA p ON f.id_fornecedor = p.id_fornecedor
LEFT JOIN ORDEM_SERVICO_PECA osp ON p.id_peca = osp.id_peca
GROUP BY f.id_fornecedor, f.nome, f.telefone
ORDER BY faturamento_pecas DESC;
