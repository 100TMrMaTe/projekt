<?php
include_once "database/database.php";
$conn = Connect_to_server();
$data = (json_decode(file_get_contents("php://input"), true));
if ($_SERVER['REQUEST_METHOD'] == "POST") {
    switch ($data["muvelet"]) {
        case "registration":
            registration($conn, $data["username"], $data["password"], $data["email"], $data["class"]);
            break;
        case "verified":
            verifyEmail($conn, $data["email_token"]);
            break;
        default:
            echo json_encode(array("status" => "error", "message" => "Ismeretlen muvelet"));
            break;
    }
}
if($_SERVER['REQUEST_METHOD'] == "GET"){
    switch ($_GET["muvelet"]) {
        case "adminpage":
            
            break;
        default:
            echo json_encode(array("status" => "error", "message" => "Ismeretlen muvelet"));
            break;
    }
}

mysqli_close($conn);
?>
