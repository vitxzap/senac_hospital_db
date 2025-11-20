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

-- Buscar médico por especialidade
CREATE OR REPLACE VIEW vw_medicos_completo AS
SELECT 
    m.id_medico,
    m.nome,
    m.crm,
    m.email,
    e.nome as especialidade,
    d.nome as departamento
FROM medico m
JOIN especialidade e ON m.id_especialidade = e.id_especialidade
JOIN departamento d ON m.id_departamento = d.id_departamento
ORDER BY m.nome;
-- Uso:
SELECT * FROM vw_medicos_completo WHERE especialidade = 'Cardiologista';


-- Buscar enfermeiros por departamento
CREATE OR REPLACE VIEW vw_enfermeiros_completo AS
SELECT 
    e.id_enfermeiro,
    e.nome,
    e.coren,
    e.email,
    d.nome as departamento
FROM enfermeiro e
JOIN departamento d ON e.id_departamento = d.id_departamento
ORDER BY d.nome, e.nome;
-- Uso:
SELECT * FROM vw_enfermeiros_completo WHERE departamento = 'UTI';


-- Buscar leitos por status
CREATE OR REPLACE VIEW vw_status_leitos AS
SELECT 
    l.id_leito,
    l.numero,
    l.unidade,
    l.tipo,
    l.status,
    p.nome as paciente_atual,
    i.data_entrada,
    TRUNC(SYSTIMESTAMP - i.data_entrada) as dias_ocupado
FROM leito l
LEFT JOIN internacao i ON l.id_leito = i.id_leito AND i.data_saida IS NULL
LEFT JOIN paciente p ON i.id_paciente = p.id_paciente
ORDER BY l.unidade, l.numero;
-- Uso:
SELECT * FROM vw_status_leitos WHERE status = 'Disponível' AND tipo = 'UTI';


-- Buscar dados mais detalhados da fatura por id
CREATE OR REPLACE VIEW vw_faturas_detalhadas AS
SELECT 
    f.id_fatura,
    f.data_emissao,
    p.nome as paciente,
    p.documento,
    fi.tipo_item,
    fi.quantidade,
    fi.valor_unitario,
    fi.valor_total,
    f.valor_total as total_fatura,
    f.status_pagamento
FROM faturamento f
JOIN paciente p ON f.id_paciente = p.id_paciente
JOIN fatura_item fi ON f.id_fatura = fi.id_fatura
ORDER BY f.id_fatura, fi.id_item;
-- Uso:
SELECT * FROM vw_faturas_detalhadas WHERE id_fatura = 10;


-- Busca faturas pendentes
CREATE OR REPLACE VIEW vw_faturas_pendentes AS
SELECT 
    f.id_fatura,
    f.data_emissao,
    TRUNC(SYSDATE - f.data_emissao) as dias_em_aberto, -- Calcula os dias em aberto da fatura, subtraindo a data do sistema com a data da emissão
    p.nome as paciente,
    p.email,
    p.documento,
    f.valor_total,
    f.status_pagamento
FROM faturamento f
JOIN paciente p ON f.id_paciente = p.id_paciente
WHERE f.status_pagamento = 'Pendente'
ORDER BY f.data_emissao; -- Ordena pela data de emissao
-- Uso:
SELECT * FROM vw_faturas_pendentes WHERE dias_em_aberto > 30 AND paciente = "nome"; 


-- Busca exames realizados por paciente
CREATE OR REPLACE VIEW vw_exames_por_paciente AS
SELECT 
    p.id_paciente,
    p.nome as paciente,
    COUNT(e.id_exame) as total_exames,
    MAX(e.data_exame) as ultimo_exame,
    SUM(CASE WHEN e.resultado IS NULL THEN 1 ELSE 0 END) as exames_pendentes -- Soma 1 toda vez que o resultado do exame estiver null
FROM paciente p
LEFT JOIN exame e ON p.id_paciente = e.id_paciente
GROUP BY p.id_paciente, p.nome
HAVING COUNT(e.id_exame) > 0
ORDER BY ultimo_exame DESC;
-- Uso:
SELECT * FROM vw_exames_por_paciente WHERE exames_pendentes > 0;

-- Busca todo o histórico do paciente
CREATE OR REPLACE VIEW vw_historico_paciente AS
SELECT 
    h.id_historico,
    h.data_registro,
    p.nome as paciente,
    p.documento,
    m.nome as medico,
    e.nome as especialidade,
    h.diagnostico,
    h.tratamento
FROM historico_medico h
JOIN paciente p ON h.id_paciente = p.id_paciente
JOIN medico m ON h.id_medico = m.id_medico
JOIN especialidade e ON m.id_especialidade = e.id_especialidade
ORDER BY h.data_registro DESC;
-- Uso:
SELECT * FROM vw_historico_paciente WHERE id_paciente = 1;


-- Busca todos os atendimentos realizados pelo medico
CREATE OR REPLACE VIEW vw_atendimentos_por_medico AS
SELECT 
    m.id_medico,
    m.nome as medico,
    e.nome as especialidade,
    COUNT(a.id_agendamento) as total_atendimentos,
    SUM(CASE WHEN a.status = 'Realizado' THEN 1 ELSE 0 END) as realizados,
    SUM(CASE WHEN a.status = 'Agendado' THEN 1 ELSE 0 END) as agendados,
    SUM(CASE WHEN a.status = 'Cancelado' THEN 1 ELSE 0 END) as cancelados
FROM medico m
JOIN especialidade e ON m.id_especialidade = e.id_especialidade
LEFT JOIN agendamento a ON m.id_medico = a.id_medico
GROUP BY m.id_medico, m.nome, e.nome
ORDER BY total_atendimentos DESC;

-- Uso:
SELECT * FROM vw_atendimentos_por_medico;