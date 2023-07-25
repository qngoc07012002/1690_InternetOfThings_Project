<?php


$servername = "103.27.239.251"; 
$username = "ngoc_db"; 
$password = "ngoc123";
$dbname = "ngoc_db"; 

$conn = new mysqli($servername, $username, $password, $dbname);


if ($conn->connect_error) {
    die("Kết nối đến cơ sở dữ liệu thất bại: " . $conn->connect_error);
}


$currentDate = date("Y-m-d");


$markAbsentQuery = "UPDATE Attendance SET Status = 'Absent' WHERE Status = 'Not Yet' AND Date <= '$currentDate'";

if ($conn->query($markAbsentQuery) === TRUE) {
    echo "Đã đánh dấu các sinh viên có Status 'Not Yet' thành 'Absent' trong ngày $currentDate";
} else {
    echo "Lỗi: " . $markAbsentQuery . "<br>" . $conn->error;
}


$conn->close();

?>
