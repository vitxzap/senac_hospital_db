# Esquemas
Encontre os esquemas de prototipação do projeto

## IDEF0
![IDEF0](/schemas/images/IDEF0.png)

## Diagrama ER

![Diagrama er](/schemas/images/er_diagram.png)

Caso prefira, abra o site [Mermaid Live](https://mermaid.live/) e cole o código de ```er_diagram.mmd``` para visualizar o diagrama conceitual.

> Por quê deste diagrama?

A escolha deste diagrama se basea na alta granulanidade de tabelas e fácil entendimento do contexto. Com tabelas bem definidas e de responsabilidade única, fica fácil de saber o que cada estrutura faz.

Um bom exemplo são tabelas como tipo_exame e fatura_item, que granulam e separam responsabiliades a mais que as tabelas principais lidariam de forma não otimizada, facilitando e evitando erros humanos na hora de cadastrar um novo exame de tipos diferentes ou adicionar um item na fatura já aberta.

## Relacionamento e tabelas
![Relacionamento](/schemas/images/tabelas.png)

 Caso prefira, abra o site [Database Diagram](https://databasediagram.com/app) e cole o código de ```schema.sql``` para visualizar e movimentar todas as tabelas.

 > Por quê deste relacionamento?
 
Tal relacionamento separa claramente as entidades principais (pacientes, médicos, enfermeiros, leitos, procedimentos) facilitando manutenção e escalabilidade. Também é capaz de evitar redundância de dados através de tabelas de referência, como item_exame.

O relacionamento também conta com uma ampla flexibilidade por meio de tabelas intermediárias, que abstraem a complexidade do sistema, abrindo portas para realizar consultas, cirurgias e exames de diversos tipos de forma mais simples.

Além disso, o esquema granula o sistema de faturamento e pagamento por meio de tabelas como faturamento e fatura_item, permitindo controle detalhado de custos por paciente, com itens genéricos (tipo_item e ref_id) que podem referenciar procedimentos, exames ou internações.
