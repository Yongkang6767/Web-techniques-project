<?php
// Database connection settings
$host = 'localhost';
$user = 'root';
$pass = '';
$db = 'tourism_db';

// Create connection
$conn = mysqli_connect($host, $user, $pass, $db);

// Check connection
if (!$conn) {
    die(json_encode(['error' => 'Database connection failed: ' . mysqli_connect_error()]));
}

// Set charset to UTF-8
mysqli_set_charset($conn, "utf8");
?>
