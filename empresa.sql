-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 07/06/2025 às 04:27
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `empresa`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `agenda`
--

CREATE TABLE `agenda` (
  `id_agenda` int(11) NOT NULL,
  `cod_pet` int(11) DEFAULT NULL,
  `data` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `descricao` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `agenda`
--

INSERT INTO `agenda` (`id_agenda`, `cod_pet`, `data`, `hora`, `descricao`) VALUES
(8, 1, '2025-06-10', '10:00:00', 'Check-in'),
(9, 2, '2025-06-10', '09:45:00', 'Check-out'),
(10, 1, '2025-10-10', '10:10:00', 'Banho');

-- --------------------------------------------------------

--
-- Estrutura para tabela `cadastro`
--

CREATE TABLE `cadastro` (
  `id_cadastro` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `login` varchar(50) NOT NULL,
  `senha` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `cadastro`
--

INSERT INTO `cadastro` (`id_cadastro`, `nome`, `login`, `senha`) VALUES
(3, 'Aline', '13', '789'),
(4, 'Pedro', '12', '1212'),
(5, 'Marcela', '16', '1313'),
(7, 'Douglas', 'Douglas', '2d95666e2649fcfc6e3af75e09f5adb9'),
(8, 'Vitor', 'Vitor', 'b59c67bf196a4758191e42f76670ceba');

--
-- Acionadores `cadastro`
--
DELIMITER $$
CREATE TRIGGER `trg_hash_senha_cadastro_insert` BEFORE INSERT ON `cadastro` FOR EACH ROW BEGIN
    IF CHAR_LENGTH(NEW.senha) != 32 THEN
        SET NEW.senha = MD5(NEW.senha);
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_hash_senha_cadastro_update` BEFORE UPDATE ON `cadastro` FOR EACH ROW BEGIN
    IF CHAR_LENGTH(NEW.senha) != 32 THEN
        SET NEW.senha = MD5(NEW.senha);
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `cliente`
--

CREATE TABLE `cliente` (
  `id_cliente` int(11) NOT NULL,
  `nome` varchar(100) DEFAULT NULL,
  `endereco` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `cliente`
--

INSERT INTO `cliente` (`id_cliente`, `nome`, `endereco`) VALUES
(1, 'Vitor', 'vitorovesso@hotmail.com'),
(2, 'Aline', 'aline123@gmail.com'),
(3, 'Lucas', 'lucasguissi@outlook.com'),
(4, 'Pedro', 'pedropedrita@gmail.com'),
(6, 'Marcela', 'marcelagatinha.gmail.com');

-- --------------------------------------------------------

--
-- Estrutura para tabela `login`
--

CREATE TABLE `login` (
  `id_login` int(11) NOT NULL,
  `login` varchar(50) DEFAULT NULL,
  `senha` varchar(50) DEFAULT NULL,
  `cargo` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `login`
--

INSERT INTO `login` (`id_login`, `login`, `senha`, `cargo`) VALUES
(5, 'Henrique', '1234', 'Adestrador'),
(6, 'Gabriel', '4321', 'Tosador');

-- --------------------------------------------------------

--
-- Estrutura para tabela `pagamento`
--

CREATE TABLE `pagamento` (
  `cod_pag` int(11) NOT NULL,
  `data_pagamento` date DEFAULT NULL,
  `forma_pag` varchar(50) DEFAULT NULL,
  `cod_reserva` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `pet`
--

CREATE TABLE `pet` (
  `cod_pet` int(11) NOT NULL,
  `especie` varchar(20) DEFAULT NULL,
  `nome` varchar(100) DEFAULT NULL,
  `raca` varchar(50) DEFAULT NULL,
  `idade` int(11) DEFAULT NULL,
  `id_cliente` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `pet`
--

INSERT INTO `pet` (`cod_pet`, `especie`, `nome`, `raca`, `idade`, `id_cliente`) VALUES
(1, NULL, 'Rex', NULL, NULL, 1),
(2, NULL, 'Jorginho', NULL, NULL, 2),
(3, NULL, 'Lion', NULL, NULL, 3),
(4, NULL, 'aurora', NULL, NULL, 4),
(6, NULL, 'Lola', NULL, NULL, 6);

-- --------------------------------------------------------

--
-- Estrutura para tabela `reserva`
--

CREATE TABLE `reserva` (
  `cod_reserva` int(11) NOT NULL,
  `Data_Inicio` date DEFAULT NULL,
  `Data_Fim` date DEFAULT NULL,
  `tipo_acomodacao` varchar(100) DEFAULT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `status` enum('Pendente','Confirmado','Recusado') NOT NULL DEFAULT 'Pendente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `suite`
--

CREATE TABLE `suite` (
  `id_suite` int(11) NOT NULL,
  `tipo` varchar(100) DEFAULT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `suite`
--

INSERT INTO `suite` (`id_suite`, `tipo`, `descricao`, `status`) VALUES
(101, 'Simples', 'Espaço individual, ventilação natural, bebedouro automático', 'Ocupada'),
(102, 'Conforto', 'Colchonete ortopédico, brinquedos, monitoramento por câmera', 'Disponível'),
(103, 'Luxo', 'Ambiente climatizado, cama premium, área externa privativa', 'Ocupada'),
(201, 'Simples', 'Espaço individual, ventilação natural, bebedouro automático', 'Ocupado'),
(202, 'Conforto', 'Colchonete ortopédico, brinquedos, monitoramento por câmera', 'Ocupado'),
(203, 'Luxo', 'Ambiente climatizado, cama premium, área externa privativa', 'Ocupado');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `agenda`
--
ALTER TABLE `agenda`
  ADD PRIMARY KEY (`id_agenda`),
  ADD KEY `cod_pet` (`cod_pet`);

--
-- Índices de tabela `cadastro`
--
ALTER TABLE `cadastro`
  ADD PRIMARY KEY (`id_cadastro`),
  ADD UNIQUE KEY `login` (`login`);

--
-- Índices de tabela `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Índices de tabela `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`id_login`);

--
-- Índices de tabela `pagamento`
--
ALTER TABLE `pagamento`
  ADD PRIMARY KEY (`cod_pag`),
  ADD KEY `cod_reserva` (`cod_reserva`);

--
-- Índices de tabela `pet`
--
ALTER TABLE `pet`
  ADD PRIMARY KEY (`cod_pet`),
  ADD KEY `id_cliente` (`id_cliente`);

--
-- Índices de tabela `reserva`
--
ALTER TABLE `reserva`
  ADD PRIMARY KEY (`cod_reserva`),
  ADD KEY `id_cliente` (`id_cliente`);

--
-- Índices de tabela `suite`
--
ALTER TABLE `suite`
  ADD PRIMARY KEY (`id_suite`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `agenda`
--
ALTER TABLE `agenda`
  MODIFY `id_agenda` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `cadastro`
--
ALTER TABLE `cadastro`
  MODIFY `id_cadastro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de tabela `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `login`
--
ALTER TABLE `login`
  MODIFY `id_login` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `pagamento`
--
ALTER TABLE `pagamento`
  MODIFY `cod_pag` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `pet`
--
ALTER TABLE `pet`
  MODIFY `cod_pet` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `reserva`
--
ALTER TABLE `reserva`
  MODIFY `cod_reserva` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `suite`
--
ALTER TABLE `suite`
  MODIFY `id_suite` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=204;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `agenda`
--
ALTER TABLE `agenda`
  ADD CONSTRAINT `agenda_ibfk_1` FOREIGN KEY (`cod_pet`) REFERENCES `pet` (`cod_pet`);

--
-- Restrições para tabelas `pagamento`
--
ALTER TABLE `pagamento`
  ADD CONSTRAINT `pagamento_ibfk_1` FOREIGN KEY (`cod_reserva`) REFERENCES `reserva` (`cod_reserva`);

--
-- Restrições para tabelas `pet`
--
ALTER TABLE `pet`
  ADD CONSTRAINT `pet_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`);

--
-- Restrições para tabelas `reserva`
--
ALTER TABLE `reserva`
  ADD CONSTRAINT `reserva_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
