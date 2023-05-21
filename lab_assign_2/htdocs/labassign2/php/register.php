<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}
include_once("dbconnect.php");
$name = $_POST['name'];
$email = $_POST['email'];
$phone = $_POST['phone'];
$password = sha1($_POST['password']);


$sqlinsert = "INSERT INTO tbl_users (email,name,password,
phone) VALUES('$email','$name','$password','$na')";

if ($conn->query($sqlinsert) === TRUE) {
$response = array('status' => 'success', 'data' => null);

       sendJsonResponse($response);
}else{
$response = array('status' => 'failed', 'data' => null);
sendJsonResponse($response);
}
function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>