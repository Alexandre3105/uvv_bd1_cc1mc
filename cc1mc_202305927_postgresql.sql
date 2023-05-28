
----PSET1----


--Verificar se o database uvv ja existe e exclui-lo 

drop database if exists uvv;

--Verificar se o schema lojas existe e exclui-lo
drop schema if exists lojas;

--Verificar se o usuario alexandre existe e exclui-lo

drop user if exists alexandre ;

--Verificar se a role existe e exclui-la 
drop role if exists alexandre ;




--Criar usuario alexandre com senha criptografada

CREATE USER alexandre WITH CREATEDB CREATEROLE ENCRYPTED PASSWORD '31052005';




--Criar banco de dados uvv

Create database uvv
with
owner=  alexandre 
template= 'template0'
encoding= "UTF8"
lc_collate= 'pt_BR.UTF-8'
lc_ctype= 'pt_BR.UTF-8'
allow_connections= true
;

--Definir a variavel PGPASSWORD como a senha do usuario alexandre(entrar sem pedir senha)--> Metodo inseguro 

\setenv PGPASSWORD 31052005


--Permissao total ao usuario alexandre para o database uvv 

GRANT ALL ON database uvv TO alexandre;


--Usar database uvv com usuario alexandre

\c uvv alexandre ;


--Comentario do banco de dados uvv

COMMENT ON DATABASE uvv
    IS 'Banco de dados geral da uvv';


--Criar schema lojas 

CREATE SCHEMA lojas authorization alexandre;


--Comentario do schema lojas 

COMMENT ON SCHEMA lojas 
    IS 'schema de lojas do banco de dados uvv';
   


 --Definindo o Search_Path para lojas como prioridade 

set search_path to lojas,"$user",public;


alter user alexandre 
set search_path to lojas,"$user",public; 

alter schema lojas owner to alexandre;



--Criar tabela produtos no schema lojas


CREATE TABLE lojas.produtos (
                produto_id                 		NUMERIC(38)  NOT NULL,
                nome                       		VARCHAR(255) NOT NULL,
                preco_unitario             		NUMERIC(10,2),
                detalhes 						BYTEA,
                imagem 							BYTEA,
                imagem_mime_type           		VARCHAR(512),
                imagem_arquivo             		VARCHAR(512),
                imagem_charset             		VARCHAR(512),
                imagem_ultima_atualizacao    	DATE,
                
                
                
--Definindo a Pk da tabela produtos                 
                
CONSTRAINT pk_produtos PRIMARY KEY (produto_id)

);


--Comentarios da tabela produtos

COMMENT ON TABLE  lojas.produtos 								IS              'tabela que lista alguns dados de produtos cadastrados';

--Comentarios das colunas da tabela produtos

COMMENT ON COLUMN lojas.produtos.produto_id 					IS              'PK. id de identificao do produto';
COMMENT ON COLUMN lojas.produtos.nome 							IS              'nome do produto';
COMMENT ON COLUMN lojas.produtos.preco_unitario 				IS              'preco da unidade do produto';
COMMENT ON COLUMN lojas.produtos.detalhes 						IS              'detalhes do produto';
COMMENT ON COLUMN lojas.produtos.imagem 						IS              'imagem do produto';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type 				IS              'mime type da imagem do produto';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo 				IS              'arquivo de imagem do produto';
COMMENT ON COLUMN lojas.produtos.imagem_charset 				IS              'formato de codificacao utilizado na imagem do produto';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao 		IS     			'data da ultima atualizacao da imagem do produto';



--Criar tabela lojas no schema lojas


CREATE TABLE lojas.lojas (
                loja_id         			NUMERIC(38)  NOT NULL,
                nome              			VARCHAR(255) NOT NULL,
                endereco_web      			VARCHAR(100),
                endereco_fisico   			VARCHAR(512),
                latitude          			NUMERIC,
                longitude         			NUMERIC,
                logo 						BYTEA,
                logo_mime_type    			VARCHAR(512),
                logo_charset      			VARCHAR(512),
                logo_arquivo      			VARCHAR(512),
                logo_ultima_atualizacao 	DATE,
                
                
--Definindo a Pk da tabela lojas                

CONSTRAINT pk_lojas PRIMARY KEY (loja_id)

);

--Comentarios da tabela lojas

COMMENT ON TABLE  lojas.lojas 							IS              'tabela que lista alguns dados de lojas cadastradas';

--Comentarios das colunas da tabela lojas 

COMMENT ON COLUMN lojas.lojas.loja_id					IS              'PK.id para identificar as lojas';
COMMENT ON COLUMN lojas.lojas.nome 						IS 				'nome das lojas cadastradas';
COMMENT ON COLUMN lojas.lojas.endereco_web 				IS 				'endereco web das lojas cadastradas';
COMMENT ON COLUMN lojas.lojas.endereco_fisico 			IS 				'endereco fisico das lojas cadastradas';
COMMENT ON COLUMN lojas.lojas.latitude 					IS 				'latitude das lojas cadastradas';
COMMENT ON COLUMN lojas.lojas.longitude 				IS 				'longitude das lojas cadastradas';
COMMENT ON COLUMN lojas.lojas.logo 						IS 				'logo das lojas cadastradas';
COMMENT ON COLUMN lojas.lojas.logo_mime_type 			IS 				'mime_type da logo';
COMMENT ON COLUMN lojas.lojas.logo_charset 				IS 				'formato de codificacao utilizado nas logos';
COMMENT ON COLUMN lojas.lojas.logo_arquivo 				IS 				'arquivo da logo';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao   IS 				'data da ultima atualizacao da logo';



--Criar tabela estoques no schema lojas


CREATE TABLE lojas.estoques (
                estoque_id 			NUMERIC(38) NOT NULL,
                loja_id 			NUMERIC(38) NOT NULL,
                produto_id 			NUMERIC(38) NOT NULL,
                quantidade 			NUMERIC(38) NOT NULL,
                
                
--Definindo a Pk da tabela estoques


CONSTRAINT pk_estoques PRIMARY KEY (estoque_id)

);




--Comentario da tabela estoques 

COMMENT ON TABLE  lojas.estoques 					IS 		'Tabela referente ao estoque das lojas';


--Comentarios das colunas da tabela estoques

COMMENT ON COLUMN lojas.estoques.estoque_id 		IS 		'PK.id de identificacao do estoque';
COMMENT ON COLUMN lojas.estoques.loja_id 			IS 		'FK.id para identificar as lojas';
COMMENT ON COLUMN lojas.estoques.produto_id 		IS 		'FK.id de identificao do produto';
COMMENT ON COLUMN lojas.estoques.quantidade			IS 	    'quantidade de produtos no estoque';




--Criar tabela clientes no schema lojas





CREATE TABLE lojas.clientes (
                cliente_Id 				NUMERIC(38)  NOT NULL,
                nome 					VARCHAR(255) NOT NULL,
                email 					VARCHAR(255) NOT NULL,
                telefone1 				VARCHAR(20),
                telefone2 				VARCHAR(20),
                telefone3 				VARCHAR(20),
                
                
--Definindo a Pk da tabela clientes

                
CONSTRAINT pk_clientes PRIMARY KEY (cliente_Id)

);




--Comentario da tabela clientes

COMMENT ON TABLE  lojas.clientes 					IS 		'Tabela que lista alguns dados de clientes';

--Comentarios das colunas da tabela clientes 


COMMENT ON COLUMN lojas.clientes.cliente_Id 		IS 		'PK.id para identificar o cliente';
COMMENT ON COLUMN lojas.clientes.nome 				IS 		'nome do cliente';
COMMENT ON COLUMN lojas.clientes.email 				IS 		'Email do cliente';
COMMENT ON COLUMN lojas.clientes.telefone1 			IS 		'primeiro telefone do cliente';
COMMENT ON COLUMN lojas.clientes.telefone2 			IS 		'segundo telefone do cliente';
COMMENT ON COLUMN lojas.clientes.telefone3 			IS 		'terceiro telefone do cliente';





--Criar tabela envios no schema lojas


CREATE TABLE lojas.envios (
                envio_id 				NUMERIC(38)  NOT NULL,
                cliente_Id 				NUMERIC(38)  NOT NULL,
                loja_id 				NUMERIC(38)  NOT NULL,
                endereco_entrega 		VARCHAR(512) NOT NULL,
                status 					VARCHAR(15)  NOT NULL,
                
                

                
--Definindo a Pk da tabela envios
                
CONSTRAINT pk_envios PRIMARY KEY (envio_id)

);




--Comentario da tabela envios 

COMMENT ON TABLE lojas.envios 						IS 		'tabela relacionada ao processo de envio dos pedidos';


--Comentarios das colunas da tabela envios


COMMENT ON COLUMN lojas.envios.envio_id 			IS 		'PK.id de identificacao do pedido';
COMMENT ON COLUMN lojas.envios.cliente_Id 			IS 		'FK.id para identificar o cliente';
COMMENT ON COLUMN lojas.envios.loja_id 			    IS 		'FK.id para identificar as lojas';
COMMENT ON COLUMN lojas.envios.endereco_entrega 	IS 		'endereco de entrega dos clientes';
COMMENT ON COLUMN lojas.envios.status 				IS 		'status do envio';




--Criar tabela pedidos no schema lojas





CREATE TABLE lojas.pedidos (
                pedido_id 				NUMERIC(38) NOT NULL,
                data_hora 				TIMESTAMP   NOT NULL,
                cliente_Id 				NUMERIC(38) NOT NULL,
                status 					VARCHAR(15) NOT NULL,
                loja_id 				NUMERIC(38) NOT NULL,
                
                
--Definindo a Pk da tabela pedidos                
                
CONSTRAINT pk_pedidos PRIMARY KEY (pedido_id)

);


--Comentario da tabela pedidos

COMMENT ON TABLE  lojas.pedidos                  IS 		'Tabela referente aos pedidos dos clientes';


--Comentarios das colunas da tabela pedidos


COMMENT ON COLUMN lojas.pedidos.pedido_id        IS 		'PK.ID do pedido realizado pelo cliente';
COMMENT ON COLUMN lojas.pedidos.data_hora        IS 		'Dia e hora do pedido';
COMMENT ON COLUMN lojas.pedidos.cliente_Id       IS 		'FK.id para identificar o cliente';
COMMENT ON COLUMN lojas.pedidos.status 	         IS 		'status do pedido';
COMMENT ON COLUMN lojas.pedidos.loja_id          IS 		'FK.id para identificar as lojas';




--Criar tabela pedidos_itens no schema lojas 




CREATE TABLE lojas.pedidos_itens (
                pedido_id 		 				NUMERIC(38) NOT NULL,
                produto_id		 				NUMERIC(38) NOT NULL,
                numero_da_linha		 			NUMERIC(38) NOT NULL,
                preco_unitario 		 			NUMERIC(10,2) NOT NULL,
                quantidade 		 				NUMERIC(38) NOT NULL,
                envio_id 		 				NUMERIC(38),
                

--Definindo a Pk da tabela pedidos_itens              
                
                
                
CONSTRAINT pk_pedidos_itens PRIMARY KEY (pedido_id, produto_id)

);





--Comentarios da tabela pedidos_itens


COMMENT ON TABLE  lojas.pedidos_itens                    IS 				'tabela referente a dados dos pedidos e e ao estoque';


--Comentarios das colunas da tabela pedidos_itens


COMMENT ON COLUMN lojas.pedidos_itens.pedido_id          IS 				'FK da tabela pedidos.ID do pedido realizado pelo cliente';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id         IS 				'FK da tabela produtos.id de identificao do produto.apenas numeros maiores ou igual a zero';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha    IS 				'numero da linha do pedido';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario     IS 				'preco da unidade do produto.apenas numeros maiores ou igual a zero ';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade 		 IS 				'quantidade de produtos adquiridos pelo cliente.apenas numeros maiores ou igual a zero';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id 			 IS 				'FK da tabela envios.id de identificacao do pedido.apenas numeros maiores ou igual a zero ';






--Chaves estrangeiras--


--Adiciona uma FK da tabela lojas.produtos na tabela lojas.estoques (produto_id)


ALTER TABLE lojas.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Adiciona uma FK da tabela lojas.produtos na tabela lojas.pedidos_itens(produto_id)

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Adiciona uma FK da tabela lojas.lojas na tabela lojas.pedidos(loja_id)

ALTER TABLE lojas.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Adiciona uma FK da tabela lojas.lojas na tabela lojas.envios(loja_id)

ALTER TABLE lojas.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Adiciona uma FK da tabela lojas.lojas na tabela lojas.estoques (loja_id)

ALTER TABLE lojas.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Adiciona uma FK da tabela lojas.clientes na tabela lojas.pedidos(cliente_Id)

ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_Id)
REFERENCES lojas.clientes (cliente_Id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Adiciona uma FK da tabela lojas.clientes na tabela lojas.envios(cliente_Id)

ALTER TABLE lojas.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_Id)
REFERENCES lojas.clientes (cliente_Id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Adiciona uma FK na tabela lojas.envios na tabela lojas.pedidos_itens(envio_id)

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Adiciona uma FK na tabela lojas.pedidos na tabela lojas.pedidos_itens(pedido_id)

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


--Restricoes das insercoes de dados--


--Restricoes da tabela clientes

ALTER TABLE         lojas.clientes
ADD CONSTRAINT      cc_clientes_nome
CHECK               (nome ~ '^[A-Za-z]+$');

ALTER TABLE 		lojas.clientes
ADD CONSTRAINT 		cc_clientes_email
CHECK 				(email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');


ALTER TABLE 		lojas.clientes 
ADD CONSTRAINT 		cc_clientes_cliente_id
CHECK				(cliente_id >= 0);

ALTER TABLE 		lojas.clientes
ADD CONSTRAINT 		cc_clientes_telefone1
CHECK 				(telefone1 ~ '^(\(\d{2}\)\s?)?\d{4,5}-\d{4}$');

ALTER TABLE 		lojas.clientes
ADD CONSTRAINT 		cc_clientes_telefone2
CHECK 				(telefone2 ~ '^(\(\d{2}\)\s?)?\d{4,5}-\d{4}$');
       
ALTER TABLE 		lojas.clientes
ADD CONSTRAINT 		cc_clientes_telefone3
CHECK 				(telefone3 ~ '^(\(\d{2}\)\s?)?\d{4,5}-\d{4}$');       

--Restricoes da tabela pedidos_itens 


ALTER TABLE 		lojas.pedidos_itens 
ADD CONSTRAINT 		cc_pedidos_itens_preco_unitario 
CHECK				( preco_unitario >= 0);

ALTER TABLE 		lojas.pedidos_itens 
ADD CONSTRAINT 		cc_pedidos_itens_quantidade
CHECK				(quantidade >= 0);

--Restricoes da tabela lojas

ALTER TABLE 		lojas.lojas 
ADD CONSTRAINT 		cc_lojas_endereco
CHECK				(endereco_fisico IS NOT NULL OR endereco_web IS NOT NULL);


ALTER TABLE 		lojas.lojas 
ADD CONSTRAINT 		cc_lojas_latitude
CHECK				(latitude BETWEEN 0 AND 90 );

ALTER TABLE 		lojas.lojas 
ADD CONSTRAINT 		cc_lojas_longitude
CHECK				(longitude BETWEEN 0 AND 180 );

ALTER TABLE 		lojas.lojas
ADD CONSTRAINT 		cc_lojas_loja_id 
CHECK				(loja_id >= 0);

--Restricoes da tabela produtos 


ALTER TABLE 		lojas.produtos 
ADD CONSTRAINT 		cc_produtos_preco_unitario 
CHECK				(preco_unitario >= 0);

ALTER TABLE 		lojas.produtos 
ADD CONSTRAINT 		cc_produtos_produto_id
CHECK				(produto_id >= 0 );

--Restricoes da tabela pedidos

ALTER TABLE 		lojas.pedidos 
ADD CONSTRAINT 		cc_pedidos_pedido_id
CHECK				(pedido_id >= 0);

ALTER TABLE  		lojas.pedidos 
ADD CONSTRAINT 		cc_pedidos_status
CHECK 				(status IN ('CANCELADO','COMPLETO','ABERTO','PAGO','REEMBOLSADO','ENVIADO'));



--Restricoes da tabela estoques


ALTER TABLE 		lojas.estoques
ADD CONSTRAINT 		cc_estoques_estoque_id
CHECK				(estoque_id >= 0);


ALTER TABLE 		lojas.estoques
ADD CONSTRAINT 		cc_estoques_quantidade
CHECK				(quantidade >= 0);

--Restricoes da tabela envios 


ALTER TABLE 		lojas.envios 
ADD CONSTRAINT 		cc_envios_envio_id
CHECK				(envio_id >= 0);

ALTER TABLE 		lojas.envios
ADD CONSTRAINT 		cc_envios_status 
CHECK 				( status IN  ('CRIADO','ENVIADO','TRANSITO','ENTREGUE'))










