-- Gerado por Oracle SQL Developer Data Modeler 24.3.1.351.0831
--   em:        2025-09-15 22:04:23 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g

DROP TABLE T_MC_BAIRRO CASCADE CONSTRAINTS 
;

DROP TABLE T_MC_CATEGORIA CASCADE CONSTRAINTS 
;

DROP TABLE T_MC_CIDADE CASCADE CONSTRAINTS 
;

DROP TABLE T_MC_CLIENTE CASCADE CONSTRAINTS 
;

DROP TABLE T_MC_CLIENTE_ENDERECO CASCADE CONSTRAINTS 
;

DROP TABLE T_MC_CLIENTE_PF CASCADE CONSTRAINTS 
;

DROP TABLE T_MC_CLIENTE_PJ CASCADE CONSTRAINTS 
;

DROP TABLE T_MC_DEPTO CASCADE CONSTRAINTS 
;

DROP TABLE T_MC_ESTADO CASCADE CONSTRAINTS 
;

DROP TABLE T_MC_FUNCIONARIO CASCADE CONSTRAINTS 
;

DROP TABLE T_MC_FUNCIONARIO_ENDERECO CASCADE CONSTRAINTS 
;

DROP TABLE T_MC_LOGRADOURO CASCADE CONSTRAINTS 
;

DROP TABLE T_MC_PRODUTO CASCADE CONSTRAINTS 
;

DROP TABLE T_MC_SAC CASCADE CONSTRAINTS 
;

DROP TABLE T_MC_VIDEO CASCADE CONSTRAINTS 
;

DROP TABLE T_MC_VISUALIZACAO CASCADE CONSTRAINTS 
;

DROP SEQUENCE SQ_MC_CATEGORIA;
DROP SEQUENCE SQ_MC_VIDEO;
DROP SEQUENCE SQ_MC_SGV_SAC;

CREATE SEQUENCE SQ_MC_CATEGORIA START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE SQ_MC_VIDEO START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE SQ_MC_SGV_SAC START WITH 1 INCREMENT BY 1;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE T_MC_BAIRRO 
    ( 
     cd_bairro NUMBER (8)  NOT NULL , 
     cd_cidade NUMBER (8)  NOT NULL , 
     nm_bairro VARCHAR2 (45)  NOT NULL 
    ) 
;

COMMENT ON TABLE T_MC_BAIRRO IS 'Armazena o cadastro de bairros. Cada bairro está obrigatoriamente vinculado a uma cidade da tabela T_MC_CIDADE.'
;

COMMENT ON COLUMN T_MC_BAIRRO.cd_bairro IS 'Chave Primária (PK) sequencial da tabela. É o identificador único e estável utilizado pelos logradouros para referência.' 
;

COMMENT ON COLUMN T_MC_BAIRRO.cd_cidade IS 'Codigo de numero unico para diferenciar diferentes tipos de região. Campo obrigatório' 
;

COMMENT ON COLUMN T_MC_BAIRRO.nm_bairro IS 'Nome oficial do bairro. Este campo, em conjunto com a chave estrangeira da cidade (id_cidade), forma uma Chave Única (UK) para evitar duplicidade.' 
;

ALTER TABLE T_MC_BAIRRO 
    ADD CONSTRAINT PK_MC_BAIRRO PRIMARY KEY ( cd_bairro ) ;

ALTER TABLE T_MC_BAIRRO 
    ADD CONSTRAINT UN_T_MC_BAIRRO_NOME_CIDADE UNIQUE ( nm_bairro , cd_cidade ) ;

CREATE TABLE T_MC_CATEGORIA 
    ( 
     cd_categoria        NUMBER (10)  NOT NULL , 
     nm_categoria        VARCHAR2 (50)  NOT NULL , 
     sg_categoria        VARCHAR2 (10) , 
     ds_categoria        VARCHAR2 (100)  NOT NULL , 
     tp_categoria        CHAR (1)  NOT NULL , 
     st_categoria        CHAR (1)  NOT NULL , 
     dt_inicio_categoria DATE  NOT NULL , 
     dt_fim_categoria    DATE 
    ) 
;

COMMENT ON COLUMN T_MC_CATEGORIA.cd_categoria IS 'Chave primária (PK) da tabela. Valor numérico gerado automaticamente via SEQUENCE ou IDENTITY crescente. Campo obrigatório (NOT NULL).' 
;

COMMENT ON COLUMN T_MC_CATEGORIA.nm_categoria IS 'Nome descritivo da categoria (ex: ''Eletronicos'', ''Tutorial''). Seu nome deve ser unico e é um campo obrigatório (NOT NULL).' 
;

COMMENT ON COLUMN T_MC_CATEGORIA.sg_categoria IS 'Armazena a sigla da categoria. O preenchimento é opcional (NULL), mas o valor, se informado, não pode ser repetido. ' 
;

COMMENT ON COLUMN T_MC_CATEGORIA.ds_categoria IS 'Breve descrição do que se trata a categoria apresentada. Seu preenchimento é obrigatório (NOT NULL).' 
;

COMMENT ON COLUMN T_MC_CATEGORIA.tp_categoria IS 'Indica o tipo da categoria: ''P'' para Produtos ou ''V'' para Vídeos. Necessario uma check constraint para validação. Campo obrigatório (NOT NULL).' 
;

COMMENT ON COLUMN T_MC_CATEGORIA.st_categoria IS 'Controla se a categoria está ativa na plataforma. Campo obrigatório (NOT NULL) que aceita os valores ''A'' (para Ativo) ou ''I'' (para Inativo). Necessario uma check constraint para validação. ' 
;

COMMENT ON COLUMN T_MC_CATEGORIA.dt_inicio_categoria IS 'Armazena a data em que a categoria se torna ativa na plataforma. Campo obrigatório (NOT NULL).' 
;

COMMENT ON COLUMN T_MC_CATEGORIA.dt_fim_categoria IS 'Armazena a data em que a categoria se torna inativa na plataforma. Campo opcional (NULL).' 
;

ALTER TABLE T_MC_CATEGORIA 
    ADD CONSTRAINT CK_MC_CATEGORIA 
    CHECK (tp_categoria IN('V', 'P'))
;


ALTER TABLE T_MC_CATEGORIA 
    ADD CONSTRAINT CK_MC_STATUS 
    CHECK (st_categoria IN('A', 'I'))
;


ALTER TABLE T_MC_CATEGORIA 
    ADD CONSTRAINT CK_DATA_FIM 
    CHECK (dt_fim_categoria > dt_inicio_categoria)
;
ALTER TABLE T_MC_CATEGORIA 
    ADD CONSTRAINT MC_CATEGORIA_PK PRIMARY KEY ( cd_categoria ) ;

ALTER TABLE T_MC_CATEGORIA 
    ADD CONSTRAINT UN_T_MC_CATEGORIA_NOME UNIQUE ( nm_categoria ) ;

ALTER TABLE T_MC_CATEGORIA 
    ADD CONSTRAINT UN_T_MC_CATEGORIA_SG UNIQUE ( sg_categoria ) ;

CREATE TABLE T_MC_CIDADE 
    ( 
     cd_cidade NUMBER (8)  NOT NULL , 
     sg_uf     CHAR (2)  NOT NULL , 
     nm_cidade VARCHAR2 (60)  NOT NULL 
    ) 
;

COMMENT ON TABLE T_MC_CIDADE IS 'Armazena o cadastro de cidades brasileiras. Cada cidade está obrigatoriamente vinculada a uma Unidade Federativa (UF) da tabela T_MC_ESTADO.'
;

COMMENT ON COLUMN T_MC_CIDADE.cd_cidade IS 'Chave Primária (PK) da tabela, identifica unicamente cada cidade. É populado via SEQUENCE (ex: SEQ_MC_CIDADE).' 
;

COMMENT ON COLUMN T_MC_CIDADE.sg_uf IS 'Campo que guarda a sigla do estado. Campo obrigatório' 
;

COMMENT ON COLUMN T_MC_CIDADE.nm_cidade IS 'Nome oficial da cidade. A combinação do nome da cidade com a sigla do estado (sg_uf) deve ser única.' 
;

ALTER TABLE T_MC_CIDADE 
    ADD CONSTRAINT PK_MC_CIDADE PRIMARY KEY ( cd_cidade ) ;

ALTER TABLE T_MC_CIDADE 
    ADD CONSTRAINT UN_T_MC_CIDADE_NOME_UF UNIQUE ( nm_cidade , sg_uf ) ;

CREATE TABLE T_MC_CLIENTE 
    ( 
     cd_cliente  NUMBER (10)  NOT NULL , 
     ds_email    VARCHAR2 (100)  NOT NULL , 
     ds_salt     VARCHAR2 (250)  NOT NULL , 
     ds_senha    VARCHAR2 (250)  NOT NULL , 
     tp_cliente  CHAR (1)  NOT NULL , 
     nr_telefone VARCHAR2 (20) 
    ) 
;

COMMENT ON TABLE T_MC_CLIENTE IS 'Entidade principal do cadastro de clientes, armazena dados comuns e de autenticação. Atua como super-tipo para as especializações T_MC_CLIENTE_PF e T_MC_CLIENTE_PJ.'
;

COMMENT ON COLUMN T_MC_CLIENTE.cd_cliente IS 'Chave primária da tabela, identifica unicamente cada cliente. É populado via SEQUENCE (ex: SEQ_MC_CLIENTE) para garantir a unicidade e a geração automática de novos códigos.' 
;

COMMENT ON COLUMN T_MC_CLIENTE.ds_email IS 'E-mail do cliente, utilizado para login na plataforma e como principal canal de comunicação. Possui uma constraint Única (UK) para impedir o cadastro de dois clientes com o mesmo e-mail.' 
;

COMMENT ON COLUMN T_MC_CLIENTE.ds_salt IS 'String aleatória (salt) única para cada usuário, utilizada para aumentar a segurança do hashing da senha, prevenindo ataques de rainbow table. O campo é Obrigatório (NOT NULL).' 
;

COMMENT ON COLUMN T_MC_CLIENTE.ds_senha IS 'Armazena o HASH da senha do cliente, gerado a partir da senha original combinada com o salt. Nunca deve conter a senha em texto plano. O campo é Obrigatório (NOT NULL).' 
;

COMMENT ON COLUMN T_MC_CLIENTE.tp_cliente IS 'Atributo discriminador que define o tipo de cliente. Deve conter uma CHECK constraint para aceitar apenas os valores ''F'' (Pessoa Física) ou ''J'' (Pessoa Jurídica).' 
;

COMMENT ON COLUMN T_MC_CLIENTE.nr_telefone IS 'Telefone de contato principal do cliente. Campo opcional no cadastro, mas pode ser exigido durante o processo de compra para fins de entrega.' 
;

ALTER TABLE T_MC_CLIENTE 
    ADD CONSTRAINT CK_MC_TIPO_CLIENTE 
    CHECK (tp_cliente IN ('F','J'))
;

ALTER TABLE T_MC_CLIENTE 
    ADD CONSTRAINT PK_MC_CLIENTE PRIMARY KEY ( cd_cliente ) ;

ALTER TABLE T_MC_CLIENTE 
    ADD CONSTRAINT UN_T_MC_CLIENTE_EMAIL UNIQUE ( ds_email ) ;

ALTER TABLE T_MC_CLIENTE 
    ADD CONSTRAINT UN_MC_DS_SALT UNIQUE ( ds_salt ) ;

CREATE TABLE T_MC_CLIENTE_ENDERECO 
    ( 
     cd_cliente     NUMBER (10)  NOT NULL , 
     id_endereco    NUMBER (10)  NOT NULL , 
     cd_logradouro  NUMBER (10)  NOT NULL , 
     nr_endereco    NUMBER (8)  NOT NULL , 
     tp_endereco    CHAR (1)  NOT NULL , 
     ds_complemento VARCHAR2 (80) 
    ) 
;

COMMENT ON TABLE T_MC_CLIENTE_ENDERECO IS 'Tabela associativa que armazena os endereços específicos de cada cliente, vinculando um registro de T_MC_CLIENTE a um logradouro em T_MC_LOGRADOURO.'
;

COMMENT ON COLUMN T_MC_CLIENTE_ENDERECO.cd_cliente IS 'Chave Estrangeira (FK) que referencia o cliente (T_MC_CLIENTE) ao qual este endereço pertence.' 
;

COMMENT ON COLUMN T_MC_CLIENTE_ENDERECO.id_endereco IS 'Chave Primária (PK) da tabela, identificando unicamente um endereço de um cliente.' 
;

COMMENT ON COLUMN T_MC_CLIENTE_ENDERECO.cd_logradouro IS 'Chave Estrangeira (FK) que referencia o logradouro (rua/CEP) do endereço.' 
;

COMMENT ON COLUMN T_MC_CLIENTE_ENDERECO.nr_endereco IS 'Número do imóvel no logradouro. Ex: "123", "S/N", "KM 15, Bloco A".' 
;

COMMENT ON COLUMN T_MC_CLIENTE_ENDERECO.tp_endereco IS 'Tipo do endereço, com CHECK constraint para aceitar ''E'' (Entrega) ou ''C'' (Cobrança), permitindo que o cliente tenha múltiplos endereços com finalidades diferentes.' 
;

COMMENT ON COLUMN T_MC_CLIENTE_ENDERECO.ds_complemento IS 'Complemento do endereço, como número do apartamento, bloco ou ponto de referência. Campo opcional.' 
;

ALTER TABLE T_MC_CLIENTE_ENDERECO 
    ADD CONSTRAINT PK_MC_END_CLI PRIMARY KEY ( cd_cliente, id_endereco ) ;

CREATE TABLE T_MC_CLIENTE_PF 
    ( 
     cd_cliente    NUMBER (10)  NOT NULL , 
     nr_cpf        CHAR (11)  NOT NULL , 
     nm_cliente    VARCHAR2 (30)  NOT NULL , 
     dt_nascimento DATE  NOT NULL 
    ) 
;

COMMENT ON TABLE T_MC_CLIENTE_PF IS 'Armazena os dados específicos de clientes do tipo Pessoa Física, complementando as informações da tabela T_MC_CLIENTE.'
;

COMMENT ON COLUMN T_MC_CLIENTE_PF.cd_cliente IS 'Constraint de Chave Primária (PK) para a tabela T_MC_CLIENTE_PF. Este identificador único também atua como Chave Estrangeira (FK), referenciando T_MC_CLIENTE.id_cliente, e estabelece o relacionamento identificador "é um" da estrutura de herança.' 
;

COMMENT ON COLUMN T_MC_CLIENTE_PF.nr_cpf IS 'Guarda o número do Cadastro de Pessoas Físicas (CPF). Este campo deve ter uma constraint Única (UK), ser Obrigatório (NOT NULL) e o valor deve ser armazenado sem formatação, contendo apenas os 11 dígitos.' 
;

COMMENT ON COLUMN T_MC_CLIENTE_PF.nm_cliente IS 'Armazena o nome civil completo do cliente pessoa física. Este campo é de preenchimento Obrigatório (NOT NULL) para a correta identificação do indivíduo.' 
;

COMMENT ON COLUMN T_MC_CLIENTE_PF.dt_nascimento IS 'Registra a data de nascimento do cliente. Esta informação é importante para segmentação de marketing e verificação de maioridade. O preenchimento do campo é Obrigatório (NOT NULL).' 
;

ALTER TABLE T_MC_CLIENTE_PF 
    ADD CONSTRAINT PK_T_MT_CLIENTE_PF PRIMARY KEY ( cd_cliente ) ;

ALTER TABLE T_MC_CLIENTE_PF 
    ADD CONSTRAINT UN_T_MT_CLIENTE_PF_CPF UNIQUE ( nr_cpf ) ;

CREATE TABLE T_MC_CLIENTE_PJ 
    ( 
     cd_cliente            NUMBER (10)  NOT NULL , 
     nr_cnpj               CHAR 
--  WARNING: CHAR size not specified 
                     NOT NULL , 
     ds_razao_social       VARCHAR2 (150)  NOT NULL , 
     nm_fantasia           VARCHAR2 (100) , 
     nr_inscricao_estadual VARCHAR2 (20) 
    ) 
;

COMMENT ON TABLE T_MC_CLIENTE_PJ IS 'Armazena os dados específicos de clientes do tipo Pessoa Jurídica, servindo como uma especialização (subtipo) da entidade T_MC_CLIENTE.'
;

COMMENT ON COLUMN T_MC_CLIENTE_PJ.cd_cliente IS 'Constraint de Chave Primária (PK) e Estrangeira (FK). Vincula o registro da pessoa jurídica ao cadastro principal de cliente em T_MC_CLIENTE, estabelecendo a relação de herança.' 
;

COMMENT ON COLUMN T_MC_CLIENTE_PJ.nr_cnpj IS 'Guarda o número do Cadastro Nacional da Pessoa Jurídica (CNPJ). É Obrigatório (NOT NULL) e Único (UK), armazenado sem formatação (apenas os 14 dígitos).' 
;

COMMENT ON COLUMN T_MC_CLIENTE_PJ.ds_razao_social IS 'Armazena o nome empresarial oficial da pessoa jurídica. É um campo Obrigatório (NOT NULL), pois é indispensável para fins fiscais e contratuais.' 
;

COMMENT ON COLUMN T_MC_CLIENTE_PJ.nm_fantasia IS 'Registra o nome comercial ou de marca da empresa. É um campo Opcional (NULL), pois nem toda empresa possui um nome fantasia distinto da sua razão social.' 
;

COMMENT ON COLUMN T_MC_CLIENTE_PJ.nr_inscricao_estadual IS 'Contém o número da Inscrição Estadual (IE) da empresa. É um campo Opcional (NULL), pois sua obrigatoriedade e existência dependem do ramo de atividade e da legislação estadual.' 
;

ALTER TABLE T_MC_CLIENTE_PJ 
    ADD CONSTRAINT PK_T_MC_CLIENTE_PJ PRIMARY KEY ( cd_cliente ) ;

ALTER TABLE T_MC_CLIENTE_PJ 
    ADD CONSTRAINT UN_T_MC_CLIENTE_PJ_CNPJ UNIQUE ( nr_cnpj ) ;

CREATE TABLE T_MC_DEPTO 
    ( 
     cd_departamento NUMBER (3)  NOT NULL , 
     nm_departamento VARCHAR2 (100)  NOT NULL , 
     st_departamento CHAR (1)  NOT NULL 
    ) 
;

COMMENT ON COLUMN T_MC_DEPTO.cd_departamento IS 'Esta coluna irá receber o codigo do departamento  e seu conteúdo é obrigatório.' 
;

COMMENT ON COLUMN T_MC_DEPTO.nm_departamento IS 'Esta coluna irá receber o nome do  departamento  e seu conteúdo é obrigatório.' 
;

COMMENT ON COLUMN T_MC_DEPTO.st_departamento IS 'Esta coluna irá receber o status do  departamento  e seu conteúdo é obrigatório. Os valores possíveis são: (A)tivo e (I)nativo.' 
;

ALTER TABLE T_MC_DEPTO 
    ADD CONSTRAINT CK_MC_STATUS_DEPTO 
    CHECK (st_departamento IN('A', 'I'))
;
ALTER TABLE T_MC_DEPTO 
    ADD CONSTRAINT PK_MC_DEPTO PRIMARY KEY ( cd_departamento ) ;

ALTER TABLE T_MC_DEPTO 
    ADD CONSTRAINT UN_MC_NOME_DEPTO UNIQUE ( nm_departamento ) ;

CREATE TABLE T_MC_ESTADO 
    ( 
     sg_uf     CHAR (2)  NOT NULL , 
     nm_estado VARCHAR2 (30)  NOT NULL 
    ) 
;

COMMENT ON TABLE T_MC_ESTADO IS 'Tabela de domínio que armazena as 27 Unidades Federativas do Brasil.'
;

COMMENT ON COLUMN T_MC_ESTADO.sg_uf IS 'Sigla da Unidade Federativa. É a Chave Primária (PK) natural da tabela, utilizando o padrão de 2 caracteres do IBGE.' 
;

COMMENT ON COLUMN T_MC_ESTADO.nm_estado IS 'Nome completo do estado. Possui uma constraint Única (UK) para garantir a não duplicidade.' 
;

ALTER TABLE T_MC_ESTADO 
    ADD CONSTRAINT PK_MC_ESTADO PRIMARY KEY ( sg_uf ) ;

ALTER TABLE T_MC_ESTADO 
    ADD CONSTRAINT UN_T_MC_ESTADO_NOME UNIQUE ( nm_estado ) ;

CREATE TABLE T_MC_FUNCIONARIO 
    ( 
     cd_funcionario  NUMBER (10)  NOT NULL , 
     cd_departamento NUMBER (3)  NOT NULL , 
     cd_funcionario1 NUMBER (10)  NOT NULL , 
     ds_email        VARCHAR2 (80)  NOT NULL , 
     nm_funcionario  VARCHAR2 (160)  NOT NULL , 
     dt_nascimento   DATE  NOT NULL , 
     ds_cargo        VARCHAR2 (80)  NOT NULL , 
     st_funcionario  CHAR (1)  NOT NULL , 
     dt_admissao     DATE  NOT NULL , 
     ds_genero       VARCHAR2 (100) , 
     dt_desligamento DATE , 
     vl_salario      NUMBER (10,2) 
    ) 
;

COMMENT ON TABLE T_MC_FUNCIONARIO IS 'Armazena os dados cadastrais dos funcionários da Melhores Compras. Inclui informações pessoais, de cargo e o relacionamento hierárquico (gestor).'
;

COMMENT ON COLUMN T_MC_FUNCIONARIO.cd_funcionario IS 'Chave Primária (PK) sequencial que identifica unicamente cada funcionário.' 
;

COMMENT ON COLUMN T_MC_FUNCIONARIO.cd_departamento IS 'Chave Estrangeira (FK) que indica o departamento do funcionário.' 
;

COMMENT ON COLUMN T_MC_FUNCIONARIO.cd_funcionario1 IS 'Chave Estrangeira (FK) auto-referenciada que aponta para o id_funcionario do gestor direto. Nulo para funcionários sem gestor direto (ex: Presidente).' 
;

COMMENT ON COLUMN T_MC_FUNCIONARIO.ds_email IS 'E-mail corporativo do funcionário. Possui uma constraint Única (UK).' 
;

COMMENT ON COLUMN T_MC_FUNCIONARIO.nm_funcionario IS 'Nome completo do funcionário. Obrigatório (NOT NULL).' 
;

COMMENT ON COLUMN T_MC_FUNCIONARIO.dt_nascimento IS 'Data de nascimento do funcionário. Obrigatório (NOT NULL).' 
;

COMMENT ON COLUMN T_MC_FUNCIONARIO.ds_cargo IS 'Descrição do cargo atual do funcionário. Obrigatório (NOT NULL).' 
;

COMMENT ON COLUMN T_MC_FUNCIONARIO.st_funcionario IS 'Status do funcionário. Deve conter uma CHECK constraint para aceitar apenas ''A'' (Ativo) ou ''I'' (Inativo).' 
;

COMMENT ON COLUMN T_MC_FUNCIONARIO.dt_admissao IS 'Data de início do contrato de trabalho do funcionário. Obrigatório (NOT NULL).' 
;

COMMENT ON COLUMN T_MC_FUNCIONARIO.ds_genero IS 'Gênero com o qual o funcionário se identifica. Campo opcional de texto livre.' 
;

COMMENT ON COLUMN T_MC_FUNCIONARIO.dt_desligamento IS 'Data de término do contrato de trabalho. Deve ser nulo para funcionários ativos. Opcional (NULL).' 
;

COMMENT ON COLUMN T_MC_FUNCIONARIO.vl_salario IS 'Valor do salário bruto do funcionário. Campo opcional.' 
;

ALTER TABLE T_MC_FUNCIONARIO 
    ADD CONSTRAINT CK_MC_DESLIGAMENTO 
    CHECK (dt_desligamento > dt_admissao)
;

ALTER TABLE T_MC_FUNCIONARIO 
    ADD CONSTRAINT PK_MC_FUNCIONARIO PRIMARY KEY ( cd_funcionario ) ;

ALTER TABLE T_MC_FUNCIONARIO 
    ADD CONSTRAINT UN_T_MC_FUNCIONARIO_EMAIL UNIQUE ( ds_email ) ;

CREATE TABLE T_MC_FUNCIONARIO_ENDERECO 
    ( 
     cd_funcionario_endereco NUMBER (10)  NOT NULL , 
     cd_funcionario          NUMBER (10)  NOT NULL , 
     cd_logradouro           NUMBER (10)  NOT NULL , 
     nr_endereco             VARCHAR2 (10)  NOT NULL , 
     ds_complemento          VARCHAR2 (80) 
    ) 
;

COMMENT ON TABLE T_MC_FUNCIONARIO_ENDERECO IS 'Tabela associativa que armazena o endereço residencial de cada funcionário.'
;

COMMENT ON COLUMN T_MC_FUNCIONARIO_ENDERECO.cd_funcionario_endereco IS 'Chave Primária (PK) sequencial para identificar unicamente o registro do endereço.' 
;

COMMENT ON COLUMN T_MC_FUNCIONARIO_ENDERECO.cd_funcionario IS 'Chave Estrangeira  (FK) sequencial que identifica unicamente cada funcionário.' 
;

COMMENT ON COLUMN T_MC_FUNCIONARIO_ENDERECO.cd_logradouro IS 'Chave Estrangeira (FK) que referencia o logradouro (rua/CEP) do endereço.' 
;

COMMENT ON COLUMN T_MC_FUNCIONARIO_ENDERECO.nr_endereco IS 'Número do imóvel no logradouro.' 
;

COMMENT ON COLUMN T_MC_FUNCIONARIO_ENDERECO.ds_complemento IS 'Complemento opcional do endereço (ex: Apto 502, Bloco A).' 
;

ALTER TABLE T_MC_FUNCIONARIO_ENDERECO 
    ADD CONSTRAINT PK_MC_END_FUNC PRIMARY KEY ( cd_funcionario_endereco ) ;

ALTER TABLE T_MC_FUNCIONARIO_ENDERECO 
    ADD CONSTRAINT UN_T_MC_FUNC_ENDERECO_FUNC UNIQUE ( cd_funcionario ) ;

CREATE TABLE T_MC_LOGRADOURO 
    ( 
     cd_logradouro NUMBER (10)  NOT NULL , 
     cd_bairro     NUMBER (8)  NOT NULL , 
     nr_cep        VARCHAR2 (8)  NOT NULL , 
     nm_logradouro VARCHAR2 (160)  NOT NULL 
    ) 
;

COMMENT ON TABLE T_MC_LOGRADOURO IS 'Armazena o cadastro de logradouros (ruas, avenidas, etc.). Cada logradouro está obrigatoriamente vinculado a um bairro da tabela T_MC_BAIRRO.'
;

COMMENT ON COLUMN T_MC_LOGRADOURO.cd_logradouro IS 'Chave Primária (PK) da tabela, identifica unicamente cada logradouro. É populado via SEQUENCE (ex: SEQ_MC_LOGRADOURO).' 
;

COMMENT ON COLUMN T_MC_LOGRADOURO.nr_cep IS 'Número do Código de Endereçamento Postal (CEP), armazenado com 8 dígitos, sem formatação. Possui uma constraint Única (UK) para evitar duplicidade.' 
;

COMMENT ON COLUMN T_MC_LOGRADOURO.nm_logradouro IS 'Nome oficial do logradouro (ex: "Avenida Ipiranga", "Rua da Praia").' 
;

ALTER TABLE T_MC_LOGRADOURO 
    ADD CONSTRAINT PK_MC_LOGRADOURO PRIMARY KEY ( cd_logradouro ) ;

ALTER TABLE T_MC_LOGRADOURO 
    ADD CONSTRAINT UN_T_MC_LOGRADOURO_CEP UNIQUE ( nr_cep , cd_bairro ) ;

CREATE TABLE T_MC_PRODUTO 
    ( 
     cd_produto               NUMBER (10)  NOT NULL , 
     cd_categoria             NUMBER (10)  NOT NULL , 
     ds_produto               VARCHAR2 (70)  NOT NULL , 
     ds_completa_produto      VARCHAR2 (4000)  NOT NULL , 
     vl_unitario_produto      NUMBER (8,2)  NOT NULL , 
     vl_total_imposto_produto NUMBER (10,2)  NOT NULL , 
     st_produto               CHAR (1)  NOT NULL , 
     dt_inicio                DATE  NOT NULL , 
     dt_fim                   DATE , 
     cd_barras_produto        VARCHAR2 (13) 
    ) 
;

COMMENT ON COLUMN T_MC_PRODUTO.cd_produto IS 'Código único do produto, gerado automaticamente pela sequência SQ_MC_PRODUTO e utilizado como chave primária da tabela de produtos. Campo obrigatório (NOT NULL).' 
;

COMMENT ON COLUMN T_MC_PRODUTO.cd_categoria IS 'Chave estrangeira da tabela, faz referência a tabela T_MC_CATEGORIA. Valor numérico gerado automaticamente via SEQUENCE ou IDENTITY. Campo obrigatório NOT NULL' 
;

COMMENT ON COLUMN T_MC_PRODUTO.ds_produto IS 'Essa coluna irá armazenar a descrição principal do produto. Seu conteúdo deve ser obrigatorio e único.' 
;

COMMENT ON COLUMN T_MC_PRODUTO.ds_completa_produto IS 'Armazena a descrição completa do produto, utilizada para apresentar suas principais características e informações detalhadas. Campo obrigatório (NOT NULL).' 
;

COMMENT ON COLUMN T_MC_PRODUTO.vl_unitario_produto IS 'Essa coluna irá armazenar o valor unitário atual do produto. Seu conteúdo deve ser maior que 0.' 
;

COMMENT ON COLUMN T_MC_PRODUTO.vl_total_imposto_produto IS 'Armazena o valor total dos impostos pagos pela empresa para a comercialização do produto. Campo obrigatório NOT NULL.' 
;

COMMENT ON COLUMN T_MC_PRODUTO.st_produto IS 'Armazena o status do produto, que pode ser "A" (Ativo), "I" (Inativo) ou "P" (Prospecção). Campo obrigatório.' 
;

COMMENT ON COLUMN T_MC_PRODUTO.dt_inicio IS 'Data de início do ciclo de vida do produto. Seu conteúdo é obrigatório (NOT NULL).' 
;

COMMENT ON COLUMN T_MC_PRODUTO.dt_fim IS 'Armazena a data e hora de término da vigência do produto, indicando até quando ele permanece ativo no sistema. Valor nulo indica que o produto continua ativo. Campo opcional (NULL).' 
;

COMMENT ON COLUMN T_MC_PRODUTO.cd_barras_produto IS 'Essa coluna irá armazenar o número do codigo de barras  do produto no padrão EAN13. Utiliza-se VARCHAR(13) para o caso de o código de barras começar por 0. Campo opcional (NULL).' 
;

ALTER TABLE T_MC_PRODUTO 
    ADD CONSTRAINT CK_MC_DATA_FINAL 
    CHECK (dt_fim > dt_inicio)
;


ALTER TABLE T_MC_PRODUTO 
    ADD CONSTRAINT CK_MC_STATUS_PRODUTO 
    CHECK (st_produto IN ('A','I','P'))
;


ALTER TABLE T_MC_PRODUTO 
    ADD CONSTRAINT CK_MC_VL_TOTAL_IMPOSTO 
    CHECK (vl_total_imposto_produto > 0)
;


ALTER TABLE T_MC_PRODUTO 
    ADD CONSTRAINT CK_MC_VL_UNIT_PRODUTO 
    CHECK (vl_unitario_produto > 0)
;
ALTER TABLE T_MC_PRODUTO 
    ADD CONSTRAINT PK_MC_PRODUTO PRIMARY KEY ( cd_produto ) ;

ALTER TABLE T_MC_PRODUTO 
    ADD CONSTRAINT UN_T_MC_PRODUTO_NOME UNIQUE ( ds_produto ) ;

CREATE TABLE T_MC_SAC 
    ( 
     cd_chamado             NUMBER (10)  NOT NULL , 
     cd_produto             NUMBER (10)  NOT NULL , 
     cd_cliente             NUMBER (10)  NOT NULL , 
     cd_funcionario         NUMBER (10)  NOT NULL , 
     ds_chamado             VARCHAR2 (4000)  NOT NULL , 
     nr_duracao_atendimento NUMBER (5,2)  NOT NULL , 
     dt_abertura            DATE  NOT NULL , 
     tp_chamado             CHAR (1)  NOT NULL , 
     st_chamado             CHAR (1)  NOT NULL , 
     dt_atendimento         DATE , 
     ds_retorno_funcionario VARCHAR2 (4000) , 
     nr_indice_satisfacao   NUMBER (2) 
    ) 
;

COMMENT ON COLUMN T_MC_SAC.cd_chamado IS 'Essa coluna irá armazenar a chave primária da tabela de SAC da Melhorees Compras. A cada SAC cadastrado pelo cliente será acionada a Sequence  SQ_MC_SGV_SAC que se encarregará de gerar o próximo número único do chamado SAC feito pelo Cliente.' 
;

COMMENT ON COLUMN T_MC_SAC.cd_produto IS 'Código único do produto, FK da entidade T_MC_PRODUTO. Campo obrigatório (NOT NULL).' 
;

COMMENT ON COLUMN T_MC_SAC.cd_cliente IS 'Essa coluna irá armazenar o código único do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório, único e preenhcido a  parrtir da chamada de sequence  SQ_MC_CLIENTE, a qual terá sempre o número disponivel para uso.' 
;

COMMENT ON COLUMN T_MC_SAC.cd_funcionario IS 'Esta coluna irá receber o codigo do funcionário e seu conteúdo é obrigatório.' 
;

COMMENT ON COLUMN T_MC_SAC.ds_chamado IS 'Essa coluna  irá  receber a descrição completa do SAC aberto pelo cliente. Seu conteudo deve ser obrigatório.' 
;

COMMENT ON COLUMN T_MC_SAC.nr_duracao_atendimento IS 'Essa coluna  irá  receber o tempo total em horas (HH24) computado desde a abertura até a conclusão dele. A unidade de medida é horas, ou seja, em quantas horas o chamado foi concluído desde a sua abertura. Seu conteúdo é opcional pois depende de ter havido atendimento.' 
;

COMMENT ON COLUMN T_MC_SAC.dt_abertura IS 'Essa coluna  irá  receber a data e horário do SAC aberto pelo cliente. Seu conteudo deve ser obrigatório (NOT NULL)' 
;

COMMENT ON COLUMN T_MC_SAC.tp_chamado IS 'Essa coluna  irá  receber o TIPO  do chamado SAC aberto pelo cliente.  Seu conteúdo deve ser  obrigatório e os possíveis valores são: sugestão (1) e reclamação (2).' 
;

COMMENT ON COLUMN T_MC_SAC.st_chamado IS 'Essa coluna  irá  receber o STATUS  do chamado SAC aberto pelo cliente.  Seu conteúdo deve ser obrigatório (NOT NULL) e os possíveis valores são: am atendimento (E); aberto (A), cancelado (C), fechado com sucesso (F) ou fechado com insatistação do cliente (X).' 
;

COMMENT ON COLUMN T_MC_SAC.dt_atendimento IS 'Essa coluna  irá  receber a data e horário do atendmiento SAC feita pelo funcionário da Melhores Compras. Seu conteudo deve ser opcional pois pode não ter sido atendido ainda.' 
;

COMMENT ON COLUMN T_MC_SAC.ds_retorno_funcionario IS 'Essa coluna  irá  receber a descrição detalhada do retorno feito pelo funcionário a partir da solicitação do cliente. Seu conteúdo deve ser opcional e preenchido pelo funcionário.' 
;

COMMENT ON COLUMN T_MC_SAC.nr_indice_satisfacao IS 'Essa coluna  irá  receber o índice de satisfação, , computado como um valor simples de 1 a 10, onde 1 refere-se ao cliente menos satisfeito e 10 o cliente mais satisfeito. Esse índice de satisfação é opcional e informado pelo cliente ao final do atendimento.' 
;

ALTER TABLE T_MC_SAC 
    ADD CONSTRAINT CK_MC_DATA_ATENDIMENTO 
    CHECK (dt_atendimento > dt_abertura)
;


ALTER TABLE T_MC_SAC 
    ADD CONSTRAINT CK_MC_TIPO_CHAMADO 
    CHECK (tp_chamado IN('1', '2'))
;


ALTER TABLE T_MC_SAC 
    ADD CONSTRAINT CK_MC_CHAMADO 
    CHECK (st_chamado IN ('E', 'A', 'C', 'F', 'X'))
;


ALTER TABLE T_MC_SAC 
    ADD CONSTRAINT CK_MC_SATISFACAO 
    CHECK (nr_indice_satisfacao >= 1 AND nr_indice_satisfacao <= 10
 )
;
ALTER TABLE T_MC_SAC 
    ADD CONSTRAINT PK_MC_SGV_SAC PRIMARY KEY ( cd_chamado, cd_produto ) ;

CREATE TABLE T_MC_VIDEO 
    ( 
     cd_video          NUMBER  NOT NULL , 
     cd_produto        NUMBER (10)  NOT NULL , 
     cd_categoria      NUMBER (10)  NOT NULL , 
     ds_video          VARCHAR2 (255)  NOT NULL , 
     st_video          CHAR (1)  NOT NULL , 
     dt_cadastro_video DATE  NOT NULL , 
     dt_inicio_video   DATE  NOT NULL , 
     dt_final_video    DATE 
    ) 
;

COMMENT ON COLUMN T_MC_VIDEO.cd_video IS 'Identificador único do vídeo (sequencial/identity) crescente.' 
;

COMMENT ON COLUMN T_MC_VIDEO.cd_produto IS 'Produto ao qual o vídeo pertence (FK para T_MC_PRODUTO).' 
;

COMMENT ON COLUMN T_MC_VIDEO.cd_categoria IS 'Categoria do vídeo (FK para T_MC_CATEGORIA).' 
;

COMMENT ON COLUMN T_MC_VIDEO.ds_video IS 'Descrição breve do vídeo (obrigatória).' 
;

COMMENT ON COLUMN T_MC_VIDEO.st_video IS 'Status do vídeo: A = Ativo, I = Inativo, B = Bloqueado. Exibição apenas quando A.' 
;

COMMENT ON COLUMN T_MC_VIDEO.dt_cadastro_video IS 'Data em que o vídeo foi cadastrado na plataforma. Obrigatório (NOT NULL).' 
;

COMMENT ON COLUMN T_MC_VIDEO.dt_inicio_video IS 'Data/hora de cadastro do vídeo na plataforma. Obrigatório (NOT NULL).' 
;

COMMENT ON COLUMN T_MC_VIDEO.dt_final_video IS 'Fim do ciclo de vida (opcional).' 
;

ALTER TABLE T_MC_VIDEO 
    ADD CONSTRAINT CK_MC_VIDEO 
    CHECK (st_video IN ('A', 'I', 'B'))
;


ALTER TABLE T_MC_VIDEO 
    ADD CONSTRAINT CK_MC_VIDEO_DATA_FINAL 
    CHECK (dt_final_video > dt_inicio_video)
;
ALTER TABLE T_MC_VIDEO 
    ADD CONSTRAINT T_MC_VIDEO_PK PRIMARY KEY ( cd_video ) ;

CREATE TABLE T_MC_VISUALIZACAO 
    ( 
     cd_visualizacao NUMBER (10)  NOT NULL , 
     cd_video        NUMBER  NOT NULL , 
     cd_cliente      NUMBER (10) , 
     dt_visualizacao DATE  NOT NULL 
    ) 
;

COMMENT ON COLUMN T_MC_VISUALIZACAO.cd_visualizacao IS 'Identificador único da visualização (sequencial/identity).' 
;

COMMENT ON COLUMN T_MC_VISUALIZACAO.cd_video IS 'Identificador do vídeo visualizado (FK para T_MC_VIDEO).' 
;

COMMENT ON COLUMN T_MC_VISUALIZACAO.cd_cliente IS 'Cliente logado que visualizou o vídeo (se a visualização for anônima, NULL).' 
;

COMMENT ON COLUMN T_MC_VISUALIZACAO.dt_visualizacao IS 'Data e hora da visualização (obrigatória).' 
;

ALTER TABLE T_MC_VISUALIZACAO 
    ADD CONSTRAINT T_MC_VISUALIZACAO_PK PRIMARY KEY ( cd_visualizacao ) ;

ALTER TABLE T_MC_BAIRRO 
    ADD CONSTRAINT Abrange FOREIGN KEY 
    ( 
     cd_cidade
    ) 
    REFERENCES T_MC_CIDADE 
    ( 
     cd_cidade
    ) 
;

ALTER TABLE T_MC_PRODUTO 
    ADD CONSTRAINT Agrupa FOREIGN KEY 
    ( 
     cd_categoria
    ) 
    REFERENCES T_MC_CATEGORIA 
    ( 
     cd_categoria
    ) 
;

ALTER TABLE T_MC_SAC 
    ADD CONSTRAINT Atende FOREIGN KEY 
    ( 
     cd_funcionario
    ) 
    REFERENCES T_MC_FUNCIONARIO 
    ( 
     cd_funcionario
    ) 
;

ALTER TABLE T_MC_VIDEO 
    ADD CONSTRAINT Classifica FOREIGN KEY 
    ( 
     cd_categoria
    ) 
    REFERENCES T_MC_CATEGORIA 
    ( 
     cd_categoria
    ) 
;

ALTER TABLE T_MC_CIDADE 
    ADD CONSTRAINT Compõe FOREIGN KEY 
    ( 
     sg_uf
    ) 
    REFERENCES T_MC_ESTADO 
    ( 
     sg_uf
    ) 
;

ALTER TABLE T_MC_LOGRADOURO 
    ADD CONSTRAINT Contém FOREIGN KEY 
    ( 
     cd_bairro
    ) 
    REFERENCES T_MC_BAIRRO 
    ( 
     cd_bairro
    ) 
;

ALTER TABLE T_MC_CLIENTE_PF 
    ADD CONSTRAINT Corresponde FOREIGN KEY 
    ( 
     cd_cliente
    ) 
    REFERENCES T_MC_CLIENTE 
    ( 
     cd_cliente
    ) 
;

ALTER TABLE T_MC_CLIENTE_ENDERECO 
    ADD CONSTRAINT FK_CLIENTE_ENDERECO_CLIENTE FOREIGN KEY 
    ( 
     cd_cliente
    ) 
    REFERENCES T_MC_CLIENTE 
    ( 
     cd_cliente
    ) 
;

ALTER TABLE T_MC_SAC 
    ADD CONSTRAINT Gera FOREIGN KEY 
    ( 
     cd_produto
    ) 
    REFERENCES T_MC_PRODUTO 
    ( 
     cd_produto
    ) 
;

ALTER TABLE T_MC_FUNCIONARIO 
    ADD CONSTRAINT Gerencia FOREIGN KEY 
    ( 
     cd_funcionario1
    ) 
    REFERENCES T_MC_FUNCIONARIO 
    ( 
     cd_funcionario
    ) 
;

ALTER TABLE T_MC_FUNCIONARIO_ENDERECO 
    ADD CONSTRAINT Localiza FOREIGN KEY 
    ( 
     cd_logradouro
    ) 
    REFERENCES T_MC_LOGRADOURO 
    ( 
     cd_logradouro
    ) 
;

ALTER TABLE T_MC_FUNCIONARIO 
    ADD CONSTRAINT Pertence FOREIGN KEY 
    ( 
     cd_departamento
    ) 
    REFERENCES T_MC_DEPTO 
    ( 
     cd_departamento
    ) 
;

ALTER TABLE T_MC_VISUALIZACAO 
    ADD CONSTRAINT Recebe FOREIGN KEY 
    ( 
     cd_video
    ) 
    REFERENCES T_MC_VIDEO 
    ( 
     cd_video
    ) 
;

ALTER TABLE T_MC_CLIENTE_ENDERECO 
    ADD CONSTRAINT Referencia FOREIGN KEY 
    ( 
     cd_logradouro
    ) 
    REFERENCES T_MC_LOGRADOURO 
    ( 
     cd_logradouro
    ) 
;

ALTER TABLE T_MC_SAC 
    ADD CONSTRAINT Registra FOREIGN KEY 
    ( 
     cd_cliente
    ) 
    REFERENCES T_MC_CLIENTE 
    ( 
     cd_cliente
    ) 
;

ALTER TABLE T_MC_CLIENTE_PJ 
    ADD CONSTRAINT Representa FOREIGN KEY 
    ( 
     cd_cliente
    ) 
    REFERENCES T_MC_CLIENTE 
    ( 
     cd_cliente
    ) 
;

ALTER TABLE T_MC_FUNCIONARIO_ENDERECO 
    ADD CONSTRAINT Reside FOREIGN KEY 
    ( 
     cd_funcionario
    ) 
    REFERENCES T_MC_FUNCIONARIO 
    ( 
     cd_funcionario
    ) 
;

ALTER TABLE T_MC_VISUALIZACAO 
    ADD CONSTRAINT Visualiza FOREIGN KEY 
    ( 
     cd_cliente
    ) 
    REFERENCES T_MC_CLIENTE 
    ( 
     cd_cliente
    ) 
;

ALTER TABLE T_MC_VIDEO 
    ADD CONSTRAINT Visualizav2 FOREIGN KEY 
    ( 
     cd_produto
    ) 
    REFERENCES T_MC_PRODUTO 
    ( 
     cd_produto
    ) 
;

CREATE OR REPLACE TRIGGER ARC_Arc_1_T_MC_CLIENTE_PF 
BEFORE INSERT OR UPDATE OF cd_cliente 
ON T_MC_CLIENTE_PF 
FOR EACH ROW 
DECLARE 
    d CHAR (1); 
BEGIN 
    SELECT A.tp_cliente INTO d 
    FROM T_MC_CLIENTE A 
    WHERE A.cd_cliente = :new.cd_cliente; 
    IF (d IS NULL OR d <> 'F') THEN 
        raise_application_error(-20223,'FK Corresponde in Table T_MC_CLIENTE_PF violates Arc constraint on Table T_MC_CLIENTE - discriminator column tp_cliente doesn''t have value ''F'''); 
    END IF; 
    EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
        NULL; 
    WHEN OTHERS THEN 
        RAISE; 
END; 
/

CREATE OR REPLACE TRIGGER ARC_Arc_1_T_MC_CLIENTE_PJ 
BEFORE INSERT OR UPDATE OF cd_cliente 
ON T_MC_CLIENTE_PJ 
FOR EACH ROW 
DECLARE 
    d CHAR (1); 
BEGIN 
    SELECT A.tp_cliente INTO d 
    FROM T_MC_CLIENTE A 
    WHERE A.cd_cliente = :new.cd_cliente; 
    IF (d IS NULL OR d <> 'J') THEN 
        raise_application_error(-20223,'FK Representa in Table T_MC_CLIENTE_PJ violates Arc constraint on Table T_MC_CLIENTE - discriminator column tp_cliente doesn''t have value ''J'''); 
    END IF; 
    EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
        NULL; 
    WHEN OTHERS THEN 
        RAISE; 
END; 
/



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            16
-- CREATE INDEX                             0
-- ALTER TABLE                             65
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           2
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 1
