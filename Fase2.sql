-- ============================================================================
-- SCRIPT DE CRIAÇÃO DA BASE DE DADOS E TABELAS (FASE 2)
-- UC: Laboratório de Aplicações Web e Bases de Dados
-- Projeto: Sistema de Gestão e Aluguer de Trotinetes
-- ============================================================================

use master
drop database GestaoTrotinetesDB;

create database GestaoTrotinetesDB;
go

use GestaoTrotinetesDB;
go

-- 1. pais
create table pais(
	id_pais int identity(1,1) primary key,
	nome varchar(100) not null
)

-- 3. administrador
create table administrador(
	id_admin int identity(1,1) primary key,
	email varchar(255) not null,
	username varchar(100) not null,
	password_hash varchar(255) not null,
	data_criacao datetime not null default getdate(),
	id_admin_criador int null,
	foreign key (id_admin_criador) references administrador(id_admin)
)

-- 2. cidade
create table cidade(
	id_cidade int identity(1,1) primary key,
	nome varchar(100) not null,
	estado bit not null,
	id_pais int not null,
	--colocar
	foreign key (id_pais) references pais(id_pais)
)



-- 4. utilizador
create table utilizador(
	id_utilizador int identity(1,1) primary key,
	nome varchar(150) not null,
	email varchar(255) not null,
	username varchar(100) not null,
	password_hash varchar(255) not null,
	confirmado bit not null,
	token_confirmacao varchar(255) null,
	data_registo datetime not null,
	id_cidade int not null,
	motivo_remocao varchar(255) null,
	data_remocao datetime null,
	id_admin_remover int null,
	foreign key (id_cidade) references cidade(id_cidade),
	foreign key (id_admin_remover) references administrador(id_admin)
)

-- 5. estacionamento
create table estacionamento(
	id_estacionamento int identity(1,1) primary key,
	nome varchar(150) not null,
	morada varchar(255) not null,
	latitude decimal(10,7) not null,
	longitude decimal(10,7) not null,
	capacidade int not null,
	estado bit not null,
	n_trotinetes int not null,
	id_cidade int not null,
	foreign key (id_cidade) references cidade(id_cidade)
)

-- 6. trotinete
create table trotinete(
	id_trotinete int identity(1,1) primary key,
	codigo varchar(50) not null,
	estado bit not null,
	nivel_bateria int not null,
	id_estacionamento int not null,
	foreign key (id_estacionamento) references estacionamento(id_estacionamento)
)

-- 7. aluguer
create table aluguer(
	id_aluguer int identity(1,1) primary key,
	data_inicio datetime not null,
	data_fim datetime null,
	nivel_bateria int null,
	foto_entrega varchar(500) null,
	id_utilizador int not null,
	id_trotinete int not null,
	id_estacionamento_inicio int not null,
	id_estacionamento_fim int null,
	foreign key (id_utilizador) references utilizador(id_utilizador),
	foreign key (id_trotinete) references trotinete(id_trotinete),
	foreign key (id_estacionamento_inicio) references estacionamento(id_estacionamento),
	foreign key (id_estacionamento_fim) references estacionamento(id_estacionamento)
)