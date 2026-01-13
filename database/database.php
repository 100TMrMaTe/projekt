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
?>