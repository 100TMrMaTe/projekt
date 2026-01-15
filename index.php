<?php
include_once "database/database.php";
$conn = Connect_to_server();
$data = (json_decode(file_get_contents("php://input"), true));
if ($_SERVER['REQUEST_METHOD'] == "POST") {
    switch ($data["muvelet"]) {
        case "registration":
            registration($conn, $data["username"], $data["password"], $data["email"], $data["class"]);
            break;
        default:
            echo json_encode(array("status" => "error", "message" => "Ismeretlen muvelet"));
            break;
    }
}

if ($_SERVER['REQUEST_METHOD'] == "GET") {
    if (isset($_GET["email_token"])) {
        $token = $_GET["email_token"];
        $sql = "UPDATE users SET email_verified = 1 WHERE verification_token = '$token'";
        if (mysqli_query($conn, $sql)) {
            echo "Az email címed sikeresen megerősítve!";
        } else {
            echo "Hiba történt az email cím megerősítése során."; 
        }
    }
}
mysqli_close($conn);
