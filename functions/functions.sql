-- Calcular idade do paciente
CREATE OR REPLACE FUNCTION calcular_idade(p_id_paciente IN NUMBER)
RETURN NUMBER AS
    v_data_nasc DATE;
BEGIN
    SELECT data_nascimento INTO v_data_nasc
    FROM paciente WHERE id_paciente = p_id_paciente;
    
    RETURN FLOOR(MONTHS_BETWEEN(SYSDATE, v_data_nasc) / 12);
END;


-- Calcular dias de internação
CREATE OR REPLACE FUNCTION dias_internacao(p_id_internacao IN NUMBER)
RETURN NUMBER AS
    v_entrada TIMESTAMP;
    v_saida TIMESTAMP;
BEGIN
    SELECT data_entrada, NVL(data_saida, SYSTIMESTAMP)
    INTO v_entrada, v_saida
    FROM internacao WHERE id_internacao = p_id_internacao;
    
    RETURN TRUNC(v_saida - v_entrada);
END;


-- Verificar disponibilidade de médico
CREATE OR REPLACE FUNCTION medico_disponivel(
    p_id_medico IN NUMBER,
    p_data_hora IN TIMESTAMP
) RETURN VARCHAR2 AS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM agendamento
    WHERE id_medico = p_id_medico
    AND status = 'Agendado'
    AND ABS(EXTRACT(HOUR FROM (data_hora - p_data_hora))) < 1;
    
    RETURN CASE WHEN v_count = 0 THEN 'S' ELSE 'N' END;
END;
