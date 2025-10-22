-- ============================================
-- TABELA DE PAGAMENTOS
-- Execute APÓS criar a tabela ORDEM_SERVICO
-- ============================================

CREATE TABLE PAGAMENTO (
    id_pagamento SERIAL PRIMARY KEY,
    id_ordem INT NOT NULL,
    valor_pago DECIMAL(10,2) NOT NULL CHECK (valor_pago > 0),
    forma_pagamento VARCHAR(20) NOT NULL CHECK (forma_pagamento IN ('DINHEIRO', 'DEBITO', 'CREDITO', 'PIX', 'BOLETO', 'TRANSFERENCIA')),
    data_pagamento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    numero_parcelas INT DEFAULT 1 CHECK (numero_parcelas > 0),
    parcela_atual INT DEFAULT 1 CHECK (parcela_atual > 0),
    observacao TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_ordem) REFERENCES ORDEM_SERVICO(id_ordem) ON DELETE CASCADE
);

-- Índices para performance
CREATE INDEX idx_pagamento_ordem ON PAGAMENTO(id_ordem);
CREATE INDEX idx_pagamento_data ON PAGAMENTO(data_pagamento);
CREATE INDEX idx_pagamento_forma ON PAGAMENTO(forma_pagamento);

-- Comentários para documentação
COMMENT ON TABLE PAGAMENTO IS 'Registra os pagamentos realizados para cada ordem de serviço';
COMMENT ON COLUMN PAGAMENTO.numero_parcelas IS 'Número total de parcelas (1 para pagamento à vista)';
COMMENT ON COLUMN PAGAMENTO.parcela_atual IS 'Número da parcela atual (ex: 2 de 3)';

-- Mensagem de sucesso
DO $$
BEGIN
    RAISE NOTICE 'Tabela PAGAMENTO criada com sucesso!';
END $$;
