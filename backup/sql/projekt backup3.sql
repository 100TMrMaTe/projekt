-- phpMyAdmin SQL Dump
-- version 5.2.2deb1+deb13u1
-- https://www.phpmyadmin.net/
--
-- Gép: localhost:3306
-- Létrehozás ideje: 2026. Ápr 28. 11:38
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
(134, 131, 'd6aadf37361287455a48510255011a170de588c428de80ec66a2d3498288785b1c21340de828aa1846de213e323b99da3a3fa9e848e166514b7691213cb6002d', '2026-04-16 10:51:29'),
(160, 139, '2d33ec45112e5d51a2303a8b2fdeee7553e8046f0b06038a6a5313811a9fe0ed4059c9b1d6cde1e66c563dd84ba5b49f43e9066ba5d81b66dfe4fbeab9b25040', '2026-04-28 12:04:03'),
(165, 147, '9aa5066d203a6e881c9ed6a7799eff9ebb61da598f2bc5ed73cfb236749468f08a0ed7483193a600982990250192c38bd3d3115fd69a037ed9e0fd71ec74adff', '2026-04-28 12:05:45'),
(166, 100, '25cd4774ae435c3429514d35e54a8307df68aea664eb200d9851fcb43b22930868789887f9c2330ba09046eaa9e209106594b04cd8b9776168b3422d1232fee0', '2026-04-28 09:00:31'),
(167, 145, '7d4f15d32d364473cd102b081566b4a0d923318af7e2eb03f935f0fd4c9f1509a38ab2d99f79c55322ec80e54fd79ebf4c474a6cb1f9c19f0a71e34938d7a836', '2026-04-28 09:04:25');

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
(30, 3, 0, 76, 3, 3),
(31, 3, 1, 3, 3, 3),
(32, 3, 2, 3, 3, 3),
(33, 3, 3, 3, 3, 3),
(34, 3, 4, 3, 3, 3),
(35, 3, 5, 3, 3, 3),
(36, 3, 6, 3, 3, 3),
(37, 3, 7, 3, 3, 3),
(38, 3, 8, 3, 3, 3),
(39, 3, 9, 3, 3, 3),
(40, 3, 10, 3, 3, 3);

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
(1, 786, 1, 2056, 10, -1, 147);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `fav`
--

CREATE TABLE `fav` (
  `id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL,
  `music_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_hungarian_ai_ci;

--
-- A tábla adatainak kiíratása `fav`
--

INSERT INTO `fav` (`id`, `user_id`, `music_id`) VALUES
(512, 100, 1),
(520, 131, 713),
(522, 139, 745),
(526, 139, 759),
(530, 147, 681),
(531, 147, 778),
(527, 150, 9),
(528, 150, 723);

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
(522, 'lRUIsWucoq8', 'Central Cee x Dave - Our 25th Birthday [Music Video]', 273),
(527, 'LFVULy02DPE', 'AASD Class of 2024 Graduation Video', 269),
(529, 'vToLebc6ZfM', 'AASD Class of 2025 Graduation Video - open English captions', 262),
(539, '6pr71BzMzMw', 'She made from balloon🧏‍♀️🎈 #shorts #funny', 24),
(543, 'r-BhWxHjJuo', 'Tayna - Si Ai (Marshmello &amp; UKAY Remix)', 185),
(544, 'gDAQ5hUUzRo', 'WELLHELLO - APUVEDDMEG - OFFICIAL LYRIC VIDEO', 210),
(549, 'iQIhqBomoXE', 'T. Danny - xXx (Official Music Video)', 254),
(550, 'FpghNC7qXBU', 'MARIO – Gurulunk tovább | Official Music Video', 188),
(552, 'v2nI1w1regY', 'a legnagyobb rajongód', 168),
(557, 'sCz5y84dwuA', 'Peggy Gou - (It Goes Like) Nanana - Official Video', 165),
(573, 'g-12jN7pj1Y', 'VALMAR - UGYANÚGY (OFFICIAL MUSIC VIDEO)', 160),
(581, 'Jd8r14atYCE', 'ekhoe - Százszorszép', 165),
(584, 'SOR5_Q2Gkag', 'Strong R. ft. Amanna - Oh Szív! Nyugodj!', 249),
(587, 'mHONNcZbwDY', 'Lionel Richie - Hello (Official Music Video)', 327),
(589, 'P2zGBP3s-aI', 'Pogány Induló - Afro Beat (OFFICIAL MUSIC VIDEO)', 194),
(592, 'YAaoq1mcFUY', 'Jazz Relaxing Music &amp; Cozy Spring Coffee Shop Ambience 🌸 Smooth Jazz Instrumental Music for Studying', 42898),
(602, 'MvsAesQ-4zA', '1 Second VideO', 1),
(604, 'icPHcK_cCF4', 'Countdown 5 seconds', 6),
(615, 'fPza0hDjbsI', 'Halász Judit: Tíz kicsi cica (gyerekdal, animáció) | MESE TV - mesék, rajzfilmek gyerekeknek', 203),
(618, 'f2iQfEcO39A', 'Majka - Csurran, cseppen (official music video)', 356),
(619, '3MGqYCjP73A', 'Majka X Curtis X Király Viktor - Füttyös', 217),
(620, '--gDIzlCM6M', 'Majka &amp; Curtis &amp; Nika - A csúcson túl (Official Music Video)', 216),
(621, 'NJ-IzX73dG4', 'Majka, Curtis, BLR - Belehalok', 271),
(622, 'pD7YrrjcOIQ', 'Curtis - Újpest a negyedem!', 265),
(623, 'RLJWh_FnFH0', 'Curtis - Fehér rózsa (Official Music Video)', 223),
(624, 'gcz1oxBC2c8', 'Curtis - Lehetne újra február (Official Music Video)', 208),
(626, '8UFIYGkROII', 'Soulja Boy Tell&#39;em - Crank That (Soulja Boy) (Official Music Video)', 238),
(632, 'byxFUKxhT3s', 'Alex Warren - Ordinary (Lyrics)', 186),
(640, 'UC-jvK553-A', 'Atesz - Az a segg, az a mell (Dj.Louis, Devil, Miklov Club Mix)_Radio Edit', 230),
(644, 'bVDNFuhGVKg', 'HORVÁTH TAMÁS &amp; RAUL - TÁNCOL VELEM A VILÁG (Official Music Video)', 240),
(645, 'ZWpCdnpq0lE', 'LL JUNIOR - FREY TIMI (Boda Kevin REMIX)', 134),
(650, 'u2F7hlwYFpg', 'L.L. Junior - Miattad (&quot;Fehér holló&quot; album)', 282),
(651, 'Pv8TKxvxNgU', 'DJ Dominique x Shygys: Hello 2026', 293),
(655, 'XsX3ATc3FbA', 'BTS (방탄소년단) &#39;작은 것들을 위한 시 (Boy With Luv) (feat. Halsey)&#39; Official MV', 253),
(666, 'NTwyipJrdPM', 'M1 - Híradó élő közvetítése', 0),
(667, 'Fgrnmo8iIHQ', 'Választás 2026 - A Vadhajtások hivatalos kampánydala', 89),
(681, 'xFrGuyw1V8s', 'ABBA - Dancing Queen (Official Music Video)', 233),
(682, 'jNQXAC9IVRw', 'Me at the zoo', 19),
(706, 'JycXBDjQl1U', 'RENDSZERVÁLTÓ CSORONITA MIX - GYÓNTATÓFÜLKE', 230),
(708, '1dMX6jlFTm8', 'DJTESLA69 - Hullik már a vén diófa levele', 230),
(710, 'TUDR9Lf2PFs', 'Atka - Monaco', 155),
(712, '6IfYhC-P-Ck', 'gyuris - meleg van', 150),
(713, 'DyPSggdS_Ew', 'gyuris - ponyvaregény', 168),
(717, 'rfUkFPCAcTE', 'volkswagen 1.9 tdi cold start -20c', 61),
(718, 'TuxMwALL_S4', 'Flo Rida - My House (Official Audio)', 194),
(719, 'OMuYf1HZ1LA', 'Gáspár Laci - TAVASZ', 203),
(720, 'PaD5DxobfT8', 'byealex és a slepp - 1év', 173),
(721, 'Ys7-6_t7OEQ', 'Justin Bieber - Beauty And A Beat (Official Music Video) ft. Nicki Minaj', 293),
(723, '520LNy1n5XU', 'MISSH feat. RAUL &amp; HORVÁTH TAMÁS – Beléd estem (Official Music Video) | #misshmusic', 235),
(724, '84DkaLNXKnY', 'Dögös Robi - Vettem neked gyémántokat', 164),
(725, '4DjeQGvsLjo', 'Koó János - kislány a zongoránál', 243),
(726, 'GnG5VxVHcTI', 'Perghouse 2017 Kegyetlen Pergető', 212),
(729, 'IE62yVELgno', 'KKevin - JACUZZI feat. BSW (SAVAGE ALBUM)', 130),
(730, 'h5XYbYNAlMQ', 'Coronita Mix 2024 Május - Dj Bacsa', 2850),
(731, 'BS2xr9mxD0s', 'Mehringer, BALKAN VIP, sosehol - SZAR AZ ÉLET', 198),
(732, 'mtRNgIsnKKY', 'KKevin - JACUZZI feat. BSW (Official Music Video)', 130),
(734, 'F09OFZFaoL0', 'OŁÓW ale to MOCNA VIXA', 123),
(740, '4uPDfuC3Jck', 'Dr. Alban - No Coke (Official HD Video)', 222),
(741, 'pKxJca7LLNM', 'Dr. Alban - Sing Hallelujah (Official HD Video)', 241),
(745, 'ufJqsmAfxnc', 'Punnany Massif - Élvezd', 238),
(750, 'iHLKKfifx1k', 'Béla - Arcon Köplek feat. Pista [OFFICIAL MUSIC VIDEO]', 189),
(751, 'l-nQU53Py8I', 'VIP - Jeden Krótki SMS (Tahiti Remix)', 232),
(756, 'hTWKbfoikeg', 'Nirvana - Smells Like Teen Spirit (Official Music Video)', 279),
(757, 'CGt-rTDkMcM', 'Omega - Gyöngyhajú lány', 238),
(758, 'HE4aAQCghGs', 'Republic - A 67-es Út', 287),
(759, 'H553cCOrsSw', 'Bagossy Brothers Company - Olyan Ő (Home Session)', 213),
(764, 'YlUKcNNmywk', 'Red Hot Chili Peppers - Californication (Official Music Video) [HD UPGRADE]', 322),
(770, 'D2xmlzMOsmM', '[BTS - Boy With Luv] Comeback Special Stage | M COUNTDOWN 190418 EP.615', 288),
(772, 'AQ4TW5Z8eu0', 'Sean Paul - I&#39;m Still In Love With You (Official Video)', 276),
(777, 'hEMm7gxBYSc', 'Nirvana - Where Did You Sleep Last Night (Live On MTV Unplugged, 1993 / Unedited)', 412),
(778, 'KrZHPOeOxQQ', 'Bon Jovi - You Give Love A Bad Name', 231),
(780, 'WL7_DjyZGtg', 'KKevin - WAY TOO HIGH feat. RZMVS (Official Music Video)', 189),
(781, '8nbI_gdmXwY', 'L.L. Junior - Ennyi volt (hivatalos videoklip)', 224),
(782, 'T_YHIZCiM0g', 'Kurva Karnevál', 218),
(784, 'nV0K_DIYtIg', 'PØLEVAYA Live at Coronita After - Brandus', 4299),
(785, 'WA8j_b5WTys', 'Kowalsky meg a Vega - Amilyen hülye vagy, úgy szeretlek (Official video klip)', 268),
(786, 'zgunMW710rA', 'Music Mix 2026 | Party Club Dance 2026 | Best Remixes Of Popular Songs 2026 MEGAMIX', 10798);

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
(4, 481, '2026-03-30 07:12:03'),
(8, 472, '2026-03-26 09:05:20'),
(9, 2, '2026-03-26 09:07:12'),
(14, 114, '2026-03-26 09:16:59'),
(15, 502, '2026-03-27 07:12:14'),
(16, 23, '2026-03-27 09:19:33'),
(17, 14, '2026-03-27 07:14:50'),
(18, 12, '2026-03-27 07:15:13'),
(19, 5, '2026-05-04 19:48:32'),
(20, 473, '2026-03-27 07:16:48'),
(21, 1, '2026-03-27 07:22:10'),
(22, 6, '2026-03-27 09:19:35'),
(23, 38, '2026-03-27 07:23:26'),
(24, 515, '2026-03-27 07:23:54'),
(25, 21, '2026-03-27 07:24:21'),
(29, 527, '2026-03-27 09:19:42'),
(30, 44, '2026-03-27 09:50:58'),
(31, 544, '2026-03-27 10:30:34'),
(33, 9, '2026-04-27 08:31:34'),
(34, 655, '2026-04-09 17:05:43'),
(35, 708, '2026-04-23 09:02:08'),
(37, 201, '2026-04-29 09:47:21'),
(38, 166, '2026-04-30 11:55:57'),
(40, 681, '2026-05-05 07:34:09'),
(41, 782, '2026-05-05 09:30:08');


-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `napok`
--

CREATE TABLE `napok` (
  `id` int(11) NOT NULL,
  `nap` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `napok`
--

INSERT INTO `napok` (`id`, `nap`) VALUES
(1, 'Normál'),
(3, 'Rendkivüli'),
(2, 'Röviditett');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `orak`
--

CREATE TABLE `orak` (
  `id` int(11) NOT NULL,
  `idopont` time NOT NULL,
  `aktive` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `orak`
--

INSERT INTO `orak` (`id`, `idopont`, `aktive`) VALUES
(1, '07:03:00', 1),
(2, '07:05:00', 1),
(3, '07:50:00', 1),
(4, '07:58:00', 1),
(5, '08:00:00', 1),
(6, '08:45:00', 1),
(7, '08:53:00', 1),
(8, '08:55:00', 1),
(9, '09:40:00', 1),
(10, '09:48:00', 1),
(11, '09:50:00', 1),
(12, '10:35:00', 1),
(13, '10:38:00', 1),
(14, '10:40:00', 1),
(15, '11:25:00', 1),
(16, '11:38:00', 1),
(17, '11:40:00', 1),
(18, '12:25:00', 1),
(19, '12:28:00', 1),
(20, '12:30:00', 1),
(21, '13:15:00', 1),
(22, '13:18:00', 1),
(23, '13:20:00', 1),
(24, '14:05:00', 1),
(25, '14:08:00', 1),
(26, '14:10:00', 1),
(27, '14:55:00', 1),
(28, '14:58:00', 1),
(29, '15:00:00', 1),
(30, '15:45:00', 1),
(31, '15:48:00', 1),
(32, '15:50:00', 1),
(33, '16:35:00', 1),
(34, '08:40:00', 0),
(35, '08:48:00', 0),
(36, '08:50:00', 0),
(37, '09:30:00', 0),
(38, '09:38:00', 0),
(40, '10:20:00', 0),
(41, '10:23:00', 0),
(42, '10:25:00', 0),
(43, '11:05:00', 0),
(44, '11:18:00', 0),
(45, '11:20:00', 0),
(46, '12:00:00', 0),
(47, '12:03:00', 0),
(48, '12:05:00', 0),
(49, '12:45:00', 0),
(50, '12:48:00', 0),
(51, '12:50:00', 0),
(52, '13:30:00', 0),
(53, '13:33:00', 0),
(54, '13:35:00', 0),
(55, '14:15:00', 0),
(56, '14:18:00', 0),
(57, '14:20:00', 0),
(59, '15:03:00', 0),
(60, '15:05:00', 0),
(62, '00:00:00', 0),
(63, '10:10:00', 0),
(64, '10:11:00', 0),
(65, '10:12:00', 0),
(66, '10:13:00', 0),
(67, '10:14:00', 0),
(68, '10:15:00', 0),
(69, '10:16:00', 0),
(70, '10:17:00', 0),
(71, '10:18:00', 0),
(72, '10:08:00', 0),
(73, '10:09:00', 0),
(74, '12:06:00', 0),
(75, '12:41:00', 0),
(76, '12:42:00', 0);

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
(96, 'Mészáros Róbert', 'meszaros.robert@ady-nagyatad.hu', '13c', '$2y$12$j3cPoKnxOOvFBQZ6ofc/eux/yRs3gRvOOke685pkBaf6e1W4KLzAG', 1, 1, 1, '732d2684dd4c1d7f7332070e1b4b1209ba15d08bf61e59348052db98a5b49476e1d78f7d93324ede2755addaa5045612324322af0fe355015b24deaa85c9c4f1'),
(100, 'Hunor', 'horvath.hunor.21@ady-nagyatad.hu', '13.C', '$2y$12$sIk5thDezJEZBq90bd0RruIGUnQ1vBtaxTfYA0pVUisUb6/IPG0fq', 1, 0, 1, '915d9d96ac6e47316cc4092f540fa66fdf6f4785636aa8fecf534f2b99b87ef6941fca2e19393bf253ee029e137ee68f3526330e99e93e5015be71662f1b16e1'),
(131, 'Falusi Farkas', 'lebar.oliver.21@ady-nagyatad.hu', '13/C', '$2y$12$uZAfAHUOdg22NyZ7PkKf0.JqxBUdYswYL3pxPH/.siGE3WTTthlA6', 1, 0, 1, '550578b4de7665ea44c21034d4a261fd9e682e5dc8e7a15bcaeca80ec3c150b636dd9c22e635412a6c7d45579dd3b88ce579eb2f91b574f7d4e4bec4fcb90e6d'),
(139, 'matyi', 'holczer.matyas.21@ady-nagyatad.hu', '13c', '$2y$12$vRlputKKfYXMEh8rCYqa9.z9okcyUKmWc3Op9pwB9jD9ud1aUC55i', 1, 1, 1, 'cb4246e678bcd361652d3c5350c01aa6af530a3f6330afa88c9a4dc66499f9dab2f267caa702e409dec3ac4f3358683727fdfd960a49ff7ae66c8f847ae74c92'),
(140, 'Robi', 'keszericze.akos.21@ady-nagyatad.hu', '13c', '$2y$12$2HJmzUHofzUpq5snn0AhZuQ4PY4MRjH9vIwuzC3WAunrQz5ctyBkm', 1, 0, 1, '721541a556155b69d786f48b5f134a4b753c02a6c4def4cd2b0136543a5ad5e8241842e41c08caba7e8626ab7f68a7499fc6f8516d794570917e64c730a467cc'),
(141, 'Teszt Elek', 'papp.peter@ady-nagyatad.hu', '11K', '$2y$12$rJ/OEd..2s98qGJetLyPlOYEYqe02phphpNh7nUzisXiCf.ZDuMii', 0, 0, 0, '1650f3ea5eb3a9e337a2fe8c0543e37073726a27d86904ffffc3db96201a37856795706cd838de2dc12b6d06795897b8df17ae65294e08f90cf5d2fa265b0402'),
(145, 'mate', 'konyhasi.mate.21@ady-nagyatad.hu', 'asd', '$2y$12$7NizdQfmo7ameO4bFq2GYereoCjfjfefIKcpsqREEjg4KAopTqhKG', 1, 1, 1, '906b0d8744bcb465bc5dcfc81347de83b909c7ee12b2991d4bb8cca6fc4278864967f62fd9765e737f786de77da46ccb3345ec681f81dffa0b7af4403231bdd0'),
(147, 'admin', 'jankovics.peter.21@ady-nagyatad.hu', '13.C', '$2y$12$Dx3XkVyxVg0.pGPfHyzR2OH2jQ3Se5Ag0cC/O3pUWfiX77KlJCsYG', 1, 1, 1, 'c44bde2e276fed6066a0f2666cfd2a00b47a4d6971776493f2d2cd611fd4a05027880e0d4323789caef47a5cb265026953e8689e150004d7d1f845c233d7c50d'),
(149, 'Cuci', 'verbulecz.bence.21@ady-nagyatad.hu', '13', '$2y$12$AF0Z8f29chalRUk9l5qsmut3o.bXiXyMdF0TpgfwG0D9UTKfwfdoS', 1, 0, 1, '79d6c85a77397b65888761d6cf70cba48004fd7370a6c861dd9ca650d533ba7d8115b4c7985d6ac2956d510632c728f92d35aef76a4679b6266a4df2d0a5a00e'),
(150, 'csongi', 'pinter.csongor.21@ady-nagyatad.hu', '13/c', '$2y$12$0vCoYrz7U0GCbWSzzW3NDumsWatbrXYVkF3i/EJTBqn15cURQBA86', 1, 0, 1, '52230e17333659631cac41309928c1a9c663525ea8decab761eba483e998d01adff20d0a14e037c41db15ebffd42f1c214e427567ce7a859fe6829e3b13bf068'),
(154, 'Tálas László Martin', 'talas.laszlo.martin.21@ady-nagyatad.hu', '13.C', '$2y$12$uf3WsiQdgzK7R6CiG6YB7.bQ8HN9gylMBkutLCzDD2SH/IFGUmATO', 1, 0, 1, '6a3b33e7c50e10305e82bc3a9f9736edda0aa56d2cfd27db3adec9641af23a53b32d9d973e0ebfc274c0539f10c5e53c5303f7d767336ce2c2a802e45c76533f');

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
(301, 100, '2026-03-20 08:33:36', 'Central Cee x Dave - Our 25th Birthday [Music Video]'),
(341, 96, '2026-03-20 10:20:45', 'Spotify slágerek 2026 - Trend popslágerek 2026 🎧 Top zenei lejátszási lista 2026 🎵 Legújabb dalok 2026'),
(468, 100, '2026-03-25 11:17:11', 'PGT - PGT TEAM (MINECRAFT ZENE ANIMÁCIÓ)'),
(469, 100, '2026-03-25 11:17:18', 'live is life '),
(571, 131, '2026-04-16 09:51:05', 'DESH - VINNIPU (Official Music Video)'),
(572, 131, '2026-04-16 09:53:38', 'Atesz - Az a segg, az a mell (Dj.Louis, Devil, Miklov Club Mix)_Radio Edit'),
(575, 131, '2026-04-16 09:56:39', 'Flo Rida - My House (Official Audio)'),
(576, 131, '2026-04-16 10:01:50', 'Gáspár Laci - TAVASZ'),
(577, 131, '2026-04-16 10:04:58', 'byealex és a slepp - 1év'),
(578, 131, '2026-04-16 10:10:15', 'Justin Bieber - Beauty And A Beat (Official Music Video) ft. Nicki Minaj'),
(579, 131, '2026-04-16 10:15:00', 'live is life '),
(580, 131, '2026-04-16 10:15:25', 'MISSH feat. RAUL &amp; HORVÁTH TAMÁS – Beléd estem (Official Music Video) | #misshmusic'),
(582, 131, '2026-04-16 10:19:59', 'Koó János - kislány a zongoránál'),
(583, 131, '2026-04-16 10:21:22', 'Perghouse 2017 Kegyetlen Pergető'),
(594, 96, '2026-04-21 09:12:02', 'DESH - TALPRA CIGÁNYOK (Official Music Video)'),
(595, 96, '2026-04-21 09:12:39', 'DESH - TALPRA CIGÁNYOK (Official Music Video)'),
(596, 96, '2026-04-21 09:33:06', 'Dr. Alban - No Coke (Official HD Video)'),
(597, 96, '2026-04-21 09:33:16', 'Dr. Alban - Sing Hallelujah (Official HD Video)'),
(598, 96, '2026-04-21 09:34:51', 'BSW - HELLO (Official Music Video)'),
(599, 96, '2026-04-21 09:34:53', 'BSW - HELLO (Official Music Video)'),
(603, 139, '2026-04-21 10:57:31', 'Punnany Massif - Élvezd'),
(606, 139, '2026-04-21 11:04:43', 'KKevin - JACUZZI feat. BSW (SAVAGE ALBUM)'),
(613, 139, '2026-04-22 06:28:39', 'ABBA - Dancing Queen (Official Music Video)'),
(614, 139, '2026-04-22 06:28:55', 'Nirvana - Smells Like Teen Spirit (Official Music Video)'),
(615, 139, '2026-04-22 06:29:12', 'Omega - Gyöngyhajú lány'),
(616, 139, '2026-04-22 06:29:30', 'Republic - A 67-es Út'),
(617, 139, '2026-04-22 08:25:46', 'Bagossy Brothers Company - Olyan Ő (Home Session)'),
(618, 139, '2026-04-22 08:26:13', 'Nirvana - Smells Like Teen Spirit (Official Music Video)'),
(619, 139, '2026-04-22 08:26:16', 'Omega - Gyöngyhajú lány'),
(620, 139, '2026-04-23 18:36:36', 'Red Hot Chili Peppers - Californication (Official Music Video) [HD UPGRADE]'),
(621, 147, '2026-04-27 07:12:07', 'live is life '),
(622, 147, '2026-04-27 07:12:52', 'PGT - PGT TEAM (MINECRAFT ZENE ANIMÁCIÓ)'),
(623, 139, '2026-04-27 07:21:42', 'BSW - HELLO (Official Music Video)'),
(624, 150, '2026-04-27 07:25:26', 'MISSH feat. RAUL &amp; HORVÁTH TAMÁS – Beléd estem (Official Music Video) | #misshmusic'),
(625, 150, '2026-04-27 07:26:32', 'LACIKA - FEKETE MERCEDES 🛞 (OFFICIAL MUSIC VIDEO)'),
(626, 147, '2026-04-27 07:40:38', 'LACIKA - FEKETE MERCEDES 🛞 (OFFICIAL MUSIC VIDEO)'),
(628, 147, '2026-04-27 11:49:01', 'DESH X YOUNG FLY X AZAHRIAH - TIP TIP (Official Music Video)'),
(629, 147, '2026-04-27 12:04:54', 'Sean Paul - I&#39;m Still In Love With You (Official Video)'),
(630, 147, '2026-04-28 06:13:30', 'Hunter - Roblox (Hivatalos AI Zene)'),
(631, 147, '2026-04-28 06:21:44', 'ABBA - Dancing Queen (Official Music Video)'),
(632, 147, '2026-04-28 06:23:41', 'live is life '),
(633, 147, '2026-04-28 06:24:12', 'ABBA - Dancing Queen (Official Music Video)'),
(634, 147, '2026-04-28 06:25:10', 'Nirvana - Where Did You Sleep Last Night (Live On MTV Unplugged, 1993 / Unedited)'),
(635, 147, '2026-04-28 06:25:32', 'Bon Jovi - You Give Love A Bad Name'),
(636, 147, '2026-04-28 06:34:14', 'ABBA - Dancing Queen (Official Music Video)'),
(637, 147, '2026-04-28 06:49:05', 'KKevin - WAY TOO HIGH feat. RZMVS (Official Music Video)'),
(638, 147, '2026-04-28 06:56:14', 'L.L. Junior - Ennyi volt (hivatalos videoklip)'),
(660, 139, '2026-04-28 11:23:29', 'Flo Rida - My House (Official Audio)'),
(661, 147, '2026-04-28 11:27:16', 'PØLEVAYA Live at Coronita After - Brandus'),
(662, 147, '2026-04-28 11:34:54', 'Kowalsky meg a Vega - Amilyen hülye vagy, úgy szeretlek (Official video klip)'),
(663, 147, '2026-04-28 11:35:44', 'Music Mix 2026 | Party Club Dance 2026 | Best Remixes Of Popular Songs 2026 MEGAMIX');

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
-- A tábla indexei `csengetes`
--
ALTER TABLE `csengetes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nap_id` (`nap_id`,`jelzo_id`,`becsengetes_id`,`kicsengetes_id`),
  ADD KEY `jelzo_id` (`jelzo_id`),
  ADD KEY `becsengetes_id` (`becsengetes_id`),
  ADD KEY `kicsengetes_id` (`kicsengetes_id`);

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
-- A tábla indexei `napok`
--
ALTER TABLE `napok`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nap` (`nap`);

--
-- A tábla indexei `orak`
--
ALTER TABLE `orak`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idopont` (`idopont`);

--
-- A tábla indexei `playlist`
--
ALTER TABLE `playlist`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `music_id` (`music_id`),
  ADD KEY `user_id` (`user_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=168;

--
-- AUTO_INCREMENT a táblához `csengetes`
--
ALTER TABLE `csengetes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT a táblához `currently_playing`
--
ALTER TABLE `currently_playing`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2009;

--
-- AUTO_INCREMENT a táblához `fav`
--
ALTER TABLE `fav`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=533;

--
-- AUTO_INCREMENT a táblához `music`
--
ALTER TABLE `music`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=787;

--
-- AUTO_INCREMENT a táblához `music_request`
--
ALTER TABLE `music_request`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT a táblához `napok`
--
ALTER TABLE `napok`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT a táblához `orak`
--
ALTER TABLE `orak`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT a táblához `playlist`
--
ALTER TABLE `playlist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=852;

--
-- AUTO_INCREMENT a táblához `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=155;

--
-- AUTO_INCREMENT a táblához `user_handler`
--
ALTER TABLE `user_handler`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=664;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `active_users`
--
ALTER TABLE `active_users`
  ADD CONSTRAINT `active_users_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `csengetes`
--
ALTER TABLE `csengetes`
  ADD CONSTRAINT `csengetes_ibfk_1` FOREIGN KEY (`nap_id`) REFERENCES `napok` (`id`),
  ADD CONSTRAINT `csengetes_ibfk_2` FOREIGN KEY (`jelzo_id`) REFERENCES `orak` (`id`),
  ADD CONSTRAINT `csengetes_ibfk_3` FOREIGN KEY (`becsengetes_id`) REFERENCES `orak` (`id`),
  ADD CONSTRAINT `csengetes_ibfk_4` FOREIGN KEY (`kicsengetes_id`) REFERENCES `orak` (`id`);

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
