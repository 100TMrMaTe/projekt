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
    //link forgot message
    //$vissza["errormessage"] = mysqli_error($conn);
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
    //email kuldese
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
    //email kuldese
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
    //email kuldese
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
    //email kuldese
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
