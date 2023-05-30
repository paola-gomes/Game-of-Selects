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