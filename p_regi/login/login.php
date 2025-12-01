<?php include_once "../database/database.php";
$conn = Connect_to_serer();
Create_databse_tables($conn);
Use_database($conn, 'projekt');
$users = Select_from($conn, 'users');

function redirect($url)
{
    header('Location: ' . $url);
    die();
}

if (isset($_POST["email"]) && isset($_POST["password"])) {
    $keres_email = $_POST["email"];
    $keres_password = $_POST["password"];
    
    if ($keres_email == "nemeth.kristof@ady-nagyatad.hu" && $keres_password == "admin") {
        redirect("http://localhost/suliscucc/projekt/adminwepage/adminpage.php");
    }

    $sikeres_bejelentkezes = false;
    
    foreach ($users as $row) {
        if ($keres_email == $row[2] && $keres_password == $row[4]) {
            $sikeres_bejelentkezes = true;
            redirect("http://localhost/suliscucc/projekt/music/music.php");
        }
    }
    
    if (!$sikeres_bejelentkezes) {
        redirect("http://localhost/suliscucc/projekt/login/login.html?error=1");
    }
}

Kill_server_connection($conn);