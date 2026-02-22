<?php

include_once "database/otthon.php";

header("Content-Type: application/json");

$conn = kapcsolat();

$data = json_decode(file_get_contents("php://input"), true);

if ($_SERVER['REQUEST_METHOD'] === "POST") {

    if (isset($data["muvelet"])) {

        switch ($data["muvelet"]) {

            case "test1":
                test1($conn);
                break;

            case "kapcsolo":
                kapcsolo($conn);
                break;

            case "seek":
                seek($conn, $data["ido"]);
                break;

            case "volume":
                volume($conn, $data["hangero"]);
                break;

            case "length":
                length($conn);
                break;

            case "setLength":
                setLength($conn, $data["hossz"]);
                break;

            case "setCurrentTime":
                setCurrentTime($conn, $data["ido"]);
                break;

            case "current_time":
                current_time($conn);
                break;
            case "porget":
                porget($conn, $data["porget"]);
                break;

            default:
                echo json_encode([
                    "status" => "error",
                    "message" => "Ismeretlen muvelet"
                ]);
                break;
        }

    } else {
        echo json_encode([
            "error" => "Nincs megadva muvelet"
        ]);
    }

} else {
    echo json_encode([
        "error" => "Csak POST engedélyezett"
    ]);
}

mysqli_close($conn);