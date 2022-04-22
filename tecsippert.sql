create database TECSIPPERT;
use TECSIPPERT;

create table CLIENTES(
ID INT unsigned auto_increment NOT null,
NOME varchar(255) NOT null,
ENDEREÇO varchar(255) NOT null,
CEP varchar(8) NOT null,
TELEFONE varchar(11) NOT null,
QUEM_INDICOU varchar(255) NOT null,
HORARIO_CONTATO varchar(255) NOT null,
primary key (ID)
);

create table SERVIÇOS(
ID INT unsigned auto_increment NOT null,
SERVIÇO_FEITO varchar(255) NOT null,
primary key (ID)
);

create table PRODUTOS(
ID INT unsigned auto_increment NOT null,
NOME varchar(255) NOT null,
FUNCIONALIDADE text NOT null,
VALOR varchar(255) NOT null,
QUANTIDADE varchar(255) NOT null,
primary key (ID)
);

create table PEDIDOS(
ID INT unsigned auto_increment NOT null,
CLIENTE_ID INT unsigned default null,
PRODUTO_ID INT unsigned default null,
SERVIÇO_ID INT unsigned default null,
primary key (ID),

CONSTRAINT FK_PEDIDOS_CLIENTES
FOREIGN KEY (CLIENTE_ID)
REFERENCES CLIENTES(ID),

CONSTRAINT FK_PEDIDOS_PRODUTOS
FOREIGN KEY (PRODUTO_ID)
REFERENCES PRODUTOS(ID),

CONSTRAINT FK_PEDIDOS_SERVIÇOS
FOREIGN KEY (SERVIÇO_ID)
REFERENCES SERVIÇOS(ID)
);


INSERT INTO CLIENTES (ID, NOME, ENDEREÇO, CEP, TELEFONE, QUEM_INDICOU, HORARIO_CONTATO)
VALUES (1, 'Douglas (Sudeste)', 'Estrada João de Oliveira Remião 5400 - Torre 9 do 201',
'91787750', '51994040754', 'Ninguém', ' A partir das 15h');
INSERT INTO CLIENTES (ID, NOME, ENDEREÇO, CEP, TELEFONE, QUEM_INDICOU, HORARIO_CONTATO)
VALUES (null, 'Guilherme Ramgrab', 'Rua Luiz Francisco Zanella - 75', '91790800', '51995722450',
'Matheus Fernandes da Rosa', ' A partir das 18h');
INSERT INTO CLIENTES (ID, NOME, ENDEREÇO, CEP, TELEFONE, QUEM_INDICOU, HORARIO_CONTATO)
VALUES (null, 'Arthur Duarte', 'Rua Aldo Sani - 54', '91788070', '51998032693',
'Matheus Fernandes da Rosa', ' A partir das 18h');


INSERT INTO PRODUTOS (ID, NOME, FUNCIONALIDADE, VALOR, QUANTIDADE)
VALUES (1, 'Mão de Obra', 'Mão de Obra', 'A calcular', '1');
INSERT INTO PRODUTOS (ID, NOME, FUNCIONALIDADE, VALOR, QUANTIDADE)
VALUES (null, 'Cano de Cobre 3/8', 'Instalar Ar Condicionado', 'R$150,00', '12m');
INSERT INTO PRODUTOS (ID, NOME, FUNCIONALIDADE, VALOR, QUANTIDADE)
VALUES (null, 'Cano de Cobre 1/4', 'Instalar Ar Condicionado', 'R$100,00',
'Uma panqueca de 15m');

INSERT INTO SERVIÇOS (ID, SERVIÇO_FEITO)
VALUES (1, 'Instalação de Ar Condicionado');
INSERT INTO SERVIÇOS (ID, SERVIÇO_FEITO)
VALUES (2, 'Manutenção de Máquina de Lavar');
INSERT INTO SERVIÇOS (ID, SERVIÇO_FEITO)
VALUES (3, 'Manutenção de Microondas');
INSERT INTO SERVIÇOS (ID, SERVIÇO_FEITO)
VALUES (4, 'Manutenção de Ar Condicionado');

INSERT INTO PEDIDOS (ID, CLIENTE_ID, PRODUTO_ID, SERVIÇO_ID)
VALUES (1, 2, 2, 1);
INSERT INTO PEDIDOS (ID, CLIENTE_ID, PRODUTO_ID, SERVIÇO_ID)
VALUES (null, 1, 1, 2);
INSERT INTO PEDIDOS (ID, CLIENTE_ID, PRODUTO_ID, SERVIÇO_ID)
VALUES (null, 1, 1, 2);
INSERT INTO PEDIDOS (ID, CLIENTE_ID, PRODUTO_ID, SERVIÇO_ID)
VALUES (null, 3, 1, 3);
INSERT INTO PEDIDOS (ID, CLIENTE_ID, PRODUTO_ID, SERVIÇO_ID)
VALUES (null, 2, 3, 1);

select * from CLIENTES;
select * from SERVIÇOS;
select * from PRODUTOS;
select * from PEDIDOS;

ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';

/*Consulta todos os pedidos realizados*/
select PEDIDOS.ID as 'NÚMERO DO PEDIDO', PEDIDOS.CLIENTE_ID, CLIENTES.NOME, PEDIDOS.PRODUTO_ID, PRODUTOS.NOME as 'NOME DO PRODUTO UTILIZADO',
PEDIDOS.SERVIÇO_ID, SERVIÇO_FEITO
from PEDIDOS
inner join PRODUTOS
on PRODUTOS.ID = PEDIDOS.PRODUTO_ID
inner join CLIENTES
on CLIENTES.ID = PEDIDOS.CLIENTE_ID
inner join SERVIÇOS
on SERVIÇOS.ID = PEDIDOS.SERVIÇO_ID;

/*Consulta os pedidos e serviços realizados pelo Guilherme*/
select PEDIDOS.ID as 'NÚMERO DO PEDIDO', PEDIDOS.CLIENTE_ID, CLIENTES.NOME, PEDIDOS.PRODUTO_ID, PRODUTOS.NOME as 'NOME DO PRODUTO UTILIZADO',
PEDIDOS.SERVIÇO_ID, SERVIÇO_FEITO
from PEDIDOS
inner join PRODUTOS
on PRODUTOS.ID = PEDIDOS.PRODUTO_ID
inner join CLIENTES
on CLIENTES.ID = PEDIDOS.CLIENTE_ID
inner join SERVIÇOS
on SERVIÇOS.ID = PEDIDOS.SERVIÇO_ID
where CLIENTES.NOME = 'Guilherme Ramgrab';

/*Consulta todos os pedidos realizados onde o serviço feito foi "Manutenção de Máquina de Lavar"*/
select PEDIDOS.ID as 'NÚMERO DO PEDIDO', PEDIDOS.CLIENTE_ID, CLIENTES.NOME, PEDIDOS.PRODUTO_ID, PRODUTOS.NOME as 'NOME DO PRODUTO UTILIZADO',
PEDIDOS.SERVIÇO_ID, SERVIÇO_FEITO
from PEDIDOS
inner join PRODUTOS
on PRODUTOS.ID = PEDIDOS.PRODUTO_ID
inner join CLIENTES
on CLIENTES.ID = PEDIDOS.CLIENTE_ID
inner join SERVIÇOS
on SERVIÇOS.ID = PEDIDOS.SERVIÇO_ID
where SERVIÇO_FEITO = 'Manutenção de Máquina de Lavar';

/*Quantos clientes o "Matheus Fernandes da Rosa" indicou*/
select CLIENTES.ID, CLIENTES.NOME, QUEM_INDICOU
from CLIENTES
where QUEM_INDICOU = 'Matheus Fernandes da Rosa'