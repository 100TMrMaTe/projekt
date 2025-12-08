<?php
include_once "database.php";

$conn = Connect_to_server();

Create_databse_tables($conn);
Use_database($conn, 'projekt');

$apiParts = explode("/", $_GET["path"]);

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $json = file_get_contents("php://input");
    $data = json_decode($json, true);

    if ($apiParts[0] == "reg") {
        $result = Insert_into_users_reg($conn, $data["nev"], $data["osztaly"], $data["email"], $data["password"]);

        $json = json_encode($result);
        echo $json;
    }

    if ($apiParts[0] == "login") {
        $users = Select_from($conn, "users");
        $result = "";
        foreach ($users as $x) {
            if ($x["email"] == $data["email"] && $x["user_password"] == $data["password"]) {
                $result = "mehetsz";

                $vege = new DateTime();
                $vege->modify('+20 minutes');

                Insert_into_users_log($conn, $x["id"], $x["user_name"], $x["user_class"], date("Y-m-d H:i:s"), $vege->format("Y-m-d H:i:s"));
            }
        }
        if ($result == "") {
            $result = "nincs ilyen felhasznalo ocskos";
        }

        $json = json_encode($result);
        echo $json;
    }
}

if ($_SERVER["REQUEST_METHOD"] == "GET") {
    if ($apiParts[0] == "adminpage") {
        $response = [];

        $response["log"]   = Select_from_log($conn, "users_log");
        $response["reg"]   = Select_from($conn, "users_reg");
        $response["users"] = Select_from($conn, "users");

        $json = json_encode($response);
        echo $json;
    }
}

if ($_SERVER["REQUEST_METHOD"] == "DELETE") {
    $json = file_get_contents("php://input");
    $data = json_decode($json, true);

    if ($apiParts[0] == "removereg") {
        $response["status"] = "error";

        Delete_from_users_reg($conn, $data["id"]);
        $response["status"] = "success";

        $json = json_encode($response);
        echo $json;
    } else if ($apiParts[0] == "removeusers") {
        $response["status"] = "error";

        Delete_from_users($conn, $data["id"]);  
        $response["status"] = "success";

        $json = json_encode($response);
        echo $json;
    }
}

Kill_server_connection($conn);
