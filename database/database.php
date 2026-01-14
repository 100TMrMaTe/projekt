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
  $usersql = "SELECT * FROM users WHERE email='$email'";


  $password = password_hash($password, PASSWORD_BCRYPT);
  $username = mysqli_real_escape_string($conn, $username);
  $email = mysqli_real_escape_string($conn, $email);
  if(str_ends_with($email, "@ady-nagyatad.hu") == false){
    $vissza["status"] = "error";
    $vissza["message"] = "Csak sulis email cimmel lehet regisztralni!"; 
    echo json_encode($vissza);
    return;
  }else if(mysqli_query($conn, $usersql)->num_rows > 0){
    $vissza["status"] = "error";
    $vissza["message"] = "Az email mar foglalt!"; 
    $vissza["longmessage"] = "Amennyiben nem te regisztraltal, kerlek vedd fel a kapcsolatot a rendszergazdaval!";
    echo json_encode($vissza);
    return;
  }
  $class = mysqli_real_escape_string($conn, $class);



  $sql = "INSERT INTO users (user_name, email, user_class, user_password) VALUES ('$username', '$email', '$class', '$password')";
  if (mysqli_query($conn, $sql)) {
    $vissza["status"] = "success";
    $vissza["message"] = "Sikeres regisztracio!";
  } else {
    $vissza["status"] = "error";
    $vissza["message"] = "Hiba a regisztracio soran probald ujra!";
    $vissza["errormessage"] = mysqli_error($conn);
  }
  echo json_encode($vissza);
}
