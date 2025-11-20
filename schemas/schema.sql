Table paciente {
id_paciente int [pk, increment]
nome varchar(200)
data_nascimento dat
sexo varchar(20)
rua varchar(200)
numero varchar(50)
bairro varchar(100)
cidade varchar(100)
cep varchar(20)
email varchar(150)
documento varchar(50) [unique]
}

Table departamento {
id_departamento int [pk, increment]
nome varchar(150)
descricao text
}

Table especialidade {
id_especialidade int [pk, increment]
nome varchar(150)
descricao text
}

Table medico {
id_medico int [pk, increment]
nome varchar(200)
crm varchar(50) [unique]
id_especialidade int [ref: > especialidade.id_especialidade]
email varchar(150)
id_departamento int [ref: > departamento.id_departamento]
}

Table enfermeiro {
id_enfermeiro int [pk, increment]
nome varchar(200)
coren varchar(50) [unique]
email varchar(150)
id_departamento int [ref: > departamento.id_departamento]
}

Table leito {
id_leito int [pk, increment]
numero varchar(50)
unidade varchar(100)
tipo varchar(50)
status varchar(50)
}

Table procedimento {
id_procedimento int [pk, increment]
codigo varchar(50)
nome varchar(200)
descricao text
custo_base decimal(12,2)
}

Table tipo_agendamento {
id_tipo int [pk, increment]
nome varchar(100)
descricao text
}

Table agendamento {
id_agendamento int [pk, increment]
data_hora datetime
id_tipo int [ref: > tipo_agendamento.id_tipo]
status varchar(50) # agendado, realizado, cancelado
id_paciente int [ref: > paciente.id_paciente]
id_medico int [ref: - medico.id_medico]
id_leito int [ref: - leito.id_leito]
observacao text
}

Table agendamento_procedimento {
id int [pk, increment]
id_agendamento int [ref: > agendamento.id_agendamento]
id_procedimento int [ref: > procedimento.id_procedimento]
quantidade int
observacao text
}

Table internacao {
id_internacao int [pk, increment]
id_paciente int [ref: > paciente.id_paciente]
id_leito int [ref: > leito.id_leito]
data_entrada datetime
data_saida datetime [null]
motivo text
}

Table faturamento {
id_fatura int [pk, increment]
id_paciente int [ref: > paciente.id_paciente]
data_emissao date
valor_total decimal(12,2)
status_pagamento varchar(50)
}

Table fatura_item {
id_item int [pk, increment]
id_fatura int [ref: > faturamento.id_fatura]
tipo_item varchar(50)
ref_id int
quantidade int
valor_unitario decimal(12,2)
valor_total decimal(12,2)
}

Table historico_medico {
id_historico int [pk, increment]
id_paciente int [ref: > paciente.id_paciente]
id_medico int [ref: > medico.id_medico]
diagnostico text
tratamento text
data_registro date
}

Table laboratorio {
id_lab int [pk, increment]
nome varchar(150)
responsavel varchar(150)
}

Table tipo_exame {
  id_tipo_exame int [pk, increment]
  codigo     varchar(150)
  nome       varchar(200)
  descricao  varchar(150)
  custo_base decimal(12,2)
  id_lab      int [ref: > laboratorio.id_lab] 

}

Table exame {
id_exame int [pk, increment]
id_paciente int [ref: > paciente.id_paciente]
id_lab int [ref: > laboratorio.id_lab]
data_exame date
tipo [ref: > tipo_exame.id_tipo_exame]
resultado text
} 