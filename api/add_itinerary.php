<?php
// Set response header to JSON
header('Content-Type: application/json');

// Include database connection
require_once 'db_connect.php';

// Get JSON data from request body
$data = json_decode(file_get_contents('php://input'), true);

// Validate required fields
if (!isset($data['destination_id']) || !isset($data['visit_date'])) {
    echo json_encode([
        'error' => 'Missing required fields: destination_id and visit_date are required'
    ]);
    exit;
}

// Validate destination_id is a number
if (!is_numeric($data['destination_id'])) {
    echo json_encode([
        'error' => 'Invalid destination_id: must be a number'
    ]);
    exit;
}

// Validate date format (YYYY-MM-DD)
if (!preg_match('/^\d{4}-\d{2}-\d{2}$/', $data['visit_date'])) {
    echo json_encode([
        'error' => 'Invalid visit_date format: use YYYY-MM-DD'
    ]);
    exit;
}

// Sanitize inputs to prevent SQL injection
$destination_id = mysqli_real_escape_string($conn, $data['destination_id']);
$visit_date = mysqli_real_escape_string($conn, $data['visit_date']);

// Insert into database
$query = "INSERT INTO itineraries (destination_id, visit_date) 
          VALUES ('$destination_id', '$visit_date')";

if (mysqli_query($conn, $query)) {
    // Get the ID of the inserted record
    $inserted_id = mysqli_insert_id($conn);
    
    echo json_encode([
        'success' => true, 
        'message' => 'Destination added to your itinerary!',
        'id' => $inserted_id
    ]);
} else {
    echo json_encode([
        'error' => 'Failed to add to itinerary: ' . mysqli_error($conn)
    ]);
}

// Close connection
mysqli_close($conn);
?>