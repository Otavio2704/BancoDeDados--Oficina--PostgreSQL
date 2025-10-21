-- View: Resumo de Clientes
CREATE VIEW vw_resumo_clientes AS
SELECT 
    c.id_cliente,
    c.nome,
    c.tipo_cliente,
    c.telefone,
    COUNT(DISTINCT v.id_veiculo) as total_veiculos,
    COUNT(os.id_ordem) as total_ordens,
    COALESCE(SUM(CASE WHEN os.status = 'FINALIZADA' THEN os.valor_total END), 0) as valor_total_gasto,
    MAX(os.data_entrada) as ultima_visita
FROM CLIENTE c
LEFT JOIN VEICULO v ON c.id_cliente = v.id_cliente
LEFT JOIN ORDEM_SERVICO os ON v.id_veiculo = os.id_veiculo
GROUP BY c.id_cliente, c.nome, c.tipo_cliente, c.telefone;

-- View: Dashboard de Mecânicos
CREATE VIEW vw_dashboard_mecanicos AS
SELECT 
    m.id_mecanico,
    m.nome,
    m.especialidade,
    m.salario,
    COUNT(os.id_ordem) as total_ordens,
    COUNT(CASE WHEN os.status = 'FINALIZADA' THEN 1 END) as ordens_finalizadas,
    SUM(CASE WHEN os.status = 'FINALIZADA' THEN os.valor_total ELSE 0 END) as faturamento_gerado,
    ROUND(
        (COUNT(CASE WHEN os.status = 'FINALIZADA' THEN 1 END) * 100.0) / 
        NULLIF(COUNT(os.id_ordem), 0), 2
    ) as taxa_conclusao
FROM MECANICO m
LEFT JOIN ORDEM_SERVICO os ON m.id_mecanico = os.id_mecanico
GROUP BY m.id_mecanico, m.nome, m.especialidade, m.salario;

-- View: Estoque Crítico
CREATE VIEW vw_estoque_critico AS
SELECT 
    p.nome as peca,
    p.estoque_atual,
    p.estoque_minimo,
    (p.estoque_atual - p.estoque_minimo) as diferenca,
    f.nome as fornecedor,
    f.telefone as telefone_fornecedor,
    CASE 
        WHEN p.estoque_atual = 0 THEN 'CRÍTICO - SEM ESTOQUE'
        WHEN p.estoque_atual < p.estoque_minimo THEN 'BAIXO'
        WHEN p.estoque_atual = p.estoque_minimo THEN 'NO LIMITE'
        ELSE 'OK'
    END as status_estoque
FROM PECA p
JOIN FORNECEDOR f ON p.id_fornecedor = f.id_fornecedor
WHERE p.estoque_atual <= p.estoque_minimo
ORDER BY p.estoque_atual ASC;
