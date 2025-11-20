-- Tabela paciente
CREATE TABLE paciente (
    id_paciente NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR2(200),
    data_nascimento DATE,
    sexo VARCHAR2(20),
    rua VARCHAR2(200),
    numero VARCHAR2(50),
    bairro VARCHAR2(100),
    cidade VARCHAR2(100),
    cep VARCHAR2(20),
    email VARCHAR2(150),
    documento VARCHAR2(50) UNIQUE
);

-- Tabela departamento
CREATE TABLE departamento (
    id_departamento NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR2(150),
    descricao VARCHAR2(300)
);

-- Tabela especialidade
CREATE TABLE especialidade (
    id_especialidade NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR2(150),
    descricao VARCHAR2(300)
);

-- Tabela medico
CREATE TABLE medico (
    id_medico NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR2(200),
    crm VARCHAR2(50) UNIQUE,
    id_especialidade NUMBER,
    email VARCHAR2(150),
    id_departamento NUMBER,
    CONSTRAINT fk_medico_especialidade FOREIGN KEY (id_especialidade) 
        REFERENCES especialidade(id_especialidade),
    CONSTRAINT fk_medico_departamento FOREIGN KEY (id_departamento) 
        REFERENCES departamento(id_departamento)
);

-- Tabela enfermeiro
CREATE TABLE enfermeiro (
    id_enfermeiro NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR2(200),
    coren VARCHAR2(50) UNIQUE,
    email VARCHAR2(150),
    id_departamento NUMBER,
    CONSTRAINT fk_enfermeiro_departamento FOREIGN KEY (id_departamento) 
        REFERENCES departamento(id_departamento)
);

-- Tabela leito
CREATE TABLE leito (
    id_leito NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    numero VARCHAR2(50),
    unidade VARCHAR2(100),
    tipo VARCHAR2(50),
    status VARCHAR2(50)
);

-- Tabela procedimento
CREATE TABLE procedimento (
    id_procedimento NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    codigo VARCHAR2(50),
    nome VARCHAR2(200),
    descricao VARCHAR2(300),
    custo_base NUMBER(12,2)
);

-- Tabela tipo_agendamento
CREATE TABLE tipo_agendamento (
    id_tipo NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR2(100),
    descricao VARCHAR2(300)
);

-- Tabela agendamento
CREATE TABLE agendamento (
    id_agendamento NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    data_hora TIMESTAMP,
    id_tipo NUMBER,
    status VARCHAR2(50),
    id_paciente NUMBER,
    id_medico NUMBER,
    id_leito NUMBER,
    observacao VARCHAR2(300),
    CONSTRAINT fk_agendamento_tipo FOREIGN KEY (id_tipo) 
        REFERENCES tipo_agendamento(id_tipo),
    CONSTRAINT fk_agendamento_paciente FOREIGN KEY (id_paciente) 
        REFERENCES paciente(id_paciente),
    CONSTRAINT fk_agendamento_medico FOREIGN KEY (id_medico) 
        REFERENCES medico(id_medico),
    CONSTRAINT fk_agendamento_leito FOREIGN KEY (id_leito) 
        REFERENCES leito(id_leito)
);

-- Tabela agendamento_procedimento
CREATE TABLE agendamento_procedimento (
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_agendamento NUMBER NOT NULL,
    id_procedimento NUMBER NOT NULL,
    quantidade NUMBER NOT NULL CHECK (quantidade >= 0),
    observacao VARCHAR2(300),
    CONSTRAINT fk_agend_proc_agendamento FOREIGN KEY (id_agendamento) 
        REFERENCES agendamento(id_agendamento),
    CONSTRAINT fk_agend_proc_procedimento FOREIGN KEY (id_procedimento) 
        REFERENCES procedimento(id_procedimento)
);

-- Tabela internacao
CREATE TABLE internacao (
    id_internacao NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_paciente NUMBER NOT NULL,
    id_leito NUMBER NOT NULL,
    data_entrada TIMESTAMP NOT NULL,
    data_saida TIMESTAMP,
    motivo VARCHAR2(150),
    CONSTRAINT fk_internacao_paciente FOREIGN KEY (id_paciente) 
        REFERENCES paciente(id_paciente),
    CONSTRAINT fk_internacao_leito FOREIGN KEY (id_leito) 
        REFERENCES leito(id_leito)
);

-- Tabela faturamento
CREATE TABLE faturamento (
    id_fatura NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_paciente NUMBER,
    data_emissao DATE,
    valor_total NUMBER(12,2),
    status_pagamento VARCHAR2(50),
    CONSTRAINT fk_faturamento_paciente FOREIGN KEY (id_paciente) 
        REFERENCES paciente(id_paciente)
);

-- Tabela fatura_item
CREATE TABLE fatura_item (
    id_item NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_fatura NUMBER NOT NULL,
    tipo_item VARCHAR2(50) NOT NULL,
    ref_id NUMBER,
    quantidade NUMBER NOT NULL,
    valor_unitario NUMBER(12,2) NOT NULL,
    valor_total NUMBER(12,2),
    CONSTRAINT fk_fatura_item_fatura FOREIGN KEY (id_fatura) 
        REFERENCES faturamento(id_fatura)
);

-- Tabela historico_medico
CREATE TABLE historico_medico (
    id_historico NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_paciente NUMBER NOT NULL,
    id_medico NUMBER NOT NULL,
    diagnostico VARCHAR2(300),
    tratamento VARCHAR2(300),
    data_registro DATE,
    CONSTRAINT fk_historico_paciente FOREIGN KEY (id_paciente) 
        REFERENCES paciente(id_paciente),
    CONSTRAINT fk_historico_medico FOREIGN KEY (id_medico) 
        REFERENCES medico(id_medico)
);

-- Tabela laboratorio
CREATE TABLE laboratorio (
    id_lab NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR2(150) NOT NULL,
    responsavel VARCHAR2(150) NOT NULL
);

-- Tabela tipo exame
CREATE TABLE tipo_exame (
    id_tipo_exame NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    codigo VARCHAR2(50) UNIQUE,
    nome VARCHAR2(200),
    descricao VARCHAR2(150),
    custo_base NUMBER(12,2),
    id_lab NUMBER,
    CONSTRAINT fk_tipo_exame_lab FOREIGN KEY (id_lab) REFERENCES laboratorio(id_lab)
);

-- Tabela exame
CREATE TABLE exame (
    id_exame NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_paciente NUMBER,
    id_lab NUMBER,
    data_exame DATE,
    valor NUMBER (12,2),
    id_tipo_exame NUMBER,
    resultado VARCHAR2(150),
    CONSTRAINT fk_exame_paciente FOREIGN KEY (id_paciente) 
        REFERENCES paciente(id_paciente),
    CONSTRAINT fk_exame_laboratorio FOREIGN KEY (id_lab) 
        REFERENCES laboratorio(id_lab),
    CONSTRAINT fk_tip_exame FOREIGN KEY (id_tipo_exame)
        REFERENCES tipo_exame(id_tipo_exame)
);