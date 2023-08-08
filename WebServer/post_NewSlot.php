<?php

$servername = "103.27.239.251";
$username = "ngoc_db";
$password = "ngoc123";
$dbname = "ngoc_db";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Kết nối đến cơ sở dữ liệu thất bại: " . $conn->connect_error);
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $slotValue = $_POST["slot_value"];

    $currentDate = date("Y-m-d");

    $slotData = array(
        1 => array("Name" => "1", "TimeIn" => "07:30:00", "TimeOut" => "09:00:00"),
        2 => array("Name" => "2", "TimeIn" => "09:10:00", "TimeOut" => "10:40:00"),
        3 => array("Name" => "3", "TimeIn" => "10:50:00", "TimeOut" => "12:20:00"),
        4 => array("Name" => "4", "TimeIn" => "12:50:00", "TimeOut" => "14:20:00"),
        5 => array("Name" => "5", "TimeIn" => "14:30:00", "TimeOut" => "16:00:00"),
        6 => array("Name" => "6", "TimeIn" => "16:10:00", "TimeOut" => "17:40:00"),
        7 => array("Name" => "7", "TimeIn" => "17:50:00", "TimeOut" => "19:20:00"),
        8 => array("Name" => "8", "TimeIn" => "19:30:00", "TimeOut" => "21:00:00")
    );

    if ($slotValue >= 1 && $slotValue <= 8) {
        $slotName = $slotData[$slotValue]["Name"];
        $timeIn = $currentDate . " " . $slotData[$slotValue]["TimeIn"];
        $timeOut = $currentDate . " " . $slotData[$slotValue]["TimeOut"];

        $checkSlotQuery = "SELECT SlotID FROM Slot WHERE TimeIn = '$timeIn' AND TimeOut = '$timeOut'";
        $checkSlotResult = $conn->query($checkSlotQuery);

        if ($checkSlotResult->num_rows > 0) {
            echo "Slot đã tồn tại với thời gian tương ứng<br>";
        } else {
            $insertSlotQuery = "INSERT INTO Slot (Name, TimeIn, TimeOut) VALUES ('$slotName', '$timeIn', '$timeOut')";
            if ($conn->query($insertSlotQuery) === TRUE) {
                $slotID = $conn->insert_id;

                $selectRFIDQuery = "SELECT RFID FROM Student WHERE Name != 'New Student'";
                $result = $conn->query($selectRFIDQuery);

                if ($result->num_rows > 0) {
                    while ($row = $result->fetch_assoc()) {
                        $rfid = $row["RFID"];
                        $status = "Not Yet";

                        $insertAttendanceQuery = "INSERT INTO Attendance (SlotID, RFID, Status) VALUES ('$slotID', '$rfid', '$status')";
                        if ($conn->query($insertAttendanceQuery) === TRUE) {
                            echo "Đã tạo lịch điểm danh cho sinh viên có RFID: $rfid trong slot $slotName vào ngày $currentDate<br>";
                        } else {
                            echo "Lỗi: " . $insertAttendanceQuery . "<br>" . $conn->error;
                        }
                    }
                } else {
                    echo "Không tìm thấy sinh viên nào có tên khác 'New Student'";
                }
            } else {
                echo "Lỗi: " . $insertSlotQuery . "<br>" . $conn->error;
            }
        }
    } else {
        echo "Giá trị slot không hợp lệ";
    }
}

$conn->close();

?>
