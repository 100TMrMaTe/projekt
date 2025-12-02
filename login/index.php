<?php
include_once "../database.php";
mysqli_report(MYSQLI_REPORT_OFF);


if (isset($_GET["path"])) {




    $servername = "localhost";
    $username = "root";
    $password = "";

    $conn = new mysqli($servername, $username, $password);

    if ($conn->connect_error) {
        die("Kapcsolódási hiba: " . $conn->connect_error);
    }


    $sql = "CREATE DATABASE IF NOT EXISTS ";
    if ($conn->query($sql) === TRUE) {
        echo "Adatbázis sikeresen létrehozva";
    } else {
        echo "Hiba az adatbázis létrehozásakor: " . $conn->error;
    }

}
