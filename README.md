# 📊 Desafio de Projeto: Nível de Atendimento ao Cliente - Melhores Compras LTDA

Este repositório contém a solução desenvolvida para o desafio de projeto do bootcamp **Imersão no Universo dos Dados** (FIAP).  
O projeto consiste na criação de uma camada de persistência de dados para uma nova funcionalidade da empresa de e-commerce **Melhores Compras LTDA**.

---

## 🎯 Objetivo
O objetivo principal foi **modelar e implementar um banco de dados relacional** para suportar uma nova funcionalidade na plataforma de e-commerce.  
Essa funcionalidade permite:

- Armazenamento de dados de vídeos de produtos;  
- Registro de informações de visualização;  
- Registro de sugestões e dúvidas dos clientes sobre os produtos.  

A solução foca na **persistência de dados**, sendo o primeiro passo para a transformação digital da empresa.  

No estudo de caso, o projeto anterior já existia, mas apresentava **diversas inconsistências e quebras de boas práticas** na modelagem.  
Diante disso, fomos **“contratados” para corrigir e aprimorar** essa estrutura, garantindo a integridade do banco e implementando as novas funcionalidades solicitadas.  

---

## 💻 Tecnologias Utilizadas
- **Oracle Data Modeler** → Modelagem do banco de dados (Modelos Entidade-Relacionamento Lógico e Físico).  
- **Oracle SQL Developer** → Criação e manipulação do banco de dados.  
- **JupyterLab (Python)** → Desenvolvimento da lógica de negócio e validação dos dados (análise do nível de atendimento do SAC).  

---

## 📁 Estrutura do Projeto
O repositório está organizado da seguinte forma:

- **Melhores_Compras_MER_Logico.pdf** → Diagrama do Modelo Entidade-Relacionamento (MER) Lógico.  
- **Melhores_Compras_MER_Fisico.pdf** → Diagrama do Modelo Entidade-Relacionamento (MER) Físico.  
- **Script_DDL_Melhores_Compras.sql** → Script DDL para criação das tabelas no banco de dados.  
- **Codigo_Nivel_Atendimento_SAC_Melhores_Compras.py** → Script em Python que analisa dados de atendimento e calcula o nível de satisfação do cliente com base no tempo de resposta.  
- **Evidencia_Teste_Melhores_Compras.pdf** → Evidências da criação das tabelas no banco de dados e consultas de teste.  
- **Evidencia_Teste_Nivel_Atendimento_SAC_Melhores_Compras.pdf** → Evidências da execução do script em Python e da validação da lógica de negócio.  

---

## 🚀 Como Executar o Projeto

### 1. Configuração do Banco de Dados
1. Certifique-se de ter o **Oracle SQL Developer** configurado.  
2. Execute o script **`Script_DDL_Melhores_Compras.sql`** para criar as tabelas.  

### 2. Execução do Script Python
1. Instale o **Python 3.x** e o **JupyterLab**, se ainda não tiver.  
2. Abra o arquivo **`Codigo_Nivel_Atendimento_SAC_Melhores_Compras.py`** no JupyterLab.  
3. Execute o script. Ele irá analisar os dados simulados de atendimento e exibir o nível de satisfação do cliente.  

---

### 🔹 Lógica de Negócio (Python)
O script implementa uma lógica simples:  

- Calcula com base de uma nota de 0 a 100, sendo 100 um atendimento de qualidade, e 0 de um atendimento insatisfatorio.
- Com base no tempo de resposta, atribui o **nível de atendimento**:

  ## 📝 Exemplo de Código em Python

```python
nota = int(input('(De 0 a 100)\nDigite a sua nota: '))

if nota >= 90 and nota <= 100:
    print(f"\nSua nota foi de {nota}\nRepresenta: \033[32mQualidade!\033[0m\nObrigado pela sua nota!")
elif nota >= 70 and nota <= 89:
    print(f"\nSua nota foi de {nota}\nRepresenta: \033[33mNeutro!\033[0m\nObrigado pela sua nota!")
elif nota >= 0 and nota < 70:
    print(f"\nSua nota foi de {nota}\nRepresenta: \033[31mInsatisfatório!\033[0m\nObrigado pela sua nota!")
else:
    print(f"\nA nota {nota} é \033[31minválida\033[0m.\nPor favor, digite um valor entre 0 e 100.")
```

Esse código em Python recebe uma nota entre 0 e 100 digitada pelo usuário e classifica o resultado em três categorias:

Qualidade (verde): notas entre 90 e 100.

Neutro (amarelo): notas entre 70 e 89.

Insatisfatório (vermelho): notas entre 0 e 69.

Caso o valor esteja fora do intervalo 0 a 100, é exibida uma mensagem de nota inválida.

As cores são exibidas no terminal utilizando códigos ANSI.
---

## ✨ Destaques do Projeto
- **Modelagem completa** → Inclui os modelos lógico e físico.  
- **Aplicação prática da regra de negócio** → Python utilizado para medir satisfação do cliente.  
- **Boas práticas** → Separação de responsabilidades:  
  - SQL para banco de dados.  
  - Python para lógica e análise.  

---
