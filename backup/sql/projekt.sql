-- phpMyAdmin SQL Dump
-- version 5.2.2deb1+deb13u1
-- https://www.phpmyadmin.net/
--
-- Gép: localhost:3306
-- Létrehozás ideje: 2026. Már 20. 09:13
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
(28, 92, 'aed21ac299ad3198b401b5f9134a72cdedbbc518fc369fb4c5ed810c3052937d2371ec903df9105f59679ca1cc8e89d90e286db525c8d16ffd31f250ec6f8c2d', '2026-03-16 11:21:03'),
(79, 97, '365c949aa3fe9c48adf60062ca2bdf70eb1f201127a32adb3312aa59710f5539a85464b5e9bf21c9f77f5e43ad3ecad1bb2c46155e11e2f384251b1dfd8bbec1', '2026-03-20 10:39:07');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `currently_playing`
--

CREATE TABLE `currently_playing` (
  `id` int(11) NOT NULL,
  `music_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `current_time` int(11) NOT NULL,
  `volume` int(11) NOT NULL,
  `porget` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_hungarian_ai_ci;

--
-- A tábla adatainak kiíratása `currently_playing`
--

INSERT INTO `currently_playing` (`id`, `music_id`, `status`, `current_time`, `volume`, `porget`, `user_id`) VALUES
(100, 5, 1, 21, 100, -1, 97);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `fav`
--

CREATE TABLE `fav` (
  `id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL,
  `music_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_hungarian_ai_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `music`
--

CREATE TABLE `music` (
  `id` int(11) NOT NULL,
  `video_id` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `length` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_hungarian_ai_ci;

--
-- A tábla adatainak kiíratása `music`
--

INSERT INTO `music` (`id`, `video_id`, `title`, `length`) VALUES
(1, 'pATX-lV0VFk', 'live is life ', 301),
(2, '0Pp8jcQ97pY', 'What Is Autism Spectrum Disorder?', 523),
(5, 'YQHsXMglC9A', 'Adele - Hello (Official Music Video)', 367),
(6, 'AR0OTaKg0sk', 'MARIO – Hello /Official Music/', 199),
(9, 'W5j89pdFG98', 'BSW - HELLO (Official Music Video)', 175),
(12, 'WdWokgePEs8', 'DESH - TALPRA CIGÁNYOK (Official Music Video)', 160),
(13, 'RC7_OkIRhgY', 'DESH - VINNIPU (Official Music Video)', 111),
(14, 'eOoIFc1sDeo', 'DESH X YOUNG FLY - OHMAMMA (Official Music Video)', 170),
(18, 'wSiODNTkwHU', 'Burai, Mario, VZS feat. Goore feat. Kretz - SeanPaul', 239),
(19, 'tSUmWLZ8dmI', 'MARIO x ESSEMM x BEAT – Rajosan 3 /Official Music Video/', 177),
(21, 'QxcdxON0rb4', 'Bill Gates reveals why he&#39;s probably on the autism spectrum', 69),
(22, '6nPDhbKvrvY', 'Remember, autism is a SPECTRUM! 🌈 #autism #autistic #neurodivergent', 44),
(23, 'wc8eEyxDxVw', 'Asdasd.', 476),
(27, 'QpstA4TjaT0', 'Early Signs of #Autism', 12),
(28, 'Lk4qs8jGN4U', 'What is Autism?', 162),
(29, '_e6EnIN65oA', 'Super Mario Bros., but Every Time Mario Jumps, He Gets Taller', 240),
(32, 'xqutsSE6lrc', 'Freaky Mario shows his hole to Luigi 💀', 22),
(33, '86ngL1-MOjQ', 'Mario vs Squid Game #shorts', 20),
(34, 'v2AC41dglnM', 'AC/DC - Thunderstruck (Official Video)', 293),
(35, 'pAgnJDJN4VA', 'AC/DC - Back In Black (Official 4K Video)', 254),
(36, 'NhsK5WExrnE', 'T.N.T.', 215),
(37, 'gEPmA3USJdI', 'AC/DC - Highway to Hell (Live At River Plate, December 2009)', 285),
(38, 'whQQpwwvSh4', 'AC/DC - Dirty Deeds Done Dirt Cheap (Live At River Plate, December 2009)', 288),
(39, 'FDUe9BP_KRI', 'BSW - Passport', 146),
(41, 'HzAu6ijipgU', 'BSW - Beb*sztam (Hogy elfelejtselek...)', 194),
(42, 'wuU4UxwOaZs', 'BSW x T. Danny - Nem megyek vissza', 147),
(43, 'eowi9-s0aEE', 'BELANO x BSW - BULLSHIT (Official Music Video)', 137),
(44, 'mR3vGf60QZo', 'Probs GVZU *BURNS* Opponents In This Short But Clean Montage.', 44),
(45, 'LEfag2mrC0k', 'LIL G – Dislike ( OFFICIAL MUSIC VIDEO )', 200),
(54, 'MZ0U41GNlnQ', 'VZS - RENDŐR BÁCSI, KÉREM (Official Visualizer)', 180),
(55, '_G8JIWSk4ZM', 'VZS - VÁRJ MEG  feat. RZMVS (OFFICIAL VISUALIZER)', 166),
(58, 'E5DOL9wGwEk', 'ekhoe - Smash!', 155),
(59, 'xwXfPg_vEUo', 'Pogány Induló - Lelkem, Nyugodj! (Official Music Video)', 255),
(60, 'PIi0NCqnLjc', 'BETON.HOFI - BETON.HOF1', 194),
(62, 'kJNk4TW7RAk', 'Rilès - PESETAS (Music Video)', 234),
(65, 'URbYei513Y0', 'ÁKOS - ILYENEK VOLTUNK (1997) :: Official video', 202),
(66, '-QGn-LlpnKw', 'ÁKOS • ELHISZEM (2019) ::: Official Music Video', 203),
(68, 'UWSWwuwWUI4', 'Noel - KÖSZI MINDENKINEK! (Official Music Video)', 165),
(69, 'WptXmMRBvRg', 'LIVE | আদালতের পর এবার পাসপোর্ট অফিসে বোমাতঙ্ক। কলকাতার রুবিতে পাসপোর্ট অফিসে বো মাতঙ্ক', 0),
(70, 'Bosb7vOqxYA', 'Leander Kills - Örökzöld (Official Lyric Video)', 224),
(71, 'Uec2Zjc5aX4', 'Hunter - Roblox (Hivatalos AI Zene)', 177),
(72, 'wDQ6pU5re-0', 'KORDA GYÖRGY X BUDAPEST AIRPORT: REPTÉR (official video)', 197),
(73, 'kXQ8WR5zRnE', 'Számoló dal (1-től 10-ig)', 146),
(74, 'wKSYlkQlfPo', 'Halász Judit - Boldog Születésnapot', 129),
(75, 'kRWuyc0cdJA', 'PGT - PGT TEAM (MINECRAFT ZENE ANIMÁCIÓ)', 153),
(78, 'kKV6uQ09g24', 'Mikee Mykanic - Cica (feat. Ótvar Pestis) [Official Audio]', 174),
(79, 'Kw3935PH01E', 'Shakira - Zoo (a Zootropolis 2-ből) hivatalos videoklip', 198),
(81, 'ePFHUbyDoOU', 'TikTok Mashup február 💖2026💖 (Nem tiszta)', 947),
(87, 'KdS6HFQ_LUc', 'Rihanna - S&amp;M', 245),
(88, 'MxEjnYdfLXU', 'I Wonder', 244),
(89, 'ZAz3rnLGthg', 'Flashing Lights', 238),
(91, 'uU9Fe-WXew4', 'On Sight', 157),
(93, 'vNDUnvbDhOo', 'Unbelievable Viral Fails | Viral Moments Caught', 943),
(94, 'IHsIQYhzyxI', 'Zséda &amp; Kökény Attila - Hello', 241),
(98, 'wX0Gi3Un3WI', 'Vicces cica panasz. Funny cat voice. Lustige Katzenbeschwerde.', 16),
(102, 'LvUtS-btnyU', 'Martin Garrix &amp; Lauv - MAD (Official Video)', 206),
(103, 'L5GwTfI_PD8', 'Fly Project - Toca Toca | Official Music Video', 170),
(104, 'pgN-vvVVxMA', 'XXXTENTACION - SAD!', 167),
(107, 'Jf0wZW-q9Wk', 'Cica dal', 152),
(112, '1NtsiXAzfLs', 'SZECSEI - ALL NIGHT LONG - Broadway Monkey, Eger - 2024.04.26.', 10019),
(113, 'PWnBA0RCZdI', 'CIAA Battle of the Bands 2026', 3938),
(114, 'VlMePlutP5c', 'MARIO &amp; FERIKE – Kimaradás van | Official Music Video', 133),
(115, 'fqTJcoSi6kQ', 'Rácz Gergő - VALAMI', 189),
(124, 'EPo5wWmKEaI', 'Pitbull - Give Me Everything ft. Ne-Yo, Afrojack, Nayer', 267),
(126, 'RKFZfwC-Cxk', 'DESH - ICE SPICE (Official Music Video)', 124),
(127, 'ugTuUirpaSo', 'Nagy Bogi x DESH - Jól leszek újra (Hűtlen Délibáb)', 157),
(131, 'jpQ72G4-c0s', 'BETON.HOFI - POKOL', 186),
(132, 'lJRTuCDopMY', 'BETON.HOFI - TARR BÉLA', 295),
(133, 'vU1NVfTurSE', 'BETON.HOFI - BE VAGYOK ZÁRVA', 182),
(135, 'tG0e72Dx1n4', 'L.L. Junior - FREY TIMI (OFFICIAL LYRICS VIDEO)', 156),
(136, 'QTUu9FDC9T4', 'L.L. Junior - Mr. Raggamoffin (&quot;Az én világom&quot; album)', 240),
(137, 'nr42IDeK13w', 'BSW - Cold (Four Seasons Album)', 135),
(138, 't8ll4k0E6qc', 'FLUOR – MIZU – OFFICIAL MUSIC VIDEO', 193),
(139, 'USppwjVG43I', 'FLUOR FEAT. SP – PARTYARC [Official Music Video]', 186),
(140, '7wtfhZwyrcc', 'Imagine Dragons - Believer (Official Music Video)', 217),
(141, '8kHEr2Zspls', 'byealex és a slepp - apám sírjánál symphonic', 229),
(142, 'BstIPwzfyGY', 'byealex és a slepp - az én országom', 185),
(144, 'KNPP3bwpmiQ', 'AMD’s Actually DOING IT!', 557),
(146, '_nNH7SlVLy4', 'Iran Israel US war Updates LIVE: युद्ध के मैदान से ताजा हालात! लाइव | Trump Vs Khamenei | 04 March', 0),
(155, '31IWLnU6Ca8', 'LIVE UPDATES: US-Israel strikes Iran, 8 ET Pentagon update, Iranian fighter jet shot down', 0),
(160, '7Ju4V4xPXSs', 'L.L. Junior x Azahriah (feat. Farkas Pisti) - ZHA MAJ DUR (Official Music Video)', 232),
(161, 'Z8agqyGIaD8', 'Echo (feat. Tauren Wells) | Live | Elevation Worship', 229),
(164, 'cvsmBsWgD3U', 'Beerseewalk - BSW', 238),
(165, '1dx-KnuSyJQ', 'Tóth Andi - Néztek', 172),
(166, '5qztvURDLzA', 'LACIKA - FEKETE MERCEDES 🛞 (OFFICIAL MUSIC VIDEO)', 180),
(167, '5thP6YSd47g', 'Manuel - Nosztalgia (Official Lyrics Video)', 190),
(168, 'SmM0653YvXU', 'Pitbull - Rain Over Me ft. Marc Anthony', 234),
(169, 'i0vFid2tKbI', 'Pitbull - Don&#39;t Stop The Party ft. TJR', 214),
(170, 'HMqgVXSvwGo', 'Pitbull - Fireball (Official Video) ft. John Ryan', 242),
(171, '5jlI4uzZGjU', 'Pitbull - Feel This Moment (Official Video) ft. Christina Aguilera', 230),
(175, 'EePoS6COqYs', 'BRUNO x Mollywood - AFTERPARTY (Official Music Video)', 154),
(176, 'l3eVv3zONT8', 'KKevin - TAKE YOUR TIME (Official Music Video)', 147),
(177, '2TX0a6W5nIs', 'L.L. Junior - Utolsó szívverés (Hivatalos Videoklip)', 278),
(179, 'tmhHVZpAr3M', 'It’s her boyfriend’s birthday 😂', 20),
(187, 'avtsc6j0gns', 'Halott Pénz - Amikor feladnád', 208),
(199, 'YKuHdOxj46I', 'Keyshia Cole - Love (Lyrics)', 258),
(201, 'Ne7mHbNj-I0', 'Kósa Lajos először a Partizánon! A debreceni DPK-n jártunk', 2942),
(204, 'J9nFix5cRKc', 'Lajos-féle újévi LENCSEFŐZELÉK 🍀✨', 251),
(206, 'TDW7nxS1fqg', '3+2 együttes - Hát idefigyelj Lajos - Studio Session 2013 HD', 238),
(211, '7X6tWXDminE', 'Teri Yaad Yaad Yaad | GHULAM ALI | Bewafaa | 2005', 464),
(217, '-vBUm9nZbP0', 'HORVÁTH TAMÁS X PIXA - BABÁM (OFFICIAL MUSIC VIDEO)', 198),
(218, 'TBpYCZ-COrY', 'DESH X YOUNG FLY X AZAHRIAH - TIP TIP (Official Music Video)', 181),
(230, 'eNgYTEcMSZs', 'We are in the Car Wheels On The Bus Song Nursery Rhymes &amp; Kids Songs', 230),
(237, 'KB5UvJT2tdI', 'SZECSEI - Welcome 2026 - Club Octagon, Győr - 2025.12.31.', 3729),
(238, 'CxrUPJ8EMQ4', 'Cirmos cica (Gyerekdalok és mondókák, rajzfilm gyerekeknek)', 49),
(240, '4vc-ki441HM', 'Noel - ÁRULÓK KÖRÜLÖTTEM! (Official Music Video)', 174),
(248, '-gusAuWDvUM', 'BME-KJK – Tervezd velünk a jövőt!', 108),
(276, 'n38JJuaScvc', 'CSODA, HOGY BÍRJA MÉG A GÉP!!!💥BeamNG Barmai #161', 2562),
(277, '9xFr2HRttck', '🔥 Relaxing Fireplace (24/7)🔥Fireplace with Burning Logs &amp; Fire Sounds', 0),
(278, '2G8LAiHSCAs', 'Forest Birdsong Nature Sounds-Relaxing Bird Sounds for Sleeping-Calming Birds Chirping Ambience', 29992),
(279, 'iDLmYZ5HqgM', 'metal pipe falling sound effect', 5),
(284, 'HRDKiN10W7c', 'VINI x BELANO - SHAKE DAT (Official Music Video)', 163),
(287, 'B8wL1GIDcm4', 'T. DANNY - PLETYKA (Official Music Video)', 219),
(288, 'JU7btMYmm24', 'T. Danny - Megmondtam (Official Music Video)', 230),
(289, 'j9hc-Fnk4MM', 'T. Danny - SZÖRNYETEG (Official Visualizer)', 209),
(290, '6alUPsunGKE', 'T. Danny - SZÍVTIPRÓ (Official Music Video)', 222),
(291, 'M5plJGB_f_Q', 'T. Danny - GÁZ (feat. JABER) (Official Music Video)', 193),
(292, 'D8vetZeFElo', 'KKevin - DEALER (Official Music Video)', 166),
(293, 'Hnl9Jqr5quQ', 'KKEVIN x L.L. Junior - GETTÓMILLIOMOS (Official Visualizer)', 193),
(294, 'sCtrOvKNI2o', 'KKevin - PROSECCO ft. Bruno (Official Music Video)', 138),
(296, 'D32XMkJpkAw', 'RZMVS - Többé nem (Official Lyric Video)', 171),
(298, 'rIEb47DacOA', 'RZMVS - HENNY (Official Visualizer)', 96),
(299, 'fpzuwn-AVUU', 'RZMVS - Miért játszol (Official Lyric Video)', 161),
(300, '5sK1hDoQOCw', 'RZMVS - PAPÍROM (Official Music Video)', 159),
(301, 'qUZppD_Zd0s', 'Open Stage - Aranka Szeretlek  TVR Magyar Adás', 190),
(346, 'c8FK3etx4s4', 'July India Part 1', 310),
(350, 'KwMxOuWbo-A', 'Winotopia room', 48),
(359, 'jgpyVM9VIe4', 'Cica dal 🐱 | Vidám gyerekdal a macskákról 🐈', 98),
(390, '2p_eRTj5s5M', 'Romeo Santos - Amigo (Audio)', 243),
(397, 'QpdArS6XtLY', 'Groote Club 9 mei 1945 Amsterdam de Dam Schietincident Binnenlandse Strijdkrachten', 118),
(400, 'y7H43fiJwFY', 'Naga Salaba Weyena Padata | නාග සළඹ වැයෙන පදට | Malani Bulathsinhala |Tribal Rock Cover by RiRi Yaka', 230),
(401, 'Ly2qmMYJ5b0', '1 hour ago! Russia&#39;s largest secret base discovered, 10 minutes later attacked by Ukraine', 42900),
(410, 'jtcpb5Zml3g', 'DESH X YOUNG FLY X AZAHRIAH - PANNONIA (Official Music Video)', 152),
(416, '51WMz9DrbZc', 'AK26 - BLÖFF | OFFICIAL MUSIC VIDEO |', 237),
(430, 'Mquk9pHpIoU', 'Luan Santana - ASAS (Vídeo Oficial)', 243),
(435, '1jz0UG3JsMc', 'gffd #tiktok #funny #dance #memes #shark #automobile #ballerina #bonecaambalabu', 11),
(446, 'fhM0hX9R5Wk', 'ASG - Live at Born to Burn Fest - The Handlebar - Pensacola, FL - April 20, 2024', 3092),
(469, '3z9j5QefqMw', 'Inside the Deal Between the SDF and Syrian Government', 570),
(472, 'Js4jysuy5W0', 'Signs of Autism Spectrum Disorder', 60),
(473, 'rOjpMWXYAiY', 'What is autism or autism spectrum disorder (ASD)? See 5 signs on my page. #autism #autismawareness', 35),
(477, '3TdBv0j3H6M', 'Keddi Kosár - Mi Vagyunk Magyar Péter (Mulatós Verzió)', 179),
(481, 'AUT5cjCOSQA', 'Spotify slágerek 2026 - Trend popslágerek 2026 🎧 Top zenei lejátszási lista 2026 🎵 Legújabb dalok 2026', 8499),
(495, 'Juo_5158tzs', 'Shiiiiiiiiiiiit, Got Yo Ass.', 8),
(499, 'OuxsXjRgSFU', 'Sdffd', 54),
(502, 'iZT40mOY8t8', '2025 SSDF 올장르 퍼포먼스 시상 해피캣모드, 시상도 이리 흥겹고 귀엽게💚 #쿄카 #kyoka #쿄카직캠 #귀여워 #ssdf', 75),
(515, 'MTW7H5UQ8Ts', 'What is Autism? | APA', 153),
(522, 'lRUIsWucoq8', 'Central Cee x Dave - Our 25th Birthday [Music Video]', 273);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `music_request`
--

CREATE TABLE `music_request` (
  `id` int(11) NOT NULL,
  `music_id` int(11) NOT NULL,
  `expire` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_hungarian_ai_ci;

--
-- A tábla adatainak kiíratása `music_request`
--

INSERT INTO `music_request` (`id`, `music_id`, `expire`) VALUES
(1, 22, '2026-03-26 09:05:08'),
(2, 410, '2026-03-26 09:09:41'),
(3, 477, '2026-03-26 09:01:18'),
(4, 481, '2026-03-26 09:11:12'),
(8, 472, '2026-03-26 09:05:20'),
(9, 2, '2026-03-26 09:07:12'),
(14, 114, '2026-03-26 09:16:59'),
(15, 502, '2026-03-27 07:12:14'),
(16, 23, '2026-03-27 07:14:43'),
(17, 14, '2026-03-27 07:14:50'),
(18, 12, '2026-03-27 07:15:13'),
(19, 5, '2026-03-27 07:16:20'),
(20, 473, '2026-03-27 07:16:48'),
(21, 1, '2026-03-27 07:22:10'),
(22, 6, '2026-03-27 07:22:17'),
(23, 38, '2026-03-27 07:23:26'),
(24, 515, '2026-03-27 07:23:54'),
(25, 21, '2026-03-27 07:24:21');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `music_test`
--

CREATE TABLE `music_test` (
  `id` int(11) NOT NULL,
  `video_id` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `lenght` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_hungarian_ai_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `playlist`
--

CREATE TABLE `playlist` (
  `id` int(11) NOT NULL,
  `music_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_hungarian_ai_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `playlist_test`
--

CREATE TABLE `playlist_test` (
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
(92, 'matyi', 'holczer.matyas.21@ady-nagyatad.hu', '12', '$2y$10$I/5y.o1UDmUyWNYhLjxPvOpNjqUBS3yinjyUsYpxHbYQIPwdmJUT6', 1, 1, 1, '52296de7b8a5da393013b1348fe032bd6d9decde26ef0db2c1ccc72d068bae2ae059ebfff6266032fdf741995d19e2f88cd02782cb1d175e318dcebfe9802c15'),
(96, 'Mészáros Róbert', 'meszaros.robert@ady-nagyatad.hu', '13c', '$2y$12$WIeU5jkztI2MliwslxHDGO6UsbWmGtfEBcRS61TP8DmdUjVyzpyQG', 1, 1, 1, 'c4a29588273b1a57a5295345eb6f062dba691a6dadf180fb089b50e6c0e66fd6f84eda2539d7f5e1140970bd512480a34802aec2e58293db398eec8238a4b46d'),
(97, 'Konyhási Máté', 'konyhasi.mate.21@ady-nagyatad.hu', '13.C', '$2y$10$ck06MrOoipUvwPqoaXcD6.CAYUwPTMBau3./AO3McKc.P9ePjCUOK', 1, 1, 1, 'ab7b70b3b46e3d1b22ae01909638b09d94f395606c1d4973b47cada4ea735457deffcdce69692bb8c60f2dccfb852c211245fcda015f525e905138f8ae3bf91d'),
(100, 'Hunor', 'horvath.hunor.21@ady-nagyatad.hu', '13.C', '$2y$10$.uLMIH8a7T43Y7G0326dw.Wu/4g2bR0MmMub6o37I2EsQJt2nqgRK', 1, 1, 1, '5047473dfacc80fa0e2e05f38adec673b56bbb0d4f6a626fa07ee4d56c220c5accc47a35487dc4bbfeef30391c5205cbdba112c2e55906fcd36722a5eaca9172');

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
-- A tábla adatainak kiíratása `user_handler`
--

INSERT INTO `user_handler` (`id`, `user_id`, `date`, `title`) VALUES
(281, 97, '2026-03-19 11:13:23', 'MARIO x ESSEMM x BEAT – Rajosan 3 /Official Music Video/'),
(282, 97, '2026-03-19 11:13:38', 'MARIO x ESSEMM x BEAT – Rajosan 3 /Official Music Video/'),
(283, 97, '2026-03-19 11:18:32', 'Asdasd.'),
(284, 97, '2026-03-19 11:21:43', 'Asdasd.'),
(285, 97, '2026-03-19 11:21:48', 'Shiiiiiiiiiiiit, Got Yo Ass.'),
(286, 97, '2026-03-19 11:21:57', 'live is life '),
(287, 97, '2026-03-19 11:26:20', 'What is autism or autism spectrum disorder (ASD)? See 5 signs on my page. #autism #autismawareness'),
(288, 97, '2026-03-20 08:06:31', 'Inside the Deal Between the SDF and Syrian Government'),
(289, 97, '2026-03-20 08:06:45', 'Sdffd'),
(290, 97, '2026-03-20 08:10:45', 'Asdasd.'),
(291, 97, '2026-03-20 08:11:00', 'Sdffd'),
(292, 97, '2026-03-20 08:11:01', 'Sdffd'),
(293, 97, '2026-03-20 08:11:01', 'Sdffd'),
(294, 97, '2026-03-20 08:11:01', 'Sdffd'),
(295, 97, '2026-03-20 08:22:20', 'MARIO – Hello /Official Music/'),
(296, 97, '2026-03-20 08:26:54', 'Asdasd.'),
(297, 97, '2026-03-20 08:26:58', 'live is life '),
(298, 97, '2026-03-20 08:26:59', 'What Is Autism Spectrum Disorder?'),
(299, 97, '2026-03-20 08:27:01', 'Pitbull - Don&#39;t Stop The Party ft. TJR'),
(300, 97, '2026-03-20 08:27:03', 'MARIO – Hello /Official Music/'),
(301, 100, '2026-03-20 08:33:36', 'Central Cee x Dave - Our 25th Birthday [Music Video]'),
(302, 97, '2026-03-20 08:39:24', 'Adele - Hello (Official Music Video)');

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
  ADD UNIQUE KEY `music_id` (`music_id`),
  ADD KEY `user_email` (`user_id`);

--
-- A tábla indexei `fav`
--
ALTER TABLE `fav`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`,`music_id`),
  ADD KEY `kedvenc_ibfk_2` (`music_id`);

--
-- A tábla indexei `music`
--
ALTER TABLE `music`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `video_youtube_id` (`video_id`);

--
-- A tábla indexei `music_request`
--
ALTER TABLE `music_request`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `music_id` (`music_id`);

--
-- A tábla indexei `playlist`
--
ALTER TABLE `playlist`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `music_id` (`music_id`),
  ADD KEY `user_id` (`user_id`);

--
-- A tábla indexei `playlist_test`
--
ALTER TABLE `playlist_test`
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT a táblához `currently_playing`
--
ALTER TABLE `currently_playing`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT a táblához `fav`
--
ALTER TABLE `fav`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=490;

--
-- AUTO_INCREMENT a táblához `music`
--
ALTER TABLE `music`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=524;

--
-- AUTO_INCREMENT a táblához `music_request`
--
ALTER TABLE `music_request`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT a táblához `playlist`
--
ALTER TABLE `playlist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=491;

--
-- AUTO_INCREMENT a táblához `playlist_test`
--
ALTER TABLE `playlist_test`
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT a táblához `user_handler`
--
ALTER TABLE `user_handler`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=303;

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
-- Megkötések a táblához `fav`
--
ALTER TABLE `fav`
  ADD CONSTRAINT `fav_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fav_ibfk_2` FOREIGN KEY (`music_id`) REFERENCES `music` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Megkötések a táblához `music_request`
--
ALTER TABLE `music_request`
  ADD CONSTRAINT `music_request_ibfk_1` FOREIGN KEY (`music_id`) REFERENCES `music` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Megkötések a táblához `playlist`
--
ALTER TABLE `playlist`
  ADD CONSTRAINT `playlist_ibfk_1` FOREIGN KEY (`music_id`) REFERENCES `music` (`id`) ON DELETE NO ACTION,
  ADD CONSTRAINT `playlist_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Megkötések a táblához `user_handler`
--
ALTER TABLE `user_handler`
  ADD CONSTRAINT `user_handler_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
