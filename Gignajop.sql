create database Gignajop;

use Gignajop;

create table endereco (
idEndereco int primary key auto_increment,
cep char (9),
rua varchar (45),
bairro varchar(45),
cidade varchar (45),
estado varchar(45)
);

insert into endereco 
values (null, '12345-678', 'Haddock Lobo', 'Consolação', 'São Paulo', 'São Paulo'),
	   (null, '12345-856', 'Augusta', 'Consolação', 'São Paulo', 'São Paulo');

create table cliente (
idCliente int primary key auto_increment,
nome varchar (45),
sobrenome varchar (45),
cpf char(14),
qtdAcompanhante int,
fkAcompanhante int,
constraint fkAcompanhante foreign key (fkAcompanhante)
references Cliente (idcliente)
);

insert into cliente 
values (null, 'Eva', 'Santos', '451.623.012-01', 1, null),
	   (null, 'Adão', 'Santos', '253.623.012-02', 0, 1);
       
insert into cliente values 
(null, 'Guilherme', 'Gonçalves', '539.263.008-17', 1, null),
(null, 'Giovanna', 'Freitas', '508.007.098-61', 0, 3);
       
create table complemento (
idComplemento int auto_increment,
fkCliente int, 
fkEndereco int,
numero varchar(10),
complemento varchar (30),
constraint fkCliente foreign key (fkCliente)
references cliente (idCliente),
constraint fkEndereco foreign key (fkEndereco)
references endereco (idEndereco),
constraint pkComp primary key (idComplemento, fkCliente, fkEndereco)
);

insert into complemento 
values (null, 1, 1, '595', 'ap 32');

create table viagem (
idViagem int primary key auto_increment,
local varchar(45)
);

insert into viagem 
values (null, 'Disney');

create table contrato (
fkClienteCont int,
constraint fkclientecont foreign key (fkClienteCont)
references cliente (idCliente),
fkViagem int,
constraint fkviagem foreign key (fkViagem)
references viagem (idViagem),
idContrato varchar(45),
constraint pkCompost primary key (idContrato, fkClienteCont, fkViagem),
dtHorarioAssinatura datetime,
seguro tinyint,
valorTotal decimal
);

insert into contrato 
values (1, 1, '1', '2023-05-30 12:51', 1, '25');

create table hospedagem (
idHospedagem int primary key auto_increment,
tipo varchar (45),
numCamas int,
nomeLocal varchar (100),
refeicao varchar(45),
fkViagemHosp int,
constraint fkViagemHos foreign key (fkViagemHosp)
references viagem (idViagem)
);

insert into hospedagem 
values (null, 'Hotel', 2, 'Disney', 'all inclusive', 1);

create table complementoHosp (
idComplementoHosp int auto_increment,
fkHospedagem int,
fkEnderecoHosp int,
numero varchar (10),
constraint fkHospedagem foreign key (fkHospedagem)
references hospedagem (idHospedagem),
constraint fkEnderecoHosp foreign key (fkEnderecoHosp)
references endereco (idEndereco),
constraint pkCompostaH primary key (idComplementoHosp, fkHospedagem, fkEnderecoHosp)
);



insert into complementoHosp 
values (null, 1, 2, '1502');

create table transporte (
idTransporte int primary key auto_increment,
meioTransporte varchar(45),
preco float,
numDiarias int,
fkViagemTransp int,
constraint fkViagemTransp foreign key (fkViagemTransp)
references viagem (idViagem)
);

insert into transporte
values (null, 'Avião', 4000, 5, 1);

create table recomendacoes (
idRec int auto_increment,
tipo varchar (45),
distanciaHosp varchar (45),
fkViagemRec int,
constraint fkViagemRec foreign key (fkViagemRec)
references viagem (idViagem),
constraint pkCompostaR primary key (idRec, fkViagemRec)
);



insert into recomendacoes 
values (null, 'Ponto de Turismo', '30 minutos', 1),
	   (null, 'Restaurante', '10 minutos', 1);
       


-- 15 SELECTS FÁCEIS 

select * from endereco;
select * from complemento;
select * from cliente;
select * from viagem;
select * from contrato;
select * from hospedagem;
select * from complementoHosp;
select * from transporte;
select * from recomendacoes;
select * from complemento join cliente on fkCliente = idCliente join endereco on fkEndereco = idEndereco;
select * from viagem join hospedagem on fkViagemHosp = idViagem;
select * from transporte join viagem on fkViagemTransp = idViagem;
select * from recomendacoes join viagem on fkViagemRec = idViagem;
select * from complementoHosp join endereco on fkEnderecoHosp = idEndereco;
select * from contrato join cliente on fkClienteCont = idCliente join viagem on fkViagem = idViagem;

-- 10 SELECTS MÉDIOS
select cliente.nome as Nome,
	   cliente.cpf as Cpf,
       acompanhante.nome as Nome_Acompanhante,
       acompanhante.cpf as Cpf_Acompanhante
       from cliente as cliente join cliente as acompanhante 
       on acompanhante.fkAcompanhante = cliente.idCliente;
       
select viagem.local as Local,
hospedagem.tipo as TipoHospedagem,
transporte.meioTransporte as MeioTrasporte,
recomendacoes.tipo as TipoRecomendacoes
from viagem join hospedagem 
            on idViagem = fkViagemHosp
            join transporte 
            on idViagem = fkViagemTransp
            join recomendacoes 
            on idViagem = fkViagemRec;
            
select sum(valorTotal) from contrato;

select round(avg(valorTotal),2) from contrato;
       
-- 5 SELECTS DIFÍCEIS


-- 2 CHALLENGE

select cliente.nome as Nome,
	   cliente.cpf as Cpf,
       acompanhante.nome as Nome_Acompanhante,
       acompanhante.cpf as Cpf_Acompanhante,       
       viagem.local as Destino,   
       contrato.valorTotal as Valor,
       hospedagem.nomeLocal as Nome_Hospedagem,
       hospedagem.tipo as Tipo_Hospedagem,       
       transporte.meioTransporte as Transporte,
       recomendacoes.tipo as Tipo_Recomendacoes,
       recomendacoes.distanciaHosp as Distancia_Hospedagem
       from cliente as cliente  left join  cliente as acompanhante 
       on acompanhante.fkAcompanhante = cliente.idCliente
       right join contrato on contrato.fkClienteCont = cliente.idCliente
       right join viagem on contrato.fkViagem = viagem.idViagem
       right join hospedagem on hospedagem.fkViagemHosp = Viagem.idViagem
       right join transporte on transporte.fkViagemTransp = Viagem.idViagem
       right join recomendacoes on recomendacoes.fkViagemRec = Viagem.idViagem
       ;