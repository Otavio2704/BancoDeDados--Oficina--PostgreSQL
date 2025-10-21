CREATE TABLE ORDEM_SERVICO (
    id_ordem INT AUTO_INCREMENT PRIMARY KEY,
    data_entrada DATETIME NOT NULL,
    data_saida DATETIME,
    status ENUM('ABERTA', 'EM_ANDAMENTO', 'FINALIZADA', 'CANCELADA') DEFAULT 'ABERTA',
    valor_total DECIMAL(10,2) DEFAULT 0.00,
    descricao TEXT,
    id_veiculo INT,
    id_mecanico INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_veiculo) REFERENCES VEICULO(id_veiculo),
    FOREIGN KEY (id_mecanico) REFERENCES MECANICO(id_mecanico)
);
