<?php
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
  $password = mysqli_real_escape_string($conn, $password);
  $password = password_hash($password, PASSWORD_BCRYPT);
  $username = mysqli_real_escape_string($conn, $username);
  $email = mysqli_real_escape_string($conn, $email);
  $class = mysqli_real_escape_string($conn, $class);



  $sql = "INSERT INTO users (user_name, email, user_class, user_password) VALUES ('$username', '$password', '$email', '$class')";
  if (mysqli_query($conn, $sql)) {
    $vissza["status"] = "success";
    $vissza["message"] = "Sikeres regisztráció";
    return true;
  } else {
    $vissza["status"] = "error";
    $vissza["message"] = "Hiba a regisztráció során probáld újra!";
    $vissza["errormessage"] = mysqli_error($conn);
    return false;
  }
}
