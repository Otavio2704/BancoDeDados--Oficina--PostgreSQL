CREATE TABLE MECANICO (
    id_mecanico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    telefone VARCHAR(15),
    especialidade VARCHAR(50),
    salario DECIMAL(10,2),
    data_contratacao DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
