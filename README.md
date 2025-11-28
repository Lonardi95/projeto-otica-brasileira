#  Projeto de Banco de Dados - Ótica Brasileira

Este repositório contém os scripts SQL e a documentação do projeto de banco de dados desenvolvido para o sistema de gestão da "Ótica Brasileira". O projeto faz parte da disciplina de Modelagem de Banco de Dados.

## Descrição do Projeto

O sistema visa informatizar o fluxo de atendimento de uma ótica, gerenciando clientes, receitas médicas, estoque de produtos e ordens de serviço com laboratórios. O foco é garantir a integridade dos dados e agilizar o processo de venda e entrega.

## Estrutura do Repositório

* `script_otica.sql`: Arquivo principal contendo:
    * **DDL:** Comandos para criação do banco de dados e tabelas.
    * **DML:** Scripts de inserção de dados fictícios para teste.
    * **Queries:** Exemplos de consultas (SELECT) com JOINs e filtros.
    * **Manipulação:** Exemplos de comandos UPDATE e DELETE.
* `Modelo_Logico.png`: (Opcional) Imagem do Diagrama Entidade-Relacionamento.

## Como Executar

1.  Certifique-se de ter um SGBD instalado (MySQL Workbench, MariaDB ou compatível).
2.  Abra o arquivo `script_otica.sql` na sua ferramenta de banco de dados.
3.  Execute o script completo ou por blocos (selecione o trecho e execute).
4.  Verifique a saída no console para confirmar a criação das tabelas e a inserção dos dados.

## Exemplos de Consultas Incluídas

O script inclui consultas para:
* Listar vendas detalhadas com nomes de clientes e vendedores.
* Verificar produtos com estoque crítico.
* Acompanhar status de Ordens de Serviço.

## 👤 Autor

Augusto Lonardi
