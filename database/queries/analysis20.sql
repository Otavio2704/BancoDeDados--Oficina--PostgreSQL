-- Procedure: Calcular valor total de uma ordem de serviço
CREATE OR REPLACE FUNCTION CalcularValorOrdem(p_id_ordem INT)
RETURNS TABLE(total_servicos DECIMAL, total_pecas DECIMAL, total_geral DECIMAL) AS $$
DECLARE
    v_total_servicos DECIMAL(10,2) DEFAULT 0;
    v_total_pecas DECIMAL(10,2) DEFAULT 0;
    v_total_geral DECIMAL(10,2) DEFAULT 0;
BEGIN
    -- Calcular total dos serviços
    SELECT COALESCE(SUM(quantidade * preco_praticado), 0) INTO v_total_servicos
    FROM ORDEM_SERVICO_SERVICO 
    WHERE id_ordem = p_id_ordem;
    
    -- Calcular total das peças
    SELECT COALESCE(SUM(quantidade * preco_praticado), 0) INTO v_total_pecas
    FROM ORDEM_SERVICO_PECA 
    WHERE id_ordem = p_id_ordem;
    
    -- Calcular total geral
    v_total_geral := v_total_servicos + v_total_pecas;
    
    -- Atualizar a ordem de serviço
    UPDATE ORDEM_SERVICO 
    SET valor_total = v_total_geral 
    WHERE id_ordem = p_id_ordem;
    
    RETURN QUERY SELECT v_total_servicos, v_total_pecas, v_total_geral;
END;
$$ LANGUAGE plpgsql;

-- Procedure: Relatório mensal de faturamento
CREATE OR REPLACE FUNCTION RelatorioMensalFaturamento(p_ano INT, p_mes INT)
RETURNS TABLE(
    tipo_relatorio TEXT,
    total_ordens BIGINT,
    veiculos_atendidos BIGINT,
    clientes_atendidos BIGINT,
    faturamento_total NUMERIC,
    ticket_medio NUMERIC
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        'RESUMO MENSAL'::TEXT as tipo_relatorio,
        COUNT(os.id_ordem) as total_ordens,
        COUNT(DISTINCT os.id_veiculo) as veiculos_atendidos,
        COUNT(DISTINCT c.id_cliente) as clientes_atendidos,
        SUM(os.valor_total) as faturamento_total,
        AVG(os.valor_total) as ticket_medio
    FROM ORDEM_SERVICO os
    JOIN VEICULO v ON os.id_veiculo = v.id_veiculo
    JOIN CLIENTE c ON v.id_cliente = c.id_cliente
    WHERE EXTRACT(YEAR FROM os.data_entrada) = p_ano 
    AND EXTRACT(MONTH FROM os.data_entrada) = p_mes
    AND os.status = 'FINALIZADA'
    
    UNION ALL
    
    SELECT 
        'MECANICO: ' || m.nome as tipo_relatorio,
        COUNT(os.id_ordem) as total_ordens,
        COUNT(DISTINCT os.id_veiculo) as veiculos_atendidos,
        COUNT(DISTINCT c.id_cliente) as clientes_atendidos,
        SUM(os.valor_total) as faturamento_total,
        AVG(os.valor_total) as ticket_medio
    FROM ORDEM_SERVICO os
    JOIN VEICULO v ON os.id_veiculo = v.id_veiculo
    JOIN CLIENTE c ON v.id_cliente = c.id_cliente
    JOIN MECANICO m ON os.id_mecanico = m.id_mecanico
    WHERE EXTRACT(YEAR FROM os.data_entrada) = p_ano 
    AND EXTRACT(MONTH FROM os.data_entrada) = p_mes
    AND os.status = 'FINALIZADA'
    GROUP BY m.id_mecanico, m.nome
    ORDER BY faturamento_total DESC;
END;
$$ LANGUAGE plpgsql;
