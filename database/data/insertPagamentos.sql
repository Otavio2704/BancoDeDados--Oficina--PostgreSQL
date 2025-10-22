-- ============================================
-- DADOS DE EXEMPLO PARA PAGAMENTOS
-- Execute APÓS inserir as ordens de serviço
-- ============================================

INSERT INTO PAGAMENTO (id_ordem, valor_pago, forma_pagamento, data_pagamento, numero_parcelas, parcela_atual, observacao) VALUES
-- Ordem 1: Pagamento à vista em PIX
(1, 105.00, 'PIX', '2024-01-15 10:15:00', 1, 1, 'Pagamento à vista'),

-- Ordem 2: Pagamento em débito
(2, 220.00, 'DEBITO', '2024-02-01 16:45:00', 1, 1, 'Pagamento no cartão de débito'),

-- Ordem 4: Pagamento parcelado em 2x no crédito
(4, 160.00, 'CREDITO', '2024-02-15 15:30:00', 2, 1, 'Primeira parcela'),
(4, 160.00, 'CREDITO', '2024-03-15 10:00:00', 2, 2, 'Segunda parcela'),

-- Ordem 6: Pagamento em dinheiro
(6, 580.00, 'DINHEIRO', '2024-02-25 12:10:00', 1, 1, 'Pagamento em espécie'),

-- Ordem 7: Pagamento em PIX
(7, 180.00, 'PIX', '2024-03-01 17:15:00', 1, 1, 'Pagamento via PIX');
