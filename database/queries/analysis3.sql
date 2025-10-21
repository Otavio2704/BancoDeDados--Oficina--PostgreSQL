-- Ordens de serviço em andamento
SELECT os.id_ordem, os.data_entrada, os.descricao, v.placa, m.nome as mecanico
FROM ORDEM_SERVICO os
JOIN VEICULO v ON os.id_veiculo = v.id_veiculo
JOIN MECANICO m ON os.id_mecanico = m.id_mecanico
WHERE os.status = 'EM_ANDAMENTO';
