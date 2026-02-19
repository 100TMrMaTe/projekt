<?php

include_once "database/otthon.php";

header("Content-Type: application/json");

$conn = kapcsolat();

$data = json_decode(file_get_contents("php://input"), true);

if ($_SERVER['REQUEST_METHOD'] === "POST") {

    if (isset($data["muvelet"]) && $data["muvelet"] === "test2") {
        test2($conn);
    } else {
        echo json_encode([
            "error" => "Ismeretlen muvelet"
        ]);
    }

} else {
    echo json_encode([
        "error" => "Csak POST engedélyezett"
    ]);
}

mysqli_close($conn);
