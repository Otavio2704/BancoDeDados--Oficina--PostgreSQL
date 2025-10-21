-- Listar todos os veículos com informações básicas
SELECT v.placa, v.marca, v.modelo, v.ano, v.cor, c.nome as proprietario
FROM VEICULO v
JOIN CLIENTE c ON v.id_cliente = c.id_cliente;
