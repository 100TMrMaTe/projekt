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
  $token = bin2hex(random_bytes(32));

  if (str_ends_with($email, "@ady-nagyatad.hu") == false) {
    $vissza["status"] = "error";
    $vissza["message"] = "Csak sulis email cimmel lehet regisztralni!";
    echo json_encode($vissza);
    return;
  }


  mysqli_report(MYSQLI_REPORT_OFF);

  $sql = "INSERT INTO users (user_name, email, user_class, user_password,verification_token) VALUES ('$username', '$email', '$class', '$password', '$token')";
  if (mysqli_query($conn, $sql)) {
    $vissza["status"] = "success";
    $vissza["message"] = "Sikeres regisztracio!";
    $vissza["longmessage"] = "Kerlek ellenorizd az emailed a megerosito linkert!";
    echo json_encode($vissza);
    sendVerificationEmail($email, $token);
  } else {
    $vissza["status"] = "error";
    $vissza["message"] = "Az email mar foglalt!";
    //link forgot message
    //$vissza["errormessage"] = mysqli_error($conn);
    echo json_encode($vissza);
    return;
  }
  mysqli_report(MYSQLI_REPORT_ALL); 
}
