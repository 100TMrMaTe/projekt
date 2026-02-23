<?php


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



