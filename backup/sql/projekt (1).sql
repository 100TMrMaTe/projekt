-- phpMyAdmin SQL Dump
-- version 5.2.2deb1+deb13u1
-- https://www.phpmyadmin.net/
--
-- Gép: localhost:3306
-- Létrehozás ideje: 2026. Feb 23. 10:10
-- Kiszolgáló verziója: 11.8.3-MariaDB-0+deb13u1 from Debian
-- PHP verzió: 8.4.16

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
-- Tábla szerkezet ehhez a táblához `active_users`
--

CREATE TABLE `active_users` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `expire` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_hungarian_ai_ci;

--
-- A tábla adatainak kiíratása `active_users`
--

INSERT INTO `active_users` (`id`, `user_id`, `token`, `expire`) VALUES
(1, 87, 'ca809e02cae597bf860b2a68c32c8cd53cf9f253c013261d65fc7c95fce283de29de1a8b09b29c329a436a1b78537200dd520bdd35413931f2254af8fe255686', '2026-02-05 08:59:07');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `currently_playing`
--

CREATE TABLE `currently_playing` (
  `id` int(11) NOT NULL,
  `music_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `lenght` time NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_hungarian_ai_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `music`
--

CREATE TABLE `music` (
  `id` int(11) NOT NULL,
  `video_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `lenght` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_hungarian_ai_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `playlist`
--

CREATE TABLE `playlist` (
  `id` int(11) NOT NULL,
  `music_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_hungarian_ai_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `test1`
--

CREATE TABLE `test1` (
  `id` int(11) NOT NULL,
  `video_id` varchar(100) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `length` int(11) NOT NULL,
  `current_time` int(11) NOT NULL,
  `volume` int(11) NOT NULL,
  `porget` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_hungarian_ai_ci;

--
-- A tábla adatainak kiíratása `test1`
--

INSERT INTO `test1` (`id`, `video_id`, `status`, `length`, `current_time`, `volume`, `porget`) VALUES
(1, 'pATX-lV0VFk', 0, 301, 99, 100, -1);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `user_class` varchar(20) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `approved` tinyint(1) NOT NULL DEFAULT 0,
  `isadmin` tinyint(1) NOT NULL DEFAULT 0,
  `email_verified` tinyint(1) NOT NULL DEFAULT 0,
  `verification_token` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_hungarian_ai_ci;

--
-- A tábla adatainak kiíratása `users`
--

INSERT INTO `users` (`id`, `user_name`, `email`, `user_class`, `user_password`, `approved`, `isadmin`, `email_verified`, `verification_token`) VALUES
(80, 'Tálas László Martin', 'talas.laszlo.martin.21@ady-nagyatad.hu', '13.C', '$2y$10$MoiQ3HoH1X6r82PZAfLpcuuPzli5mZLFpiX/5cp3gDdcyCHhyRckO', 0, 0, 0, 'ed096dcb3f0087daeda3fd05aff6d19973fe98e15a8ba8e9735619fa5a6e151cb93183c66ab4ab6992966d6d8f0dc997048918d12de391f765fbf69ca58b3d77'),
(84, 'asd', 'jankovics.peter.21@ady-nagyatad.hu', 'asd', '$2y$10$6jpDYZJemFvXm70jP1Zknec0c0jB.pZb63EadGSwrdRAhoIg/dbZe', 1, 1, 1, '3df1ec6add4f00ca15fa7aaf37fd232a973038dc46f6dd9b0a3dc559ca8197592e4d1cb88b24e43a1960bc24d046c494067788dbac9b5a735e9ed58ac46b8b10'),
(87, 'konyhasai', 'konyhasi.mate.21@ady-nagyatad.hu', '123', '$2y$10$pC54yv5z2zeXatrl0Va20.XfH6M3rmLOf9f7E4md1CaaJJ0dW9p2e', 1, 1, 1, 'd91964a4c1e65b426a07fe6bd3913839108cff2b686de68fa27cc87a1bc4aae3dc935fdf201dc0001848064efc646297b6f69f445cd787f2d82e4b9ba18c0434'),
(92, 'matyi', 'holczer.matyas.21@ady-nagyatad.hu', '12', '$2y$10$I/5y.o1UDmUyWNYhLjxPvOpNjqUBS3yinjyUsYpxHbYQIPwdmJUT6', 1, 0, 1, '52296de7b8a5da393013b1348fe032bd6d9decde26ef0db2c1ccc72d068bae2ae059ebfff6266032fdf741995d19e2f88cd02782cb1d175e318dcebfe9802c15');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user_handler`
--

CREATE TABLE `user_handler` (
  `id` int(11) NOT NULL,
  `user_id` int(255) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_hungarian_ai_ci;

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `active_users`
--
ALTER TABLE `active_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD UNIQUE KEY `token` (`token`);

--
-- A tábla indexei `currently_playing`
--
ALTER TABLE `currently_playing`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `music_id` (`music_id`);

--
-- A tábla indexei `music`
--
ALTER TABLE `music`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `video_youtube_id` (`video_id`);

--
-- A tábla indexei `playlist`
--
ALTER TABLE `playlist`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `music_id` (`music_id`);

--
-- A tábla indexei `test1`
--
ALTER TABLE `test1`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `verification_token` (`verification_token`);

--
-- A tábla indexei `user_handler`
--
ALTER TABLE `user_handler`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `active_users`
--
ALTER TABLE `active_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT a táblához `currently_playing`
--
ALTER TABLE `currently_playing`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `music`
--
ALTER TABLE `music`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `playlist`
--
ALTER TABLE `playlist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `test1`
--
ALTER TABLE `test1`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;

--
-- AUTO_INCREMENT a táblához `user_handler`
--
ALTER TABLE `user_handler`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `active_users`
--
ALTER TABLE `active_users`
  ADD CONSTRAINT `active_users_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `currently_playing`
--
ALTER TABLE `currently_playing`
  ADD CONSTRAINT `currently_playing_ibfk_1` FOREIGN KEY (`music_id`) REFERENCES `music` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Megkötések a táblához `playlist`
--
ALTER TABLE `playlist`
  ADD CONSTRAINT `playlist_ibfk_1` FOREIGN KEY (`music_id`) REFERENCES `music` (`id`) ON DELETE NO ACTION;

--
-- Megkötések a táblához `user_handler`
--
ALTER TABLE `user_handler`
  ADD CONSTRAINT `user_handler_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
