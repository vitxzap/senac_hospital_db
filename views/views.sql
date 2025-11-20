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
SELECT * FROM vw_faturas_pendentes WHERE dias_em_aberto > 30 AND id_paciente = 1; 


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