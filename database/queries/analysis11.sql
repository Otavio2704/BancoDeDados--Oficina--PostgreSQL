-- Relatório completo de ordem de serviço
SELECT 
    os.id_ordem,
    os.data_entrada,
    os.data_saida,
    os.status,
    c.nome as cliente,
    c.telefone as telefone_cliente,
    v.placa,
    v.marca || ' ' || v.modelo || ' ' || v.ano as veiculo,
    m.nome as mecanico,
    m.especialidade,
    os.descricao,
    os.valor_total,
    STRING_AGG(DISTINCT s.nome, ', ') as servicos_realizados,
    STRING_AGG(DISTINCT p.nome || ' (' || osp.quantidade::TEXT || 'x)', ', ') as pecas_utilizadas
FROM ORDEM_SERVICO os
JOIN VEICULO v ON os.id_veiculo = v.id_veiculo
JOIN CLIENTE c ON v.id_cliente = c.id_cliente
JOIN MECANICO m ON os.id_mecanico = m.id_mecanico
LEFT JOIN ORDEM_SERVICO_SERVICO oss ON os.id_ordem = oss.id_ordem
LEFT JOIN SERVICO s ON oss.id_servico = s.id_servico
LEFT JOIN ORDEM_SERVICO_PECA osp ON os.id_ordem = osp.id_ordem
LEFT JOIN PECA p ON osp.id_peca = p.id_peca
GROUP BY os.id_ordem, os.data_entrada, os.data_saida, os.status, c.nome, c.telefone, 
         v.placa, v.marca, v.modelo, v.ano, m.nome, m.especialidade, os.descricao, os.valor_total
ORDER BY os.data_entrada DESC;
