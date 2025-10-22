-- ============================================
-- VALIDAÇÕES ADICIONAIS
-- Execute APÓS criar todas as tabelas
-- ============================================

-- Validação: Ano do veículo não pode ser futuro nem muito antigo
ALTER TABLE VEICULO 
ADD CONSTRAINT check_ano_valido 
CHECK (ano >= 1900 AND ano <= EXTRACT(YEAR FROM CURRENT_DATE) + 1);

-- Validação: Formato de CPF/CNPJ (opcional, pode ser pesado)
-- Descomente se quiser validação de formato
/*
ALTER TABLE CLIENTE 
ADD CONSTRAINT check_cpf_cnpj_format 
CHECK (
    (tipo_cliente = 'PF' AND cpf_cnpj ~ '^\d{3}\.\d{3}\.\d{3}-\d{2}$') OR
    (tipo_cliente = 'PJ' AND cpf_cnpj ~ '^\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}$')
);

ALTER TABLE MECANICO 
ADD CONSTRAINT check_cpf_format 
CHECK (cpf ~ '^\d{3}\.\d{3}\.\d{3}-\d{2}$');

ALTER TABLE FORNECEDOR 
ADD CONSTRAINT check_cnpj_format 
CHECK (cnpj ~ '^\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}$');
*/

-- Validação: Salário deve ser positivo
ALTER TABLE MECANICO 
ADD CONSTRAINT check_salario_positivo 
CHECK (salario > 0);

-- Validação: Preços devem ser positivos
ALTER TABLE PECA 
ADD CONSTRAINT check_preco_positivo 
CHECK (preco_unitario > 0);

ALTER TABLE SERVICO 
ADD CONSTRAINT check_preco_servico_positivo 
CHECK (preco_base > 0);

-- Validação: Estoque não pode ser negativo
ALTER TABLE PECA 
ADD CONSTRAINT check_estoque_positivo 
CHECK (estoque_atual >= 0 AND estoque_minimo >= 0);

-- Validação: Quantidade em ordem deve ser positiva
ALTER TABLE ORDEM_SERVICO_PECA 
ADD CONSTRAINT check_quantidade_peca_positiva 
CHECK (quantidade > 0);

ALTER TABLE ORDEM_SERVICO_SERVICO 
ADD CONSTRAINT check_quantidade_servico_positiva 
CHECK (quantidade > 0);

-- Validação: Data de saída deve ser após data de entrada
ALTER TABLE ORDEM_SERVICO 
ADD CONSTRAINT check_data_saida_valida 
CHECK (data_saida IS NULL OR data_saida >= data_entrada);

-- Mensagem de sucesso
DO $$
BEGIN
    RAISE NOTICE 'Validações adicionadas com sucesso!';
END $$;
