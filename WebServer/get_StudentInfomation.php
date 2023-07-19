<?php
$servername = "103.27.239.251"; 
$username = "ngoc_db"; 
$password = "ngoc123";
$dbname = "ngoc_db"; 


$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connect SQL Fail: " . $conn->connect_error);
}

if (isset($_GET['rfid'])) {
    $rfid = $_GET['rfid'];

    $sql = "SELECT * FROM Student WHERE RFID = '$rfid'";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $student = $result->fetch_assoc();

        header('Content-Type: application/json');
        echo json_encode($student);
    } else {
        echo json_encode(array("error" => "Student Not Found."));
    }
} else {
    echo json_encode(array("error" => "RFID Null"));
}

$conn->close();
?>