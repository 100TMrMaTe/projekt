<?php
include_once "database/database_login.php";
include_once "database/database_music.php";
//include_once "database/otthon.php";
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
        case "deleteuseradmin":
            deleteuseradmin($conn, $data["id"]);
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


        //==========================> main.html <==========================

        case "insertIntoMusic":
            insertIntoMusic($conn, $data["video_id"], $data["title"], $data["length"]);
            break;
        case "insertIntoPlaylist":
            insertIntoPlaylist($conn, $data["music_id"], $data["token"]);
            InsertIntoLog($conn, $data["music_id"], $data["token"]);
            break;
        case "isPlaylistEmpty":
            isPlaylistEmpty($conn);
            break;
        case "loadCurrentlyPlaying":
            loadCurrentlyPlaying($conn);
            break;
        case "playPause":
            playPause($conn);
            break;
        case "setVolume":
            setVolume($conn, $data["volume"]);
            break;
        case "setPorget":
            setPorget($conn, $data["time"]);
            break;
        case "getVolume":
            getVolume($conn);
            break;
        case "getCurrentTime":
            getCurrentTime($conn);
            break;
        case "getLength":
            getLength($conn);
            break;
        case "getPlaylist":
            getPlaylist($conn);
            break;
        case "tokenRefresh":
            tokenRefresh($conn, $data["token"]);
            break;
        case "isPlaying":
            isPlaying($conn);
            break;
        case "logout":
            logout($conn, $data["token"]);
            break;
        case "search":
            search($conn, $data["search"]);
            break;
        case "kedvencHozzaad":
            insertIntoFav($conn, $data["id"], $data["user_id"]);
            break;
        case "kedvencElvesz":
            deleteFromFav($conn, $data["id"], $data["user_id"]);
            break;
        case "favLeker":
            favLeker($conn, $data["user_id"]);
            break;
        case "favList":
            favList($conn, $data["user_id"]);
            break;
        case "DeleteFromFavList":
            DeleteFromFavList($conn, $data["id"], $data["user_id"]);
            break;

        //==========================> server.html <==========================

        case "getVideoData":
            getVideoData($conn);
            break;  
        case "setCurrentTime":
            setCurrentTime($conn, $data["time"]);
            break;
        case "noSeek":
            noSeek($conn);
            break;
        case "moveFirstToCurrentlyPlaying":
            moveFirstToCurrentlyPlaying($conn);
            break;
        case "setLength":
            setLength($conn, $data["length"]);
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
