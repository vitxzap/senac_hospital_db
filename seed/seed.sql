-- Departamento
INSERT INTO departamento (nome, descricao)
VALUES ('Cardiologia', 'Departamento especializado em doenças cardiovasculares');

-- Especialidade
INSERT INTO especialidade (nome, descricao)
VALUES ('Cardiologista', 'Especialista em coração e sistema circulatório');

-- Médico
INSERT INTO medico (nome, crm, id_especialidade, email, id_departamento)
VALUES ('Dr. Carlos Silva', 'CRM-12345-SP', 1, 'carlos.silva@hospital.com', 1);

-- Enfermeiro
INSERT INTO enfermeiro (nome, coren, email, id_departamento)
VALUES ('Enf. Maria Santos', 'COREN-54321-SP', 'maria.santos@hospital.com', 1);

-- Leito
INSERT INTO leito (numero, unidade, tipo, status)
VALUES ('101', 'Ala A - 1º Andar', 'Enfermaria', 'Disponível');

-- Tipo de Agendamento
INSERT INTO tipo_agendamento (nome, descricao)
VALUES ('Consulta', 'Consulta médica ambulatorial');

INSERT INTO tipo_agendamento (nome, descricao)
VALUES ('Internação', 'Internação hospitalar');

-- Laboratório
INSERT INTO laboratorio (nome, responsavel)
VALUES ('Lab Central', 'Dr. João Oliveira');

-- Tipo de Exame
INSERT INTO tipo_exame (codigo, nome, descricao, custo_base, id_lab)
VALUES ('ECG001', 'Eletrocardiograma', 'Exame do coração', 150.00, 1);

-- Procedimento
INSERT INTO procedimento (codigo, nome, descricao, custo_base)
VALUES ('PROC001', 'Cateterismo Cardíaco', 'Procedimento invasivo cardíaco', 3500.00);

COMMIT;


-- Cadastro do Paciente
INSERT INTO paciente (nome, data_nascimento, sexo, rua, numero, bairro, cidade, cep, email, documento)
VALUES ('João Pedro Almeida', TO_DATE('1975-03-15', 'YYYY-MM-DD'), 'Masculino', 'Rua das Flores', '123', 
        'Centro', 'São Paulo', '01234-567', 'joao.almeida@email.com', '123.456.789-00');

COMMIT;

-- Seleciona como teste usando a função de calcular idade
SELECT 
    p.id_paciente,
    p.nome,
    p.documento,
    p.data_nascimento,
    calcular_idade(p.id_paciente) as idade
FROM paciente p
WHERE p.documento = '123.456.789-00';

