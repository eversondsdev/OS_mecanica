
-- Script Banco de Dados OS de Mecanica

CREATE DATABASE IF NOT EXISTS `osOficinaMecanica`;
USE `osOficinaMecanica`;

CREATE TABLE IF NOT EXISTS cliente (
    idCliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(25) NOT NULL,
    sobrenome VARCHAR(20),
    documentoIdentificacao VARCHAR(20) NOT NULL UNIQUE,
    contato VARCHAR(45),
    logradouro VARCHAR(100),
    numero SMALLINT,
    complemento VARCHAR(100),
    bairro VARCHAR(30),
    cidade VARCHAR(30),
    estado CHAR(2),
    cep CHAR(8)
);


CREATE TABLE IF NOT EXISTS veiculo (
    idVeiculo INT PRIMARY KEY AUTO_INCREMENT,
    modelo VARCHAR(45) NOT NULL,
    ano VARCHAR(45),
    cor VARCHAR(45),
    placa VARCHAR(45) UNIQUE NOT NULL,
    imagem_veiculo VARCHAR(255),
    Cliente_idCliente INT NOT NULL,
    
    FOREIGN KEY (Cliente_idCliente) REFERENCES cliente(idCliente)
);


CREATE TABLE IF NOT EXISTS servico (
    idServico INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(255) NOT NULL,
    valor_mao_de_obra DECIMAL(10,2) NOT NULL
);


CREATE TABLE IF NOT EXISTS equipe (
    idEquipe INT PRIMARY KEY AUTO_INCREMENT,
    nome_equipe VARCHAR(45) NOT NULL
);


CREATE TABLE IF NOT EXISTS mecanico (
    idMecanico INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    sobrenone VARCHAR(20),
    logradouro VARCHAR(100),
    numero SMALLINT,
    complemento VARCHAR(100),
    bairro VARCHAR(30),
    cidade VARCHAR(30),
    estado CHAR(2),
    cep CHAR(8),
    especializacao VARCHAR(45),
    Equipe_idEquipe INT NOT NULL,
    
    FOREIGN KEY (equipe_idEquipe) REFERENCES equipe(idEquipe)
);

CREATE TABLE IF NOT EXISTS peca_veiculo (
    idPecaVeiculo INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    categoria VARCHAR(45),
    valor DECIMAL(10,2) NOT NULL,
    descricao VARCHAR(255)
);



CREATE TABLE IF NOT EXISTS ordem_de_servico (
    idOrdemServico INT PRIMARY KEY AUTO_INCREMENT,
    data_emissao VARCHAR(45) NOT NULL,
    tipo_OS VARCHAR(45),
    descricao VARCHAR(255),
    status_OS VARCHAR(45),
    data_conclusao VARCHAR(45),
    valor_total VARCHAR(45),
    veiculo_idVeiculo INT NOT NULL,
    equipe_idEquipe INT NOT NULL,
    
    FOREIGN KEY (veiculo_idVeiculo) REFERENCES veiculo(idVeiculo),
    FOREIGN KEY (equipe_idEquipe) REFERENCES equipe(idEquipe)
);


-- Tabela de Relacionamento N para N

CREATE TABLE IF NOT EXISTS orcamento_servico (
    ordem_de_Servico_idOrdemServico INT NOT NULL,
    servico_idServico INT NOT NULL,
    quantidade INT NOT NULL,
    valor_total_servico DECIMAL(10,2),
    PRIMARY KEY (ordem_de_servico_idOrdemServico, servico_idServico),
    
    FOREIGN KEY (ordem_de_servico_idOrdemServico) REFERENCES ordem_de_servico(idOrdemServico),
    FOREIGN KEY (servico_idServico) REFERENCES servico(idServico)
);

CREATE TABLE IF NOT EXISTS orcamento_peca (
    ordem_de_Servico_idOrdemServico INT NOT NULL,
    peca_Veiculo_idPecaVeiculo INT NOT NULL,
    quantidade INT NOT NULL,
    valor_total_peca DECIMAL(10,2),
    PRIMARY KEY (ordem_de_servico_idOrdemServico, peca_veiculo_idPecaVeiculo),
    FOREIGN KEY (ordem_de_servico_idOrdemServico) REFERENCES ordem_de_servico(idOrdemServico),
    FOREIGN KEY (peca_veiculo_idPecaVeiculo) REFERENCES peca_veiculo(idPecaVeiculo)
);
