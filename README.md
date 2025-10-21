# 🔧 Sistema de Gestão para Oficina Mecânica

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?logo=postgresql&logoColor=white)](https://www.postgresql.org/)

> Sistema completo de banco de dados para gerenciamento de oficinas mecânicas, incluindo controle de clientes, veículos, serviços, peças, mecânicos e ordens de serviço.

## 📋 Sobre o Projeto

Este projeto fornece uma estrutura completa de banco de dados PostgreSQL para gestão de oficinas mecânicas, permitindo controle detalhado de todas as operações, desde o cadastro de clientes até análises financeiras e de performance.

## ✨ Funcionalidades

- **Gestão de Clientes**: Cadastro de pessoas físicas e jurídicas
- **Controle de Veículos**: Registro completo de veículos dos clientes
- **Ordens de Serviço**: Gerenciamento completo do fluxo de trabalho
- **Estoque de Peças**: Controle de estoque com alertas de reposição
- **Catálogo de Serviços**: Serviços padronizados com preços e tempos estimados
- **Gestão de Mecânicos**: Controle de equipe e especialidades
- **Fornecedores**: Cadastro de fornecedores de peças
- **Análises e Relatórios**: Queries prontas para análises gerenciais

## 🗂️ Estrutura do Banco de Dados

### Tabelas Principais

- **CLIENTE**: Clientes PF e PJ
- **VEICULO**: Veículos dos clientes
- **MECANICO**: Equipe de mecânicos
- **FORNECEDOR**: Fornecedores de peças
- **PECA**: Catálogo de peças
- **SERVICO**: Catálogo de serviços
- **ORDEM_SERVICO**: Ordens de serviço
- **ORDEM_SERVICO_PECA**: Relação peças x ordem
- **ORDEM_SERVICO_SERVICO**: Relação serviços x ordem

### Diagrama de Relacionamentos

```
CLIENTE (1) ──── (N) VEICULO (1) ──── (N) ORDEM_SERVICO (N) ──── (1) MECANICO
                                              │
                                              ├──── (N) ORDEM_SERVICO_PECA (N) ──── (1) PECA (N) ──── (1) FORNECEDOR
                                              │
                                              └──── (N) ORDEM_SERVICO_SERVICO (N) ──── (1) SERVICO
```

## 🚀 Como Usar

### Pré-requisitos

- PostgreSQL 12 ou superior
- Cliente PostgreSQL (psql, pgAdmin, DBeaver, etc.)

### Instalação

1. **Clone o repositório**
```bash
git clone https://github.com/Otavio2007/nome-do-repo.git
cd nome-do-repo
```

2. **Crie o banco de dados**
```sql
CREATE DATABASE oficina_mecanica;
\c oficina_mecanica
```

3. **Execute os scripts de schema** (na ordem)
```bash
# Execute os scripts em database/schema/ na seguinte ordem:
psql -d oficina_mecanica -f database/schema/tableCliente.sql
psql -d oficina_mecanica -f database/schema/tableVeiculo.sql
psql -d oficina_mecanica -f database/schema/tableMecanico.sql
psql -d oficina_mecanica -f database/schema/tabelaFornecedor.sql
psql -d oficina_mecanica -f database/schema/tablePeca.sql
psql -d oficina_mecanica -f database/schema/tableServico.sql
psql -d oficina_mecanica -f database/schema/tableOrdem_Servico.sql
psql -d oficina_mecanica -f database/schema/tableOrdem_Servico_Peca.sql
psql -d oficina_mecanica -f database/schema/tableOrdem_Servico_Servico.sql
```

4. **Popule com dados de exemplo**
```bash
# Execute os scripts em database/data/
psql -d oficina_mecanica -f database/data/insertClientes.sql
psql -d oficina_mecanica -f database/data/insertVeiculo.sql
psql -d oficina_mecanica -f database/data/insertMecanico.sql
psql -d oficina_mecanica -f database/data/insertFornecedor.sql
psql -d oficina_mecanica -f database/data/insertPeca.sql
psql -d oficina_mecanica -f database/data/insertServico.sql
psql -d oficina_mecanica -f database/data/insertOrdem_Servico.sql
psql -d oficina_mecanica -f database/data/insertOrdem_Servico_Peca.sql
psql -d oficina_mecanica -f database/data/insertOrdem_Servico_Servico.sql
```

5. **Crie views, functions e triggers** (opcional)
```bash
psql -d oficina_mecanica -f database/queries/analysis19.sql
psql -d oficina_mecanica -f database/queries/analysis20.sql
psql -d oficina_mecanica -f database/queries/analysis21.sql
```

## 📊 Queries de Análise Disponíveis

O projeto inclui diversas queries prontas para análises gerenciais:

### Análises Básicas
- `analysis-1.sql`: Lista de clientes
- `analysis2.sql`: Veículos com proprietários
- `analysis3.sql`: Ordens em andamento
- `analysis4.sql`: Estoque baixo de peças

### Análises Avançadas
- `analysis10.sql`: Mecânicos com faturamento acima de R$ 1000
- `analysis11.sql`: Relatório completo de ordens de serviço
- `analysis12.sql`: Ranking de clientes por valor gasto
- `analysis13.sql`: Performance dos mecânicos
- `analysis14.sql`: Análise de peças por fornecedor
- `analysis15.sql`: Sazonalidade de serviços
- `analysis16.sql`: Rentabilidade por tipo de serviço
- `analysis17.sql`: Perfil de consumo PF vs PJ
- `analysis18.sql`: Análise ABC de peças

### Views Gerenciais
- `vw_resumo_clientes`: Resumo consolidado de clientes
- `vw_dashboard_mecanicos`: Dashboard de performance
- `vw_estoque_critico`: Alerta de estoque baixo

### Functions e Procedures
- `CalcularValorOrdem()`: Calcula valor total de uma ordem
- `RelatorioMensalFaturamento()`: Relatório mensal detalhado

### Triggers Automáticos
- Atualização automática de estoque
- Cálculo automático de valor total das ordens

## 💡 Exemplos de Uso

### Consultar ordens em andamento
```sql
SELECT * FROM ORDEM_SERVICO WHERE status = 'EM_ANDAMENTO';
```

### Ver estoque crítico
```sql
SELECT * FROM vw_estoque_critico;
```

### Calcular valor de uma ordem
```sql
SELECT * FROM CalcularValorOrdem(1);
```

### Relatório mensal
```sql
SELECT * FROM RelatorioMensalFaturamento(2024, 2);
```

## 🔐 Segurança

- CPF e CNPJ têm constraints de unicidade
- Status de ordens validados via CHECK constraints
- Relacionamentos garantidos via Foreign Keys
- Timestamps automáticos em todas as tabelas


## 🤝 Contribuindo

Contribuições são bem-vindas! Sinta-se à vontade para:

1. Fazer fork do projeto
2. Criar uma branch para sua feature (`git checkout -b feature/NovaFuncionalidade`)
3. Commit suas mudanças (`git commit -m 'Adiciona nova funcionalidade'`)
4. Push para a branch (`git push origin feature/NovaFuncionalidade`)
5. Abrir um Pull Request

## 📝 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 👤 Autor

**Otavio2007**

- GitHub: [@Otavio2007](https://github.com/Otavio2007)

## 📞 Suporte

Se você tiver alguma dúvida ou sugestão, sinta-se à vontade para abrir uma issue no GitHub.

---

⭐ Se este projeto foi útil para você, considere dar uma estrela no repositório!
