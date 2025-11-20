-- TABELA PACIENTE
CREATE INDEX idx_paciente_documento ON paciente(documento);
CREATE INDEX idx_paciente_nome ON paciente(nome);

-- TABELA MEDICO
CREATE INDEX idx_medico_crm ON medico(crm);
CREATE INDEX idx_medico_departamento ON medico(id_departamento);

-- TABELA ENFERMEIRO
CREATE INDEX idx_enfermeiro_coren ON enfermeiro(coren);
CREATE INDEX idx_enfermeiro_departamento ON enfermeiro(id_departamento);

-- TABELA AGENDAMENTO
CREATE INDEX idx_agendamento_paciente ON agendamento(id_paciente);
CREATE INDEX idx_agendamento_medico ON agendamento(id_medico);
CREATE INDEX idx_agendamento_data_hora ON agendamento(data_hora);
CREATE INDEX idx_agendamento_status ON agendamento(status);
CREATE INDEX idx_agendamento_paciente_status ON agendamento(id_paciente, status);
CREATE INDEX idx_agendamento_leito ON agendamento(id_leito);

-- TABELA AGENDAMENTO_PROCEDIMENTO
CREATE INDEX idx_agend_procedimento_agendamento ON agendamento_procedimento(id_agendamento);
CREATE INDEX idx_agend_procedimento_procedimento ON agendamento_procedimento(id_procedimento);

-- TABELA INTERNACAO
CREATE INDEX idx_internacao_paciente ON internacao(id_paciente);
CREATE INDEX idx_internacao_leito ON internacao(id_leito);
CREATE INDEX idx_internacao_ativa ON internacao(id_leito, data_saida);

-- TABELA LEITO
CREATE INDEX idx_leito_status ON leito(status);
CREATE INDEX idx_leito_unidade ON leito(unidade);
CREATE INDEX idx_leito_tipo ON leito(tipo);
CREATE INDEX idx_leito_status_tipo ON leito(status, tipo);

-- TABELA EXAME
CREATE INDEX idx_exame_paciente ON exame(id_paciente);
CREATE INDEX idx_exame_laboratorio ON exame(id_lab);

-- TABELA TIPO_EXAME
CREATE INDEX idx_tipo_exame_codigo ON tipo_exame(codigo);
CREATE INDEX idx_tipo_exame_lab ON tipo_exame(id_lab);

-- TABELA PROCEDIMENTO
CREATE INDEX idx_procedimento_codigo ON procedimento(codigo);
CREATE INDEX idx_procedimento_nome ON procedimento(nome);

-- TABELA FATURAMENTO
CREATE INDEX idx_faturamento_paciente ON faturamento(id_paciente);
CREATE INDEX idx_faturamento_status ON faturamento(status_pagamento);

-- TABELA FATURA_ITEM
CREATE INDEX idx_fatura_item_fatura ON fatura_item(id_fatura);
CREATE INDEX idx_fatura_item_tipo ON fatura_item(tipo_item);

-- TABELA HISTORICO_MEDICO
CREATE INDEX idx_historico_paciente ON historico_medico(id_paciente);
CREATE INDEX idx_historico_medico ON historico_medico(id_medico);


-- TABELA LABORATORIO
CREATE INDEX idx_laboratorio_nome ON laboratorio(nome);

-- TABELA DEPARTAMENTO
CREATE INDEX idx_departamento_nome ON departamento(nome);

-- TABELA ESPECIALIDADE
CREATE INDEX idx_especialidade_nome ON especialidade(nome);

-- TABELA TIPO_AGENDAMENTO
CREATE INDEX idx_tipo_agendamento_nome ON tipo_agendamento(nome);