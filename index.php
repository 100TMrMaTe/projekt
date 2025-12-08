<?php
include_once "database.php";

$conn = Connect_to_server();

Create_databse_tables($conn);
Use_database($conn, 'projekt');

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $json = file_get_contents("php://input");
    $data = json_decode($json, true);

    if ($data["login"] == "reg") {
        $result = Insert_into_users_reg($conn, $data["nev"], $data["osztaly"], $data["email"], $data["password"]);

        $json = json_encode($result);
        echo $json;
    }

    if ($data["login"] == "login") {
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

Kill_server_connection($conn);
