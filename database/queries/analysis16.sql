-- Análise de rentabilidade por tipo de serviço
SELECT 
    s.nome as servico,
    s.preco_base,
    COUNT(oss.id_servico) as vezes_executado,
    SUM(oss.quantidade) as quantidade_total,
    AVG(oss.preco_praticado) as preco_medio_praticado,
    SUM(oss.quantidade * oss.preco_praticado) as faturamento_total,
    SUM(oss.quantidade * (oss.preco_praticado - s.preco_base)) as margem_total,
    ROUND(
        (SUM(oss.quantidade * (oss.preco_praticado - s.preco_base)) / 
         SUM(oss.quantidade * oss.preco_praticado)) * 100, 2
    ) as margem_percentual,
    ROUND(s.tempo_estimado / 60.0, 2) as tempo_estimado_horas,
    ROUND(
        (SUM(oss.quantidade * oss.preco_praticado) / COUNT(oss.id_servico)) / 
        (s.tempo_estimado / 60.0), 2
    ) as faturamento_por_hora
FROM SERVICO s
JOIN ORDEM_SERVICO_SERVICO oss ON s.id_servico = oss.id_servico
GROUP BY s.id_servico, s.nome, s.preco_base, s.tempo_estimado
ORDER BY margem_total DESC, faturamento_por_hora DESC;
