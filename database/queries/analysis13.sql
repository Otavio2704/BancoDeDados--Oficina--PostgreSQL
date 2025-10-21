-- Performance dos mecânicos
SELECT 
    m.nome as mecanico,
    m.especialidade,
    m.salario,
    COUNT(os.id_ordem) as total_ordens,
    COUNT(CASE WHEN os.status = 'FINALIZADA' THEN 1 END) as ordens_finalizadas,
    COUNT(CASE WHEN os.status = 'EM_ANDAMENTO' THEN 1 END) as ordens_em_andamento,
    SUM(CASE WHEN os.status = 'FINALIZADA' THEN os.valor_total ELSE 0 END) as faturamento_gerado,
    ROUND(
        SUM(CASE WHEN os.status = 'FINALIZADA' THEN os.valor_total ELSE 0 END) / 
        NULLIF(COUNT(CASE WHEN os.status = 'FINALIZADA' THEN 1 END), 0), 2
    ) as valor_medio_por_ordem,
    ROUND(
        (COUNT(CASE WHEN os.status = 'FINALIZADA' THEN 1 END) * 100.0) / 
        NULLIF(COUNT(os.id_ordem), 0), 2
    ) as percentual_conclusao
FROM MECANICO m
LEFT JOIN ORDEM_SERVICO os ON m.id_mecanico = os.id_mecanico
GROUP BY m.id_mecanico, m.nome, m.especialidade, m.salario
ORDER BY faturamento_gerado DESC, percentual_conclusao DESC;
