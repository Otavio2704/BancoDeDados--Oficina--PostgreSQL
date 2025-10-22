-- ============================================
-- ANÁLISE DE FORMAS DE PAGAMENTO
-- ============================================

SELECT 
    p.forma_pagamento,
    COUNT(DISTINCT p.id_ordem) as total_ordens,
    COUNT(p.id_pagamento) as total_transacoes,
    SUM(p.valor_pago) as valor_total,
    AVG(p.valor_pago) as valor_medio,
    ROUND((COUNT(DISTINCT p.id_ordem) * 100.0) / 
          (SELECT COUNT(DISTINCT id_ordem) FROM PAGAMENTO), 2) as percentual_uso
FROM PAGAMENTO p
GROUP BY p.forma_pagamento
ORDER BY valor_total DESC;
