-- 1. Registrar internação completa
CREATE OR REPLACE PROCEDURE registrar_internacao(
    p_id_paciente IN NUMBER,
    p_id_leito IN NUMBER,
    p_motivo IN VARCHAR2
) AS
BEGIN
    INSERT INTO internacao (id_paciente, id_leito, data_entrada, motivo)
    VALUES (p_id_paciente, p_id_leito, SYSTIMESTAMP, p_motivo);
    
    COMMIT;
END;


-- Processar alta do paciente
CREATE OR REPLACE PROCEDURE processar_alta(
    p_id_internacao IN NUMBER
) AS
BEGIN
    UPDATE internacao 
    SET data_saida = SYSTIMESTAMP
    WHERE id_internacao = p_id_internacao;
    
    COMMIT;
END;


-- Criar agendamento
CREATE OR REPLACE PROCEDURE criar_agendamento(
    p_id_paciente IN NUMBER,
    p_id_medico IN NUMBER,
    p_data_hora IN TIMESTAMP,
    p_id_tipo IN NUMBER,
    p_observacao IN VARCHAR2
) AS
BEGIN
    INSERT INTO agendamento (data_hora, id_tipo, status, id_paciente, id_medico, observacao)
    VALUES (p_data_hora, p_id_tipo, 'Agendado', p_id_paciente, p_id_medico, p_observacao);
    
    COMMIT;
END;


-- Gerar fatura de internação
CREATE OR REPLACE PROCEDURE gerar_fatura_internacao(
    p_id_internacao IN NUMBER
) AS
    v_id_paciente NUMBER;
    v_id_fatura NUMBER;
    v_dias NUMBER;
    v_valor_diaria NUMBER := 800.00;
BEGIN
    -- Buscar dados da internação
    SELECT id_paciente INTO v_id_paciente
    FROM internacao WHERE id_internacao = p_id_internacao;
    
    -- Calcular dias
    v_dias := dias_internacao(p_id_internacao);
    
    -- Criar fatura
    INSERT INTO faturamento (id_paciente, data_emissao, valor_total, status_pagamento)
    VALUES (v_id_paciente, SYSDATE, 0, 'Pendente')
    RETURNING id_fatura INTO v_id_fatura;
    
    -- Adicionar item de diária
    INSERT INTO fatura_item (id_fatura, tipo_item, ref_id, quantidade, valor_unitario, valor_total)
    VALUES (v_id_fatura, 'Diária', p_id_internacao, v_dias, v_valor_diaria, v_dias * v_valor_diaria);
    
    COMMIT;
END;
