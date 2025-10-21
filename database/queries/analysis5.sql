-- Margem de lucro por serviço (assumindo 30% de margem sobre preço base)
SELECT 
    oss.id_ordem,
    s.nome as servico,
    s.preco_base,
    oss.preco_praticado,
    (oss.preco_praticado - s.preco_base) as diferenca_preco,
    ROUND(((oss.preco_praticado - s.preco_base) / s.preco_base) * 100, 2) as percentual_diferenca
FROM ORDEM_SERVICO_SERVICO oss
JOIN SERVICO s ON oss.id_servico = s.id_servico;
