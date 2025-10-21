-- Idade dos veículos
SELECT 
    placa, 
    marca, 
    modelo, 
    ano,
    (YEAR(CURDATE()) - ano) as idade_veiculo,
    CASE 
        WHEN (YEAR(CURDATE()) - ano) <= 2 THEN 'Novo'
        WHEN (YEAR(CURDATE()) - ano) <= 5 THEN 'Semi-novo'
        ELSE 'Usado'
    END as categoria_veiculo
FROM VEICULO
ORDER BY ano DESC;
