# 🎥 Projeto SGV - Sistema de Gerenciamento de Vídeos  
**Melhores Compras LTDA**

![Projeto](https://img.shields.io/badge/projeto-finalizado-blue)

---

## Visão Geral do Projeto

Este repositório contém o desenvolvimento completo do **Sistema de Gerenciamento de Vídeos (SGV)** da empresa **Melhores Compras LTDA**. O projeto foi desenvolvido em fases (Sprints), abordando desde a **modelagem de dados** até a **implementação de lógica de negócio com Python** e **armazenamento em JSON**.

O objetivo do SGV é fornecer uma solução robusta para:

- Gerenciamento de conteúdo de vídeo;
- Registro de visualizações;
- Apoio a decisões estratégicas com base em dados (data-driven).

---

## Tecnologias Utilizadas

- **Banco de Dados:** Oracle SQL / SGBD Oracle  
- **Modelagem:** Oracle Data Modeler  
- **Linguagem:** Python (com uso de função Lambda e tratamento de exceções)  
- **Formato de Dados:** JSON  
- **Conceitos Aplicados:** DML, DQL, Metodologia Ágil e ESG (Sustentabilidade)

---

## 📁 Estrutura do Repositório (Organizado por Fases)

### 📂 Fase 01 — Modelagem de Dados (Camada de Persistência)

> Estruturação inicial do banco de dados, correção de inconsistências e elaboração dos diagramas.

| Arquivo | Descrição |
|--------|-----------|
| `Melhores_Compras_MER_Logico.pdf` | Diagrama MER Lógico |
| `Melhores_Compras_MER_Fisico.pdf` | Diagrama MER Físico |
| `Script_DDL_Melhores_Compras.sql` | Script DDL para criação das tabelas no Oracle |
| `Codigo_Nivel_Atendimento_SAC_Melhores_Compras.py` | Script Python para análise do atendimento SAC |
| `Documentação da Fase` | Evidências de testes, prints e validações |

---

### 📂 Fase 02 — Start Data Management (Implementação e Manipulação)

> Aplicação prática dos dados, scripts de manipulação e lógica de negócio.

| Arquivo | Descrição |
|--------|-----------|
| `1_2_comandos_DML.sql` | Script com comandos `INSERT`, `UPDATE`, `DELETE`, `COMMIT` e testes de integridade |
| `1_3_comandos_DQL.sql` | Consultas SQL (`SELECT`) para extração de dados relevantes |
| `1_4_algoritmo_produto.py` | Algoritmo Python com cadastro de produtos e cálculo de ICMS |
| `1_5_arquivo_produto.json` | Arquivo JSON gerado com os produtos cadastrados |
| `1_6_ProgramaSustentabilidade.docx` | Documento com planejamento ESG (foco ambiental) |

---

## Destaques da Fase 02

### Comandos DML & Testes de Integridade

- Uso adequado de `TO_DATE`, `SEQUENCE/IDENTITY`;
- Simulação de erro de integridade:
  - **Login duplicado** (violação de UNIQUE);
  - **Tentativa de DELETE** em entidade com dependência (FOREIGN KEY).

---

### Algoritmo Python (`1_4_algoritmo_produto.py`)

O script Python desenvolvido para cadastro de produtos foi implementado com atenção à usabilidade, cálculos tributários e robustez no tratamento de erros.

#### Funcionalidades Implementadas:

- **Lista de produtos** (`produtos = []`) usada para armazenar dinamicamente os cadastros.
- **Função Lambda** para cálculo de ICMS (18% sobre o valor do produto).
- **Laço principal `while True`** para permitir o cadastro contínuo de múltiplos produtos.
- **Geração de JSON** automático após o cadastro de 5 ou mais produtos (`1_5_arquivo_produto.json`).

#### Tratamentos de Erro e Validações:

- ✅ **Descrição do produto**
  - Remove espaços em branco e formata para capitalização.
  - **Validação obrigatória:** impede cadastro com campo vazio.

- ✅ **Valor do produto**
  - Conversão para `float`, com tratamento de erro `ValueError` caso o input não seja numérico.
  - **Validação de valor positivo:** rejeita valores zero ou negativos com mensagem personalizada.

- ✅ **Tipo de embalagem**
  - Remove espaços e capitaliza.
  - **Validação obrigatória:** impede campo vazio.

- ✅ **Confirmação de continuidade**
  - Aceita apenas 's' ou 'n' como resposta válida.
  - **Loop de validação:** impede que o usuário continue com entradas inválidas.

- ✅ **Validação de quantidade mínima para gerar JSON**
  - Gera o arquivo `.json` **somente se** houver no mínimo **5 produtos cadastrados**.
  - Caso contrário, exibe mensagem de aviso personalizada.

- ✅ **Tratamento de exceção ao salvar o arquivo JSON**
  - Envolvido em `try/except` para capturar e exibir falhas na escrita do arquivo.

#### Exemplo de estrutura gerada no JSON:

```json
[
    {
        "descrição_produto": "Banana Nanica",
        "valor_produto": 4.5,
        "tipo_embalagem": "Pacote",
        "valor_icms": 0.81
    },
]
```
O script oferece uma experiência interativa, segura e alinhada a boas práticas de programação em Python, com foco na confiabilidade e clareza para o usuário final.

---

### ESG - Sustentabilidade (Foco Ambiental)

Documento `1_6_ProgramaSustentabilidade.docx` aborda:

- **Diagnóstico:** Consumo energético de servidores e impactos logísticos;
- **Metas:** 
  - Redução de consumo;
  - Coleta seletiva;
  - TI Verde;
- **Iniciativas:**
  - Substituição de equipamentos por versões com selo **Energy Star**;
  - Descarte correto de **REEE** (Resíduos de Equipamentos Eletroeletrônicos);
- **Benefícios Esperados:** 
  - Redução de custos;
  - Menor pegada de carbono;
  - Alinhamento ao **ODS 12** da ONU.

---

### 📂 Fase 03 — Data Processing, Analytics e Governança (Fase Final)

> **Esta fase final** focou na consolidação dos dados de atendimento (SAC), processamento da lógica de negócio e geração de *insights* cruciais para a auditoria e análise de desempenho, cumprindo o requisito de **Governança de Dados**.

| Arquivo | Descrição |
|--------|-----------|
| `Codigo-Fonte-Bloco-Anonimo-Cursor.sql` | **Rotina de ETL/Classificação (PL/SQL)**. O bloco utiliza um **Cursor Explícito** para buscar dados de múltiplas tabelas (`SAC`, `Produto`, `Cliente`, `Estado`). Ele aplica **regras de negócio** para: <ul><li>Classificar o tipo de SAC (Sugestão, Dúvida, Elogio);</li><li>Calcular o lucro unitário do produto;</li><li>Inserir os dados transformados, incluindo o resumo final das transações (`COMMIT`), na tabela destino `MC_SGV_OCORRENCIA_SAC`.</li></ul>|
| `Codigo-Fonte-Consulta-DQL.sql` | **Consulta Analítica de Desempenho (DQL)**. Relaciona a contagem de atendimentos SAC realizados com as categorias de produtos (`mc_categoria_prod`), utilizando `LEFT JOIN` e `NVL` para garantir que todas as categorias (mesmo as sem SAC) sejam listadas. |

## Destaques da Fase 03

A implementação desta fase demonstra proficiência em:

* **Processamento de Dados em Lote:** Uso de **Cursor Explícito** (`OPEN`, `FETCH`, `CLOSE`, `EXIT WHEN %NOTFOUND`) para iterar e processar dados de milhões de registros de forma eficiente.
* **Lógica de Negócio em PL/SQL:** Aplicação de lógica condicional (`IF/ELSIF`) para classificar dados brutos em categorias de negócio específicas (ex: `S` para SUGESTÃO).
* **Controles de Governança:** Inserção de dados em uma tabela de *Data Mart* (`MC_SGV_OCORRENCIA_SAC`) e geração de resumo final, que servem como ponto de **auditoria e *Business Intelligence***.
* **Análise de Cobertura:** Uso de `LEFT JOIN` e `NVL(COUNT, 0)` na consulta DQL para fornecer uma visão completa do desempenho das categorias, prevenindo a omissão de categorias que nunca tiveram SACs.

---

## ▶️ Como Executar o Projeto

1. **Criar Banco de Dados (Fase 01):**
   - Execute o script `Script_DDL_Melhores_Compras.sql` no Oracle SQL Developer.

2. **Popular Dados (Fase 02):**
   - Execute `1_2_comandos_DML.sql` para inserir e testar dados.

3. **Realizar Consultas:**
   - Execute `1_3_comandos_DQL.sql` para obter insights do sistema.

4. **Executar Algoritmo Python:**
   - Execute `1_4_algoritmo_produto.py` com Python 3.x.
   - Após cadastrar no mínimo 5 produtos, será gerado o arquivo `1_5_arquivo_produto.json`.

---

## 📎 Referências

> As citações utilizadas no projeto foram baseadas em fontes confiáveis, como relatórios da ONU, artigos acadêmicos e documentos técnicos, relacionados a ESG, TI Verde e boas práticas em banco de dados e programação.

---

## ✅ Status do Projeto

> ✅ **Concluído** — Todas as entregas das fases 01, 02 e 03 foram finalizadas com sucesso, incluindo a documentação, testes, scripts e lógica de negócio.
