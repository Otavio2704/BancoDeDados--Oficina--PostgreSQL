-- Ordens de serviço ordenadas por data de entrada (mais recentes primeiro)
SELECT 
    os.id_ordem,
    os.data_entrada,
    c.nome as cliente,
    v.placa,
    os.status,
    os.valor_total
FROM ORDEM_SERVICO os
JOIN VEICULO v ON os.id_veiculo = v.id_veiculo
JOIN CLIENTE c ON v.id_cliente = c.id_cliente
ORDER BY os.data_entrada DESC
LIMIT 10;
