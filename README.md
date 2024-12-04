# RentaCar - Sistema de Locação de Veículos


## Descrição
O RentaCar é um banco de dados relacional projetado para gerenciar operações de locação de veículos. O sistema abrange cadastro de clientes, gerenciamento de veículos, registro de aluguéis e pagamentos, além de consultas SQL para relatórios e análises. O projeto aplica as melhores práticas de modelagem de dados e normalização até a 3ª Forma Normal (3FN). Foi feito como projeto final da disciplina Banco de Dados (CC0025).

--- 

## Estrutura do Projeto

- **`cidades`**: Armazena as cidades onde os clientes e funcionários residem.
- **`clientes`**: Registra informações pessoais dos clientes, como CPF, email e cidade.
- **`cliente_telefone`**: Permite o registro de múltiplos números de telefone por cliente.
- **`funcionarios`**: Contém dados dos funcionários responsáveis pelos aluguéis.
- **`veiculos`**: Armazena informações sobre os veículos, incluindo disponibilidade.
- **`aluguéis`**: Registra detalhes das locações realizadas pelos clientes.
- **`pagamentos`**: Armazena os pagamentos realizados pelos clientes.

---

## Requisitos Atendidos
- **Normalização:** Todas as tabelas foram normalizadas até a **3ª Forma Normal (3FN)** para evitar redundâncias e garantir a integridade dos dados.
- **Relacionamentos:** As tabelas estão conectadas por chaves estrangeiras para manter a integridade referencial.
- **Consultas SQL:** Incluem seleção, funções agregadas e subconsultas.
- **Dados Fictícios:** O banco contém dados fictícios para simulação e testes.

---

## Funcionalidades
- **Cadastro de Clientes:** Inclui informações como nome, CPF, email e cidade.
- **Gerenciamento de Veículos:** Registra modelo, marca, ano, categoria e status de disponibilidade.
- **Registro de Aluguéis:** Detalhes sobre cliente, veículo, período de locação, valor total e funcionário responsável.
- **Pagamentos:** Registra valores pagos, datas e métodos de pagamento.
- **Relatórios:** Geração de relatórios sobre veículos disponíveis, receitas por veículo e histórico de locações.

---

