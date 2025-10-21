-- Perfil de consumo PF vs PJ
SELECT 
    c.tipo_cliente,
    COUNT(DISTINCT c.id_cliente) as total_clientes,
    COUNT(DISTINCT v.id_veiculo) as total_veiculos,
    ROUND(COUNT(DISTINCT v.id_veiculo) * 1.0 / COUNT(DISTINCT c.id_cliente), 2) as veiculos_por_cliente,
    COUNT(os.id_ordem) as total_ordens_servico,
    ROUND(COUNT(os.id_ordem) * 1.0 / COUNT(DISTINCT c.id_cliente), 2) as ordens_por_cliente,
    SUM(CASE WHEN os.status = 'FINALIZADA' THEN os.valor_total ELSE 0 END) as faturamento_total,
    ROUND(
        SUM(CASE WHEN os.status = 'FINALIZADA' THEN os.valor_total ELSE 0 END) / 
        COUNT(DISTINCT c.id_cliente), 2
    ) as faturamento_medio_por_cliente,
    ROUND(
        SUM(CASE WHEN os.status = 'FINALIZADA' THEN os.valor_total ELSE 0 END) / 
        NULLIF(COUNT(CASE WHEN os.status = 'FINALIZADA' THEN 1 END), 0), 2
    ) as ticket_medio_por_ordem
FROM CLIENTE c
LEFT JOIN VEICULO v ON c.id_cliente = v.id_cliente
LEFT JOIN ORDEM_SERVICO os ON v.id_veiculo = os.id_veiculo
GROUP BY c.tipo_cliente
ORDER BY faturamento_total DESC;
