-- Verificar disponibilidade do médico
SELECT 
    medico_disponivel(1, SYSTIMESTAMP + INTERVAL '1' DAY) as medico_disponivel
FROM DUAL;

-- Consultar médicos disponíveis através da view
SELECT * FROM vw_medicos_completo WHERE id_medico = 1;

-- Consultar leitos disponíveis através da view
SELECT * FROM vw_status_leitos WHERE status = 'Disponível';

-- Criar agendamento de consulta inicial
BEGIN
    criar_agendamento(
        p_id_paciente => 1,
        p_id_medico => 1,
        p_data_hora => SYSTIMESTAMP + INTERVAL '1' DAY,
        p_id_tipo => 1,
        p_observacao => 'Paciente com dores no peito e falta de ar'
    );
END;
/

-- Atualizar status do agendamento para realizado
UPDATE agendamento 
SET status = 'Realizado'
WHERE id_paciente = 1 AND id_tipo = 1;

COMMIT;

-- Registrar histórico médico da consulta
INSERT INTO historico_medico (id_paciente, id_medico, diagnostico, tratamento, data_registro)
VALUES (1, 1, 'Angina instável - Necessita internação urgente', 
        'Internação imediata, medicação anticoagulante, cateterismo programado', SYSDATE);

COMMIT;

-- Consultar histórico através da view
SELECT * FROM vw_historico_paciente WHERE paciente = 'João Pedro Almeida';

-- Registrar internação usando a procedure
BEGIN
    registrar_internacao(
        p_id_paciente => 1,
        p_id_leito => 1,
        p_motivo => 'Angina instável - Cateterismo programado'
    );
END;
/

-- Consultar status do leito após internação (trigger trg_leito_ocupado foi acionado)
SELECT * FROM vw_status_leitos WHERE id_leito = 1;

-- Agendar procedimento durante internação
INSERT INTO agendamento (data_hora, id_tipo, status, id_paciente, id_medico, id_leito, observacao)
VALUES (SYSTIMESTAMP + INTERVAL '2' DAY, 2, 'Agendado', 1, 1, 1, 'Cateterismo cardíaco - Paciente em jejum');

COMMIT;

-- Vincular procedimento ao agendamento
INSERT INTO agendamento_procedimento (id_agendamento, id_procedimento, quantidade, observacao)
VALUES (2, 1, 1, 'Procedimento de urgência');

COMMIT;

-- Simular realização do procedimento
UPDATE agendamento 
SET status = 'Realizado'
WHERE id_agendamento = 2;

COMMIT;

-- Registrar resultado do procedimento no histórico
INSERT INTO historico_medico (id_paciente, id_medico, diagnostico, tratamento, data_registro)
VALUES (1, 1, 'Cateterismo realizado - Obstrução de 70% na artéria coronária',
        'Angioplastia com stent realizada. Paciente estável. Alta prevista em 24h', SYSDATE);

COMMIT;

-- Simular 3 dias de internação
UPDATE internacao 
SET data_entrada = SYSTIMESTAMP - INTERVAL '3' DAY
WHERE id_paciente = 1 AND data_saida IS NULL;

COMMIT;

-- Consultar dias de internação usando a função
SELECT 
    id_internacao,
    id_paciente,
    data_entrada,
    dias_internacao(id_internacao) as dias_internado
FROM internacao
WHERE id_paciente = 1 AND data_saida IS NULL;