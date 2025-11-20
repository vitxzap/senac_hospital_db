
-- Horários com mais agendamentos
SELECT 
    TO_CHAR(data_hora, 'HH24') || ':00' as horario, -- Extrai a hora 24h e junta com :00
    COUNT(*) as quantidade_agendamentos,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) as percentual
FROM agendamento
WHERE data_hora >= SYSDATE - 90
GROUP BY TO_CHAR(data_hora, 'HH24')  -- Converte para char para agrupar pela hora
ORDER BY TO_NUMBER(TO_CHAR(data_hora, 'HH24')); -- Converte para número para ordenar pela hora


-- 10 Médicos com mais atendimentos no mês
SELECT 
    ROWNUM as posicao,
    medico,
    especialidade,
    total_atendimentos,
    media_diaria
FROM (
    SELECT 
        m.nome as medico,
        e.nome as especialidade,
        COUNT(a.id_agendamento) as total_atendimentos, -- Calcula todos os agendamentos
        ROUND(COUNT(a.id_agendamento) / 30.0, 1) as media_diaria -- Calcula a média diária de agendamentos
    FROM medico m
    JOIN especialidade e ON m.id_especialidade = e.id_especialidade
    LEFT JOIN agendamento a ON m.id_medico = a.id_medico 
        AND a.status = 'Realizado'
        AND a.data_hora >= SYSDATE - 30
    GROUP BY m.nome, e.nome
    ORDER BY total_atendimentos DESC -- Ordena pelo total de agendamentos
)
WHERE ROWNUM <= 10;

-- Receita mensal e tipo de serviço
SELECT 
    TO_CHAR(f.data_emissao, 'MM/YYYY') as mes_ano,
    fi.tipo_item,
    COUNT(DISTINCT f.id_fatura) as quantidade_faturas, -- Calcula quantas faturas houveram
    SUM(fi.quantidade) as quantidade_itens, -- Soma todos os itens
    SUM(fi.valor_total) as receita_total, -- soma toda receita
    ROUND(AVG(fi.valor_unitario), 2) as ticket_medio -- Calcula valor médio com 2 casas decimais
FROM faturamento f
JOIN fatura_item fi ON f.id_fatura = fi.id_fatura
WHERE f.data_emissao >= ADD_MONTHS(SYSDATE, -6)
GROUP BY TO_CHAR(f.data_emissao, 'MM/YYYY'), fi.tipo_item
ORDER BY TO_DATE('01/' || mes_ano, 'DD/MM/YYYY') DESC, receita_total DESC;

-- Views dão suporte a estes relatórios.