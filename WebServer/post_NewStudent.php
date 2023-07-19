<?php
$servername = "sql202.infinityfree.com";
$username = "if0_34619232";
$password = "yWaJOEHTUEP4";
$dbname = "if0_34619232_nqngoc";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connect SQL Fail: " . $conn->connect_error);
}

$rfid = $_POST['rfid'];
$name = "New Student";

if ($rfid !== null) {
    $sql = "INSERT INTO Student (RFID, Name) VALUES ('$rfid', '$name')";

    if ($conn->query($sql) === TRUE) {
        echo "Add Successful";
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }
} else {
    echo "RFID value is null";
}

$conn->close();
?>