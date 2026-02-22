<?php
header("Content-Type: application/json");
function kapcsolat()
{
$host = "localhost";
$user = "root";
$pass = "";
$db   = "projekt1";

$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_error) {
    die(json_encode(["error" => "Kapcsolódási hiba"]));
}

    return $conn;
}

function test1($conn)
{
  $sql = "SELECT video_id, status, length, test1.current_time, volume, porget from test1";
  mysqli_query($conn, $sql);
  $result = mysqli_query($conn, $sql);
  $row = mysqli_fetch_assoc($result);
  echo json_encode(array("video_id" => $row['video_id'], "status" => $row['status'], "length" => $row['length'], "current_time" => $row['current_time'], "volume" => $row['volume'], "porget" => $row['porget']));
}

function kapcsolo($conn)
{
  $sql = "UPDATE test1 SET test1.status = NOT test1.status";
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
  $sql = "UPDATE test1 SET test1.current_time = $ido";
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
  $sql = "UPDATE test1 SET test1.volume = $hangero";
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
  $sql = "SELECT test1.length FROM test1";
  $result = mysqli_query($conn, $sql);
  $row = mysqli_fetch_assoc($result);
  echo json_encode(array("length" => $row['length']));
}

function setLength($conn, $hossz)
{
  $sql = "UPDATE test1 SET test1.length = $hossz";
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
  $sql = "UPDATE test1 SET test1.current_time = $ido";
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
  $sql = "SELECT test1.current_time FROM test1";
  $result = mysqli_query($conn, $sql);
  $row = mysqli_fetch_assoc($result);
  echo json_encode(array("current_time" => $row['current_time']));
}

function porget($conn, $porget)
{
  $sql = "UPDATE test1 SET test1.porget = $porget";
  $status["status"] = "";
  if ($result = mysqli_query($conn, $sql)) {
    $status = "success";
  } else {
    $status = "error";
  }
  echo json_encode($status);
}






