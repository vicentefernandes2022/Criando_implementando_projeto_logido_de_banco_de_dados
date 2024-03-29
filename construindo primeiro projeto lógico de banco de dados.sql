-- Criação do banco de dados para um cenário de E-commerce
-- drop database ecomerce;
create database ecomerce;
use ecomerce;

-- criar tabela cliente
create table clients(
		idClient int auto_increment primary key,
        Fname varchar(10),
        Minit char(3),
        Lname varchar(20),
        CPF char(11) not null,
        Address varchar(60),
        constraint unique_cpf_client unique (CPF)
);

alter table clients auto_increment = 1;

desc clients;
-- criar tabela produto

-- size equivale a dimensão do produto
create table product(
		idProduct int auto_increment primary key,
        Pname varchar(30) not null,
        classification_kids bool default false,
        category enum('Eletronico','Vestimenta','Brinquedos','Alimentos','Moveis') not null,
        avaliação float default 0,
        size varchar(10)
);

alter table product auto_increment = 1;

-- criar tabela pagamento
-- para ser continuado no desafio: termine de implementar a tabela e crie a conexão com as tabelas necessarias
-- além disso, reflita essa modificação no diagrama de esquema relacional
-- criar constraints relacionadas ao pagamento
create table payments(
	idClient int,
    idPayment int,
    typePayment enum('Boleto','Cartão','Dois cartões'),
    limitAvailable float,
    primary key (idClient, idPayment)
);


-- criar tabela pedido

create table orders(
	idOrder int auto_increment primary key,
    idOrderClient int,
    orderStatus enum('Cancelado','Confirmado','Em processamento') default 'Em processamento',
    orderDescription varchar(255),
    sendValue float default 10,
    paymentCash boolean default false,
    constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
			on update cascade
);

alter table orders auto_increment = 1;

desc orders;

-- criar tabela estoque

create table productStorage(
	idProdstorage int auto_increment primary key,
    storageLocation varchar(255),
    quantity int default 0
);

alter table productStorage auto_increment = 1;

-- criar tabela fornecedor

create table supplier(
	idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
    Contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);

alter table supplier auto_increment = 1;

desc supplier;

-- criar tabela vendedor

create table seller(
	idSeller int auto_increment primary key,
    SocialName varchar(255) not null,
    AbstName varchar(255),
    CNPJ char(15),
    CPF char(11),
    location varchar(255),
    Contact char(11) not null,
    constraint unique_cnpf_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF)
);

alter table seller auto_increment = 1;

create table productSeller(
	idPseller int,
    idPproduct int,
    prodQuantity int default 1,
    primary key (idPseller, idPproduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idPproduct) references product(idProduct)
);


create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponível','Sem estoque') default 'Disponível',
    primary key (idPOproduct, idPOorder),
    constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
    constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
);

create table storageLocation(
	idLproduct int,
    idLstorange int,
    location varchar(255) not null,
    primary key (idLproduct, idLstorange),
    constraint fk_storage_locatior_product foreign key (idLproduct) references product(idProduct),
    constraint fk_storage_locatior_storage foreign key (idLstorange) references productStorage(idProdStorage)
);

create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier,idPsProduct),
	constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
	constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);

show tables;

show databases;

use information_schema;
show tables;
desc REFERENTIAL_CONSTRAINTS;
select * from REFERENTIAL_CONSTRAINTS where constraint_schema = 'ecomerce';

use ecomerce;
select * from clients;
desc clients;