SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

-- --------------------------------------------------------
-- napok tábla (először, mert csengetes hivatkozik rá)
-- --------------------------------------------------------

CREATE TABLE `napok` (
  `id` int(11) NOT NULL,
  `nap` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `napok` (`id`, `nap`) VALUES
(1, 'Normál'),
(3, 'Rendkivüli'),
(2, 'Röviditett');

ALTER TABLE `napok`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nap` (`nap`);

ALTER TABLE `napok`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

-- --------------------------------------------------------
-- orak tábla (először, mert csengetes hivatkozik rá)
-- --------------------------------------------------------

CREATE TABLE `orak` (
  `id` int(11) NOT NULL,
  `idopont` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

ALTER TABLE `orak`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idopont` (`idopont`);

ALTER TABLE `orak`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

-- --------------------------------------------------------
-- csengetes tábla (utoljára, mert napok és orak-ra hivatkozik)
-- --------------------------------------------------------

CREATE TABLE `csengetes` (
  `id` int(11) NOT NULL,
  `nap_id` int(11) NOT NULL,
  `oraszam` int(11) NOT NULL,
  `jelzo_id` int(11) NOT NULL,
  `becsengetes_id` int(11) NOT NULL,
  `kicsengetes_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

ALTER TABLE `csengetes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nap_id` (`nap_id`,`jelzo_id`,`becsengetes_id`,`kicsengetes_id`),
  ADD KEY `jelzo_id` (`jelzo_id`),
  ADD KEY `becsengetes_id` (`becsengetes_id`),
  ADD KEY `kicsengetes_id` (`kicsengetes_id`);

ALTER TABLE `csengetes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

ALTER TABLE `csengetes`
  ADD CONSTRAINT `csengetes_ibfk_1` FOREIGN KEY (`nap_id`) REFERENCES `napok` (`id`),
  ADD CONSTRAINT `csengetes_ibfk_2` FOREIGN KEY (`jelzo_id`) REFERENCES `orak` (`id`),
  ADD CONSTRAINT `csengetes_ibfk_3` FOREIGN KEY (`becsengetes_id`) REFERENCES `orak` (`id`),
  ADD CONSTRAINT `csengetes_ibfk_4` FOREIGN KEY (`kicsengetes_id`) REFERENCES `orak` (`id`);

COMMIT;
