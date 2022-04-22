/* Cria BD */
CREATE DATABASE BD19_CONTROLE_ESTOQUE;

USE BD19_CONTROLE_ESTOQUE;
/* Cria a tabela Clientes - Autorelacionamento */

CREATE TABLE clientes
(
	id int unsigned not null auto_increment,
    nome varchar(45) not null,
    SOBRENOME VARCHAR (45) NOT NULL,
	ENDERECO varchar(45) NOT NULL,
	TELEFONE varchar(15) not null DEFAULT ' ',
    PRIMARY KEY (id)
   
);

#Cria a tabela Produtos
use BD19_CONTROLE_ESTOQUE;
CREATE table PRODUTOS(
ID INT unsigned NOT null auto_increment,
PRODUTO VARCHAR (25) NOT NULL,
QUANT double NOT NULL DEFAULT '0',
VALOR DOUBLE NOT NULL DEFAULT '0',
primary key(ID)
);

#Cria a tabela Pedidos
use BD19_CONTROLE_ESTOQUE;
CREATE table PEDIDOS(
ID INT unsigned NOT null auto_increment,
CLIENTE_ID INT UNSIGNED DEFAULT NULL,
PRODUTO_ID INT UNSIGNED DEFAULT NULL,
QUANT double NOT NULL DEFAULT '0',
primary key(ID),
CONSTRAINT FK_PEDIDOS_CLIENTES FOREIGN KEY (CLIENTE_ID) 
REFERENCES CLIENTES(ID),
CONSTRAINT FK_PEDIDOS_PRODUTOS FOREIGN KEY (PRODUTO_ID) 
REFERENCES PRODUTOS(ID));

INSERT CLIENTES (ID, NOME, SOBRENOME, ENDERECO, TELEFONE)
VALUES (1, 'FERNANDO', 'OLIVEIRA', 'RUA 1 - NÚMERO 1', '11 11111 1111');
INSERT CLIENTES (ID, NOME, SOBRENOME, ENDERECO, TELEFONE)
VALUES (NULL, 'MARIA', 'SILVA', 'RUA 2 - NÚMERO 2', '22 22222 2222');
INSERT CLIENTES (ID, NOME, SOBRENOME, ENDERECO, TELEFONE)
VALUES (NULL, 'JOÃO', 'COSTA', 'RUA 3 - NÚMERO 3', '33 33333 3333');
INSERT CLIENTES (ID, NOME, SOBRENOME, ENDERECO, TELEFONE)
VALUES (NULL, 'TEREZA', 'CONCEIÇÃO', 'RUA 4 - NÚMERO 4', '44 4444 4444');
INSERT CLIENTES (ID, NOME, SOBRENOME, ENDERECO, TELEFONE)
VALUES (NULL, 'MARINA', 'MACHADO', 'RUA 5 - NÚMERO 5', '55 55555 5555');
SELECT * FROM CLIENTES;

# Insere dados na Tabela Produtos
INSERT PRODUTOS (ID, PRODUTO, QUANT, VALOR)
VALUES (1, 'TV', 11, 1000);
INSERT PRODUTOS (ID, PRODUTO, QUANT, VALOR)
VALUES (2, 'GELADEIRA', 12, 2000);
INSERT PRODUTOS (ID, PRODUTO, QUANT, VALOR)
VALUES (3, 'MICROONDAS', 13, 3000);
INSERT PRODUTOS (ID, PRODUTO, QUANT, VALOR)
VALUES (4, 'CAMA', 14, 1500);
INSERT PRODUTOS (ID, PRODUTO, QUANT, VALOR)
VALUES (5, 'COMPUTADOR', 15, 500);
Select * from Produtos;

# Insere dados na Tabela Pedidos
INSERT PEDIDOS (ID, CLIENTE_ID, PRODUTO_ID, QUANT)
VALUES (1, 5, 5, 1);
INSERT PEDIDOS (ID, CLIENTE_ID, PRODUTO_ID, QUANT)
VALUES (2, 4, 4, 2);
INSERT PEDIDOS (ID, CLIENTE_ID, PRODUTO_ID, QUANT)
VALUES (3, 3, 3, 3);
INSERT PEDIDOS (ID, CLIENTE_ID, PRODUTO_ID, QUANT)
VALUES (4, 2, 2, 4);
INSERT PEDIDOS (ID, CLIENTE_ID, PRODUTO_ID, QUANT)
VALUES (5, 1, 1, 5);
Select * from PEDIDOS;


select Pedidos.Id as 'Número do Pedido', Clientes.id as 'Código do Cliente', Nome,
Produtos.id as 'Código do Produto', Produto, Pedidos.Quant as 'Quant Pedida', 
Produtos.Quant as 'quant em estoque' 
from Pedidos 
inner join Clientes on cliente_id = Clientes.id
inner join Produtos on Produto_id = Produtos.id;

/*
select * from Clientes left join Produtos on Cliente_id = Clientes.id;
select * from Clientes right join Produtos on Cliente_id = Clientes.id;

Select * from PRODUTOS LEFT JOIN CLIENTES ON CLIENTE_ID = CLIENTES.ID UNION
Select * from PRODUTOS RIGHT JOIN CLIENTES ON CLIENTE_ID = CLIENTES.ID;*/

USE BD19_CONTROLE_ESTOQUE;

SET SQL_SAFE_UPDATES = 0;
update produtos 
inner join pedidos on produtos.ID = pedidos.produto_id
set produtos.quant = produtos.quant - pedidos.quant;

select * from PEDIDOS;