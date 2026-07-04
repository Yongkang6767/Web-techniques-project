<?php
// Database configuration credentials
$host = "localhost";
$username = "root";
$password = ""; // Default XAMPP password is empty
$dbname = "tourism_db";

// Establish a connection using MySQLi extension
$conn = new mysqli($host, $username, $password, $dbname);

// Handle execution crashes gracefully with meaningful messages
if ($conn->connect_error) {
    // Send a JSON header error so your frontend JavaScript fetch requests don't break silently
    header('Content-Type: application/json');
    http_response_code(500);
    echo json_encode([
        "error" => true,
        "message" => "Database Connection Failed: " . $conn->connect_error
    ]);
    exit();
}

// Setcharset to prevent encoding output mismatches
$conn->set_charset("utf8mb4");
?>