-- Usar function
SELECT nome, fn_calcular_idade(id_paciente) as idade
FROM paciente;

-- Usar procedure
BEGIN
    sp_registrar_internacao(1, 4, 'Pneumonia grave');
END;


-- Usar package
BEGIN
    pkg_hospital.criar_agendamento(2, 1, TIMESTAMP '2025-11-25 19:00:00', 1, 'Consulta de rotina');
END;


-- Verificar disponibilidade
SELECT fn_medico_disponivel(1, TIMESTAMP '2025-11-25 10:00:00') as disponivel FROM dual;