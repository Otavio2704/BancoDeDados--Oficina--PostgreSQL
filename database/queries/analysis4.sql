-- Peças com estoque baixo
SELECT p.nome, p.estoque_atual, p.estoque_minimo, f.nome as fornecedor
FROM PECA p
JOIN FORNECEDOR f ON p.id_fornecedor = f.id_fornecedor
WHERE p.estoque_atual <= p.estoque_minimo;
