-- Análise ABC de peças por faturamento
WITH PecaFaturamento AS (
    SELECT 
        p.id_peca,
        p.nome,
        f.nome as fornecedor,
        SUM(osp.quantidade * osp.preco_praticado) as faturamento_peca,
        SUM(osp.quantidade) as quantidade_vendida,
        ROUND(AVG(osp.preco_praticado), 2) as preco_medio_venda
    FROM PECA p
    LEFT JOIN ORDEM_SERVICO_PECA osp ON p.id_peca = osp.id_peca
    LEFT JOIN FORNECEDOR f ON p.id_fornecedor = f.id_fornecedor
    GROUP BY p.id_peca, p.nome, f.nome
),
TotalFaturamento AS (
    SELECT SUM(faturamento_peca) as total_geral
    FROM PecaFaturamento
),
PecaComPercentual AS (
    SELECT 
        pf.*,
        tf.total_geral,
        ROUND((pf.faturamento_peca / tf.total_geral) * 100, 2) as percentual_faturamento,
        SUM(ROUND((pf.faturamento_peca / tf.total_geral) * 100, 2)) 
            OVER (ORDER BY pf.faturamento_peca DESC) as percentual_acumulado
    FROM PecaFaturamento pf
    CROSS JOIN TotalFaturamento tf
)
SELECT 
    nome as peca,
    fornecedor,
    faturamento_peca,
    quantidade_vendida,
    preco_medio_venda,
    percentual_faturamento,
    percentual_acumulado,
    CASE 
        WHEN percentual_acumulado <= 80 THEN 'A - Alta Importância'
        WHEN percentual_acumulado <= 95 THEN 'B - Média Importância'
        ELSE 'C - Baixa Importância'
    END as classificacao_abc
FROM PecaComPercentual
ORDER BY faturamento_peca DESC;
