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
            header("Location: http://localhost/suliscucc/projekt/suc_reg/suc_reg.html?status=success_verified&message=Az email sikeresen megerősítve!");
        } else {
            header("Location: http://localhost/suliscucc/projekt/suc_reg/suc_reg.html?status=error_verified&message=Hiba történt az email megerősítése során.");
        }
    }
}
mysqli_close($conn);
