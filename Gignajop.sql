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
select * from transporte;
select * from complementoHosp;
select * from recomendacoes;
select * from complementoHosp join endereco on fkEnderecoHosp = idEndereco;
select * from viagem join hospedagem on idViagem = fkViagemHosp;
select * from cliente join contrato on idCliente = fkClienteCont;
select * from transporte join viagem on fkViagemTransp = idViagem;
select * from recomendacoes join viagem on fkViagemRec = idViagem;


-- 10 SELECTS MÉDIOS

select nome, sobrenome from cliente where nome like 'G%';

select * from viagem join hospedagem on fkViagemHosp = idViagem;

select cliente.nome as Nome,
cliente.cpf as Cpf,
acompanhante.nome as Nome_Acompanhante,
acompanhante.cpf as Cpf_Acompanhante
from cliente as cliente join cliente as acompanhante 
on acompanhante.fkAcompanhante = cliente.idCliente;
       
select c.nome, c.sobrenome, c.cpf, cont.idContrato, cont.dtHorarioAssinatura, cont.seguro, cont.valorTotal
from cliente c
inner join contrato cont on c.idCliente = cont.fkClienteCont
order by c.nome asc;
       
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
            
select sum(valorTotal) as somaTotal from contrato;

select round(avg(valorTotal),2) as Media from contrato;

select v.local, SUM(distanciaHosp) as totalDistanciaRecomendacoes
from viagem v
left join recomendacoes r on v.idViagem = r.fkViagemRec
group by v.local;

select c.idContrato, e.rua, e.bairro, e.cidade, e.estado
from contrato c
join cliente cl on c.fkClienteCont = cl.idCliente
join complemento comp on comp.fkCliente = cl.idCliente
join endereco e on comp.fkEndereco = e.idEndereco;

select cl.idCliente, cl.nome, cl.sobrenome, cl.cpf, e.cep, e.rua, e.bairro, e.cidade, e.estado
from cliente cl
join complemento comp on cl.idCliente = comp.fkCliente
join endereco e on comp.fkEndereco = e.idEndereco;

select v.local, c.nome, c.sobrenome, c.cpf, c.idCliente, cont.dtHorarioAssinatura
from viagem v
join contrato cont on v.idViagem = cont.fkViagem
join cliente c on cont.fkClienteCont = c.idCliente
where c.idCliente = 1
order by cont.dtHorarioAssinatura;

       
-- 5 SELECTS DIFÍCEIS

select v.local, h.tipo as tipo_hospedagem, h.nomeLocal as local_hospedagem, t.meioTransporte, t.numDiarias
from viagem v
left join hospedagem h on v.idViagem = h.fkViagemHosp
left join transporte t on v.idViagem = t.fkViagemTransp;

select c.nome as Cliente, 
cont.idContrato as ID_Contrato, 
v.local as Local_Viagem, 
h.nomeLocal as Hospedagem, 
t.meioTransporte as Transporte
from cliente c
join contrato cont on c.idCliente = cont.fkClienteCont
join viagem v on cont.fkViagem = v.idViagem
join hospedagem h on v.idViagem = h.fkViagemHosp
join transporte t on v.idViagem = t.fkViagemTransp;

select c.nome as Nome_Cliente, c.cpf as CPF_Cliente,
acomp.nome as Nome_Acompanhante, acomp.cpf as CPF_Acompanhante,
v.local as Destino_Viagem, cont.valorTotal as Valor_Viagem,
h.nomeLocal as Nome_Hospedagem, h.tipo as Tipo_Hospedagem,
trans.meioTransporte as Meio_Transporte,
rec.tipo as Tipo_Recomendacao, rec.distanciaHosp as Distancia_Hospedagem
from cliente c
left join cliente acomp on c.fkAcompanhante = acomp.idCliente
join contrato cont on c.idCliente = cont.fkClienteCont
join viagem v on cont.fkViagem = v.idViagem
join hospedagem h on v.idViagem = h.fkViagemHosp
join transporte trans on v.idViagem = trans.fkViagemTransp
left join recomendacoes rec on v.idViagem = rec.fkViagemRec;

select v.local as Destino_Viagem, 
sum(cont.valorTotal + trans.preco) as Total_Viagem_Transporte
from viagem v
join contrato cont on v.idViagem = cont.fkViagem
join transporte trans on v.idViagem = trans.fkViagemTransp
group by v.local;

select c.nome as Nome_Cliente, 
eCliente.cep as CEP_Cliente, 
eCliente.rua as Rua_Cliente, 
eCliente.bairro as Bairro_Cliente, 
eCliente.cidade as Cidade_Cliente, 
eCliente.estado as Estado_Cliente,
acomp.nome as Nome_Acompanhante,
eAcomp.cep as CEP_Acompanhante, 
eAcomp.rua as Rua_Acompanhante, 
eAcomp.bairro as Bairro_Acompanhante, 
eAcomp.cidade as Cidade_Acompanhante, 
eAcomp.estado as Estado_Acompanhante
from cliente c
left join endereco eCliente on c.idCliente = eCliente.idEndereco
left join cliente acomp on c.fkAcompanhante = acomp.idCliente
left join endereco eAcomp on acomp.idCliente = eAcomp.idEndereco;


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
       
select c.nome, c.sobrenome, c.cpf, comp.numero as numero_complemento, comp.complemento, 
e.cep, e.rua, e.bairro, 
e.cidade, e.estado, h.tipo as tipo_hospedagem, 
h.numCamas, h.nomeLocal as local_hospedagem, 
t.meioTransporte, t.numDiarias
from cliente c
left join complemento comp on c.idCliente = comp.fkCliente
left join endereco e on comp.fkEndereco = e.idEndereco
left join contrato cont on c.idCliente = cont.fkClienteCont
left join hospedagem h on cont.fkViagem = h.fkViagemHosp
left join transporte t on cont.fkViagem = t.fkViagemTransp
where c.qtdAcompanhante = 0;