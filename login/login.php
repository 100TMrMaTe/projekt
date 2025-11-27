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

    foreach ($users as $row) {
        if ($keres_email == $row[2] && $keres_password == $row[4]) {
            redirect("http://localhost/suliscucc/projekt/music/music.php");
        }
    }
    echo "<script type='text/javascript'>alert('valami nem jo gec');</script>";
    redirect("C:\xampp\htdocs\suliscucc\projekt\login\login.html");
}
Kill_server_connection($conn);
