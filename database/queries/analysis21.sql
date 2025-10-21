-- Trigger: Atualizar estoque após inserção de peça em ordem
DELIMITER //
CREATE TRIGGER trg_atualizar_estoque_after_insert
AFTER INSERT ON ORDEM_SERVICO_PECA
FOR EACH ROW
BEGIN
    UPDATE PECA 
    SET estoque_atual = estoque_atual - NEW.quantidade
    WHERE id_peca = NEW.id_peca;
END //
DELIMITER ;

-- Trigger: Restaurar estoque após exclusão de peça da ordem
DELIMITER //
CREATE TRIGGER trg_restaurar_estoque_after_delete
AFTER DELETE ON ORDEM_SERVICO_PECA
FOR EACH ROW
BEGIN
    UPDATE PECA 
    SET estoque_atual = estoque_atual + OLD.quantidade
    WHERE id_peca = OLD.id_peca;
END //
DELIMITER ;

-- Trigger: Atualizar valor total da ordem automaticamente
DELIMITER //
CREATE TRIGGER trg_atualizar_valor_ordem_servico
AFTER INSERT ON ORDEM_SERVICO_SERVICO
FOR EACH ROW
BEGIN
    CALL CalcularValorOrdem(NEW.id_ordem);
END //
DELIMITER ;
