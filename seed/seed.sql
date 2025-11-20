-- Populando DEPARTAMENTO (sem dependências)
INSERT INTO departamento (nome, descricao) VALUES ('Cardiologia', 'Departamento especializado em doenças cardiovasculares');
INSERT INTO departamento (nome, descricao) VALUES ('Ortopedia', 'Departamento de tratamento de ossos e articulações');
INSERT INTO departamento (nome, descricao) VALUES ('Pediatria', 'Departamento de atendimento infantil');
INSERT INTO departamento (nome, descricao) VALUES ('Neurologia', 'Departamento de doenças neurológicas');
INSERT INTO departamento (nome, descricao) VALUES ('Emergência', 'Departamento de atendimento emergencial');

-- Populando ESPECIALIDADE (sem dependências)
INSERT INTO especialidade (nome, descricao) VALUES ('Cardiologista', 'Especialista em coração e sistema circulatório');
INSERT INTO especialidade (nome, descricao) VALUES ('Ortopedista', 'Especialista em ossos, músculos e articulações');
INSERT INTO especialidade (nome, descricao) VALUES ('Pediatra', 'Especialista em saúde infantil');
INSERT INTO especialidade (nome, descricao) VALUES ('Neurologista', 'Especialista em sistema nervoso');
INSERT INTO especialidade (nome, descricao) VALUES ('Clínico Geral', 'Médico generalista');

-- Populando TIPO_AGENDAMENTO (sem dependências)
INSERT INTO tipo_agendamento (nome, descricao) VALUES ('Consulta', 'Consulta médica ambulatorial');
INSERT INTO tipo_agendamento (nome, descricao) VALUES ('Exame', 'Exame diagnóstico');
INSERT INTO tipo_agendamento (nome, descricao) VALUES ('Procedimento', 'Procedimento médico');
INSERT INTO tipo_agendamento (nome, descricao) VALUES ('Cirurgia', 'Procedimento cirúrgico');
INSERT INTO tipo_agendamento (nome, descricao) VALUES ('Retorno', 'Consulta de retorno');

-- Popular tipos de exame
INSERT INTO tipo_exame (codigo, nome, descricao, custo_base, id_lab)
VALUES ('EX001', 'Hemograma Completo', 'Análise completa do sangue', 80.00, 2);

INSERT INTO tipo_exame (codigo, nome, descricao, custo_base, id_lab)
VALUES ('EX002', 'Raio-X Simples', 'Radiografia simples', 180.00, 3);

INSERT INTO tipo_exame (codigo, nome, descricao, custo_base, id_lab)
VALUES ('EX003', 'Enzimas Cardíacas', 'Dosagem de troponina e CK-MB', 320.00, 1);

INSERT INTO tipo_exame (codigo, nome, descricao, custo_base, id_lab)
VALUES ('EX004', 'Ultrassonografia', 'Exame de ultrassom', 220.00, 3);


-- Populando PACIENTE (sem dependências)
INSERT INTO paciente (nome, data_nascimento, sexo, rua, numero, bairro, cidade, cep, email, documento) 
VALUES ('João Silva Santos', TO_DATE('1985-03-15', 'YYYY-MM-DD'), 'Masculino', 'Rua das Flores', '123', 'Centro', 'São Paulo', '01234-567', 'joao.silva@email.com', '123.456.789-00');

INSERT INTO paciente (nome, data_nascimento, sexo, rua, numero, bairro, cidade, cep, email, documento) 
VALUES ('Maria Oliveira Costa', TO_DATE('1990-07-22', 'YYYY-MM-DD'), 'Feminino', 'Av. Paulista', '456', 'Bela Vista', 'São Paulo', '01310-100', 'maria.oliveira@email.com', '234.567.890-11');

INSERT INTO paciente (nome, data_nascimento, sexo, rua, numero, bairro, cidade, cep, email, documento) 
VALUES ('Pedro Henrique Souza', TO_DATE('2015-11-10', 'YYYY-MM-DD'), 'Masculino', 'Rua Augusta', '789', 'Consolação', 'São Paulo', '01305-000', 'pedro.souza@email.com', '345.678.901-22');

INSERT INTO paciente (nome, data_nascimento, sexo, rua, numero, bairro, cidade, cep, email, documento) 
VALUES ('Ana Paula Ferreira', TO_DATE('1978-05-30', 'YYYY-MM-DD'), 'Feminino', 'Rua Oscar Freire', '321', 'Jardins', 'São Paulo', '01426-001', 'ana.ferreira@email.com', '456.789.012-33');

INSERT INTO paciente (nome, data_nascimento, sexo, rua, numero, bairro, cidade, cep, email, documento) 
VALUES ('Carlos Eduardo Lima', TO_DATE('1965-12-08', 'YYYY-MM-DD'), 'Masculino', 'Rua Haddock Lobo', '654', 'Cerqueira César', 'São Paulo', '01414-001', 'carlos.lima@email.com', '567.890.123-44');

INSERT INTO paciente (nome, data_nascimento, sexo, rua, numero, bairro, cidade, cep, email, documento) 
VALUES ('Juliana Martins Rocha', TO_DATE('1995-09-18', 'YYYY-MM-DD'), 'Feminino', 'Rua da Consolação', '987', 'Consolação', 'São Paulo', '01301-000', 'juliana.rocha@email.com', '678.901.234-55');


-- Populando MEDICO (depende de especialidade e departamento)
INSERT INTO medico (nome, crm, id_especialidade, email, id_departamento) 
VALUES ('Dr. Roberto Cardoso', 'CRM-SP 123456', 1, 'roberto.cardoso@hospital.com', 1);

INSERT INTO medico (nome, crm, id_especialidade, email, id_departamento) 
VALUES ('Dra. Fernanda Almeida', 'CRM-SP 234567', 2, 'fernanda.almeida@hospital.com', 2);

INSERT INTO medico (nome, crm, id_especialidade, email, id_departamento) 
VALUES ('Dr. Lucas Mendes', 'CRM-SP 345678', 3, 'lucas.mendes@hospital.com', 3);

INSERT INTO medico (nome, crm, id_especialidade, email, id_departamento) 
VALUES ('Dra. Patricia Santos', 'CRM-SP 456789', 4, 'patricia.santos@hospital.com', 4);

INSERT INTO medico (nome, crm, id_especialidade, email, id_departamento) 
VALUES ('Dr. Marcos Ribeiro', 'CRM-SP 567890', 5, 'marcos.ribeiro@hospital.com', 5);


-- Populando ENFERMEIRO (depende de departamento)
INSERT INTO enfermeiro (nome, coren, email, id_departamento) 
VALUES ('Enf. Carla Souza', 'COREN-SP 123456', 'carla.souza@hospital.com', 1);

INSERT INTO enfermeiro (nome, coren, email, id_departamento) 
VALUES ('Enf. Ricardo Oliveira', 'COREN-SP 234567', 'ricardo.oliveira@hospital.com', 2);

INSERT INTO enfermeiro (nome, coren, email, id_departamento) 
VALUES ('Enf. Amanda Costa', 'COREN-SP 345678', 'amanda.costa@hospital.com', 3);

INSERT INTO enfermeiro (nome, coren, email, id_departamento) 
VALUES ('Enf. Bruno Silva', 'COREN-SP 456789', 'bruno.silva@hospital.com', 4);

INSERT INTO enfermeiro (nome, coren, email, id_departamento) 
VALUES ('Enf. Tatiana Lima', 'COREN-SP 567890', 'tatiana.lima@hospital.com', 5);

INSERT INTO enfermeiro (nome, coren, email, id_departamento) 
VALUES ('Enf. Felipe Santos', 'COREN-SP 678901', 'felipe.santos@hospital.com', 1);

-- Populando LEITO (sem dependências)
INSERT INTO leito (numero, unidade, tipo, status) VALUES ('101', 'UTI', 'Intensivo', 'Disponível');
INSERT INTO leito (numero, unidade, tipo, status) VALUES ('102', 'UTI', 'Intensivo', 'Ocupado');
INSERT INTO leito (numero, unidade, tipo, status) VALUES ('103', 'UTI', 'Intensivo', 'Disponível');
INSERT INTO leito (numero, unidade, tipo, status) VALUES ('201', 'Enfermaria', 'Comum', 'Disponível');
INSERT INTO leito (numero, unidade, tipo, status) VALUES ('202', 'Enfermaria', 'Comum', 'Ocupado');
INSERT INTO leito (numero, unidade, tipo, status) VALUES ('203', 'Enfermaria', 'Comum', 'Disponível');
INSERT INTO leito (numero, unidade, tipo, status) VALUES ('204', 'Enfermaria', 'Comum', 'Disponível');
INSERT INTO leito (numero, unidade, tipo, status) VALUES ('301', 'Apartamento', 'Privativo', 'Ocupado');
INSERT INTO leito (numero, unidade, tipo, status) VALUES ('302', 'Apartamento', 'Privativo', 'Disponível');
INSERT INTO leito (numero, unidade, tipo, status) VALUES ('303', 'Apartamento', 'Privativo', 'Disponível');


-- Populando LABORATORIO (sem dependências)
INSERT INTO laboratorio (nome, responsavel) VALUES ('Lab Central', 'Dr. José Laboratório');
INSERT INTO laboratorio (nome, responsavel) VALUES ('Lab Análises Clínicas', 'Dra. Mariana Testes');
INSERT INTO laboratorio (nome, responsavel) VALUES ('Lab Imagem', 'Dr. Paulo Radiologia');
INSERT INTO laboratorio (nome, responsavel) VALUES ('Lab Patologia', 'Dra. Sandra Patologista');


-- Populando PROCEDIMENTO (sem dependências)
INSERT INTO procedimento (codigo, nome, descricao, custo_base) 
VALUES ('PROC001', 'Consulta Cardiológica', 'Consulta com cardiologista', 250.00);

INSERT INTO procedimento (codigo, nome, descricao, custo_base) 
VALUES ('PROC002', 'Eletrocardiograma', 'Exame de eletrocardiograma', 150.00);

INSERT INTO procedimento (codigo, nome, descricao, custo_base) 
VALUES ('PROC003', 'Raio-X Tórax', 'Radiografia de tórax', 180.00);

INSERT INTO procedimento (codigo, nome, descricao, custo_base) 
VALUES ('PROC004', 'Hemograma Completo', 'Exame de sangue completo', 80.00);

INSERT INTO procedimento (codigo, nome, descricao, custo_base) 
VALUES ('PROC005', 'Ultrassonografia Abdominal', 'Ultrassom de abdômen', 220.00);

INSERT INTO procedimento (codigo, nome, descricao, custo_base) 
VALUES ('PROC006', 'Ressonância Magnética', 'Exame de ressonância', 850.00);

INSERT INTO procedimento (codigo, nome, descricao, custo_base) 
VALUES ('PROC007', 'Cirurgia Ortopédica', 'Procedimento cirúrgico ortopédico', 5500.00);

INSERT INTO procedimento (codigo, nome, descricao, custo_base) 
VALUES ('PROC008', 'Tomografia Computadorizada', 'Exame de tomografia', 650.00);

INSERT INTO procedimento (codigo, nome, descricao, custo_base) 
VALUES ('PROC009', 'Ecocardiograma', 'Ultrassom do coração', 320.00);

INSERT INTO procedimento (codigo, nome, descricao, custo_base) 
VALUES ('PROC010', 'Consulta Pediátrica', 'Consulta com pediatra', 200.00);




-- Populando FATURAMENTO (depende de paciente)
INSERT INTO faturamento (id_paciente, data_emissao, valor_total, status_pagamento) 
VALUES (1, TO_DATE('2025-11-15', 'YYYY-MM-DD'), 400.00, 'Pago');

INSERT INTO faturamento (id_paciente, data_emissao, valor_total, status_pagamento) 
VALUES (2, TO_DATE('2025-11-18', 'YYYY-MM-DD'), 3500.00, 'Pendente');

INSERT INTO faturamento (id_paciente, data_emissao, valor_total, status_pagamento) 
VALUES (5, TO_DATE('2025-11-19', 'YYYY-MM-DD'), 15000.00, 'Pendente');


-- Populando FATURA_ITEM (depende de faturamento)
INSERT INTO fatura_item (id_fatura, tipo_item, ref_id, quantidade, valor_unitario, valor_total) 
VALUES (1, 'Consulta', 1, 1, 250.00, 250.00);

INSERT INTO fatura_item (id_fatura, tipo_item, ref_id, quantidade, valor_unitario, valor_total) 
VALUES (1, 'Exame', 2, 1, 150.00, 150.00);

INSERT INTO fatura_item (id_fatura, tipo_item, ref_id, quantidade, valor_unitario, valor_total) 
VALUES (2, 'Internação', 1, 3, 800.00, 2400.00);

INSERT INTO fatura_item (id_fatura, tipo_item, ref_id, quantidade, valor_unitario, valor_total) 
VALUES (2, 'Medicamento', 1, 1, 1100.00, 1100.00);

INSERT INTO fatura_item (id_fatura, tipo_item, ref_id, quantidade, valor_unitario, valor_total) 
VALUES (3, 'Cirurgia', 1, 1, 12000.00, 12000.00);

INSERT INTO fatura_item (id_fatura, tipo_item, ref_id, quantidade, valor_unitario, valor_total) 
VALUES (3, 'UTI', 1, 2, 1500.00, 3000.00);

-- Commit das transações
COMMIT;