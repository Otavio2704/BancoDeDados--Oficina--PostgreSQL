-- Idade dos veículos
SELECT 
    placa, 
    marca, 
    modelo, 
    ano,
    (EXTRACT(YEAR FROM CURRENT_DATE) - ano) as idade_veiculo,
    CASE 
        WHEN (EXTRACT(YEAR FROM CURRENT_DATE) - ano) <= 2 THEN 'Novo'
        WHEN (EXTRACT(YEAR FROM CURRENT_DATE) - ano) <= 5 THEN 'Semi-novo'
        ELSE 'Usado'
    END as categoria_veiculo
FROM VEICULO
ORDER BY ano DESC;
