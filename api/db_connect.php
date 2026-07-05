<?php

if (basename($_SERVER['SCRIPT_FILENAME']) === 'db_connect.php') {
    header('Content-Type: application/json');
    die(json_encode(['error' => 'Direct script access is strictly forbidden.']));
}

$host = 'localhost';
$user = 'root';
$pass = '';
$db   = 'tourism_db';

$conn = mysqli_connect($host, $user, $pass, $db);

if (!$conn) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'error' => 'Database connection failed: ' . mysqli_connect_error()
    ]);
    exit;
}

mysqli_set_charset($conn, "utf8mb4");