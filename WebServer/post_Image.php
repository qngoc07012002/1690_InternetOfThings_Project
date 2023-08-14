<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_FILES['image']) && $_FILES['image']['error'] === UPLOAD_ERR_OK) {
        $targetFile = basename($_FILES['image']['name']); // Lưu vào thư mục gốc

        if (move_uploaded_file($_FILES['image']['tmp_name'], $targetFile)) {
            echo 'Image uploaded successfully.';
        } else {
            echo 'Error uploading image.';
        }
    } else {
        echo 'No image sent or an error occurred.';
    }
}
?>
