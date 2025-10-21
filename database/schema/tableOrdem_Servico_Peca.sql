CREATE TABLE ORDEM_SERVICO_PECA (
    id_ordem INT,
    id_peca INT,
    quantidade INT DEFAULT 1,
    preco_praticado DECIMAL(10,2),
    PRIMARY KEY (id_ordem, id_peca),
    FOREIGN KEY (id_ordem) REFERENCES ORDEM_SERVICO(id_ordem),
    FOREIGN KEY (id_peca) REFERENCES PECA(id_peca)
);
