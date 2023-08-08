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


$sql = "SELECT RFID FROM Student WHERE Student_Code IS NOT NULL";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    
    while ($row = $result->fetch_assoc()) {
        $rfid = $row["RFID"];
        $status = "Not Yet";

        $checkQuery = "SELECT RFID FROM Attendance WHERE RFID = '$rfid' AND Date = '$currentDate'";
        $checkResult = $conn->query($checkQuery);

        if ($checkResult->num_rows > 0) {
            echo "Bản ghi đã tồn tại cho sinh viên có RFID: $rfid và ngày $currentDate<br>";
        } else {
            $insertQuery = "INSERT INTO Attendance (RFID, Status, Date) VALUES ('$rfid', '$status', '$currentDate')";

            if ($conn->query($insertQuery) === TRUE) {
                echo "Đã tạo lịch điểm danh cho sinh viên có RFID: $rfid vào ngày $currentDate<br>";
            } else {
                echo "Lỗi: " . $insertQuery . "<br>" . $conn->error;
            }
        }
    }
} else {
    echo "Không tìm thấy sinh viên nào có mã RFID";
}

$conn->close();

?>
