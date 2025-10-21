-- Análise de sazonalidade de serviços
SELECT 
    YEAR(os.data_entrada) as ano,
    MONTH(os.data_entrada) as mes,
    MONTHNAME(os.data_entrada) as nome_mes,
    COUNT(os.id_ordem) as total_ordens,
    SUM(os.valor_total) as faturamento_mes,
    AVG(os.valor_total) as ticket_medio,
    COUNT(DISTINCT os.id_veiculo) as veiculos_atendidos,
    ROUND(SUM(os.valor_total) / COUNT(DISTINCT os.id_veiculo), 2) as faturamento_por_veiculo
FROM ORDEM_SERVICO os
WHERE os.status = 'FINALIZADA'
GROUP BY YEAR(os.data_entrada), MONTH(os.data_entrada), MONTHNAME(os.data_entrada)
ORDER BY ano DESC, mes DESC;
