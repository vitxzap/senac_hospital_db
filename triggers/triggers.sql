-- Ocupa Leito automaticamente
CREATE OR REPLACE TRIGGER trg_leito_ocupado
AFTER INSERT ON internacao
FOR EACH ROW
BEGIN
    UPDATE leito 
    SET status = 'Ocupado' 
    WHERE id_leito = :NEW.id_leito;
END;

-- Libera leito automaticamente
CREATE OR REPLACE TRIGGER trg_leito_disponivel
AFTER UPDATE OF data_saida ON internacao
FOR EACH ROW
WHEN (NEW.data_saida IS NOT NULL)
BEGIN
    UPDATE leito 
    SET status = 'Disponível' 
    WHERE id_leito = :NEW.id_leito;
END;

-- Adiciona exame a fatura do paciente 
CREATE OR REPLACE TRIGGER trg_faturar_exame
AFTER INSERT ON exame
FOR EACH ROW
DECLARE
    v_id_fatura NUMBER;
    v_custo NUMBER;
BEGIN
    -- Buscar custo do tipo de exame
    SELECT custo_base INTO v_custo
    FROM tipo_exame
    WHERE id_tipo_exame = :NEW.id_tipo_exame;
    
    -- Buscar ou criar fatura
    BEGIN
        SELECT id_fatura INTO v_id_fatura
        FROM faturamento
        WHERE id_paciente = :NEW.id_paciente
        AND status_pagamento = 'Pendente'
        AND ROWNUM = 1;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            INSERT INTO faturamento (id_paciente, data_emissao, valor_total, status_pagamento)
            VALUES (:NEW.id_paciente, SYSDATE, 0, 'Pendente')
            RETURNING id_fatura INTO v_id_fatura;
    END;
    -- Adiciona item na fatura
    INSERT INTO fatura_item (id_fatura, tipo_item, ref_id, quantidade, valor_unitario)
    VALUES (v_id_fatura, 'Exame', :NEW.id_exame, 1, v_custo);
END;

-- Calcular valor total do item da fatura
CREATE OR REPLACE TRIGGER trg_calc_valor_item
BEFORE INSERT OR UPDATE ON fatura_item
FOR EACH ROW
BEGIN
    :NEW.valor_total := :NEW.quantidade * :NEW.valor_unitario;
END;

-- Atualizar total da fatura
CREATE OR REPLACE TRIGGER trg_atualizar_total_fatura
AFTER INSERT OR UPDATE OR DELETE ON fatura_item
FOR EACH ROW
DECLARE
    v_id_fatura NUMBER;
BEGIN
    v_id_fatura := COALESCE(:NEW.id_fatura, :OLD.id_fatura);
    
    UPDATE faturamento
    SET valor_total = (
        SELECT NVL(SUM(valor_total), 0)
        FROM fatura_item
        WHERE id_fatura = v_id_fatura
    )
    WHERE id_fatura = v_id_fatura;
END;

