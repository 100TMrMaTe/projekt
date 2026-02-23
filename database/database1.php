<?php

include_once __DIR__ . "/../mailer/sendVerification.php";
function Connect_to_server()
{
  $servername = "172.16.2.100";
  $username = "root";
  $password = "admin";
  $dbname = "projekt";

  // Create connection
  $conn = mysqli_connect($servername, $username, $password, $dbname, 3306);
  // Check connection
  if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
  }

  mysqli_set_charset($conn, "utf8mb4");
  return $conn;
}
function registration($conn, $username, $password, $email, $class)
{
  $password = password_hash($password, PASSWORD_BCRYPT);
  $username = mysqli_real_escape_string($conn, $username);
  $email = mysqli_real_escape_string($conn, $email);
  $class = mysqli_real_escape_string($conn, $class);

  $token = generateToken($conn);

  if (str_ends_with($email, "@ady-nagyatad.hu") == false) {
    $vissza["status"] = "error_sulisemail";
    $vissza["long_message"] = "Csak sulis email cimmel lehet regisztralni!";
    $vissza["message"] = "Hibas email cimmel probalsz regisztralni!";
    echo json_encode($vissza);
    return;
  }


  mysqli_report(MYSQLI_REPORT_OFF);

  $sql = "INSERT INTO users (user_name, email, user_class, user_password,verification_token) VALUES ('$username', '$email', '$class', '$password', '$token')";
  if (mysqli_query($conn, $sql)) {
    $vissza["status"] = "success_registration";
    $vissza["message"] = "aktiváld az emailed!";
    $vissza["long_message"] = "Kerlek ellenorizd az emailed a megerosito linkert!";
    echo json_encode($vissza);
    sendVerificationEmail($email, $token);
  } else {
    $vissza["status"] = "error_registration";
    $vissza["message"] = "Az email mar foglalt!";
    $vissza["long_message"] = "Amennyiben te még nem regisztrátál vedd fel a kapcsolatot a rendszer gazdával!";
    echo json_encode($vissza);
    return;
  }
  mysqli_report(MYSQLI_REPORT_ALL);
}

function verifyEmail($conn, $token)
{
  $token = mysqli_real_escape_string($conn, $token);
  $sql = "UPDATE users SET email_verified = 1 WHERE verification_token = '$token'";
  if (mysqli_query($conn, $sql)) {
    echo json_encode(array("status" => "success_verified"));
    return;
  } else {
    echo json_encode(array("status" => "error_verified"));
    return;
  }
}

function adminpage($conn)
{
  $sql = "SELECT id,email,user_class,approved,isadmin,email_verified FROM users";
  $userlist = [];

  $approvedusers = [];
  $waitinglist = [];
  $log = [];
  if ($result = mysqli_query($conn, $sql)) {
    while ($row = mysqli_fetch_assoc($result)) {
      $userlist[] = $row;
    }
  } else {
    echo json_encode(array("status" => "error_adminpage"));
    return;
  }

  foreach ($userlist as $user) {
    if ($user['email_verified'] == 1) {
      if ($user['approved'] == 1) {
        $approvedusers[] = $user;
      } else {
        $waitinglist[] = $user;
      }
    }
  }

  $sql_log = "SELECT users.id,users.email, users.user_class, user_handler.date, user_handler.title FROM user_handler,users WHERE users.id=user_handler.user_id";
  if ($result = mysqli_query($conn, $sql_log)) {
    while ($row = mysqli_fetch_assoc($result)) {
      $log[] = $row;
    }
  } else {
    echo json_encode(array("status" => "error_adminpage"));
    return;
  }

  $vissza["status"] = "success_adminpage";
  $vissza["approvedusers"] = $approvedusers;
  $vissza["waitinglist"] = $waitinglist;
  $vissza["log"] = $log;
  echo json_encode($vissza);
}

function approveUser($conn, $id)
{
  $id = mysqli_real_escape_string($conn, $id);
  $sql = "UPDATE users SET approved = 1 WHERE id = '$id' AND approved = 0";

  $user_email_sql = "SELECT email FROM users WHERE id = '$id' LIMIT 1";
  $user_email_result = mysqli_query($conn, $user_email_sql);
  if (mysqli_query($conn, $sql)) {
    echo json_encode(array("status" => "success_approveuser"));
    $user_email_row = mysqli_fetch_assoc($user_email_result);
    $user_email = $user_email_row['email'];
    confirmReg($user_email);
    return;
  } else {
    echo json_encode(array("status" => "error_approveuser"));
    return;
  }
}

function denyUser($conn, $id)
{
  $id = mysqli_real_escape_string($conn, $id);
  $sql = "DELETE FROM users WHERE id = '$id' AND approved = 0";
  if (mysqli_query($conn, $sql)) {
    echo json_encode(array("status" => "success_denyuser"));
    return;
  } else {
    echo json_encode(array("status" => "error_denyuser"));
    return;
  }
}

function deleteUser($conn, $id)
{
  $id = mysqli_real_escape_string($conn, $id);
  $sql_log = "DELETE FROM user_handler WHERE user_id = '$id'";
  $sql = "DELETE FROM users WHERE id = '$id' AND approved = 1";
  if (mysqli_query($conn, $sql_log) && mysqli_query($conn, $sql)) {
    echo json_encode(array("status" => "success_deleteuser"));
    return;
  } else {
    echo json_encode(array("status" => "error_deleteuser"));
    return;
  }
}

function useradmin($conn, $id)
{
  $id = mysqli_real_escape_string($conn, $id);
  $sql = "UPDATE users SET isadmin = 1 WHERE id = '$id' AND isadmin = 0";
  if (mysqli_query($conn, $sql)) {
    echo json_encode(array("status" => "success_useradmin"));
    return;
  } else {
    echo json_encode(array("status" => "error_useradmin"));
    return;
  }
}

function checkEmail($conn, $email)
{
  $email = mysqli_real_escape_string($conn, $email);
  $sql = "SELECT id FROM users WHERE email = '$email' and approved = 1";
  $result = mysqli_query($conn, $sql);
  if (mysqli_num_rows($result) > 0) {
    echo json_encode(array("status" => "email_exists"));
    $token = bin2hex(random_bytes(64));
    $update_token_sql = "UPDATE users SET verification_token = '$token' WHERE email = '$email' LIMIT 1";
    mysqli_query($conn, $update_token_sql);
    sendPasswordResetEmail($email, $token);
    return;
  } else {
    echo json_encode(array("status" => "email_not_exists"));
    return;
  }
}

function resetPassword($conn, $token, $new_password)
{
  $token = mysqli_real_escape_string($conn, $token);
  $new_password_hashed = password_hash($new_password, PASSWORD_BCRYPT);
  $sql = "UPDATE users SET user_password = '$new_password_hashed' WHERE verification_token = '$token' LIMIT 1";
  if (mysqli_query($conn, $sql)) {
    echo json_encode(array("status" => "success_reset_password"));
    return;
  } else {
    echo json_encode(array("status" => "error_reset_password"));
    return;
  }
}

function generateToken($conn)
{
  do {
    $token = bin2hex(random_bytes(64));
    $check = mysqli_query($conn, "SELECT id FROM users WHERE verification_token = '$token' LIMIT 1");
  } while (mysqli_num_rows($check) > 0);

  return $token;
}

function expire()
{
  $lejarat = date("Y-m-d H:i:s", strtotime("+30 minutes"));
  return $lejarat;
}

function generateSessionToken($conn)
{
  do {
    $token = bin2hex(random_bytes(64));
    $check = mysqli_query($conn, "SELECT user_id FROM active_users WHERE token = '$token' LIMIT 1");
  } while (mysqli_num_rows($check) > 0);

  return $token;
}

function login($conn, $email, $password)
{
  $email = mysqli_real_escape_string($conn, $email);
  $sql = "SELECT id, user_password, approved, isadmin, email_verified, user_class FROM users WHERE email = '$email' LIMIT 1";
  $result = mysqli_query($conn, $sql);
  if (mysqli_num_rows($result) == 0) {
    echo json_encode(array("status" => "error_login_no_user"));
    return;
  }
  $row = mysqli_fetch_assoc($result);
  if (password_verify($password, $row['user_password'])) {
    if ($row['email_verified'] == 0) {
      echo json_encode(array("status" => "error_login_email_not_verified"));
      return;
    }
    if ($row['approved'] == 0) {
      echo json_encode(array("status" => "error_login_not_approved"));
      return;
    }
    $sql_token = "SELECT token FROM active_users WHERE user_id = '" . $row['id'] . "' LIMIT 1";
    $result_token = mysqli_query($conn, $sql_token);
    if (mysqli_num_rows($result_token) == 0) {
      $new_token = generateSessionToken($conn);
      $insert_token_sql = "INSERT INTO active_users (user_id, token, expire) VALUES ('" . $row['id'] . "', '$new_token', '" . expire() . "')";
      mysqli_query($conn, $insert_token_sql);
    } else {
      $new_token = generateSessionToken($conn);
      $sql_new_token = "UPDATE active_users SET token = '$new_token', expire = '" . expire() . "' WHERE user_id = '" . $row['id'] . "'";
      mysqli_query($conn, $sql_new_token);
    }
    echo json_encode(array("status" => "success_login", "isadmin" => $row['isadmin'], "token" => $new_token, "email" => $email, "user_class" => $row['user_class']));
  } else {
    echo json_encode(array("status" => "error_login_wrong_password"));
    return;
  }
}

// -----------------------------------------------------------------------
// Lejátszó függvények – átírva: test1 helyett currently_playing + music
// -----------------------------------------------------------------------

/**
 * Visszaadja az aktuálisan játszott zene összes adatát.
 * Összeköti a currently_playing és music táblákat music_id alapján.
 * Visszatérési mezők: video_id, title, lenght (mp), status, current_time, volume, porget
 */
function getCurrentlyPlaying($conn)
{
  $sql = "SELECT music.video_id, music.title, music.lenght,
                 currently_playing.status, currently_playing.current_time,
                 currently_playing.volume, currently_playing.porget
          FROM currently_playing
          JOIN music ON currently_playing.music_id = music.id
          LIMIT 1";
  $result = mysqli_query($conn, $sql);
  if (!$result || mysqli_num_rows($result) == 0) {
    echo json_encode(array("status" => "error_no_current"));
    return;
  }
  $row = mysqli_fetch_assoc($result);
  echo json_encode(array(
    "video_id"     => $row['video_id'],
    "title"        => $row['title'],
    "length"       => $row['lenght'],
    "status"       => $row['status'],
    "current_time" => $row['current_time'],
    "volume"       => $row['volume'],
    "porget"       => $row['porget']
  ));
}

/**
 * Play/Pause kapcsoló – currently_playing.status toggelése
 */
function kapcsolo($conn)
{
  $sql = "UPDATE currently_playing SET currently_playing.status = NOT currently_playing.status";
  if (mysqli_query($conn, $sql)) {
    echo json_encode("success");
  } else {
    echo json_encode("error");
  }
}

/**
 * Seek (ugrás adott időpontra) – currently_playing.current_time beállítása
 */
function seek($conn, $ido)
{
  $ido = (int)$ido;
  $sql = "UPDATE currently_playing SET currently_playing.current_time = $ido";
  if (mysqli_query($conn, $sql)) {
    echo json_encode("success");
  } else {
    echo json_encode("error");
  }
}

/**
 * Hangerő beállítása – currently_playing.volume frissítése
 */
function volume($conn, $hangero)
{
  $hangero = (int)$hangero;
  $sql = "UPDATE currently_playing SET currently_playing.volume = $hangero";
  if (mysqli_query($conn, $sql)) {
    echo json_encode("success");
  } else {
    echo json_encode("error");
  }
}

/**
 * Aktuális zene hosszának lekérése – music.lenght a currently_playing.music_id alapján
 */
function length($conn)
{
  $sql = "SELECT music.lenght FROM currently_playing
          JOIN music ON currently_playing.music_id = music.id
          LIMIT 1";
  $result = mysqli_query($conn, $sql);
  if (!$result || mysqli_num_rows($result) == 0) {
    echo json_encode(array("length" => null));
    return;
  }
  $row = mysqli_fetch_assoc($result);
  echo json_encode(array("length" => $row['lenght']));
}

/**
 * Zene hosszának frissítése – music.lenght frissítése a currently_playing.music_id alapján
 */
function setLength($conn, $hossz)
{
  $hossz = (int)$hossz;
  $sql = "UPDATE music
          JOIN currently_playing ON currently_playing.music_id = music.id
          SET music.lenght = $hossz";
  if (mysqli_query($conn, $sql)) {
    echo json_encode("success");
  } else {
    echo json_encode("error");
  }
}

/**
 * Aktuális lejátszási idő beállítása – currently_playing.current_time frissítése
 */
function setCurrentTime($conn, $ido)
{
  $ido = (int)$ido;
  $sql = "UPDATE currently_playing SET currently_playing.current_time = $ido";
  if (mysqli_query($conn, $sql)) {
    echo json_encode("success");
  } else {
    echo json_encode("error");
  }
}

/**
 * Aktuális lejátszási idő lekérése – currently_playing.current_time
 */
function current_time($conn)
{
  $sql = "SELECT currently_playing.current_time FROM currently_playing LIMIT 1";
  $result = mysqli_query($conn, $sql);
  if (!$result || mysqli_num_rows($result) == 0) {
    echo json_encode(array("current_time" => null));
    return;
  }
  $row = mysqli_fetch_assoc($result);
  echo json_encode(array("current_time" => $row['current_time']));
}

/**
 * Porget (seek trigger) értékének beállítása – currently_playing.porget
 */
function porget($conn, $porget)
{
  $porget = (int)$porget;
  $sql = "UPDATE currently_playing SET currently_playing.porget = $porget";
  if (mysqli_query($conn, $sql)) {
    echo json_encode("success");
  } else {
    echo json_encode("error");
  }
}

/**
 * Porget visszaállítása -1-re (seek befejezve) – currently_playing.porget
 */
function noSeek($conn)
{
  $sql = "UPDATE currently_playing SET currently_playing.porget = -1";
  if (mysqli_query($conn, $sql)) {
    echo json_encode("success");
  } else {
    echo json_encode("error");
  }
}

/**
 * Hangerő lekérése – currently_playing.volume
 */
function getVolume($conn)
{
  $sql = "SELECT currently_playing.volume FROM currently_playing LIMIT 1";
  $result = mysqli_query($conn, $sql);
  if (!$result || mysqli_num_rows($result) == 0) {
    echo json_encode(array("volume" => null));
    return;
  }
  $row = mysqli_fetch_assoc($result);
  echo json_encode(array("volume" => $row['volume']));
}

// -----------------------------------------------------------------------
// Playlist kezelés – music és playlist táblák
// -----------------------------------------------------------------------

/**
 * Playlist összes zenéjének lekérése (music adatokkal együtt)
 */
function getPlaylist($conn)
{
  $sql = "SELECT music.id, music.video_id, music.title, music.lenght
          FROM playlist
          JOIN music ON playlist.music_id = music.id";
  $playlist = [];
  if ($result = mysqli_query($conn, $sql)) {
    while ($row = mysqli_fetch_assoc($result)) {
      $playlist[] = $row;
    }
    echo json_encode(array("status" => "success", "playlist" => $playlist));
  } else {
    echo json_encode(array("status" => "error_getplaylist"));
  }
}

/**
 * Zene hozzáadása a music táblához, majd a playlist-hez
 * $video_id: YouTube video azonosító (string)
 * $title: a zene neve
 * $lenght: hossz másodpercben (int)
 */
function addMusic($conn, $video_id, $title, $lenght)
{
  $video_id = mysqli_real_escape_string($conn, $video_id);
  $title    = mysqli_real_escape_string($conn, $title);
  $lenght   = (int)$lenght;

  mysqli_report(MYSQLI_REPORT_OFF);

  // Beillesztés a music táblába (ha még nem létezik)
  $sql_music = "INSERT INTO music (video_id, title, lenght) VALUES ('$video_id', '$title', '$lenght')";
  if (!mysqli_query($conn, $sql_music)) {
    // Ha már létezik, lekérjük az id-t
    $sql_existing = "SELECT id FROM music WHERE video_id = '$video_id' LIMIT 1";
    $res = mysqli_query($conn, $sql_existing);
    $music_row = mysqli_fetch_assoc($res);
    $music_id = $music_row['id'];
  } else {
    $music_id = mysqli_insert_id($conn);
  }

  // Hozzáadás a playlist-hez
  $sql_playlist = "INSERT INTO playlist (music_id) VALUES ($music_id)";
  if (mysqli_query($conn, $sql_playlist)) {
    echo json_encode(array("status" => "success_addmusic", "music_id" => $music_id));
  } else {
    echo json_encode(array("status" => "error_addmusic_already_in_playlist"));
  }

  mysqli_report(MYSQLI_REPORT_ALL);
}

/**
 * Zene törlése a playlist-ből (a music táblából NEM töröl)
 */
function removeFromPlaylist($conn, $music_id)
{
  $music_id = (int)$music_id;
  $sql = "DELETE FROM playlist WHERE music_id = $music_id";
  if (mysqli_query($conn, $sql)) {
    echo json_encode(array("status" => "success_removefromplaylist"));
  } else {
    echo json_encode(array("status" => "error_removefromplaylist"));
  }
}

/**
 * Aktuálisan játszott zene beállítása – currently_playing sor frissítése vagy létrehozása
 * $music_id: a music tábla id-ja
 */
function setCurrentlyPlaying($conn, $music_id)
{
  $music_id = (int)$music_id;

  // Megnézzük, van-e már sor a currently_playing táblában
  $check_sql = "SELECT id FROM currently_playing LIMIT 1";
  $check_result = mysqli_query($conn, $check_sql);

  if (mysqli_num_rows($check_result) == 0) {
    // Még nincs sor, INSERT
    $sql = "INSERT INTO currently_playing (music_id, status, current_time, volume, porget)
            VALUES ($music_id, 0, 0, 100, -1)";
  } else {
    // Már van sor, UPDATE
    $sql = "UPDATE currently_playing SET music_id = $music_id, status = 0, current_time = 0, porget = -1";
  }

  if (mysqli_query($conn, $sql)) {
    echo json_encode(array("status" => "success_setcurrentlyplaying"));
  } else {
    echo json_encode(array("status" => "error_setcurrentlyplaying"));
  }
}