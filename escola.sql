create database escola;

use escola;

create table professor(
	id_professor int primary key auto_increment,
	materia text NOT NULL,
    nome text NOT NULL,
    cpf varchar(15) NOT NULL UNIQUE,
    idade int NOT NULL CHECK(idade > 18 AND idade < 90),
    sexo char(1),
    email varchar(100) NOT NULL UNIQUE,
    orientador varchar(20), /* Cada professor tem pelo menos 1 sala como orientador */
    foreign key(id_professor) references informacoes_professor(id_professor)
);

create table informacoes_professor(
    id_professor int,
    telefone varchar(30) NOT NULL UNIQUE,
    rua text,
    numero varchar(6),
    bairro text,
    cidade text,
    estado text,
    formacao text NOT NULL,
    salario decimal(10, 2) NOT NULL,
    foreign key(id_professor) references professor(id_professor)
);

create table aluno(
	id_aluno int primary key auto_increment,
    nome text,
    data_nascimento date,
    cpf varchar(15) NOT NULL UNIQUE,
	serie varchar(10) NOT NULL,
	deficiente char(1) CHECK (deficiente IN ('S', 'N')), /* Responder apenas com S ou N */
    anotacao varchar(800), /* Esse campo será destinado para especificar caso o aluno em questão tenha alguma deficiência ou 
    algum disturbio a ser informado para a escola */
    nota_final int NOT NULL
);

create table informacoes_aluno(
	id_aluno int primary key,
    telefone_responsavel varchar(30) NOT NULL,
	rua text,
    numero varchar(6),
    bairro text,
    cidade text,
    estado text,
    faltas int,
    foreign key(id_aluno) references aluno(id_aluno)
);

create table aula(
	id_prof int NOT NULL UNIQUE,
	materia text,
    sala varchar(10),
    data_aula date,
    horario time,
	foreign key(id_prof) references professor(id_professor)
);

create table diario_classe(
	id_prof int NOT NULL UNIQUE,
	sala varchar(10) NOT NULL UNIQUE, /* O diário é exclusivo dessa classe */
    id_aluno int NOT NULL UNIQUE,
    data_aula date,
    presenca char(1) NOT NULL CHECK (presenca IN ('P','F')), /* Preencher com P para presença e F para Falta */
    atividades decimal(2,2),
    prova decimal(2,2),
    foreign key(id_prof) references professor(id_professor),
    foreign key(id_aluno) references aluno(id_aluno),
    foreign key(data_aula) references aula(data_aula) /* Foi colocado esse foreign key pois 1 professor pode lesionar mais de 1 matéria */
);