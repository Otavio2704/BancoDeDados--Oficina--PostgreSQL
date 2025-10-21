CREATE TABLE SERVICO (
    id_servico SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco_base DECIMAL(10,2) NOT NULL,
    tempo_estimado INT, -- em minutos
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
