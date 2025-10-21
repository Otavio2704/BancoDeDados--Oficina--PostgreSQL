-- Mecânicos com faturamento total acima de R$ 1000
SELECT 
    m.nome as mecanico,
    m.especialidade,
    COUNT(os.id_ordem) as total_ordens,
    SUM(os.valor_total) as faturamento_total
FROM MECANICO m
JOIN ORDEM_SERVICO os ON m.id_mecanico = os.id_mecanico
WHERE os.status = 'FINALIZADA'
GROUP BY m.id_mecanico, m.nome, m.especialidade
HAVING SUM(os.valor_total) > 1000
ORDER BY faturamento_total DESC;
