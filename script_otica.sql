CREATE DATABASE IF NOT EXISTS otica_brasileira;
USE otica_brasileira;

CREATE TABLE Cliente (
    ID_Cliente INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    CPF VARCHAR(14) UNIQUE NOT NULL,
    Telefone VARCHAR(20),
    Email VARCHAR(100),
    Data_Nascimento DATE
);

CREATE TABLE Medico (
    ID_Medico INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Medico VARCHAR(100) NOT NULL,
    CRM VARCHAR(20) UNIQUE NOT NULL,
    Especialidade VARCHAR(50)
);

CREATE TABLE Produto (
    ID_Produto INT AUTO_INCREMENT PRIMARY KEY,
    Descricao VARCHAR(100) NOT NULL,
    Codigo_Barras VARCHAR(50) UNIQUE,
    Tipo ENUM('Armacao', 'Lente_Contato', 'Acessorio', 'Lente_Oftalmica'),
    Preco DECIMAL(10,2) NOT NULL,
    Qtd_Estoque INT NOT NULL
);

CREATE TABLE Vendedor (
    ID_Vendedor INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Matricula VARCHAR(20) UNIQUE
);

CREATE TABLE Laboratorio (
    ID_Laboratorio INT AUTO_INCREMENT PRIMARY KEY,
    Razao_Social VARCHAR(100) NOT NULL,
    CNPJ VARCHAR(20) UNIQUE,
    Telefone VARCHAR(20)
);

CREATE TABLE Receita (
    ID_Receita INT AUTO_INCREMENT PRIMARY KEY,
    ID_Cliente INT,
    ID_Medico INT,
    Data_Emissao DATE,
    Esferico_OD DECIMAL(4,2),
    Esferico_OE DECIMAL(4,2),
    Cilindrico_OD DECIMAL(4,2),
    Cilindrico_OE DECIMAL(4,2),
    Eixo_OD INT,
    Eixo_OE INT,
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente),
    FOREIGN KEY (ID_Medico) REFERENCES Medico(ID_Medico)
);

CREATE TABLE Venda (
    ID_Venda INT AUTO_INCREMENT PRIMARY KEY,
    ID_Cliente INT,
    ID_Vendedor INT,
    Data_Venda DATETIME DEFAULT CURRENT_TIMESTAMP,
    Valor_Total DECIMAL(10,2),
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente),
    FOREIGN KEY (ID_Vendedor) REFERENCES Vendedor(ID_Vendedor)
);

CREATE TABLE Item_Venda (
    ID_Item INT AUTO_INCREMENT PRIMARY KEY,
    ID_Venda INT,
    ID_Produto INT,
    Quantidade INT,
    Valor_Unitario DECIMAL(10,2),
    FOREIGN KEY (ID_Venda) REFERENCES Venda(ID_Venda),
    FOREIGN KEY (ID_Produto) REFERENCES Produto(ID_Produto)
);

CREATE TABLE Ordem_Servico (
    ID_OS INT AUTO_INCREMENT PRIMARY KEY,
    ID_Venda INT,
    ID_Laboratorio INT,
    Data_Envio DATE,
    Status ENUM('Pendente', 'Em Producao', 'Concluido', 'Entregue'),
    Previsao_Retorno DATE,
    FOREIGN KEY (ID_Venda) REFERENCES Venda(ID_Venda),
    FOREIGN KEY (ID_Laboratorio) REFERENCES Laboratorio(ID_Laboratorio)
);


INSERT INTO Cliente (Nome, CPF, Telefone, Email, Data_Nascimento) VALUES
('João Silva', '123.456.789-00', '(11) 99999-1111', 'joao@email.com', '1985-05-20'),
('Maria Oliveira', '234.567.890-11', '(11) 98888-2222', 'maria@email.com', '1990-10-15'),
('Carlos Souza', '345.678.901-22', '(21) 97777-3333', 'carlos@email.com', '1978-03-30');


INSERT INTO Medico (Nome_Medico, CRM, Especialidade) VALUES
('Dr. Roberto Alves', 'CRM/SP 12345', 'Oftalmologista'),
('Dra. Ana Costa', 'CRM/SP 67890', 'Oftalmologista');


INSERT INTO Produto (Descricao, Codigo_Barras, Tipo, Preco, Qtd_Estoque) VALUES
('Armação Ray-Ban Aviador', 'RB3025', 'Armacao', 850.00, 10),
('Lente Varilux Comfort', 'VAR001', 'Lente_Oftalmica', 1200.00, 50),
('Solução Limpeza Lentes', 'SOL500', 'Acessorio', 35.00, 100),
('Armação Oakley Holbrook', 'OKL999', 'Armacao', 600.00, 5);


INSERT INTO Vendedor (Nome, Matricula) VALUES
('Pedro Santos', 'VEND01'),
('Julia Lima', 'VEND02');


INSERT INTO Laboratorio (Razao_Social, CNPJ, Telefone) VALUES
('Lab Ótico Precision', '11.222.333/0001-99', '(11) 3030-4040');


INSERT INTO Receita (ID_Cliente, ID_Medico, Data_Emissao, Esferico_OD, Esferico_OE, Cilindrico_OD, Cilindrico_OE, Eixo_OD, Eixo_OE) VALUES
(1, 1, '2025-01-10', -2.50, -2.75, 0.00, -0.50, 0, 180),
(2, 2, '2025-02-15', +1.00, +1.25, -0.50, -0.50, 90, 95);


INSERT INTO Venda (ID_Cliente, ID_Vendedor, Valor_Total) VALUES
(1, 1, 2050.00), 
(2, 2, 35.00);   


INSERT INTO Item_Venda (ID_Venda, ID_Produto, Quantidade, Valor_Unitario) VALUES
(1, 1, 1, 850.00),  
(1, 2, 1, 1200.00), 
(2, 3, 1, 35.00);   


INSERT INTO Ordem_Servico (ID_Venda, ID_Laboratorio, Data_Envio, Status, Previsao_Retorno) VALUES
(1, 1, '2025-03-01', 'Pendente', '2025-03-10');



SELECT v.ID_Venda, c.Nome AS Cliente, vd.Nome AS Vendedor, v.Valor_Total, v.Data_Venda
FROM Venda v
JOIN Cliente c ON v.ID_Cliente = c.ID_Cliente
JOIN Vendedor vd ON v.ID_Vendedor = vd.ID_Vendedor;


SELECT Descricao, Qtd_Estoque, Preco
FROM Produto
WHERE Qtd_Estoque < 10
ORDER BY Preco DESC;


SELECT os.ID_OS, os.Status, os.Previsao_Retorno, l.Razao_Social
FROM Ordem_Servico os
JOIN Laboratorio l ON os.ID_Laboratorio = l.ID_Laboratorio;



UPDATE Produto
SET Preco = Preco * 1.10
WHERE Tipo = 'Acessorio';


UPDATE Ordem_Servico
SET Status = 'Em Producao'
WHERE ID_OS = 1;


UPDATE Cliente
SET Telefone = '(11) 99999-9999'
WHERE Nome = 'João Silva';



DELETE FROM Item_Venda
WHERE ID_Item = 3;


INSERT INTO Vendedor (Nome, Matricula) VALUES ('Vendedor Teste', 'TESTE01');
DELETE FROM Vendedor
WHERE Matricula = 'TESTE01';


DELETE FROM Produto
WHERE Codigo_Barras IS NULL;