-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2026. Már 25. 14:14
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
-- Tábla szerkezet ehhez a táblához `csengetes`
--

CREATE TABLE `csengetes` (
  `id` int(11) NOT NULL,
  `nap_id` int(11) NOT NULL,
  `oraszam` int(11) NOT NULL,
  `jelzo_id` int(11) NOT NULL,
  `becsengetes_id` int(11) NOT NULL,
  `kicsengetes_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `csengetes`
--

INSERT INTO `csengetes` (`id`, `nap_id`, `oraszam`, `jelzo_id`, `becsengetes_id`, `kicsengetes_id`) VALUES
(1, 1, 0, 1, 2, 3),
(2, 1, 1, 4, 5, 6),
(3, 1, 2, 7, 8, 9),
(11, 1, 3, 10, 11, 12),
(12, 1, 4, 13, 14, 15),
(13, 1, 5, 16, 17, 18),
(14, 1, 6, 19, 20, 21),
(15, 1, 7, 22, 23, 24),
(16, 1, 8, 25, 26, 27),
(17, 1, 9, 28, 29, 30),
(18, 1, 10, 31, 32, 33),
(19, 2, 0, 1, 2, 3),
(20, 2, 1, 4, 5, 34),
(21, 2, 2, 35, 36, 37),
(22, 2, 3, 38, 9, 40),
(23, 2, 4, 41, 42, 43),
(24, 2, 5, 44, 45, 46),
(25, 2, 6, 47, 48, 49),
(26, 2, 7, 50, 51, 52),
(27, 2, 8, 53, 54, 55),
(28, 2, 9, 56, 57, 29),
(29, 2, 10, 59, 60, 30),
(30, 3, 0, 1, 1, 1),
(31, 3, 1, 1, 1, 1),
(32, 3, 2, 1, 1, 1),
(33, 3, 3, 1, 1, 1),
(34, 3, 4, 1, 1, 1),
(35, 3, 5, 1, 1, 1),
(36, 3, 6, 1, 1, 1),
(37, 3, 7, 1, 1, 1),
(38, 3, 8, 1, 1, 1),
(39, 3, 9, 1, 1, 1),
(40, 3, 10, 1, 1, 1);

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `csengetes`
--
ALTER TABLE `csengetes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nap_id` (`nap_id`,`jelzo_id`,`becsengetes_id`,`kicsengetes_id`),
  ADD KEY `jelzo_id` (`jelzo_id`),
  ADD KEY `becsengetes_id` (`becsengetes_id`),
  ADD KEY `kicsengetes_id` (`kicsengetes_id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `csengetes`
--
ALTER TABLE `csengetes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `csengetes`
--
ALTER TABLE `csengetes`
  ADD CONSTRAINT `csengetes_ibfk_1` FOREIGN KEY (`nap_id`) REFERENCES `napok` (`id`),
  ADD CONSTRAINT `csengetes_ibfk_2` FOREIGN KEY (`jelzo_id`) REFERENCES `orak` (`id`),
  ADD CONSTRAINT `csengetes_ibfk_3` FOREIGN KEY (`becsengetes_id`) REFERENCES `orak` (`id`),
  ADD CONSTRAINT `csengetes_ibfk_4` FOREIGN KEY (`kicsengetes_id`) REFERENCES `orak` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
