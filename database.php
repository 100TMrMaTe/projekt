<?php
function Connect_to_server()
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
  mysqli_set_charset($conn, "utf8mb4");
  return $conn;
}

function Kill_server_connection($conn)
{
  mysqli_close($conn);
}

function Use_database($conn, $dbname)
{
  if (!mysqli_select_db($conn, $dbname)) {
    die(mysqli_error($conn));
  }
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
  user_password VARCHAR(255),
  approved BOOLEAN DEFAULT FALSE
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
  vege DATETIME,
  FOREIGN KEY (user_id) REFERENCES users(id)
)";

  if (mysqli_query($conn, $sql)) {
    //echo "Table user_log created successfully";
  } else {
    echo "Error creating table: " . mysqli_error($conn);
  }
}

function Insert_into_users($conn, $user_name, $user_class, $email, $user_password, $approved = false)
{
  
  // Escape special characters
  $user_name = mysqli_real_escape_string($conn, $user_name);
  $user_class = mysqli_real_escape_string($conn, $user_class);
  $email = mysqli_real_escape_string($conn, $email);
  $user_password = mysqli_real_escape_string($conn, $user_password);
  $approved = $approved ? 1 : 0;

  $sql = "INSERT INTO users (user_name, email, user_class, user_password, approved)
            VALUES ('$user_name', '$email', '$user_class', '$user_password', '$approved')";

  if (mysqli_query($conn, $sql)) {
    return true;
  } else {
    echo "Error inserting user: " . mysqli_error($conn);
    return false;
  }
}

function Update_user_approval($conn, $user_id, $approved)
{
  $approved = $approved ? 1 : 0;
  $sql = "UPDATE users SET approved='$approved' WHERE id=$user_id";

  if (mysqli_query($conn, $sql)) {
    return true;
  } else {
    echo "Error updating user: " . mysqli_error($conn);
    return false;
  }
}

function Insert_into_users_log($conn, $user_id, $user_name, $user_class, $datum, $vege)
{
  $user_name = mysqli_real_escape_string($conn, $user_name);
  $user_class = mysqli_real_escape_string($conn, $user_class);
  $datum = mysqli_real_escape_string($conn, $datum);
  $vege = mysqli_real_escape_string($conn, $vege);

  $sql = "INSERT INTO users_log (user_id, user_name, user_class, datum, vege)
      VALUES ('$user_id', '$user_name', '$user_class', '$datum', '$vege')";


  if (mysqli_query($conn, $sql)) {
    //echo "New record created successfully";
  } else {
    echo "Error: " . $sql . "<br>" . mysqli_error($conn);
  }
}

function Delete_from_users($conn, $user_id)
{
  mysqli_query($conn, "SET FOREIGN_KEY_CHECKS = 0");

  $sql = "DELETE FROM users WHERE id=$user_id";

  $result = mysqli_query($conn, $sql);

  // Mindig visszakapcsoljuk a foreign key ellenőrzést
  mysqli_query($conn, "SET FOREIGN_KEY_CHECKS = 1");

  if ($result) {
    return true;
  } else {
    echo "Error deleting record: " . mysqli_error($conn);
    return false;
  }
}


function Select_from($conn, $table_name)
{
  $sql = "SELECT * FROM " . $table_name;
  $result = mysqli_query($conn, $sql);

  if (!$result) {
    return [];
  }

  $rows = [];

  while ($row = mysqli_fetch_assoc($result)) {
    $rows[] = $row;
  }

  return $rows;
}

function Select_from_where($conn, $table_name, $condition)
{
  $sql = "SELECT * FROM " . $table_name . " WHERE " . $condition;
  $result = mysqli_query($conn, $sql);

  if (!$result) {
    return [];
  }

  $rows = [];

  while ($row = mysqli_fetch_assoc($result)) {
    $rows[] = $row;
  }

  return $rows;
}

function Select_from_log($conn, $table_name)
{
  $sql = "SELECT * FROM " . $table_name . " ORDER BY id DESC LIMIT 100";
  $result = mysqli_query($conn, $sql);

  if (!$result) {
    return [];
  }

  $rows = [];

  while ($row = mysqli_fetch_assoc($result)) {
    $rows[] = $row;
  }

  return $rows;
}

//$conn = Connect_to_server();

//Create_databse_tables($conn);
//Use_database($conn, 'projekt');

//Insert_into_users($conn, 'mate', '13.c','kony@gmail.com', 'kony', true);
//Insert_into_users($conn, 'jani', '13.b','kony@gmai.com', 'jani', false);
//Insert_into_users_log($conn, 1, 'mate','9.a', '2025-01-15 10:30:00');
//Update_user_approval($conn, 2, true);
//Delete_from_users($conn, 1);
//$array = Select_from_where($conn, 'users', 'approved = false');
//var_dump($array[0]);

//Kill_server_connection($conn);
?>