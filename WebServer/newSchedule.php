<?php

// Kết nối đến cơ sở dữ liệu MySQL
$servername = "103.27.239.251"; 
$username = "ngoc_db"; 
$password = "ngoc123";
$dbname = "ngoc_db"; 

$conn = new mysqli($servername, $username, $password, $dbname);

// Kiểm tra kết nối
if ($conn->connect_error) {
    die("Kết nối đến cơ sở dữ liệu thất bại: " . $conn->connect_error);
}

// Lấy ngày hiện tại
$currentDate = date("Y-m-d");

// Truy vấn lấy tất cả RFID mà Student_Code không phải NULL
$sql = "SELECT RFID FROM Student WHERE Student_Code IS NOT NULL";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // Lặp qua kết quả và thêm vào bảng Attendance
    while ($row = $result->fetch_assoc()) {
        $rfid = $row["RFID"];
        $status = "NY";

        // Truy vấn để thêm bản ghi vào bảng Attendance
        $insertQuery = "INSERT INTO Attendance (RFID, Status, Date) VALUES ('$rfid', '$status', '$currentDate')";

        if ($conn->query($insertQuery) === TRUE) {
            echo "Đã tạo lịch điểm danh cho sinh viên có RFID: $rfid<br>";
        } else {
            echo "Lỗi: " . $insertQuery . "<br>" . $conn->error;
        }
    }
} else {
    echo "Không tìm thấy sinh viên nào có mã RFID";
}

// Đóng kết nối
$conn->close();

?>