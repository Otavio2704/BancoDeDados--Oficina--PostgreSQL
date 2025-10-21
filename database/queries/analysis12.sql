-- Ranking de clientes por valor total gasto
SELECT 
    c.nome as cliente,
    c.tipo_cliente,
    c.telefone,
    COUNT(DISTINCT v.id_veiculo) as total_veiculos,
    COUNT(DISTINCT os.id_ordem) as total_ordens,
    COALESCE(SUM(os.valor_total), 0) as valor_total_gasto,
    AVG(os.valor_total) as valor_medio_por_ordem,
    MAX(os.data_entrada) as ultima_visita
FROM CLIENTE c
LEFT JOIN VEICULO v ON c.id_cliente = v.id_cliente
LEFT JOIN ORDEM_SERVICO os ON v.id_veiculo = os.id_veiculo AND os.status = 'FINALIZADA'
GROUP BY c.id_cliente, c.nome, c.tipo_cliente, c.telefone
ORDER BY valor_total_gasto DESC, total_ordens DESC;
