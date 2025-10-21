CREATE TABLE ORDEM_SERVICO (
    id_ordem SERIAL PRIMARY KEY,
    data_entrada TIMESTAMP NOT NULL,
    data_saida TIMESTAMP,
    status VARCHAR(20) DEFAULT 'ABERTA' CHECK (status IN ('ABERTA', 'EM_ANDAMENTO', 'FINALIZADA', 'CANCELADA')),
    valor_total DECIMAL(10,2) DEFAULT 0.00,
    descricao TEXT,
    id_veiculo INT,
    id_mecanico INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_veiculo) REFERENCES VEICULO(id_veiculo),
    FOREIGN KEY (id_mecanico) REFERENCES MECANICO(id_mecanico)
);
