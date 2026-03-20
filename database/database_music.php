<?php

//---------------main.html------------------
//beszúrja az adatbázisba, music táblába
function insertIntoMusic($conn, $video_id, $title, $length)
{
    $sql = "INSERT INTO music (video_id, title, length)
            VALUES (?, ?, ?)
            ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id)";

    if ($stmt = $conn->prepare($sql)) {
        $stmt->bind_param("ssi", $video_id, $title, $length);
        $stmt->execute();

        $music_id = $conn->insert_id;

        echo json_encode([
            "status" => "success",
            "music_id" => $music_id
        ]);

        $stmt->close();
    }
}

//beszúrja az adatbázisba, playlist táblába
function insertIntoPlaylist($conn, $music_id, $token)
{
    $sql = "INSERT INTO playlist (music_id, user_id)
            VALUES (?, (
                SELECT users.id 
                FROM users, active_users 
                WHERE users.id = active_users.user_id 
                AND active_users.token = ?
            ))
            ON DUPLICATE KEY UPDATE music_id = music_id";

    if ($stmt = $conn->prepare($sql)) {
        $stmt->bind_param("is", $music_id, $token);
        $stmt->execute();

        echo json_encode([
            "status" => "success",
            "music_id" => $music_id
        ]);

        $stmt->close();
    }
}

function insertIntoMusicRequest($conn, $music_id)
{
    $sql = "INSERT INTO music_request (music_id, expire)
            VALUES (?, DATE_ADD(NOW(), INTERVAL 7 DAY))
            ON DUPLICATE KEY UPDATE expire = DATE_ADD(NOW(), INTERVAL 7 DAY)";

    if ($stmt = $conn->prepare($sql)) {
        $stmt->bind_param("i", $music_id);
        $stmt->execute();

        echo json_encode([
            "status" => "success",
        ]);

        $stmt->close();
    }
}

//megnézi a playlist üres-e
function isPlaylistEmpty($conn)
{
    $sql = "SELECT id FROM playlist LIMIT 1";

    if ($stmt = $conn->prepare($sql)) {
        $stmt->execute();
        $stmt->store_result();

        echo json_encode([
            "status" => "success",
            "empty" => $stmt->num_rows == 0
        ]);

        $stmt->close();
    }
}





function getPlaylist($conn)
{
    $sql = "SELECT music.id, music.video_id, music.title, music.length
            FROM playlist
            JOIN music ON playlist.music_id = music.id";

    if ($stmt = $conn->prepare($sql)) {
        $stmt->execute();

        $result = $stmt->get_result();
        $rows = $result->fetch_all(MYSQLI_ASSOC);

        echo json_encode([
            "status" => "success",
            "playlist" => $rows
        ]);

        $stmt->close();
    }
}

function getMusicRequest($conn)
{
    $sql = "SELECT music_request.expire, music.video_id, music.title, music.length, music.id
            FROM music_request
            JOIN music ON music_request.music_id = music.id
            WHERE music_request.expire > NOW()";

    if ($stmt = $conn->prepare($sql)) {
        $stmt->execute();

        $result = $stmt->get_result(); 
        $rows = $result->fetch_all(MYSQLI_ASSOC);

        echo json_encode([
            "status" => "success",
            "music_request" => $rows
        ]);

        $stmt->close();
    }
}


function search($conn, $search)
{
    $sql = "SELECT video_id, title, length FROM music WHERE title LIKE '%" . $conn->real_escape_string($search) . "%' LIMIT 7";

    if ($stmt = $conn->prepare($sql)) {
        $stmt->execute();

        $result = $stmt->get_result();
        $row = $result->fetch_all(MYSQLI_ASSOC);

        echo json_encode([
            "status" => "success",
            "results" => $row

        ]);

        $stmt->close();
    }
}







//---------------cuurently_playing_video------------------

function loadCurrentlyPlaying($conn)
{
    $sql = "SELECT currently_playing.*, music.video_id, music.id, music.title, music.length
            FROM currently_playing
            JOIN music ON currently_playing.music_id = music.id
            LIMIT 1";

    if ($stmt = $conn->prepare($sql)) {
        $stmt->execute();

        $result = $stmt->get_result();
        $row = $result->fetch_assoc();

        echo json_encode([
            "video_id" => $row["video_id"] ?? null,
            "music_id" => $row["id"] ?? null,
            "title" => $row["title"] ?? null,
            "length" => $row["length"] ?? null,
            "status" => $row["status"] ?? null,
            "current_time" => $row["current_time"] ?? null,
            "volume" => $row["volume"] ?? null,
            "porget" => $row["porget"] ?? null,
            "user_id" => $row["user_id"] ?? null
        ]);

        $stmt->close();
    }
}


function playPause($conn)
{
    $sql = "UPDATE currently_playing SET currently_playing.status = NOT currently_playing.status";

    if ($stmt = $conn->prepare($sql)) {
        $stmt->execute();

        echo json_encode([
            "status" => "success"
        ]);

        $stmt->close();
    }
}

function isPlaying($conn)
{
    $sql = "SELECT currently_playing.status FROM currently_playing";

    if ($stmt = $conn->prepare($sql)) {
        $stmt->execute();

        $result = $stmt->get_result();
        $row = $result->fetch_assoc();

        echo json_encode([
            "status" => $row["status"] ?? null
        ]);

        $stmt->close();
    }
}


function setVolume($conn, $volume)
{
    $sql = "UPDATE currently_playing SET currently_playing.volume = $volume";

    if ($stmt = $conn->prepare($sql)) {
        $stmt->execute();

        echo json_encode([
            "status" => "success"
        ]);

        $stmt->close();
    }
}


function setPorget($conn, $time)
{
    $sql = "UPDATE currently_playing SET currently_playing.porget = $time";

    if ($stmt = $conn->prepare($sql)) {
        $stmt->execute();

        echo json_encode([
            "status" => "success"
        ]);

        $stmt->close();
    }
}


function getVolume($conn)
{
    $sql = "SELECT currently_playing.volume FROM currently_playing";

    if ($stmt = $conn->prepare($sql)) {
        $stmt->execute();

        $result = $stmt->get_result();
        $row = $result->fetch_assoc();

        echo json_encode([
            "volume" => $row["volume"] ?? null
        ]);

        $stmt->close();
    }
}


function getCurrentTime($conn)
{
    $sql = "SELECT currently_playing.current_time FROM currently_playing";

    if ($stmt = $conn->prepare($sql)) {
        $stmt->execute();

        $result = $stmt->get_result();
        $row = $result->fetch_assoc();

        echo json_encode([
            "current_time" => $row["current_time"] ?? null
        ]);

        $stmt->close();
    }
}


function getLength($conn)
{
    $sql = "SELECT music.length FROM music where music.id = (SELECT currently_playing.music_id FROM currently_playing)";

    if ($stmt = $conn->prepare($sql)) {
        $stmt->execute();

        $result = $stmt->get_result();
        $row = $result->fetch_assoc();

        echo json_encode([
            "length" => $row["length"] ?? null
        ]);

        $stmt->close();
    }
}



function kedvenc($conn){
    $sql = "SELECT fav.id, fav.user_id, fav.music_id from fav";

    if ($stmt = $conn->prepare($sql)) {
        $stmt->execute();

        $result = $stmt->get_result();
        $row = $result->fetch_assoc();

        echo json_encode([
            "id" => $row["id"] ?? null,
            "user_id" => $row["user_id"] ?? null,
            "music_id" => $row["music_id"] ?? null
        ]);

        $stmt->close();
    }
    
}



function insertIntoFav($conn, $video_id, $user_id)
{
    $sql = "INSERT INTO fav (music_id, user_id) VALUES ((SELECT id FROM music WHERE video_id = ?), ?)";

    if ($stmt = $conn->prepare($sql)) {
        $stmt->bind_param("si", $video_id, $user_id);
        $stmt->execute();      

        $stmt->close();

        $sql = "SELECT music_id FROM fav WHERE music_id = (SELECT id FROM music WHERE video_id = ?) AND user_id = ?";

        if ($stmt = $conn->prepare($sql)) {
            $stmt->bind_param("si", $video_id, $user_id);
            $stmt->execute();

            $result = $stmt->get_result();
            $row = $result->fetch_assoc();

            echo json_encode([
                "status" => "success",
                "music_id" => $row["music_id"] ?? null
            ]);

            $stmt->close();
        }
    }
}

function DeleteFromFav($conn, $video_id, $user_id)
{
    $sql = "DELETE FROM fav WHERE music_id = (SELECT id FROM music WHERE video_id = ?) AND user_id = ?";

    if ($stmt = $conn->prepare($sql)) {
        $stmt->bind_param("si", $video_id, $user_id);
        $stmt->execute();
        $stmt->close();
        $sql = "SELECT music_id FROM fav WHERE music_id = (SELECT id FROM music WHERE video_id = ?) AND user_id = ?";

        if ($stmt = $conn->prepare($sql)) {
            $stmt->bind_param("si", $video_id, $user_id);
            $stmt->execute();

            $result = $stmt->get_result();
            $row = $result->fetch_assoc();

            echo json_encode([
                "status" => "success",
                "music_id" => $row["music_id"] ?? null
            ]);

            $stmt->close();
        }
    }
}

function DeleteFromFavList($conn, $music_id, $user_id)
{
    $sql = "DELETE FROM fav WHERE music_id = ? AND user_id = ?";

    if ($stmt = $conn->prepare($sql)) {
        $stmt->bind_param("ii", $music_id, $user_id);
        $stmt->execute();
        $stmt->close();

        echo json_encode([
            "status" => "success",
            "music_id" => $music_id
        ]);
    }
}

function favLeker($conn, $user_id){
    $sql = "SELECT fav.music_id from fav WHERE fav.user_id = ?";

    if ($stmt = $conn->prepare($sql)) {
        $stmt->bind_param("i", $user_id);
        $stmt->execute();

        $result = $stmt->get_result();
        $rows = $result->fetch_all(MYSQLI_ASSOC);

        echo json_encode([
            "status" => "success",
            "fav_music_ids" => $rows
        ]);

        $stmt->close();
    }
}

function favList($conn, $user_id){
    $sql ="SELECT music.* from music JOIN fav ON music.id = fav.music_id WHERE fav.user_id = ?";

    if ($stmt = $conn->prepare($sql)) {
        $stmt->bind_param("i", $user_id);
        $stmt->execute();

        $result = $stmt->get_result();
        $rows = $result->fetch_all(MYSQLI_ASSOC);

        echo json_encode([
            "status" => "success",
            "fav_music" => $rows
        ]);

        $stmt->close();
    }
}


//--------------------------- server.html ---------------------------
function getVideoData($conn)
{
    $sql = "SELECT music.video_id, music.title, music.length, 
    currently_playing.status, currently_playing.current_time, currently_playing.volume, currently_playing.porget
    FROM currently_playing
    JOIN music ON currently_playing.music_id = music.id
    LIMIT 1";

    if ($stmt = $conn->prepare($sql)) {
        $stmt->execute();

        $result = $stmt->get_result();
        $row = $result->fetch_assoc();

        if ($result->num_rows == 0) {
            echo json_encode([
                "video_id" => null,
                "title" => null,
                "length" => null,
                "status" => null,
                "current_time" => null,
                "volume" => null,
                "porget" => null
            ]);
        } else {
            echo json_encode([
                "video_id" => $row["video_id"] ?? null,
                "title" => $row["title"] ?? null,
                "length" => $row["length"] ?? null,
                "status" => $row["status"] ?? null,
                "current_time" => $row["current_time"] ?? null,
                "volume" => $row["volume"] ?? null,
                "porget" => $row["porget"] ?? null
            ]);
        }


        $stmt->close();
    }
}

function setCurrentTime($conn, $time)
{
    $sql = "UPDATE currently_playing SET currently_playing.current_time = $time";

    if ($stmt = $conn->prepare($sql)) {
        $stmt->execute();

        echo json_encode([
            "status" => "success"
        ]);

        $stmt->close();
    }
}

function setLength($conn, $length)
{
    $sql = "UPDATE music SET music.length = $length";

    if ($stmt = $conn->prepare($sql)) {
        $stmt->execute();

        echo json_encode([
            "status" => "success"
        ]);

        $stmt->close();
    }
}


function noSeek($conn)
{
    $sql = "UPDATE currently_playing SET currently_playing.porget = -1";

    if ($stmt = $conn->prepare($sql)) {
        $stmt->execute();

        echo json_encode([
            "status" => "success"
        ]);

        $stmt->close();
    }
}

function moveFirstToCurrentlyPlaying($conn)
{
    $result = $conn->query("SELECT id, music_id, user_id FROM playlist ORDER BY id ASC LIMIT 1");

    if ($result->num_rows == 0) {
        echo json_encode(["status" => "empty"]);
        return;
    }

    $row = $result->fetch_assoc();
    $playlistId = $row['id'];
    $musicId = $row['music_id'];
    $userId = $row['user_id'];

    $stmt = $conn->prepare("UPDATE currently_playing SET music_id = ?, user_id = ?");
    $stmt->bind_param("ii", $musicId, $userId);
    $stmt->execute();
    $stmt->close();

    $stmt = $conn->prepare("DELETE FROM playlist WHERE id = ?");
    $stmt->bind_param("i", $playlistId);
    $stmt->execute();
    $stmt->close();

    echo json_encode(["status" => "success"]);
}

function InsertIntoLog($conn, $music_id, $token)
{
    $log = [];
    $stmt = $conn->prepare("SELECT title FROM music WHERE id = ?");
    $stmt->bind_param("i", $music_id);
    $stmt->execute();

    $result = $stmt->get_result();
    $row = $result->fetch_assoc();
    $log["title"] = $row['title'];
    $log["date"] = date("Y-m-d H:i:s");
    $stmt->close();

    $stmt = $conn->prepare("SELECT user_id FROM active_users WHERE token = ?");
    $stmt->bind_param("s", $token);
    $stmt->execute();

    $result = $stmt->get_result();
    $row = $result->fetch_assoc();
    $log["id"] = $row['user_id'];
    $stmt->close();

    $stmt = $conn->prepare("INSERT INTO user_handler (user_id, date, title) VALUES (?, ?, ?)");
    $stmt->bind_param("iss", $log["id"], $log["date"], $log["title"]);
    $stmt->execute();
    $stmt->close();

}




/*
function test1($conn)
{
    $sql = "SELECT music.video_id, music.title, music.lenght,
                 currently_playing.status, currently_playing.current_time,
                 currently_playing.volume, currently_playing.porget
          FROM currently_playing
          JOIN music ON currently_playing.music_id = music.id
          LIMIT 1";
    $result = mysqli_query($conn, $sql);
    if (!$result || mysqli_num_rows($result) == 0) {
        echo json_encode(array("status" => "error_no_current"));
        return;
    }
    $row = mysqli_fetch_assoc($result);
    echo json_encode(array(
        "video_id" => $row['video_id'],
        "title" => $row['title'],
        "length" => $row['lenght'],
        "status" => $row['status'],
        "current_time" => $row['current_time'],
        "volume" => $row['volume'],
        "porget" => $row['porget']
    ));
}

function kapcsolo($conn)
{
    $sql = "UPDATE currently_playing SET currently_playing.status = NOT currently_playing.status";
    $status["status"] = "";
    if ($result = mysqli_query($conn, $sql)) {
        $status = "success";
    } else {
        $status = "error";
    }
    echo json_encode($status);
}

function seek($conn, $ido)
{
    $ido = (int) $ido;
    $sql = "UPDATE currently_playing SET currently_playing.current_time = $ido";
    $status["status"] = "";
    if ($result = mysqli_query($conn, $sql)) {
        $status = "success";
    } else {
        $status = "error";
    }
    echo json_encode($status);
}

function volume($conn, $hangero)
{
    $hangero = (int) $hangero;
    $sql = "UPDATE currently_playing SET currently_playing.volume = $hangero";
    $status["status"] = "";
    if ($result = mysqli_query($conn, $sql)) {
        $status = "success";
    } else {
        $status = "error";
    }
    echo json_encode($status);
}

function length($conn)
{
    $sql = "SELECT music.lenght FROM currently_playing
          JOIN music ON currently_playing.music_id = music.id
          LIMIT 1";
    $result = mysqli_query($conn, $sql);
    if (!$result || mysqli_num_rows($result) == 0) {
        echo json_encode(array("length" => null));
        return;
    }
    $row = mysqli_fetch_assoc($result);
    echo json_encode(array("length" => $row['lenght']));
}

function setLength($conn, $hossz)
{
    $hossz = (int) $hossz;
    $sql = "UPDATE music
          JOIN currently_playing ON currently_playing.music_id = music.id
          SET music.lenght = $hossz";
    $status["status"] = "";
    if ($result = mysqli_query($conn, $sql)) {
        $status = "success";
    } else {
        $status = "error";
    }
    echo json_encode($status);
}

function setCurrentTime($conn, $ido)
{
    $ido = (int) $ido;
    $sql = "UPDATE currently_playing SET currently_playing.current_time = $ido";
    $status["status"] = "";
    if ($result = mysqli_query($conn, $sql)) {
        $status = "success";
    } else {
        $status = "error";
    }
    echo json_encode($status);
}

function current_time($conn)
{
    $sql = "SELECT currently_playing.current_time FROM currently_playing LIMIT 1";
    $result = mysqli_query($conn, $sql);
    if (!$result || mysqli_num_rows($result) == 0) {
        echo json_encode(array("current_time" => null));
        return;
    }
    $row = mysqli_fetch_assoc($result);
    echo json_encode(array("current_time" => $row['current_time']));
}

function porget($conn, $porget)
{
    $porget = (int) $porget;
    $sql = "UPDATE currently_playing SET currently_playing.porget = $porget";
    $status["status"] = "";
    if ($result = mysqli_query($conn, $sql)) {
        $status = "success";
    } else {
        $status = "error";
    }
    echo json_encode($status);
}

function noSeek($conn)
{
    $sql = "UPDATE currently_playing SET currently_playing.porget = -1";
    $status["status"] = "";
    if ($result = mysqli_query($conn, $sql)) {
        $status = "success";
    } else {
        $status = "error";
    }
    echo json_encode($status);
}

function getVolume($conn)
{
    $sql = "SELECT currently_playing.volume FROM currently_playing LIMIT 1";
    $result = mysqli_query($conn, $sql);
    if (!$result || mysqli_num_rows($result) == 0) {
        echo json_encode(array("volume" => null));
        return;
    }
    $row = mysqli_fetch_assoc($result);
    echo json_encode(array("volume" => $row['volume']));
}
*/

/*
function insertIntoMusic($conn, $video_id, $title, $length)
{
    $sql = "INSERT INTO music (video_id, title, length) VALUES (?, ?, ?)";

    if ($stmt = $conn->prepare($sql)) {
        $stmt->bind_param("ssi", $video_id, $title, $length);

        if ($stmt->execute()) {
            echo json_encode(array("status" => "success"));
        } else {
            echo json_encode(array("status" => "error_letezik"));
        }

        $stmt->close();
    } else {
        echo json_encode(array("status" => "error_letezik"));
    }
}
*/
