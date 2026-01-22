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
        case "approve_user":
            approveUser($conn, $data["id"]);
            break;
        case "deny_user":
            denyUser($conn, $data["id"]);
            break;
        case "delete_user":
            deleteUser($conn, $data["id"]);
            break;
        case "useradmin":
            useradmin($conn, $data["id"]);
            break;
        case "reset_password_request":
            checkEmail($conn, $data["email"]);
            break;
        case "reset_password":
            resetPassword($conn, $data["token"], $data["new_password"]);
            break;
        case "login":
            login($conn, $data["email"], $data["password"]);
            break;
        default:
            echo json_encode(array("status" => "error", "message" => "Ismeretlen muvelet"));
            break;
    }
}
if ($_SERVER['REQUEST_METHOD'] == "GET") {
    switch ($_GET["muvelet"]) {
        case "adminpage":
            adminpage($conn);
            break;
        default:
            echo json_encode(array("status" => "error", "message" => "Ismeretlen muvelet"));
            break;
    }
}

mysqli_close($conn);
