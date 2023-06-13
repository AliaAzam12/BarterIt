<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$prname = $_POST['prname'];
$prdesc = $_POST['prdesc'];
$prprice = $_POST['prprice'];
$prqty = $_POST['prqty'];
$prlat = $_POST['prlat'];
$prlong = $_POST['prlong'];
$prstate = $_POST['prstate'];
$prloc = $_POST['prloc'];
$image = $_POST['image'];

$sqlinsert = "INSERT INTO tbl_products(prname, prdesc, prprice, prqty, prstate, prloc, prlat, prlong) VALUES('$prname','$prdesc','$prprice','$prqty','$prstate','$prloc','$prlat','$prlong')";
if ($conn->query($sqlinsert) === TRUE) {
  $filename = mysqli_insert_id($conn);
  $response = array('status' => 'success', 'data' => null);
  $decoded_string = base64_decode($image);
  $path = '../images/items/'.$filename.'.jpg';
  file_put_contents($path, $decoded_string);
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