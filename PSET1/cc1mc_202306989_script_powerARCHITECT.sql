
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
COMMENT ON COLUMN lojas.produtos.produto_id IS 'id de cada produto da coluna produtos.';
COMMENT ON COLUMN lojas.produtos.nome IS 'nome dos produtos da coluna produtos.';
COMMENT ON COLUMN lojas.produtos.preco_unitario IS 'Preço unitario de cada produto da coluna produtos.';
COMMENT ON COLUMN lojas.produtos.detalhes IS 'detalhes de cada produto da coluna produtos.';
COMMENT ON COLUMN lojas.produtos.imagem IS 'imagem dos produtos da tabela produtos';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type IS 'imagem mime type da dos produtos da tabela produtos.';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo IS 'Arquivo da imagem de cada um dos produtos da tabela produtos.';
COMMENT ON COLUMN lojas.produtos.imagem_charset IS 'imagem charset de cada um dos produtos da tabela produtos.';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS 'ultima atualização da imagem da tabela produtos.';


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
COMMENT ON COLUMN lojas.lojas.loja_id IS 'id de cada uma das lojas da tabela lojas.';
COMMENT ON COLUMN lojas.lojas.nome IS 'Nome das lojas da tabela lojas.';
COMMENT ON COLUMN lojas.lojas.endereco_web IS 'Endereço web dos clientes.';
COMMENT ON COLUMN lojas.lojas.endereco_fisico IS 'endereço fisico dos clientes que receberão o seus pedidos.';
COMMENT ON COLUMN lojas.lojas.latitude IS 'latitude das lojas da coluna lojas.';
COMMENT ON COLUMN lojas.lojas.longitude IS 'Longitude da coluna lojas.';
COMMENT ON COLUMN lojas.lojas.logo IS 'logo da coluna lojas.';
COMMENT ON COLUMN lojas.lojas.logo_mime_type IS 'logo mime type da coluna lojas.';
COMMENT ON COLUMN lojas.lojas.logo_arquivo IS 'arquivo da logo da coluna lojas.';
COMMENT ON COLUMN lojas.lojas.logo_charset IS 'logo charset da coluna lojas.';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'ultima atualização da logo, da coluna lojas.';


CREATE TABLE lojas.estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT estoque_id PRIMARY KEY (estoque_id)
);
COMMENT ON TABLE lojas.estoques IS 'Tabela Estoques, mostra todos os produtos que estão em estoques';
COMMENT ON COLUMN lojas.estoques.estoque_id IS 'id dos produtos em estoque, da tabela estoques.';
COMMENT ON COLUMN lojas.estoques.loja_id IS 'id da loja que está com o produto em estoque, da tabela estoques.';
COMMENT ON COLUMN lojas.estoques.produto_id IS 'Id do produto que está em estoque, da tabela estoques.';
COMMENT ON COLUMN lojas.estoques.quantidade IS 'Quantidade de produto que está em estoque, tabela estoques.';


CREATE TABLE lojas.clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT clientes_pk PRIMARY KEY (cliente_id)
);
COMMENT ON TABLE lojas.clientes IS 'Tabela dos Clientes.';
COMMENT ON COLUMN lojas.clientes.cliente_id IS 'Id dos clientes da coluna clientes.';
COMMENT ON COLUMN lojas.clientes.email IS 'Email dos clientes da tabela clientes';
COMMENT ON COLUMN lojas.clientes.nome IS 'Nome dos Clientes da tabela Clientes';
COMMENT ON COLUMN lojas.clientes.telefone1 IS 'Primeiro telefone dos clientes, da tabela  clientes.';
COMMENT ON COLUMN lojas.clientes.telefone2 IS 'Segundo telefone dos clientes da tabela clientes.';
COMMENT ON COLUMN lojas.clientes.telefone3 IS 'Terceiro telefone dos clientes da tabela clientes.';


CREATE TABLE lojas.envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT envios_id PRIMARY KEY (envio_id)
);
COMMENT ON TABLE lojas.envios IS 'Tabela envios, todos os envios feitos para os clientes.';
COMMENT ON COLUMN lojas.envios.envio_id IS 'id dos envios dos clientes, da tabela envios.';
COMMENT ON COLUMN lojas.envios.loja_id IS 'id das lojas que fizeram os envios.';
COMMENT ON COLUMN lojas.envios.cliente_id IS 'id dos clientes que receberao os envios.';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'endereço em que os envios irão ser entregue';
COMMENT ON COLUMN lojas.envios.status IS 'status dos envios dos clientes.';


CREATE TABLE lojas.pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedido_id PRIMARY KEY (pedido_id)
);
COMMENT ON TABLE lojas.pedidos IS 'Tabela que guarda os pedidos de cada um dos clientes.';
COMMENT ON COLUMN lojas.pedidos.pedido_id IS 'ID dos pedidos de cada um dos clientes.';
COMMENT ON COLUMN lojas.pedidos.data_hora IS 'Data e hora que foi realizado os pedidos por cada cliente.';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'ID de cada um dos clientes que realizou os pedidos';
COMMENT ON COLUMN lojas.pedidos.status IS 'status do pedido realizado pelo cliente.';
COMMENT ON COLUMN lojas.pedidos.loja_id IS 'ID da loja que foi realizado o pedido.';


CREATE TABLE lojas.pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedido_id PRIMARY KEY (pedido_id, produto_id)
);
COMMENT ON TABLE lojas.pedidos_itens IS 'Itens dos pedidos realizados.';
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id IS 'id dos pedidos.';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id IS 'id dos produtos da coluna pedidos.';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS 'Numero da linha da coluna pedidos_itens';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario IS 'preço unitario de cada um dos itens, da tabela pedidos_itens';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade IS 'quantidade de pedidos da tabela pedidos_itens';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id IS 'id dos envios dos clientes, da tabela envios.';


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