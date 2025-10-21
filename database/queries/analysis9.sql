-- Clientes com mais de um veículo
SELECT 
    c.nome as cliente,
    c.tipo_cliente,
    COUNT(v.id_veiculo) as total_veiculos
FROM CLIENTE c
JOIN VEICULO v ON c.id_cliente = v.id_cliente
GROUP BY c.id_cliente, c.nome, c.tipo_cliente
HAVING COUNT(v.id_veiculo) > 1
ORDER BY total_veiculos DESC;
