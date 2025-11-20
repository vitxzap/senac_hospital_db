-- Processar alta do paciente usando a procedure
BEGIN
    processar_alta(p_id_internacao => 1);
END;
/

-- Verificar status do leito após alta (trigger trg_leito_disponivel foi acionado)
SELECT * FROM vw_status_leitos WHERE id_leito = 1;

-- Gerar fatura da internação usando a procedure
BEGIN
    gerar_fatura_internacao(p_id_internacao => 1);
END;
/

-- Adicionar procedimento à fatura existente
INSERT INTO fatura_item (id_fatura, tipo_item, ref_id, quantidade, valor_unitario)
VALUES (2, 'Procedimento', 1, 1, 3500.00);

COMMIT;

-- Consultar fatura detalhada através da view
SELECT * FROM vw_faturas_detalhadas WHERE paciente = 'João Pedro Almeida';

-- Consultar faturas pendentes através da view
SELECT * FROM vw_faturas_pendentes WHERE paciente = 'João Pedro Almeida';

-- Consultar total por fatura
SELECT 
    id_fatura,
    data_emissao,
    valor_total,
    status_pagamento
FROM faturamento
WHERE id_paciente = 1
ORDER BY data_emissao;

-- Consultar atendimentos do médico através da view
SELECT * FROM vw_atendimentos_por_medico WHERE id_medico = 1;

-- Resumo final do paciente
SELECT 
    p.nome,
    p.documento,
    calcular_idade(p.id_paciente) as idade,
    COUNT(DISTINCT a.id_agendamento) as total_agendamentos,
    COUNT(DISTINCT e.id_exame) as total_exames,
    COUNT(DISTINCT i.id_internacao) as total_internacoes,
    SUM(f.valor_total) as valor_total_faturas
FROM paciente p
LEFT JOIN agendamento a ON p.id_paciente = a.id_paciente
LEFT JOIN exame e ON p.id_paciente = e.id_paciente
LEFT JOIN internacao i ON p.id_paciente = i.id_paciente
LEFT JOIN faturamento f ON p.id_paciente = f.id_paciente
WHERE p.id_paciente = 1
GROUP BY p.nome, p.documento, p.id_paciente;