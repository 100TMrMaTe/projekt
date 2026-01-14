<?php
include_once "database/database.php";

$conn = Connect_to_server();

if($_SERVER['REQUEST_METHOD'] == "POST"){
    
}

mysqli_close($conn);
?>