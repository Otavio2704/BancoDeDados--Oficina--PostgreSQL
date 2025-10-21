-- Mecânicos ordenados por salário (do maior para o menor)
SELECT nome, especialidade, salario, data_contratacao
FROM MECANICO
ORDER BY salario DESC, nome ASC;
