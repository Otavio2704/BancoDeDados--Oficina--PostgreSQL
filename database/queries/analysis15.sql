-- Análise de sazonalidade de serviços
SELECT 
    EXTRACT(YEAR FROM os.data_entrada) as ano,
    EXTRACT(MONTH FROM os.data_entrada) as mes,
    TO_CHAR(os.data_entrada, 'Month') as nome_mes,
    COUNT(os.id_ordem) as total_ordens,
    SUM(os.valor_total) as faturamento_mes,
    AVG(os.valor_total) as ticket_medio,
    COUNT(DISTINCT os.id_veiculo) as veiculos_atendidos,
    ROUND(SUM(os.valor_total) / COUNT(DISTINCT os.id_veiculo), 2) as faturamento_por_veiculo
FROM ORDEM_SERVICO os
WHERE os.status = 'FINALIZADA'
GROUP BY EXTRACT(YEAR FROM os.data_entrada), EXTRACT(MONTH FROM os.data_entrada), TO_CHAR(os.data_entrada, 'Month')
ORDER BY ano DESC, mes DESC;
