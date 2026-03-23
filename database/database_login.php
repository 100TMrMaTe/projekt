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

  $token = generateToken($conn);

  if (str_ends_with($email, "@ady-nagyatad.hu") == false) {
    $vissza["status"] = "error_sulisemail";
    $vissza["long_message"] = "Csak sulis email cimmel lehet regisztralni!";
    $vissza["message"] = "Hibas email cimmel probalsz regisztralni!";
    echo json_encode($vissza);
    return;
  }

  mysqli_report(MYSQLI_REPORT_OFF);

  $stmt = $conn->prepare("INSERT INTO users (user_name, email, user_class, user_password, verification_token) VALUES (?, ?, ?, ?, ?)");
  $stmt->bind_param("sssss", $username, $email, $class, $password, $token);

  if ($stmt->execute()) {
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
  }
  $stmt->close();
  mysqli_report(MYSQLI_REPORT_ALL);
}

function verifyEmail($conn, $token)
{
  $stmt = $conn->prepare("UPDATE users SET email_verified = 1 WHERE verification_token = ?");
  $stmt->bind_param("s", $token);
  if ($stmt->execute()) {
    echo json_encode(array("status" => "success_verified"));
  } else {
    echo json_encode(array("status" => "error_verified"));
  }
  $stmt->close();
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

  $sql_log = "SELECT users.id,users.email, users.user_class, user_handler.date, user_handler.title FROM user_handler,users WHERE users.id=user_handler.user_id ORDER BY user_handler.date DESC LIMIT 100";
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
  $stmt_email = $conn->prepare("SELECT email FROM users WHERE id = ? LIMIT 1");
  $stmt_email->bind_param("s", $id);
  $stmt_email->execute();
  $user_email_result = $stmt_email->get_result();
  $stmt_email->close();

  $stmt = $conn->prepare("UPDATE users SET approved = 1 WHERE id = ? AND approved = 0");
  $stmt->bind_param("s", $id);
  if ($stmt->execute()) {
    echo json_encode(array("status" => "success_approveuser"));
    $user_email_row = $user_email_result->fetch_assoc();
    $user_email = $user_email_row['email'];
    confirmReg($user_email);
  } else {
    echo json_encode(array("status" => "error_approveuser"));
  }
  $stmt->close();
}

function denyUser($conn, $id)
{
  $stmt = $conn->prepare("DELETE FROM users WHERE id = ? AND approved = 0");
  $stmt->bind_param("s", $id);
  if ($stmt->execute()) {
    //deny reg email lekell kerni az emailt mielott trolod
    echo json_encode(array("status" => "success_denyuser"));
  } else {
    echo json_encode(array("status" => "error_denyuser"));
  }
  $stmt->close();
}

function deleteUser($conn, $id)
{
  $tables = ["active_users", "user_handler", "playlist", "currently_playing", "fav"];
  foreach ($tables as $table) {
    $stmt = $conn->prepare("DELETE FROM $table WHERE user_id = ?");
    $stmt->bind_param("s", $id);
    $stmt->execute();
    $stmt->close();
  }

  $stmt = $conn->prepare("DELETE FROM users WHERE id = ?");
  $stmt->bind_param("s", $id);
  if ($stmt->execute()) {
    echo json_encode(array("status" => "success_deleteuser"));
  } else {
    echo json_encode(array("status" => "error_deleteuser"));
  }
  $stmt->close();
}

function useradmin($conn, $id)
{
  $stmt = $conn->prepare("UPDATE users SET isadmin = 1 WHERE id = ? AND isadmin = 0");
  $stmt->bind_param("s", $id);
  if ($stmt->execute()) {
    echo json_encode(array("status" => "success_useradmin"));
  } else {
    echo json_encode(array("status" => "error_useradmin"));
  }
  $stmt->close();
}

function deleteuseradmin($conn, $id)
{
  $stmt = $conn->prepare("UPDATE users SET isadmin = 0 WHERE id = ? AND isadmin = 1");
  $stmt->bind_param("s", $id);
  if ($stmt->execute()) {
    echo json_encode(array("status" => "success_useradmin"));
  } else {
    echo json_encode(array("status" => "error_useradmin"));
  }
  $stmt->close();
}

function checkEmail($conn, $email)
{
  $stmt = $conn->prepare("SELECT id FROM users WHERE email = ? AND approved = 1");
  $stmt->bind_param("s", $email);
  $stmt->execute();
  $result = $stmt->get_result();
  $stmt->close();

  if (mysqli_num_rows($result) > 0) {
    echo json_encode(array("status" => "email_exists"));
    $token = bin2hex(random_bytes(64));
    $stmt_update = $conn->prepare("UPDATE users SET verification_token = ? WHERE email = ? LIMIT 1");
    $stmt_update->bind_param("ss", $token, $email);
    $stmt_update->execute();
    $stmt_update->close();
    sendPasswordResetEmail($email, $token);
  } else {
    echo json_encode(array("status" => "email_not_exists"));
  }
}

function resetPassword($conn, $token, $new_password)
{
  $new_password_hashed = password_hash($new_password, PASSWORD_BCRYPT);
  $stmt = $conn->prepare("UPDATE users SET user_password = ? WHERE verification_token = ? LIMIT 1");
  $stmt->bind_param("ss", $new_password_hashed, $token);
  if ($stmt->execute()) {
    echo json_encode(array("status" => "success_reset_password"));
  } else {
    echo json_encode(array("status" => "error_reset_password"));
  }
  $stmt->close();
}

function generateToken($conn)
{
  do {
    $token = bin2hex(random_bytes(64));
    $stmt = $conn->prepare("SELECT id FROM users WHERE verification_token = ? LIMIT 1");
    $stmt->bind_param("s", $token);
    $stmt->execute();
    $check = $stmt->get_result();
    $stmt->close();
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
  $stmt = $conn->prepare("SELECT id, user_password, approved, isadmin, email_verified, user_class FROM users WHERE email = ? LIMIT 1");
  $stmt->bind_param("s", $email);
  $stmt->execute();
  $result = $stmt->get_result();
  $stmt->close();

  if ($result->num_rows == 0) {
    echo json_encode(array("status" => "error_login_no_user"));
    return;
  }
  $row = $result->fetch_assoc();
  if (password_verify($password, $row['user_password'])) {
    if ($row['email_verified'] == 0) {
      echo json_encode(array("status" => "error_login_email_not_verified"));
      return;
    }
    if ($row['approved'] == 0) {
      echo json_encode(array("status" => "error_login_not_approved"));
      return;
    }

    $stmt_check = $conn->prepare("SELECT token FROM active_users WHERE user_id = ? LIMIT 1");
    $stmt_check->bind_param("s", $row['id']);
    $stmt_check->execute();
    $result_token = $stmt_check->get_result();
    $stmt_check->close();

    $new_token = generateSessionToken($conn);

    if ($result_token->num_rows == 0) {
      $stmt_insert = $conn->prepare("INSERT INTO active_users (user_id, token, expire) VALUES (?, ?, ?)");
      $expire = expire();
      $stmt_insert->bind_param("sss", $row['id'], $new_token, $expire);
      $stmt_insert->execute();
      $stmt_insert->close();
    } else {
      $stmt_update = $conn->prepare("UPDATE active_users SET token = ?, expire = ? WHERE user_id = ?");
      $expire = expire();
      $stmt_update->bind_param("sss", $new_token, $expire, $row['id']);
      $stmt_update->execute();
      $stmt_update->close();
    }
    echo json_encode(array("status" => "success_login", "isadmin" => $row['isadmin'], "token" => $new_token, "email" => $email, "user_class" => $row['user_class'], "user_id" => $row['id']));
  } else {
    echo json_encode(array("status" => "error_login_wrong_password"));
    return;
  }
}

function tokenRefresh($conn, $token)
{
  $sql = "SELECT expire FROM active_users WHERE token = ? LIMIT 1";

  $expire = null;

  if ($stmt = $conn->prepare($sql)) {

    $stmt->bind_param("s", $token);
    $stmt->execute();

    $result = $stmt->get_result();
    if ($row = $result->fetch_assoc()) {
      $expire = $row['expire'];
    }

    $stmt->close();
  }

  if ($expire) {
    $current_time = date("Y-m-d H:i:s");
    if ($current_time < $expire) {
      $new_expire = expire();
      $update_sql = "UPDATE active_users SET expire = ? WHERE token = ?";
      if ($stmt = $conn->prepare($update_sql)) {
        $stmt->bind_param("ss", $new_expire, $token);
        $stmt->execute();
        $stmt->close();
        echo json_encode(array("status" => "success_token_refresh"));
        return;
      } else {
        echo json_encode(array("status" => "error_token_refresh"));
        return;
      }
    } else {
      echo json_encode(array("status" => "error_token_expired"));
      return;
    }
  } else {
    echo json_encode(array("status" => "error_token_not_found"));
    return;
  }
}

function logout($conn, $token)
{
  $sql = "DELETE FROM active_users WHERE token = ?";
  if ($stmt = $conn->prepare($sql)) {
    $stmt->bind_param("s", $token);
    $stmt->execute();
    $stmt->close();
    echo json_encode(array("status" => "success_logout"));
    return;
  } else {
    echo json_encode(array("status" => "error_logout"));
    return;
  }
}
