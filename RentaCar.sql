-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS RentaCar;
USE RentaCar;

-- Excluir tabelas existentes
DROP TABLE IF EXISTS pagamentos;
DROP TABLE IF EXISTS alugueis;
DROP TABLE IF EXISTS veiculos;
DROP TABLE IF EXISTS funcionarios;
DROP TABLE IF EXISTS cliente_telefone;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS cidades;

-- Criar a tabela de cidades
CREATE TABLE cidades (
    ID_Cidade INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Cidade VARCHAR(100) NOT NULL,
    Estado CHAR(2) NOT NULL
);

-- Criar a tabela de clientes
CREATE TABLE clientes (
    ID_Cliente INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    CPF VARCHAR(14) UNIQUE NOT NULL,
    Email VARCHAR(100),
    ID_Cidade INT NOT NULL,
    FOREIGN KEY (ID_Cidade) REFERENCES cidades(ID_Cidade)
);

-- Criar a tabela de cliente_telefone
CREATE TABLE cliente_telefone (
    ID_Telefone INT AUTO_INCREMENT PRIMARY KEY,
    ID_Cliente INT NOT NULL,
    Telefone VARCHAR(15) NOT NULL,
    FOREIGN KEY (ID_Cliente) REFERENCES clientes(ID_Cliente)
);

-- Criar a tabela de funcionários
CREATE TABLE funcionarios (
    ID_Funcionario INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    CPF VARCHAR(14) UNIQUE NOT NULL,
    Cargo VARCHAR(50),
    Salario DECIMAL(10, 2),
    ID_Cidade INT NOT NULL,
    FOREIGN KEY (ID_Cidade) REFERENCES cidades(ID_Cidade)
);

-- Criar a tabela de veículos
CREATE TABLE veiculos (
    ID_Veiculo INT AUTO_INCREMENT PRIMARY KEY,
    Modelo VARCHAR(100) NOT NULL,
    Marca VARCHAR(50) NOT NULL,
    Ano INT NOT NULL,
    Categoria VARCHAR(50) NOT NULL,
    Disponivel BOOLEAN NOT NULL DEFAULT TRUE
);

-- Criar a tabela de aluguéis
CREATE TABLE alugueis (
    ID_Aluguel INT AUTO_INCREMENT PRIMARY KEY,
    ID_Cliente INT NOT NULL,
    ID_Funcionario INT NOT NULL,
    ID_Veiculo INT NOT NULL,
    Data_Inicio DATE NOT NULL,
    Data_Fim DATE NOT NULL,
    Valor_Total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (ID_Cliente) REFERENCES clientes(ID_Cliente),
    FOREIGN KEY (ID_Funcionario) REFERENCES funcionarios(ID_Funcionario),
    FOREIGN KEY (ID_Veiculo) REFERENCES veiculos(ID_Veiculo)
);

-- Criar a tabela de pagamentos
CREATE TABLE pagamentos (
    ID_Pagamento INT AUTO_INCREMENT PRIMARY KEY,
    ID_Aluguel INT NOT NULL,
    Valor_Pago DECIMAL(10, 2) NOT NULL,
    Data_Pagamento DATE NOT NULL,
    Metodo_Pagamento ENUM('Cartão', 'Dinheiro', 'Pix') NOT NULL,
    FOREIGN KEY (ID_Aluguel) REFERENCES alugueis(ID_Aluguel)
);

-- Inserir os dados de cidades
INSERT INTO cidades (Nome_Cidade, Estado) VALUES
('Juazeiro do Norte', 'CE'),
('Barbalha', 'CE'),
('Crato', 'CE');

-- Inserir os dados de clientes
INSERT INTO clientes (Nome, CPF, Email, ID_Cidade) VALUES
('João Silva', '123.456.789-00', 'joao.silva@email.com', 1),
('Maria Oliveira', '987.654.321-00', 'maria.oliveira@email.com', 2);

-- Inserir telefones dos clientes
INSERT INTO cliente_telefone (ID_Cliente, Telefone) VALUES
(1, '(88) 99999-1111'),
(2, '(88) 99999-2222');

-- Inserir dados de funcionários
INSERT INTO funcionarios (Nome, CPF, Cargo, Salario, ID_Cidade) VALUES
('Carlos Souza', '456.789.123-00', 'Atendente', 2500.00, 1),
('Ana Santos', '321.654.987-00', 'Gerente', 5000.00, 3);

-- Inserir dados de veículos
INSERT INTO veiculos (Modelo, Marca, Ano, Categoria, Disponivel) VALUES
('Corolla', 'Toyota', 2022, 'Sedan', TRUE),
('Onix', 'Chevrolet', 2021, 'Hatch', TRUE);

-- Inserir dados de aluguéis
INSERT INTO alugueis (ID_Cliente, ID_Funcionario, ID_Veiculo, Data_Inicio, Data_Fim, Valor_Total) VALUES
(1, 1, 1, '2024-12-01', '2024-12-10', 1500.00),
(2, 2, 2, '2024-12-05', '2024-12-15', 1200.00);

-- Inserir dados de pagamentos
INSERT INTO pagamentos (ID_Aluguel, Valor_Pago, Data_Pagamento, Metodo_Pagamento) VALUES
(1, 1500.00, '2024-12-01', 'Cartão'),
(2, 1200.00, '2024-12-05', 'Pix');

-- Seleção de dados com JOIN
SELECT 
    clientes.Nome AS Cliente,
    veiculos.Marca AS Veiculo,
    alugueis.Data_Inicio AS Data_Inicio,
    alugueis.Data_Fim AS Data_Fim,
    funcionarios.Nome AS Funcionario
FROM alugueis
JOIN clientes ON alugueis.ID_Cliente = clientes.ID_Cliente
JOIN veiculos ON alugueis.ID_Veiculo = veiculos.ID_Veiculo
JOIN funcionarios ON alugueis.ID_Funcionario = funcionarios.ID_Funcionario;

-- Função agregada: Receita total por veículo
SELECT 
    veiculos.Marca, 
    SUM(alugueis.Valor_Total) AS Receita_Total
FROM alugueis
JOIN veiculos ON alugueis.ID_Veiculo = veiculos.ID_Veiculo
GROUP BY veiculos.Marca;

-- Contar clientes por cidade
SELECT 
    cidades.Nome_Cidade, 
    COUNT(clientes.ID_Cliente) AS Total_Clientes
FROM clientes
JOIN cidades ON clientes.ID_Cidade = cidades.ID_Cidade
GROUP BY cidades.Nome_Cidade;

-- Subconsulta: Veículos alugados
SELECT * 
FROM veiculos
WHERE Disponivel = FALSE;

-- Atualizar a disponibilidade de um veículo
UPDATE veiculos
SET Disponivel = TRUE
WHERE ID_Veiculo = 2;

-- Excluir um aluguel (e pagamentos relacionados)
DELETE FROM pagamentos WHERE ID_Aluguel = 1;
DELETE FROM alugueis WHERE ID_Aluguel = 1;