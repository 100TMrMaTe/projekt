-- phpMyAdmin SQL Dump
-- version 5.2.2deb1+deb13u1
-- https://www.phpmyadmin.net/
--
-- Gép: localhost:3306
-- Létrehozás ideje: 2026. Ápr 21. 11:07
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
(124, 129, '4959e5440541296f6d3187ba58cff2e484bdc9254299c0bc8695fb9b0135481bbd1365fc3bf4fc3ca0a00d2e4f8d6262b0323d14aa61a3a896463d9a93d50f12', '2026-04-21 10:42:00'),
(133, 130, '5ba8d8a3579cfd708c4db19ecf112fc4efa88b388a015f162c3033d747c345918804458d786401e19ab31d6c1418e07cf03d405e1a03e81967e30691820e3c05', '2026-04-02 16:45:47'),
(134, 131, 'd6aadf37361287455a48510255011a170de588c428de80ec66a2d3498288785b1c21340de828aa1846de213e323b99da3a3fa9e848e166514b7691213cb6002d', '2026-04-16 10:51:29'),
(145, 124, 'cb44edc639d04c6f910e1abcd3391e6cf56fb6129b7085b561488857b03c05c3c4b01d6e63a5c6d1bdf1ba6f5a789f35797a5050fa773f8cfa43979a7e408606', '2026-04-21 11:37:01'),
(149, 139, '41bde5116034e285eaf561bb9bf17fe05d47f8e0ac4e74ea6a5efa0b2407d6f3f5c37778535c0752d396b8eef0b010636b74d729861c5870d06055a54bd4bbd3', '2026-04-21 11:36:28');

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
(1, 750, 1, 16, 71, -1, 124);

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
(521, 139, 13),
(522, 139, 745);

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
(750, 'iHLKKfifx1k', 'Béla - Arcon Köplek feat. Pista [OFFICIAL MUSIC VIDEO]', 189);

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
(19, 5, '2026-03-27 07:16:20'),
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
(35, 708, '2026-04-23 09:02:08');

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
-- Tábla szerkezet ehhez a táblához `playlist_test`
--

CREATE TABLE `playlist_test` (
  `id` int(11) NOT NULL,
  `music_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_hungarian_ai_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `szunetek`
--

CREATE TABLE `szunetek` (
  `id` int(11) NOT NULL,
  `hossz` time NOT NULL
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
(96, 'Mészáros Róbert', 'meszaros.robert@ady-nagyatad.hu', '13c', '$2y$12$T7285nSuoBl2yjTSST6ZuecDIWs2ofJGz0Dpnx4YdnSABtg/ViqZW', 1, 1, 1, '249042d7687b7203f44acfbe3cec35d0e44d8856b351668b03cdf15369c819c0b5393a97d5b5b93bba72ef94a2512838ef1644f7a467eb1e7b66f00f2e7f3665'),
(100, 'Hunor', 'horvath.hunor.21@ady-nagyatad.hu', '13.C', '$2y$10$.uLMIH8a7T43Y7G0326dw.Wu/4g2bR0MmMub6o37I2EsQJt2nqgRK', 1, 0, 1, '5047473dfacc80fa0e2e05f38adec673b56bbb0d4f6a626fa07ee4d56c220c5accc47a35487dc4bbfeef30391c5205cbdba112c2e55906fcd36722a5eaca9172'),
(124, 'peti', 'jankovics.peter.21@ady-nagyatad.hu', '13.C', '$2y$10$0FvV4DM8q2xGdZjW1TPnG.DRS1tYeGngWck7P3pSD7XrSVdtfSQZK', 1, 1, 1, '74f17b28733f50b6821d1a26b5ddea1534aea15be0debfc3e21e962e873236cfa7997cdaba7ab4ea8c070df0ea380e0bfac8d9f8c0197d663e9a609a6ab4ab6b'),
(129, 'mate', 'konyhasi.mate.21@ady-nagyatad.hu', '13.C', '$2y$10$gjDI3qJEG9ACKXFeir8hv.Aom7YPkIJ8dX/9KPNO3afLmFf502e3a', 1, 1, 1, '53b7443c73baaeaf4ae78ceb27d112d06b66543796c2177f7f40c203b2bdbc66e294d4d4f52e2b94c9684504532059d30a6a5b1b7395ad6fd27718dba756c8b2'),
(130, 'Lébár Gréta', 'lebar.greta.21@ady-nagyatad.hu', '13.D', '$2y$12$yS9pqmTa23lB2l5ivV2D5uQe71CCAg8YAZ8RG/kUqtoIUoKVTQodq', 1, 0, 1, '95f6cca657f585b625c71d2ecaaffa838982b337a85d98d656cf1bee3289a615f71f50017774b39bc0f211b5c1cbe971546f7a2e3de8c83393ff54110fa58749'),
(131, 'Falusi Farkas', 'lebar.oliver.21@ady-nagyatad.hu', '13/C', '$2y$12$uZAfAHUOdg22NyZ7PkKf0.JqxBUdYswYL3pxPH/.siGE3WTTthlA6', 1, 0, 1, '550578b4de7665ea44c21034d4a261fd9e682e5dc8e7a15bcaeca80ec3c150b636dd9c22e635412a6c7d45579dd3b88ce579eb2f91b574f7d4e4bec4fcb90e6d'),
(139, 'asd', 'holczer.matyas.21@ady-nagyatad.hu', 'asd', '$2y$12$vRlputKKfYXMEh8rCYqa9.z9okcyUKmWc3Op9pwB9jD9ud1aUC55i', 1, 1, 1, '77c466a8d9a90b680d4ca2598a1ede6842bafee85cb32ecd54b727e4fabfae8ff672fe52a46b128eb1770c2b5a444dd8ab7b02a2932c26c5f689a0e8ccb65c7f');

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
(447, 124, '2026-03-25 08:09:21', 'Hunter - Roblox (Hivatalos AI Zene)'),
(448, 124, '2026-03-25 08:09:45', 'Adele - Hello (Official Music Video)'),
(449, 124, '2026-03-25 08:10:55', 'PGT - PGT TEAM (MINECRAFT ZENE ANIMÁCIÓ)'),
(450, 124, '2026-03-25 08:11:44', 'Mikee Mykanic - Cica (feat. Ótvar Pestis) [Official Audio]'),
(451, 124, '2026-03-25 08:12:24', 'Cica dal'),
(452, 124, '2026-03-25 08:13:25', 'Halász Judit: Tíz kicsi cica (gyerekdal, animáció) | MESE TV - mesék, rajzfilmek gyerekeknek'),
(453, 124, '2026-03-25 08:13:32', 'DESH - VINNIPU (Official Music Video)'),
(454, 124, '2026-03-25 08:13:48', 'PGT - PGT TEAM (MINECRAFT ZENE ANIMÁCIÓ)'),
(455, 124, '2026-03-25 08:16:54', 'Majka - Csurran, cseppen (official music video)'),
(456, 124, '2026-03-25 08:16:59', 'Majka X Curtis X Király Viktor - Füttyös'),
(457, 124, '2026-03-25 08:17:01', 'Majka &amp; Curtis &amp; Nika - A csúcson túl (Official Music Video)'),
(458, 124, '2026-03-25 08:17:03', 'Majka, Curtis, BLR - Belehalok'),
(459, 124, '2026-03-25 08:17:22', 'Curtis - Újpest a negyedem!'),
(460, 124, '2026-03-25 08:17:28', 'Curtis - Fehér rózsa (Official Music Video)'),
(461, 124, '2026-03-25 08:17:32', 'Curtis - Lehetne újra február (Official Music Video)'),
(462, 124, '2026-03-25 08:17:37', 'Curtis - Fehér rózsa (Official Music Video)'),
(463, 124, '2026-03-25 08:22:59', 'Soulja Boy Tell&#39;em - Crank That (Soulja Boy) (Official Music Video)'),
(464, 124, '2026-03-25 11:02:06', 'Majka - Csurran, cseppen (official music video)'),
(465, 124, '2026-03-25 11:02:09', 'Majka - Csurran, cseppen (official music video)'),
(466, 124, '2026-03-25 11:07:57', 'PGT - PGT TEAM (MINECRAFT ZENE ANIMÁCIÓ)'),
(467, 124, '2026-03-25 11:13:28', 'PGT - PGT TEAM (MINECRAFT ZENE ANIMÁCIÓ)'),
(468, 100, '2026-03-25 11:17:11', 'PGT - PGT TEAM (MINECRAFT ZENE ANIMÁCIÓ)'),
(469, 100, '2026-03-25 11:17:18', 'live is life '),
(470, 129, '2026-03-25 11:21:32', 'Halász Judit - Boldog Születésnapot'),
(471, 124, '2026-03-25 11:21:35', 'Alex Warren - Ordinary (Lyrics)'),
(472, 124, '2026-03-25 11:21:38', 'VZS - RENDŐR BÁCSI, KÉREM (Official Visualizer)'),
(473, 124, '2026-03-25 11:21:42', 'DESH - TALPRA CIGÁNYOK (Official Music Video)'),
(474, 124, '2026-03-25 11:21:48', 'Spotify slágerek 2026 - Trend popslágerek 2026 🎧 Top zenei lejátszási lista 2026 🎵 Legújabb dalok 2026'),
(475, 124, '2026-03-25 11:21:51', 'VZS - VÁRJ MEG  feat. RZMVS (OFFICIAL VISUALIZER)'),
(476, 124, '2026-03-26 09:18:56', 'Hunter - Roblox (Hivatalos AI Zene)'),
(477, 124, '2026-03-26 09:30:49', 'Majka - Csurran, cseppen (official music video)'),
(478, 124, '2026-03-26 10:32:54', 'live is life '),
(479, 124, '2026-03-30 06:25:51', 'Adele - Hello (Official Music Video)'),
(480, 124, '2026-03-30 06:27:25', 'Atesz - Az a segg, az a mell (Dj.Louis, Devil, Miklov Club Mix)_Radio Edit'),
(481, 124, '2026-03-30 08:28:50', 'Hunter - Roblox (Hivatalos AI Zene)'),
(482, 124, '2026-03-31 06:19:30', 'Cica dal'),
(483, 124, '2026-03-31 06:23:24', 'HORVÁTH TAMÁS &amp; RAUL - TÁNCOL VELEM A VILÁG (Official Music Video)'),
(484, 124, '2026-03-31 06:23:56', 'LL JUNIOR - FREY TIMI (Boda Kevin REMIX)'),
(485, 124, '2026-03-31 06:26:38', 'KKEVIN x L.L. Junior - GETTÓMILLIOMOS (Official Visualizer)'),
(487, 124, '2026-03-31 07:09:27', 'PGT - PGT TEAM (MINECRAFT ZENE ANIMÁCIÓ)'),
(489, 124, '2026-03-31 07:14:48', 'L.L. Junior - Miattad (&quot;Fehér holló&quot; album)'),
(491, 124, '2026-03-31 09:19:48', 'live is life '),
(492, 124, '2026-04-01 16:24:34', 'Adele - Hello (Official Music Video)'),
(493, 124, '2026-04-02 16:04:08', 'Mikee Mykanic - Cica (feat. Ótvar Pestis) [Official Audio]'),
(494, 124, '2026-04-02 16:04:44', 'BTS (방탄소년단) &#39;작은 것들을 위한 시 (Boy With Luv) (feat. Halsey)&#39; Official MV'),
(495, 124, '2026-04-02 16:06:44', 'BSW - HELLO (Official Music Video)'),
(496, 130, '2026-04-02 16:15:39', 'Adele - Hello (Official Music Video)'),
(497, 124, '2026-04-11 21:20:19', 'DESH - VINNIPU (Official Music Video)'),
(498, 124, '2026-04-13 06:59:43', 'VZS - RENDŐR BÁCSI, KÉREM (Official Visualizer)'),
(499, 124, '2026-04-14 08:02:23', 'Adele - Hello (Official Music Video)'),
(500, 124, '2026-04-14 10:10:03', 'PGT - PGT TEAM (MINECRAFT ZENE ANIMÁCIÓ)'),
(501, 124, '2026-04-14 10:10:14', 'DESH - TALPRA CIGÁNYOK (Official Music Video)'),
(502, 124, '2026-04-15 09:11:50', 'PGT - PGT TEAM (MINECRAFT ZENE ANIMÁCIÓ)'),
(503, 124, '2026-04-16 06:12:00', 'Cica dal 🐱 | Vidám gyerekdal a macskákról 🐈'),
(504, 124, '2026-04-16 06:12:36', 'live is life '),
(505, 124, '2026-04-16 06:13:12', 'live is life '),
(506, 124, '2026-04-16 06:13:13', 'live is life '),
(507, 124, '2026-04-16 06:13:13', 'live is life '),
(508, 124, '2026-04-16 06:13:14', 'live is life '),
(509, 124, '2026-04-16 06:13:14', 'live is life '),
(510, 124, '2026-04-16 06:13:15', 'live is life '),
(511, 124, '2026-04-16 06:13:15', 'live is life '),
(512, 124, '2026-04-16 06:13:15', 'live is life '),
(513, 124, '2026-04-16 06:13:16', 'live is life '),
(514, 124, '2026-04-16 06:13:16', 'live is life '),
(515, 124, '2026-04-16 06:13:16', 'live is life '),
(516, 124, '2026-04-16 06:13:17', 'live is life '),
(517, 124, '2026-04-16 06:13:17', 'live is life '),
(518, 124, '2026-04-16 06:13:17', 'live is life '),
(519, 124, '2026-04-16 06:13:17', 'live is life '),
(520, 124, '2026-04-16 06:13:17', 'live is life '),
(521, 124, '2026-04-16 06:13:17', 'live is life '),
(522, 124, '2026-04-16 06:15:47', 'M1 - Híradó élő közvetítése'),
(523, 124, '2026-04-16 06:16:09', 'Választás 2026 - A Vadhajtások hivatalos kampánydala'),
(524, 124, '2026-04-16 08:17:12', 'Spotify slágerek 2026 - Trend popslágerek 2026 🎧 Top zenei lejátszási lista 2026 🎵 Legújabb dalok 2026'),
(525, 124, '2026-04-16 08:18:52', 'live is life '),
(526, 124, '2026-04-16 08:23:39', 'Hunter - Roblox (Hivatalos AI Zene)'),
(527, 124, '2026-04-16 08:23:49', 'BSW - HELLO (Official Music Video)'),
(528, 124, '2026-04-16 08:25:36', 'Hunter - Roblox (Hivatalos AI Zene)'),
(529, 124, '2026-04-16 08:26:01', 'Hunter - Roblox (Hivatalos AI Zene)'),
(530, 124, '2026-04-16 08:26:08', 'live is life '),
(531, 124, '2026-04-16 08:26:15', 'BSW - HELLO (Official Music Video)'),
(532, 124, '2026-04-16 08:26:33', 'DESH - TALPRA CIGÁNYOK (Official Music Video)'),
(533, 124, '2026-04-16 08:26:42', 'DESH - VINNIPU (Official Music Video)'),
(534, 124, '2026-04-16 08:30:04', 'live is life '),
(535, 124, '2026-04-16 08:30:52', 'Hunter - Roblox (Hivatalos AI Zene)'),
(536, 124, '2026-04-16 08:31:16', 'live is life '),
(537, 124, '2026-04-16 08:31:38', 'ABBA - Dancing Queen (Official Music Video)'),
(538, 124, '2026-04-16 08:32:04', 'Me at the zoo'),
(539, 124, '2026-04-16 08:32:49', 'What Is Autism Spectrum Disorder?'),
(540, 124, '2026-04-16 08:32:56', 'PGT - PGT TEAM (MINECRAFT ZENE ANIMÁCIÓ)'),
(541, 124, '2026-04-16 08:33:10', 'BSW - HELLO (Official Music Video)'),
(542, 124, '2026-04-16 08:33:23', 'Hunter - Roblox (Hivatalos AI Zene)'),
(543, 124, '2026-04-16 08:34:40', 'BSW - Passport'),
(544, 124, '2026-04-16 08:34:51', 'BSW - HELLO (Official Music Video)'),
(545, 124, '2026-04-16 08:35:02', 'Hunter - Roblox (Hivatalos AI Zene)'),
(546, 124, '2026-04-16 08:43:48', 'PGT - PGT TEAM (MINECRAFT ZENE ANIMÁCIÓ)'),
(547, 124, '2026-04-16 08:44:00', 'Hunter - Roblox (Hivatalos AI Zene)'),
(548, 124, '2026-04-16 08:44:23', 'PGT - PGT TEAM (MINECRAFT ZENE ANIMÁCIÓ)'),
(549, 124, '2026-04-16 08:46:00', 'Hunter - Roblox (Hivatalos AI Zene)'),
(550, 124, '2026-04-16 09:00:51', 'Hunter - Roblox (Hivatalos AI Zene)'),
(551, 124, '2026-04-16 09:00:58', 'Adele - Hello (Official Music Video)'),
(552, 124, '2026-04-16 09:01:11', 'Hunter - Roblox (Hivatalos AI Zene)'),
(553, 124, '2026-04-16 09:01:34', 'PGT - PGT TEAM (MINECRAFT ZENE ANIMÁCIÓ)'),
(554, 124, '2026-04-16 09:01:42', 'Hunter - Roblox (Hivatalos AI Zene)'),
(556, 124, '2026-04-16 07:24:27', 'Cica dal 🐱 | Vidám gyerekdal a macskákról 🐈'),
(557, 124, '2026-04-16 07:31:32', 'Adele - Hello (Official Music Video)'),
(558, 124, '2026-04-16 07:31:50', 'DESH - TALPRA CIGÁNYOK (Official Music Video)'),
(559, 124, '2026-04-16 07:33:29', 'BTS (방탄소년단) &#39;작은 것들을 위한 시 (Boy With Luv) (feat. Halsey)&#39; Official MV'),
(560, 124, '2026-04-16 07:34:56', 'What Is Autism Spectrum Disorder?'),
(561, 124, '2026-04-16 07:45:21', 'MARIO &amp; FERIKE – Kimaradás van | Official Music Video'),
(562, 124, '2026-04-16 07:54:34', 'RENDSZERVÁLTÓ CSORONITA MIX - GYÓNTATÓFÜLKE'),
(566, 124, '2026-04-16 08:37:21', 'DESH X YOUNG FLY X AZAHRIAH - TIP TIP (Official Music Video)'),
(567, 124, '2026-04-16 09:42:09', 'Atka - Monaco'),
(568, 124, '2026-04-16 09:42:16', 'Atka - Monaco'),
(569, 124, '2026-04-16 09:43:55', 'gyuris - meleg van'),
(570, 124, '2026-04-16 09:45:03', 'gyuris - ponyvaregény'),
(571, 131, '2026-04-16 09:51:05', 'DESH - VINNIPU (Official Music Video)'),
(572, 131, '2026-04-16 09:53:38', 'Atesz - Az a segg, az a mell (Dj.Louis, Devil, Miklov Club Mix)_Radio Edit'),
(575, 131, '2026-04-16 09:56:39', 'Flo Rida - My House (Official Audio)'),
(576, 131, '2026-04-16 10:01:50', 'Gáspár Laci - TAVASZ'),
(577, 131, '2026-04-16 10:04:58', 'byealex és a slepp - 1év'),
(578, 131, '2026-04-16 10:10:15', 'Justin Bieber - Beauty And A Beat (Official Music Video) ft. Nicki Minaj'),
(579, 131, '2026-04-16 10:15:00', 'live is life '),
(580, 131, '2026-04-16 10:15:25', 'MISSH feat. RAUL &amp; HORVÁTH TAMÁS – Beléd estem (Official Music Video) | #misshmusic'),
(581, 124, '2026-04-16 12:19:56', 'Dögös Robi - Vettem neked gyémántokat'),
(582, 131, '2026-04-16 10:19:59', 'Koó János - kislány a zongoránál'),
(583, 131, '2026-04-16 10:21:22', 'Perghouse 2017 Kegyetlen Pergető'),
(584, 124, '2026-04-16 12:22:22', 'VINI x BELANO - SHAKE DAT (Official Music Video)'),
(585, 124, '2026-04-16 12:23:24', 'KKevin - PROSECCO ft. Bruno (Official Music Video)'),
(587, 124, '2026-04-16 12:25:30', 'Coronita Mix 2024 Május - Dj Bacsa'),
(588, 124, '2026-04-17 07:52:10', 'Mehringer, BALKAN VIP, sosehol - SZAR AZ ÉLET'),
(589, 124, '2026-04-17 09:43:40', 'KKevin - JACUZZI feat. BSW (Official Music Video)'),
(590, 124, '2026-04-21 06:51:28', 'OŁÓW ale to MOCNA VIXA'),
(591, 124, '2026-04-21 06:53:46', 'DESH - TALPRA CIGÁNYOK (Official Music Video)'),
(592, 124, '2026-04-21 06:56:50', 'DESH X YOUNG FLY - OHMAMMA (Official Music Video)'),
(593, 124, '2026-04-21 08:39:52', 'KKevin - TAKE YOUR TIME (Official Music Video)'),
(594, 96, '2026-04-21 09:12:02', 'DESH - TALPRA CIGÁNYOK (Official Music Video)'),
(595, 96, '2026-04-21 09:12:39', 'DESH - TALPRA CIGÁNYOK (Official Music Video)'),
(596, 96, '2026-04-21 09:33:06', 'Dr. Alban - No Coke (Official HD Video)'),
(597, 96, '2026-04-21 09:33:16', 'Dr. Alban - Sing Hallelujah (Official HD Video)'),
(598, 96, '2026-04-21 09:34:51', 'BSW - HELLO (Official Music Video)'),
(599, 96, '2026-04-21 09:34:53', 'BSW - HELLO (Official Music Video)'),
(600, 124, '2026-04-21 10:15:45', 'live is life '),
(601, 124, '2026-04-21 10:16:07', 'Adele - Hello (Official Music Video)'),
(602, 124, '2026-04-21 10:16:22', 'DESH - VINNIPU (Official Music Video)'),
(603, 139, '2026-04-21 10:57:31', 'Punnany Massif - Élvezd'),
(604, 124, '2026-04-21 11:01:10', 'KKevin - TAKE YOUR TIME (Official Music Video)'),
(605, 124, '2026-04-21 11:01:26', 'VINI x BELANO - SHAKE DAT (Official Music Video)'),
(606, 139, '2026-04-21 11:04:43', 'KKevin - JACUZZI feat. BSW (SAVAGE ALBUM)'),
(607, 124, '2026-04-21 11:05:28', 'BSW - HELLO (Official Music Video)'),
(608, 124, '2026-04-21 11:06:58', 'Béla - Arcon Köplek feat. Pista [OFFICIAL MUSIC VIDEO]');

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
-- A tábla indexei `playlist_test`
--
ALTER TABLE `playlist_test`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `music_id` (`music_id`);

--
-- A tábla indexei `szunetek`
--
ALTER TABLE `szunetek`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `hossz` (`hossz`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=150;

--
-- AUTO_INCREMENT a táblához `csengetes`
--
ALTER TABLE `csengetes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT a táblához `currently_playing`
--
ALTER TABLE `currently_playing`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2005;

--
-- AUTO_INCREMENT a táblához `fav`
--
ALTER TABLE `fav`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=523;

--
-- AUTO_INCREMENT a táblához `music`
--
ALTER TABLE `music`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=751;

--
-- AUTO_INCREMENT a táblához `music_request`
--
ALTER TABLE `music_request`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=797;

--
-- AUTO_INCREMENT a táblához `playlist_test`
--
ALTER TABLE `playlist_test`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `szunetek`
--
ALTER TABLE `szunetek`
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=140;

--
-- AUTO_INCREMENT a táblához `user_handler`
--
ALTER TABLE `user_handler`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=609;

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
