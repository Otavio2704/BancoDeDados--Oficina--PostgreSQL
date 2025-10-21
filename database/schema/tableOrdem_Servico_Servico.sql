CREATE TABLE ORDEM_SERVICO_SERVICO (
    id_ordem INT,
    id_servico INT,
    quantidade INT DEFAULT 1,
    preco_praticado DECIMAL(10,2),
    PRIMARY KEY (id_ordem, id_servico),
    FOREIGN KEY (id_ordem) REFERENCES ORDEM_SERVICO(id_ordem),
    FOREIGN KEY (id_servico) REFERENCES SERVICO(id_servico)
);
