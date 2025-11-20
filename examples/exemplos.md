# Exemplos de uso
Exemplos de como usar funções, procedures, packages e muito mais do sistema.

## Faturamento Completo
Para ver um exemplo de faturamento completo, abra ```exemplo_faturamento.sql```

## Agendamento de internação
Para ver um exemplo de um agendamento de internação, abra  ```exemplo_agendamento_internacao.sql```

## Outros exemplos (não todos possíveis)

### Calcular idade por meio de função
```SQL
SELECT nome, calcular_idade(id_paciente) as idade FROM paciente;
```

### Registrar internação por meio da procedure
```SQL
BEGIN
    registrar_internacao(1, 4, 'Pneumonia grave');
END;
```

### Criar agendamento por meio do package
```SQL
BEGIN
    pkg_hospital.criar_agendamento(2, 1, TIMESTAMP '2025-11-25 19:00:00', 1, 'Consulta de rotina');
END;
```


### Verificar disponibilidade do médico
```SQL
SELECT medico_disponivel(1, SYSTIMESTAMP + INTERVAL '1' DAY) as medico_disponivel FROM DUAL;
```

### Consultar médicos disponíveis através da view
```SQL
SELECT * FROM vw_medicos_completo WHERE id_medico = 1; 
-- Usando * pois a view cuida dos campos retornados (Não surte Afonso, por favor) :))
```

### Consultar leitos disponíveis através da view
```SQL
SELECT * FROM vw_status_leitos WHERE status = 'Disponível'; 
-- Usando * pois a view cuida dos campos retornados (Não surte Afonso, por favor) :))
```

### Inserir exame (trigger faturar_exame criará fatura automaticamente)
```SQL
INSERT INTO exame (id_paciente, id_lab, data_exame, valor, id_tipo_exame, resultado)
VALUES (1, 1, SYSDATE, 150.00, 1, 'Ritmo sinusal normal, sem alterações significativas');
```

