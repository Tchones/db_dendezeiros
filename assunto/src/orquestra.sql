CREATE DATABASE orquestra CHARACTER SET utf8;
 
USE orquestra;

CREATE TABLE preco_pauta (
    id_preco INT(11) NOT NULL AUTO_INCREMENT,
    preco_custo VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_preco)
)  ENGINE=INNODB;

CREATE TABLE _release (
    id_release INT(11) NOT NULL AUTO_INCREMENT,
    texto TEXT NULL,
    PRIMARY KEY (id_release)
)  ENGINE=INNODB;

CREATE TABLE musico_chefe (
    id_musico INT(11) NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) NULL,
    chefe_de_naipe INT(11) NOT NULL,
    PRIMARY KEY (id_musico , chefe_de_naipe),
    FOREIGN KEY (chefe_de_naipe)
        REFERENCES musico_chefe (id_musico)
        ON DELETE CASCADE ON UPDATE NO ACTION
)  ENGINE=INNODB;

CREATE TABLE naipe (
    id_naipe INT(11) NOT NULL AUTO_INCREMENT,
    nome_naipe VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_naipe)
)  ENGINE=INNODB;

CREATE TABLE especialidade (
    id_especialidade INT(11) NOT NULL AUTO_INCREMENT,
    nome_instrumento VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_especialidade)
);

CREATE TABLE musico_naipe_especialidade (
    id_musico INT(11) NOT NULL AUTO_INCREMENT,
    id_naipe INT(11) NOT NULL,
    id_especialidade INT(11) NOT NULL,
    PRIMARY KEY (id_musico, id_especialidade), /* pode haver repetição no conteúdo das colunas relacionadas  */
    FOREIGN KEY (id_musico)
        REFERENCES musico_chefe (id_musico)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_especialidade)
        REFERENCES especialidade (id_especialidade)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_naipe)
        REFERENCES naipe (id_naipe)
        ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE(id_musico, id_naipe), /* não pode haver repetição no conteúdo das colunas relacionadas  */
    UNIQUE(id_naipe, id_especialidade) /* não pode haver repetição no conteúdo das colunas relacionadas  */
)  ENGINE=INNODB;

CREATE TABLE pais (
    id_pais INT(11) NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_pais)
)  ENGINE=INNODB;

CREATE TABLE uf (
    id_uf INT(11) NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    id_pais INT(11) NOT NULL,
    PRIMARY KEY (id_uf),
    FOREIGN KEY (id_pais)
        REFERENCES pais (id_pais)
        ON DELETE NO ACTION ON UPDATE CASCADE
)  ENGINE=INNODB;

CREATE TABLE cidade (
    id_cidade INT(11) NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    id_uf INT(11) NOT NULL,
    PRIMARY KEY (id_cidade),
    FOREIGN KEY (id_uf)
        REFERENCES uf (id_uf)
        ON DELETE NO ACTION ON UPDATE CASCADE
)  ENGINE=INNODB;

CREATE TABLE bairro (
    id_bairro INT(11) NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    id_cidade INT(11) NOT NULL,
    PRIMARY KEY (id_bairro),
    FOREIGN KEY (id_cidade)
        REFERENCES cidade (id_cidade)
        ON DELETE NO ACTION ON UPDATE CASCADE
)  ENGINE=INNODB;

CREATE TABLE rua (
    id_rua INT(11) NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    id_bairro INT(11) NOT NULL,
    PRIMARY KEY (id_rua),
    FOREIGN KEY (id_bairro)
        REFERENCES bairro (id_bairro)
        ON DELETE NO ACTION ON UPDATE CASCADE
)  ENGINE=INNODB;

CREATE TABLE pauta (
    id_pauta INT(11) NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    id_rua INT(11) NOT NULL,
    id_preco INT(11) NOT NULL,
    PRIMARY KEY (id_pauta),
    FOREIGN KEY (id_rua)
        REFERENCES rua (id_rua)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_preco)
        REFERENCES preco_pauta (id_preco)
        ON DELETE CASCADE ON UPDATE CASCADE
)  ENGINE=INNODB;

CREATE TABLE historico (
    id_historico INT(11) NOT NULL AUTO_INCREMENT,
    regitro_foto VARCHAR(250) NULL,
    registro_video VARCHAR(250) NULL,
    id_naipe INT(11) NOT NULL,
    id_musico INT(11) NOT NULL,
    PRIMARY KEY (id_historico),
    FOREIGN KEY (id_naipe)
        REFERENCES naipe (id_naipe)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_musico)
        REFERENCES musico_chefe (id_musico)
        ON DELETE CASCADE ON UPDATE CASCADE
)  ENGINE=INNODB;

CREATE TABLE concerto (
    id_concerto INT(11) NOT NULL AUTO_INCREMENT,
    id_historico INT(11) NOT NULL,
    nome_obra VARCHAR(50) NULL,
    data_concerto DATE NULL,
    horario TIME NULL,
    id_pauta INT(11) NOT NULL,
    PRIMARY KEY (id_concerto),
    FOREIGN KEY (id_pauta)
        REFERENCES pauta (id_pauta)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_historico)
        REFERENCES historico (id_historico)
        ON DELETE CASCADE ON UPDATE CASCADE
)  ENGINE=INNODB;