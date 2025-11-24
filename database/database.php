<?php
$servername = "localhost";
$username = "root";
$password = "";

// Create connection
$conn = mysqli_connect($servername, $username, $password);

// Check connection
if (!$conn) {
  die("Connection failed: " . mysqli_connect_error());
}

// Create database
$sql = "CREATE DATABASE IF NOT EXISTS  projekt";
if (mysqli_query($conn, $sql)) {
  echo "Database created successfully";
} else {
  echo "Error creating database: " . mysqli_error($conn);
}

// Select the database
mysqli_select_db($conn, "projekt");

// sql to create table
$sql = "CREATE TABLE MyGuests (
id INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
user_name VARCHAR(255) NOT NULL,
email VARCHAR(255) NOT NULL,
user_class VARCHAR(255) NOT NULL,
user_password varchar(255) NOT NULL,
)";

if (mysqli_query($conn, $sql)) {
  echo "Table MyGuests created successfully";
} else {
  echo "Error creating table: " . mysqli_error($conn);
}

mysqli_close($conn);
?>