
-- Criação das tabelas
CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    email VARCHAR(100),
    data_registro DATE
);

CREATE TABLE Produtos (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome_produto VARCHAR(100),
    preco DECIMAL(10,2),
    estoque INT
);

CREATE TABLE Pedidos (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    data_pedido DATE,
    total DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

CREATE TABLE Itens_Pedido (
    id_pedido INT,
    id_produto INT,
    quantidade INT,
    preco_unitario DECIMAL(10,2),
    PRIMARY KEY (id_pedido, id_produto),
    FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto)
);

-- Criação do trigger
CREATE TRIGGER AtualizaEstoque
AFTER INSERT ON Itens_Pedido
FOR EACH ROW
BEGIN
    UPDATE Produtos
    SET estoque = estoque - NEW.quantidade
    WHERE id_produto = NEW.id_produto;
END;

-- Inserindo um cliente
INSERT INTO Clientes (nome, email, data_registro)
VALUES ('João Silva', 'joao.silva@email.com', '2024-10-24');

-- Inserindo um produto
INSERT INTO Produtos (nome_produto, preco, estoque)
VALUES ('Notebook Dell', 3500.00, 10);

-- Inserindo um pedido
INSERT INTO Pedidos (id_cliente, data_pedido, total)
VALUES (1, '2024-10-24', 3500.00);

-- Inserindo um item no pedido (aciona o trigger)
INSERT INTO Itens_Pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (1, 1, 1, 3500.00);

-- Verificando o estoque atualizado
SELECT * FROM Produtos WHERE id_produto = 1;
