-- ============================================
-- ADICIONAR CAMPO UPDATED_AT PARA AUDITORIA
-- Execute APÓS criar todas as tabelas
-- ============================================

-- Adicionar coluna updated_at nas tabelas principais
ALTER TABLE CLIENTE ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP;
ALTER TABLE VEICULO ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP;
ALTER TABLE MECANICO ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP;
ALTER TABLE FORNECEDOR ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP;
ALTER TABLE PECA ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP;
ALTER TABLE SERVICO ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP;
ALTER TABLE ORDEM_SERVICO ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP;

-- Função genérica para atualizar updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Criar triggers para cada tabela
CREATE TRIGGER update_cliente_updated_at 
BEFORE UPDATE ON CLIENTE
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_veiculo_updated_at 
BEFORE UPDATE ON VEICULO
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_mecanico_updated_at 
BEFORE UPDATE ON MECANICO
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_fornecedor_updated_at 
BEFORE UPDATE ON FORNECEDOR
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_peca_updated_at 
BEFORE UPDATE ON PECA
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_servico_updated_at 
BEFORE UPDATE ON SERVICO
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_ordem_servico_updated_at 
BEFORE UPDATE ON ORDEM_SERVICO
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Mensagem de sucesso
DO $$
BEGIN
    RAISE NOTICE 'Campo updated_at e triggers criados com sucesso!';
END $$;
