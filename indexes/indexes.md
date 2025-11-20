# Índices
Índices ajudam o banco de dados a percorrer menos colunas quando executar alguma consulta, otimizando drasticamente o desempenho e eficência do banco.

## Índices Disponíveis
Índices disponíveis agrupados e separados por tabela

### PACIENTE
* ```idx_paciente_documento```
* ```idx_paciente_nome```

### MEDICO
* ```idx_medico_crm```
* ```idx_medico_departamento```

### ENFERMEIRO
* ```idx_enfermeiro_coren```
* ```idx_enfermeiro_departamento```

### AGENDAMENTO
* ```idx_agendamento_paciente```
* ```idx_agendamento_medico```
* ```idx_agendamento_data_hora```
* ```idx_agendamento_status```
* ```idx_agendamento_paciente_status```
* ```idx_agendamento_leito```

### AGENDAMENTO_PROCEDIMENTO
* ```idx_agend_procedimento_agendamento```
* ```idx_agend_procedimento_procedimento```

### INTERNACAO
* ```idx_internacao_paciente```
* ```idx_internacao_leito```
* ```idx_internacao_ativa```

### LEITO
* ```idx_leito_status```
* ```idx_leito_unidade```
* ```idx_leito_tipo```
* ```idx_leito_status_tipo```

### EXAME
* ```idx_exame_paciente```
* ```idx_exame_laboratorio```

### TIPO_EXAME
* ```idx_tipo_exame_codigo```
* ```idx_tipo_exame_lab```

### PROCEDIMENTO
* ```idx_procedimento_codigo```
* ```idx_procedimento_nome```

### FATURAMENTO
* ```idx_faturamento_paciente```
* ```idx_faturamento_status```

### FATURA_ITEM
* ```idx_fatura_item_fatura```
* ```idx_fatura_item_tipo```

### HISTORICO_MEDICO
* ```idx_historico_paciente```
* ```idx_historico_medico```

### LABORATORIO
* ```idx_laboratorio_nome```

### DEPARTAMENTO
* ```idx_departamento_nome```

### ESPECIALIDADE
* ```idx_especialidade_nome```

### TIPO_AGENDAMENTO
* ```idx_tipo_agendamento_nome```
