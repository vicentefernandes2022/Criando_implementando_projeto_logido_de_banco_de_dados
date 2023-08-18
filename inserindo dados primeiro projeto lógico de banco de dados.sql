use ecomerce;
show tables;

insert into clients (Fname, Minit, Lname, CPF, Address)
		values('Maria','M','Silva',12346789,'rua silva de prata 29, Carangola - cidade das flores'),
			  ('Mateus','O','Pimentel',987654321,'rua alameda 289 -centro - cidade das flores'),
			  ('Ricardo','F','Silva',456789123,'avenida alameda vinha 1079, centro - cidade das flores'),
			  ('Julia','S','França',789123456,'Rua laranjeiras 861, centro - cidade das flores'),
			  ('Roberta','G','Assis',978456254,'avenida Koller 19, centro - cidade das flores'),
			  ('Isabela','M','Cruz',654789123,'rua alameda das flores 2078, centro - cidade das flores');
              
select * from clients;

insert into product (Pname, classification_kids, category, avaliação, size) values
						('Fone de ouvido',false,'Eletrônico','4',null),
                        ('Barbie Elsa',true,'Brinquedos','3',null),
                        ('Boby Carters',true,'Vestimenta','5',null),
                        ('Microfone Vedo - Youtuber',false,'Eletrônico','4',null),
                        ('Sofa retratil',false,'Móveis','3','3x57x80'),
                        ('Farinha de arroz',false,'Alimentos','2',null),
                        ('Fire stick amazon',false,'Eletrônico','3',null);

select * from product;

delete from orders where idOrderClient in (1,2,3,4);

alter table orders auto_increment = 1;

insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values
						(1, default, 'compra via apliativo', null, 1),
                        (2, default, 'compra via apliativo', 50, 0),
                        (3, 'Confirmado', null, null, 1),
                        (4, default, 'compra via web site', 150, 0);
                        
select * from orders;

insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus) values
							(1, 1, 2, default),
                            (2, 1, 1, default),
                            (3, 2, 1, default);
                            
select * from productOrder;

insert into productStorage (storageLocation,quantity) values
							('Rio de Janeiro',1000),
                            ('Rio de Janeiro',500),
                            ('São Paulo',10),
                            ('São Paulo',100),
                            ('São Paulo',10),
                            ('Brasilia',60);
                            
select * from productStorage;

insert into storageLocation (idLproduct, idLstorange, location) values
							(1, 2, 'RJ'),
                            (2, 6, 'GO');
                            
select * from storageLocation;

insert into supplier (socialName, CNPJ, contact) values
						('Almeida e filhos', 123456789123456, '21985474'),
                        ('Eletrônicos Silva', 854519649143457, '21985484'),
                        ('Eletronicos Valma', 985542222663351, '21544552');
                        
insert into productSupplier (idPsSupplier,idPsProduct, quantity) values
							(1,1,500),
                            (1,2,400),
                            (2,4,633),
                            (3,3,5),
                            (2,5,10);
                            
insert into seller (SocialName, AbstName, CNPJ, CPF, location, contact) values
					('Tech Eletrônicos', null, 123456789123456, null, 'Rio de Janeiro',21998554412),
                    ('Botique Douglas', null, null,123456783, 'Rio de Janeiro',21981544469),
                    ('Kids World', null, 25415555666999, null, 'São Paulo',11978445222);
                    
insert into productSeller (idPseller, idPproduct, prodQuantity) values
							(1,6,80),
                            (2,7,10);
                            
select count(*) from clients;

select * from clients c, orders o where c.idClient = idOrderClient;

select Fname, Lname, idOrder, orderStatus from clients c, orders o where c.idClient = idOrderClient;

select concat(Fname,' ', Lname) as Client, idOrder as Request, orderStatus as Status from clients c, orders o where c.idClient = idOrderClient;

insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values
						(2, default, 'compra via apliativo', null, 1);
                        
select * from orders;

-- recuperação de pedido com produto associado
select * from clients c
					inner join orders o on c.idClient = o.idOrderClient
					inner join productOrder p on p.idPOorder = o.idOrder
				group by idClient;

-- consultar quantidade de pedidos realizado pelos clientes
select idClient, concat(Fname,' ',Lname) as Nome, count(*) as Quantidade_de_pedidos from clients c inner join orders o on c.idClient = o.idOrderClient
					inner join productOrder p on p.idPOorder = o.idOrder
                    group by idClient;