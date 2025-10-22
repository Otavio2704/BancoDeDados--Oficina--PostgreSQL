-- ============================================
-- ÍNDICES PARA MELHORAR PERFORMANCE
-- Execute APÓS criar todas as tabelas
-- ============================================

-- Índices para CLIENTE
CREATE INDEX IF NOT EXISTS idx_cliente_cpf_cnpj ON CLIENTE(cpf_cnpj);
CREATE INDEX IF NOT EXISTS idx_cliente_tipo ON CLIENTE(tipo_cliente);
CREATE INDEX IF NOT EXISTS idx_cliente_nome ON CLIENTE(nome);

-- Índices para VEICULO
CREATE INDEX IF NOT EXISTS idx_veiculo_cliente ON VEICULO(id_cliente);
CREATE INDEX IF NOT EXISTS idx_veiculo_placa ON VEICULO(placa);
CREATE INDEX IF NOT EXISTS idx_veiculo_marca ON VEICULO(marca);

-- Índices para MECANICO
CREATE INDEX IF NOT EXISTS idx_mecanico_cpf ON MECANICO(cpf);
CREATE INDEX IF NOT EXISTS idx_mecanico_especialidade ON MECANICO(especialidade);

-- Índices para ORDEM_SERVICO
CREATE INDEX IF NOT EXISTS idx_ordem_status ON ORDEM_SERVICO(status);
CREATE INDEX IF NOT EXISTS idx_ordem_data_entrada ON ORDEM_SERVICO(data_entrada);
CREATE INDEX IF NOT EXISTS idx_ordem_veiculo ON ORDEM_SERVICO(id_veiculo);
CREATE INDEX IF NOT EXISTS idx_ordem_mecanico ON ORDEM_SERVICO(id_mecanico);

-- Índices para PECA
CREATE INDEX IF NOT EXISTS idx_peca_fornecedor ON PECA(id_fornecedor);
CREATE INDEX IF NOT EXISTS idx_peca_estoque ON PECA(estoque_atual);

-- Índices para tabelas associativas
CREATE INDEX IF NOT EXISTS idx_ordem_servico_peca_ordem ON ORDEM_SERVICO_PECA(id_ordem);
CREATE INDEX IF NOT EXISTS idx_ordem_servico_peca_peca ON ORDEM_SERVICO_PECA(id_peca);
CREATE INDEX IF NOT EXISTS idx_ordem_servico_servico_ordem ON ORDEM_SERVICO_SERVICO(id_ordem);
CREATE INDEX IF NOT EXISTS idx_ordem_servico_servico_servico ON ORDEM_SERVICO_SERVICO(id_servico);

-- Mensagem de sucesso
DO $$
BEGIN
    RAISE NOTICE 'Índices criados com sucesso!';
END $$;
