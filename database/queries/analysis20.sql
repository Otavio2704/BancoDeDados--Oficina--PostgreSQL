-- Procedure: Calcular valor total de uma ordem de serviço
DELIMITER //
CREATE PROCEDURE CalcularValorOrdem(IN p_id_ordem INT)
BEGIN
    DECLARE v_total_servicos DECIMAL(10,2) DEFAULT 0;
    DECLARE v_total_pecas DECIMAL(10,2) DEFAULT 0;
    DECLARE v_total_geral DECIMAL(10,2) DEFAULT 0;
    
    -- Calcular total dos serviços
    SELECT COALESCE(SUM(quantidade * preco_praticado), 0) INTO v_total_servicos
    FROM ORDEM_SERVICO_SERVICO 
    WHERE id_ordem = p_id_ordem;
    
    -- Calcular total das peças
    SELECT COALESCE(SUM(quantidade * preco_praticado), 0) INTO v_total_pecas
    FROM ORDEM_SERVICO_PECA 
    WHERE id_ordem = p_id_ordem;
    
    -- Calcular total geral
    SET v_total_geral = v_total_servicos + v_total_pecas;
    
    -- Atualizar a ordem de serviço
    UPDATE ORDEM_SERVICO 
    SET valor_total = v_total_geral 
    WHERE id_ordem = p_id_ordem;
    
    SELECT v_total_servicos as total_servicos, 
           v_total_pecas as total_pecas, 
           v_total_geral as total_geral;
END //
DELIMITER ;

-- Procedure: Relatório mensal de faturamento
DELIMITER //
CREATE PROCEDURE RelatorioMensalFaturamento(IN p_ano INT, IN p_mes INT)
BEGIN
    SELECT 
        'RESUMO MENSAL' as tipo_relatorio,
        COUNT(os.id_ordem) as total_ordens,
        COUNT(DISTINCT os.id_veiculo) as veiculos_atendidos,
        COUNT(DISTINCT c.id_cliente) as clientes_atendidos,
        SUM(os.valor_total) as faturamento_total,
        AVG(os.valor_total) as ticket_medio
    FROM ORDEM_SERVICO os
    JOIN VEICULO v ON os.id_veiculo = v.id_veiculo
    JOIN CLIENTE c ON v.id_cliente = c.id_cliente
    WHERE YEAR(os.data_entrada) = p_ano 
    AND MONTH(os.data_entrada) = p_mes
    AND os.status = 'FINALIZADA'
    
    UNION ALL
    
    SELECT 
        CONCAT('MECANICO: ', m.nome) as tipo_relatorio,
        COUNT(os.id_ordem) as total_ordens,
        COUNT(DISTINCT os.id_veiculo) as veiculos_atendidos,
        COUNT(DISTINCT c.id_cliente) as clientes_atendidos,
        SUM(os.valor_total) as faturamento_total,
        AVG(os.valor_total) as ticket_medio
    FROM ORDEM_SERVICO os
    JOIN VEICULO v ON os.id_veiculo = v.id_veiculo
    JOIN CLIENTE c ON v.id_cliente = c.id_cliente
    JOIN MECANICO m ON os.id_mecanico = m.id_mecanico
    WHERE YEAR(os.data_entrada) = p_ano 
    AND MONTH(os.data_entrada) = p_mes
    AND os.status = 'FINALIZADA'
    GROUP BY m.id_mecanico, m.nome
    ORDER BY faturamento_total DESC;
END //
DELIMITER ;
