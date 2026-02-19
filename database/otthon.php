<?php
header("Content-Type: application/json");
function kapcsolat()
{
$host = "localhost";
$user = "root";
$pass = "";
$db   = "otthon";

$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_error) {
    die(json_encode(["error" => "Kapcsolódási hiba"]));
}

    return $conn;
}

function test2($conn)
{
    $sql = "SELECT id, status FROM allapot LIMIT 1";
    $result = $conn->query($sql);

if ($result && $row = $result->fetch_assoc()) {
    echo json_encode([
        "id" => $row["id"],
        "status" => $row["status"]
    ]);
} else {
    echo json_encode(["error" => "Nincs adat"]);
}
}


