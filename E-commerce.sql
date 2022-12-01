-- Criação de banco de dados para E-commerce

CREATE DATABASE Ecommerce;
USE Ecommerce;

-- Criar tabela cliente
CREATE TABLE cliente(
 id_cliente INT AUTO_INCREMENT  primary key NOT NULL,
 nome_cliente varchar(100),
 CPF char(11) not null ,
 endereco varchar(50),
 data_nascimento date,
 constraint unique_CPF_cliente unique(CPF)
);
desc cliente;

alter table cliente auto_increment = 1;

-- Criar tabela produto
CREATE TABLE produto(
 id_produto INT primary key NOT NULL,
 classificação_crianca bool,
 nome_produto varchar(25) not null,
 categoria varchar(25) not null,
 valor_produto float not null,
 disponibilidade enum('Disponivel', 'Não Disponivel'),
 avaliacao float default 0
);
desc produto;

/*
-- Criar tabela pagamento
CREATE TABLE pagamento(
  id_cliente int,
  id_pagamento int,
  tipo_pagamento enum('Dinheiro','Boleto','Cartão de Credito','Cartão de Debito'), -- Dinheiro = Pix
  limite_cartao float,
  primary key(id_cliente,id_pagamento)
);
desc pagamento;*/

-- Criar tabela pedido
CREATE TABLE pedido(
 id_pedido INT AUTO_INCREMENT  primary key NOT NULL,
 id_cliente int,
 status_pedido enum('Cancelado','Pagamento Confirmado', 'Processando', 'Enviado', 'Entregue','Concluido'),
 descricao_pedifo varchar(45),
 frete float default 0,
 pagamento_con bool default false,
 constraint fk_cliente_pedido foreign key (id_cliente) references cliente(id_cliente)
);
alter table pedido auto_increment = 1;
desc pedido;

-- Criar tabela estoque
CREATE TABLE estoque(
 id_estoque int primary key not null,
 local_estoque varchar(45) not null,
 quantidade int  default 0
);
desc estoque;

-- Criar tabela fornecedor
CREATE TABLE fornecedor(
 id_fornecedor int auto_increment primary key not null,
 razao_social varchar(45),
 CNPJ char(15) not null,
 contato char(14) not null,
 constraint unique_fornecedor unique (CNPJ)
);
alter table fornecedor auto_increment = 1;
desc fornecedor;

-- Criar tabela vendedor
CREATE TABLE vendedor(
 id_vendedor int auto_increment primary key not null,
 razao_social varchar(45) not null,
 nome_fantasia varchar(45),
 endereco varchar(50),
 CNPJ char(15) ,
 CPF char(9),
 Contato char(14) not null,
 nome_vendedor varchar(50) not null,
 constraint unique_CNPJ_vendedor unique (CNPJ),
 constraint unique_CPF_vendedor unique (CPF)
);
alter table vendedor auto_increment = 1;
desc vendedor;

-- Criar tabela produto_vendedor
CREATE TABLE  produto_vendedor(
 id_vendedor int,
 id_produto int,
 quantidade int default 1,
 primary key (id_vendedor,id_produto),
 constraint fk_produto_vendedor foreign key (id_vendedor) references vendedor (id_vendedor),
 constraint fk_produto_produto foreign key (id_produto) references produto(id_produto)
);
desc produto_vendedor;

-- Criar tabela produto_pedido
CREATE TABLE  produto_pedido(
 id_produto int,
 id_pedido int,
 quantidade int default 1,
 status_p ENUM('disponivel', 'sem estoque'),
 primary key (id_produto,id_pedido),
 constraint fk_produto_pedido foreign key (id_produto) references produto(id_produto),
 constraint fk_pedido_pedido foreign key (id_pedido) references pedido(id_pedido)
);
desc produto_pedido;

-- Criar tabela produto_fornecedor
CREATE TABLE  produto_fornecedor(
 id_produto int,
 id_fornecedor int,
 quantidade int default 1,
 primary key (id_produto,id_fornecedor),
 constraint fk_produto_fornecedor foreign key (id_produto) references produto(id_produto),
 constraint fk_fornecedor_produto foreign key (id_fornecedor) references fornecedor(id_fornecedor)
);
desc produto_fornecedor;

-- Criar tabela produto_estoque
CREATE TABLE  produto_estoque(
 id_estoque int,
 id_produto int,
 localizacao varchar(45) not null,
 primary key (id_estoque,id_produto),
 constraint fk_estoque_produto foreign key (id_estoque) references estoque(id_estoque),
 constraint fk_produto_estoque foreign key (id_produto) references produto(id_produto)
);
desc produto_estoque;




