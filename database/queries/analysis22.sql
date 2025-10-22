-- ============================================
-- ANÁLISE FINANCEIRA COM PAGAMENTOS
-- Relatório de inadimplência e pagamentos
-- ============================================

-- Ordens finalizadas vs Pagamentos recebidos
SELECT 
    os.id_ordem,
    os.data_entrada,
    c.nome as cliente,
    v.placa,
    os.valor_total as valor_ordem,
    COALESCE(SUM(p.valor_pago), 0) as valor_pago,
    (os.valor_total - COALESCE(SUM(p.valor_pago), 0)) as saldo_restante,
    CASE 
        WHEN COALESCE(SUM(p.valor_pago), 0) = 0 THEN 'NÃO PAGO'
        WHEN COALESCE(SUM(p.valor_pago), 0) < os.valor_total THEN 'PARCIAL'
        WHEN COALESCE(SUM(p.valor_pago), 0) >= os.valor_total THEN 'PAGO'
    END as status_pagamento,
    STRING_AGG(DISTINCT p.forma_pagamento, ', ') as formas_pagamento
FROM ORDEM_SERVICO os
JOIN VEICULO v ON os.id_veiculo = v.id_veiculo
JOIN CLIENTE c ON v.id_cliente = c.id_cliente
LEFT JOIN PAGAMENTO p ON os.id_ordem = p.id_ordem
WHERE os.status = 'FINALIZADA'
GROUP BY os.id_ordem, os.data_entrada, c.nome, v.placa, os.valor_total
ORDER BY saldo_restante DESC, os.data_entrada DESC;
