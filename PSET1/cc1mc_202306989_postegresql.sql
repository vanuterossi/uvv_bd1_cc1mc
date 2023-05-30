drop database if exists uvv;

drop user if exists vanute;

create user vanute with createdb createrole encrypted password 'vanute001';

--ALtera a role principal pelo usuário POSTGRES (usuer administrador) para o user vanute
set role vanute;

--Cria o banco de dados uvv com os paramentros que estava no PSET
create database uvv 
with owner = vanute 
template = template0 
encoding = 'UTF8'
lc_collate = 'pt_BR.UTF-8'
lc_ctype = 'pt_BR.UTF-8'
allow_connections = true;

--Conecta ao banco de dados uvv, com o user vanute
\c uvv vanute;

--Criar o esquema dentro do banco de dados uvv com autorizacao para o user vanute
create schema lojas authorization vanute;

alter database uvv set search_path to lojas, '$user', public;

--Alterar o search_path do user vanute para lojas, user e public 
alter user vanute set search_path to lojas, '$user', public;

--Alterar o search_path para lojas, user e public
set search_path to lojas, '$user', public;

--Altera o dono do esquema lojas para o user vanute 
alter schema lojas owner to vanute;


------------------------PRODUTOS-----------------------------

--Criacao da tabela produtos
CREATE TABLE lojas.produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT produto_id PRIMARY KEY (produto_id)
);

-------------------------LOJAS E PRODUTOS-----------------------

COMMENT ON TABLE lojas.produtos IS 'Tabela com os dados de nome, detalhes e imagem dos produtos';

COMMENT ON COLUMN lojas.produtos.produto_id IS          'id de cada produto da coluna produtos.';
COMMENT ON COLUMN lojas.produtos.nome IS                'nome dos produtos da coluna produtos.';
COMMENT ON COLUMN lojas.produtos.preco_unitario IS      'Preço unitario de cada produto da coluna produtos.';
COMMENT ON COLUMN lojas.produtos.detalhes IS            'detalhes de cada produto da coluna produtos.';
COMMENT ON COLUMN lojas.produtos.imagem IS              'imagem dos produtos da tabela produtos';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type IS    'imagem mime type da dos produtos da tabela produtos.';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo IS      'Arquivo da imagem de cada um dos produtos da tabela produtos.';
COMMENT ON COLUMN lojas.produtos.imagem_charset IS      'imagem charset de cada um dos produtos da tabela produtos.';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS 'ultima atualização da imagem da tabela produtos.';

--------------------LOJAS------------------------------

CREATE TABLE lojas.lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT loja_id PRIMARY KEY (loja_id)
);
COMMENT ON TABLE lojas.lojas IS                        'Tabela lojas, que contém detalhes da loja';
COMMENT ON COLUMN lojas.lojas.loja_id IS               'ID de cada uma das lojas da tabela lojas.';
COMMENT ON COLUMN lojas.lojas.nome IS                  'Nome das lojas da tabela lojas.';
COMMENT ON COLUMN lojas.lojas.endereco_web IS          'Endereço web dos clientes.';
COMMENT ON COLUMN lojas.lojas.endereco_fisico IS       'endereço fisico dos clientes que receberão o seus pedidos.';
COMMENT ON COLUMN lojas.lojas.latitude IS              'latitude das lojas da coluna lojas.';
COMMENT ON COLUMN lojas.lojas.longitude IS             'Longitude da coluna lojas.';
COMMENT ON COLUMN lojas.lojas.logo IS                  'logo da coluna lojas.';
COMMENT ON COLUMN lojas.lojas.logo_mime_type IS        'logo mime type da coluna lojas.';
COMMENT ON COLUMN lojas.lojas.logo_arquivo IS          'arquivo da logo da coluna lojas.';
COMMENT ON COLUMN lojas.lojas.logo_charset IS          'logo charset da coluna lojas.';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'ultima atualização da logo, da coluna lojas.';

----------------------------------ESTOQUES-----------------------------

CREATE TABLE lojas.estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT estoque_id PRIMARY KEY (estoque_id)
);
COMMENT ON TABLE lojas.estoques IS                    'Tabela Estoques, mostra todos os produtos que estão em estoques';
COMMENT ON COLUMN lojas.estoques.estoque_id IS        'Chave Primária dos produtos em estoque, da tabela estoques.';
COMMENT ON COLUMN lojas.estoques.loja_id IS           'ID da loja que está com o produto em estoque, da tabela estoques.';
COMMENT ON COLUMN lojas.estoques.produto_id IS        'ID do produto que está em estoque, da tabela estoques.';
COMMENT ON COLUMN lojas.estoques.quantidade IS        'Quantidade de produto que está em estoque, tabela estoques.';

-----------------------------CLIENTES--------------------------------

CREATE TABLE lojas.clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT clientes_pk PRIMARY KEY (cliente_id)
);
COMMENT ON TABLE lojas.clientes IS                    'Tabela dos Clientes.';
COMMENT ON COLUMN lojas.clientes.cliente_id IS        'ID dos clientes da coluna clientes.';
COMMENT ON COLUMN lojas.clientes.email IS             'Email dos clientes da tabela clientes';
COMMENT ON COLUMN lojas.clientes.nome IS              'Nome dos Clientes da tabela Clientes';
COMMENT ON COLUMN lojas.clientes.telefone1 IS         'Primeiro telefone dos clientes, da tabela  clientes.';
COMMENT ON COLUMN lojas.clientes.telefone2 IS         'Segundo telefone dos clientes da tabela clientes.';
COMMENT ON COLUMN lojas.clientes.telefone3 IS         'Terceiro telefone dos clientes da tabela clientes.';

--------------------------ENVIOS---------------------------------

CREATE TABLE lojas.envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT envios_id PRIMARY KEY (envio_id)
);
COMMENT ON TABLE lojas.envios IS                     'Tabela envios, todos os envios feitos para os clientes.';
COMMENT ON COLUMN lojas.envios.envio_id IS           'ID dos envios dos clientes, da tabela envios.';
COMMENT ON COLUMN lojas.envios.loja_id IS            'ID das lojas que fizeram os envios.';
COMMENT ON COLUMN lojas.envios.cliente_id IS         'ID dos clientes que receberao os envios.';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS   'endereço em que os envios irão ser entregue';
COMMENT ON COLUMN lojas.envios.status IS             'status dos envios dos clientes.';

-------------------------PEDIDOS-----------------------------------

CREATE TABLE lojas.pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedido_id PRIMARY KEY (pedido_id)
);
COMMENT ON TABLE lojas.pedidos IS                   'Tabela que guarda os pedidos de cada um dos clientes.';
COMMENT ON COLUMN lojas.pedidos.pedido_id IS        'Chave Primaria dos pedidos de cada um dos clientes.';
COMMENT ON COLUMN lojas.pedidos.data_hora IS        'Data e hora que foi realizado os pedidos por cada cliente.';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS       'Chave Estrangeira de cada um dos clientes que realizou os pedidos';
COMMENT ON COLUMN lojas.pedidos.status IS           'status do pedido realizado pelo cliente.';
COMMENT ON COLUMN lojas.pedidos.loja_id IS          'Chave Estrangeira da loja que foi realizado o pedido.';

-----------------------PEDIDO ITENS------------------------------------

CREATE TABLE lojas.pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38) NOT NULL
);

alter table only lojas.pedidos_itens
add constraint pk_pedido_id_produto_id
primary key (pedido_id, produto_id);




COMMENT ON TABLE lojas.pedidos_itens IS              'Itens dos pedidos realizados.';
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id IS   'ID dos pedidos.';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id IS  'ID dos produtos da coluna pedidos.';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS 'Numero da linha da coluna pedidos_itens';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario IS 'preço unitario de cada um dos itens, da tabela pedidos_itens';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade IS  'quantidade de pedidos da tabela pedidos_itens';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id IS    'ID dos envios dos clientes, da tabela envios.';


ALTER TABLE lojas.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--------------Retenção da tabela PEDIDOS------------------SS

ALTER TABLE lojas.pedidos
ADD CONSTRAINT check_status_pedidos
CHECK (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));

-------------Retenção da tabela ENVIOS E STATUS----------

ALTER TABLE lojas.envios 
ADD CONSTRAINT check_status_envios 
CHECK (status IN ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));

------------Retenção da tabela PRODUTOS E PREÇO UNITÁRIO------------

ALTER TABLE lojas.produtos 
ADD CONSTRAINT check_preco_unitario_produtos 
CHECK (preco_unitario >= 0);

-------------Retenção da coluna NOME----------------

ALTER TABLE lojas.produtos
ADD CONSTRAINT unico_nome_produtos 
UNIQUE (nome);

------------Retenção da tabela ESTOQUES E QUANTIDADE ---------------

ALTER TABLE lojas.estoques 
ADD CONSTRAINT check_quantidade_estoques 
CHECK (quantidade >= 0);

-----------Retenção da tabela LOJAS E ENDEREÇO WEB E ENDEREÇO FISICO-------------------

ALTER TABLE lojas.lojas
ADD CONSTRAINT check_endereco_lojas
CHECK (endereco_web IS NOT NULL OR endereco_fisico IS NOT NULL);

-------------------Retenção da coluna NOME---------------------

ALTER TABLE lojas.lojas
ADD CONSTRAINT unico_nome_lojas 
UNIQUE (nome);

----------------Retenção da tabela PEDIDOS_ITENS E QUANTIDADE_PEDIDO_ITENS---------------------

ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT check_quantidade_pedidos_itens
CHECK (quantidade >= 0);

-------------------Retenção da coluna PRECO_UNITARIO--------------------

ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT check_preco_unitario_pedidos_itens
CHECK (preco_unitario >= 0);