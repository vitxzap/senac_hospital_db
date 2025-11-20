-- Package simples para agrupar funções relacionadas
CREATE OR REPLACE PACKAGE pkg_hospital AS
    -- Functions
    FUNCTION calcular_idade(p_id_paciente NUMBER) RETURN NUMBER;
    FUNCTION dias_internacao(p_id_internacao NUMBER) RETURN NUMBER;
    FUNCTION medico_disponivel(p_id_medico NUMBER, p_data_hora TIMESTAMP) RETURN VARCHAR2;
    
    -- Procedures
    PROCEDURE registrar_internacao(p_id_paciente NUMBER, p_id_leito NUMBER, p_motivo VARCHAR2);
    PROCEDURE processar_alta(p_id_internacao NUMBER);
    PROCEDURE criar_agendamento(p_id_paciente NUMBER, p_id_medico NUMBER, p_data_hora TIMESTAMP, p_id_tipo NUMBER, p_observacao VARCHAR2);
END pkg_hospital;


CREATE OR REPLACE PACKAGE BODY pkg_hospital AS
    FUNCTION calcular_idade(p_id_paciente NUMBER) RETURN NUMBER IS
    BEGIN
        RETURN calcular_idade(p_id_paciente);
    END;
    
    FUNCTION dias_internacao(p_id_internacao NUMBER) RETURN NUMBER IS
    BEGIN
        RETURN dias_internacao(p_id_internacao);
    END;
    
    FUNCTION medico_disponivel(p_id_medico NUMBER, p_data_hora TIMESTAMP) RETURN VARCHAR2 IS
    BEGIN
        RETURN medico_disponivel(p_id_medico, p_data_hora);
    END;
    
    PROCEDURE registrar_internacao(p_id_paciente NUMBER, p_id_leito NUMBER, p_motivo VARCHAR2) IS
    BEGIN
        registrar_internacao(p_id_paciente, p_id_leito, p_motivo);
    END;
    
    PROCEDURE processar_alta(p_id_internacao NUMBER) IS
    BEGIN
        processar_alta(p_id_internacao);
    END;
    
    PROCEDURE criar_agendamento(p_id_paciente NUMBER, p_id_medico NUMBER, p_data_hora TIMESTAMP, p_id_tipo NUMBER, p_observacao VARCHAR2) IS
    BEGIN
        criar_agendamento(p_id_paciente, p_id_medico, p_data_hora, p_id_tipo, p_observacao);
    END;
END pkg_hospital;