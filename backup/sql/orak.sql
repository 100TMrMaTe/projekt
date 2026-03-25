-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2026. Már 25. 14:15
-- Kiszolgáló verziója: 10.4.32-MariaDB
-- PHP verzió: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `projekt`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `orak`
--

CREATE TABLE `orak` (
  `id` int(11) NOT NULL,
  `idopont` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `orak`
--

INSERT INTO `orak` (`id`, `idopont`) VALUES
(1, '07:03:00'),
(2, '07:05:00'),
(3, '07:50:00'),
(4, '07:58:00'),
(5, '08:00:00'),
(34, '08:40:00'),
(6, '08:45:00'),
(35, '08:48:00'),
(36, '08:50:00'),
(7, '08:53:00'),
(8, '08:55:00'),
(37, '09:30:00'),
(38, '09:38:00'),
(9, '09:40:00'),
(10, '09:48:00'),
(11, '09:50:00'),
(40, '10:20:00'),
(41, '10:23:00'),
(42, '10:25:00'),
(12, '10:35:00'),
(13, '10:38:00'),
(14, '10:40:00'),
(43, '11:05:00'),
(44, '11:18:00'),
(45, '11:20:00'),
(15, '11:25:00'),
(16, '11:38:00'),
(17, '11:40:00'),
(46, '12:00:00'),
(47, '12:03:00'),
(48, '12:05:00'),
(18, '12:25:00'),
(19, '12:28:00'),
(20, '12:30:00'),
(49, '12:45:00'),
(50, '12:48:00'),
(51, '12:50:00'),
(21, '13:15:00'),
(22, '13:18:00'),
(23, '13:20:00'),
(52, '13:30:00'),
(53, '13:33:00'),
(54, '13:35:00'),
(24, '14:05:00'),
(25, '14:08:00'),
(26, '14:10:00'),
(55, '14:15:00'),
(56, '14:18:00'),
(57, '14:20:00'),
(27, '14:55:00'),
(28, '14:58:00'),
(29, '15:00:00'),
(59, '15:03:00'),
(60, '15:05:00'),
(30, '15:45:00'),
(31, '15:48:00'),
(32, '15:50:00'),
(33, '16:35:00');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `orak`
--
ALTER TABLE `orak`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nap` (`idopont`),
  ADD UNIQUE KEY `idopont` (`idopont`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `orak`
--
ALTER TABLE `orak`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
