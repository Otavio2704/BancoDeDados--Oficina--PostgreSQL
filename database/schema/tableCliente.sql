CREATE TABLE CLIENTE (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf_cnpj VARCHAR(18) UNIQUE NOT NULL,
    telefone VARCHAR(15),
    email VARCHAR(100),
    endereco TEXT,
    tipo_cliente ENUM('PF', 'PJ') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
