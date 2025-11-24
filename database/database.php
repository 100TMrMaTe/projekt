<?php
function connect_to_serer()
{
  $servername = "localhost";
  $username = "root";
  $password = "";

  // Create connection
  $conn = mysqli_connect($servername, $username, $password);

  // Check connection
  if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
  }
  return $conn;
}

function create_databse_tables($conn)
{
  // Create database
  $sql = "CREATE DATABASE IF NOT EXISTS  projekt";
  if (mysqli_query($conn, $sql)) {
    echo "Database created successfully";
  } else {
    echo "Error creating database: " . mysqli_error($conn);
  }

  // Select the database
  mysqli_select_db($conn, "projekt");

  // sql to create table users
  $sql = "CREATE TABLE IF NOT EXISTS users (
  id INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_name VARCHAR(255),
  email VARCHAR(255),
  user_class VARCHAR(255),
  user_password VARCHAR(255)
)";

  if (mysqli_query($conn, $sql)) {
    echo "Table users created successfully";
  } else {
    echo "Error creating table: " . mysqli_error($conn);
  }

  // sql to create table user_log
  $sql = "CREATE TABLE IF NOT EXISTS user_log (
  id INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id INT(11) UNSIGNED,
  user_name VARCHAR(255),
  user_class VARCHAR(255),
  datum DATETIME,
  FOREIGN KEY (user_id) REFERENCES users(id)
)";

  if (mysqli_query($conn, $sql)) {
    echo "Table user_log created successfully";
  } else {
    echo "Error creating table: " . mysqli_error($conn);
  }
}


create_databse_tables(connect_to_serer());

mysqli_close(connect_to_serer());
