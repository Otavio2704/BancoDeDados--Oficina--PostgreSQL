-- Trigger: Atualizar estoque após inserção de peça em ordem
CREATE OR REPLACE FUNCTION trg_atualizar_estoque_after_insert()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE PECA 
    SET estoque_atual = estoque_atual - NEW.quantidade
    WHERE id_peca = NEW.id_peca;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_atualizar_estoque_after_insert
AFTER INSERT ON ORDEM_SERVICO_PECA
FOR EACH ROW
EXECUTE FUNCTION trg_atualizar_estoque_after_insert();

-- Trigger: Restaurar estoque após exclusão de peça da ordem
CREATE OR REPLACE FUNCTION trg_restaurar_estoque_after_delete()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE PECA 
    SET estoque_atual = estoque_atual + OLD.quantidade
    WHERE id_peca = OLD.id_peca;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_restaurar_estoque_after_delete
AFTER DELETE ON ORDEM_SERVICO_PECA
FOR EACH ROW
EXECUTE FUNCTION trg_restaurar_estoque_after_delete();

-- Trigger: Atualizar valor total da ordem automaticamente
CREATE OR REPLACE FUNCTION trg_atualizar_valor_ordem_servico()
RETURNS TRIGGER AS $$
BEGIN
    PERFORM CalcularValorOrdem(NEW.id_ordem);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_atualizar_valor_ordem_servico
AFTER INSERT ON ORDEM_SERVICO_SERVICO
FOR EACH ROW
EXECUTE FUNCTION trg_atualizar_valor_ordem_servico();

-- Trigger adicional: Atualizar valor total após inserção de peça
CREATE TRIGGER trg_atualizar_valor_ordem_peca
AFTER INSERT ON ORDEM_SERVICO_PECA
FOR EACH ROW
EXECUTE FUNCTION trg_atualizar_valor_ordem_servico();
