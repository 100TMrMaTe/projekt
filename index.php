<?php
include_once "database/database.php";

$conn = Connect_to_server();

Create_databse_tables($conn);
Use_database($conn, 'projekt');

$apiParts = explode("/", $_GET["path"]);

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $json = file_get_contents("php://input");
    $data = json_decode($json, true);

    if ($apiParts[0] == "reg") {
        // Ellenőrizzük, hogy az email iskolai cím-e
        if (str_ends_with($data["email"], '@ady-nagyatad.hu')) {
            $user_password = password_hash($data["password"], PASSWORD_DEFAULT);
            $result = Insert_into_users($conn, $data["nev"], $data["osztaly"], $data["email"], $user_password, false);
            
            if ($result) {
                $response = ["success" => "success"];
            } else {
                $response = ["error" => "error"];
            }
        } else {
            $response = ["sulisemail" => "Suliss emaillel regisztrálj"];
        }
        
        $json = json_encode($response);
        echo $json;
    } else if ($apiParts[0] == "login") {
        $users = Select_from_where($conn, "users", "approved = true");
        $result = ["status" => "error", "message" => "nincs ilyen felhasznalo"];
        $found = false;

        foreach ($users as $x) {
            if ($x["email"] == $data["email"]) {
                $found = true;
                if (password_verify($data["password"], $x["user_password"])) {
                    $result = ["status" => "success", "message" => "mehetsz"];

                    $vege = new DateTime();
                    $vege->modify('+20 minutes');

                    Insert_into_users_log(
                        $conn,
                        $x["id"],
                        $x["user_name"],
                        $x["user_class"],
                        date("Y-m-d H:i:s"),
                        $vege->format("Y-m-d H:i:s")
                    );
                    break;
                } else {
                    $result = ["status" => "error", "message" => "hibas jelszo"];
                    break;
                }
            }
        }

        if (!$found) {
            $result = ["status" => "error", "message" => "nincs ilyen felhasznalo vagy a regisztráció még nincs jóváhagyva"];
        }

        $json = json_encode($result);
        echo $json;
    } else if ($apiParts[0] == "approveuser") {
        $result = Update_user_approval($conn, $data["id"], true);
        $json = json_encode($result);
        echo $json;
    }
}

if ($_SERVER["REQUEST_METHOD"] == "GET") {
    if ($apiParts[0] == "adminpage") {
        $response = [];

        $response["log"]   = Select_from_log($conn, "users_log");
        $response["reg"]   = Select_from_where($conn, "users", "approved = false");
        $response["users"] = Select_from_where($conn, "users", "approved = true");

        $json = json_encode($response);
        echo $json;
    }
}

if ($_SERVER["REQUEST_METHOD"] == "DELETE") {
    $json = file_get_contents("php://input");
    $data = json_decode($json, true);

    if ($apiParts[0] == "removereg") {
        $response["status"] = "error";

        if (Delete_from_users($conn, $data["id"])) {
            $response["status"] = "success";
        }

        $json = json_encode($response);
        echo $json;
    } else if ($apiParts[0] == "removeusers") {
        $response["status"] = "error";

        if (Delete_from_users($conn, $data["id"])) {
            $response["status"] = "success";
        }

        $json = json_encode($response);
        echo $json;
    }
}

Kill_server_connection($conn);
?>