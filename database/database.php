<?php
function Connect_to_serer()
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

function Kill_server_connection($conn)
{
  mysqli_close($conn);
}

function Use_database($conn, $dbname)
{
  mysqli_select_db($conn, $dbname);
}

function Create_databse_tables($conn)
{
  // Create database
  $sql = "CREATE DATABASE IF NOT EXISTS  projekt";
  if (mysqli_query($conn, $sql)) {
    //echo "Database created successfully";
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
    //echo "Table users created successfully";
  } else {
    echo "Error creating table: " . mysqli_error($conn);
  }

  // sql to create table user_log
  $sql = "CREATE TABLE IF NOT EXISTS users_log (
  id INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id INT(11) UNSIGNED,
  user_name VARCHAR(255),
  user_class VARCHAR(255),
  datum DATETIME,
  FOREIGN KEY (user_id) REFERENCES users(id)
)";

  if (mysqli_query($conn, $sql)) {
    //echo "Table user_log created successfully";
  } else {
    echo "Error creating table: " . mysqli_error($conn);
  }

  // sql to create table user_reg
  $sql = "CREATE TABLE IF NOT EXISTS users_reg (
  id INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_name VARCHAR(255),
  user_class VARCHAR(255),
  email VARCHAR(255),
  user_password VARCHAR(255)
)";

  if (mysqli_query($conn, $sql)) {
    //echo "Table user_log created successfully";
  } else {
    echo "Error creating table: " . mysqli_error($conn);
  }
}

function Insert_into_users($conn, $user_name, $user_class, $email, $user_password)
{
  $sql = "INSERT INTO users (user_name, email, user_class, user_password)
      VALUES ('$user_name', '$email', '$user_class', '$user_password')";


  if (mysqli_query($conn, $sql)) {
    echo "New record created successfully";
  } else {
    echo "Error: " . $sql . "<br>" . mysqli_error($conn);
  }
}

function Insert_into_users_reg($conn, $user_name, $user_class, $email, $user_password)
{
  $sql = "INSERT INTO users_reg (user_name, user_class, email, user_password)
      VALUES ('$user_name', '$user_class', '$email', '$user_password')";


  if (mysqli_query($conn, $sql)) {
    echo "New record created successfully";
  } else {
    echo "Error: " . $sql . "<br>" . mysqli_error($conn);
  }
}

function Insert_into_users_log($conn, $user_id, $user_name, $user_class, $datum)
{
  $sql = "INSERT INTO users_log (user_id, user_name, user_class, datum)
      VALUES ('$user_id', '$user_name', '$user_class', '$datum')";


  if (mysqli_query($conn, $sql)) {
    echo "New record created successfully";
  } else {
    echo "Error: " . $sql . "<br>" . mysqli_error($conn);
  }
}

function delete_from_users($conn, $user_id)
{
  // sql to delete a record
  $sql = "DELETE FROM MyGuests WHERE id=$user_id";

  if (mysqli_query($conn, $sql)) {
    echo "Record deleted successfully";
  } else {
    echo "Error deleting record: " . mysqli_error($conn);
  }
}

$conn = Connect_to_serer();

Create_databse_tables($conn);
Use_database($conn, 'projekt');

//Insert_into_users($conn, 'mate', '13.c','kony@gmail.com', 'kony');
//Insert_into_users_reg($conn, 'jani', '13.b','kony@gmai.com', 'jani');
//Insert_into_users_log($conn, 1, 'mate','9.a', '2025-01-15 10:30:00');

Kill_server_connection($conn);
