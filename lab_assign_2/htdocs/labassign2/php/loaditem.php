<?php
include_once("dbconnect.php");
$prid = $_POST['prid'];
$sqlloadproduct = "SELECT * FROM tbl_products WHERE prid = '$prid' ORDER BY
prdate DESC";
$result = $conn->query($sqlloadproduct);
if ($result->num_rows > 0) {
    $response["items"] = array();
while ($row = $result->fetch_assoc()) {
        $prlist = array();
        $prlist['prid'] = $row['prid'];
        $prlist['prname'] = $row['prname'];
        $prlist['prdesc'] = $row['prdesc'];
        $prlist['prprice'] = $row['prprice'];
        $prlist['prqty'] = $row['prqty'];
        $prlist['prdel'] = $row['prdel'];
        $prlist['prstate'] = $row['prstate'];
        $prlist['prloc'] = $row['prloc'];
        $prlist['prlat'] = $row['prlat'];
        $prlist['prlong'] = $row['prlong'];
        $prlist['prdate'] = $row['prdate'];
        array_push($response["items"],$prlist);
    }
    $response = array('status' => 'success', 'data' => $items);
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