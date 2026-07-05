<?php
// Set response header to JSON
header('Content-Type: application/json');

// Include database connection
require_once 'db_connect.php';

// Get JSON data from request body
$data = json_decode(file_get_contents('php://input'), true);

// Validate required field
if (!isset($data['id'])) {
    echo json_encode([
        'error' => 'Missing required field: id is required'
    ]);
    exit;
}

// Validate id is a number
if (!is_numeric($data['id'])) {
    echo json_encode([
        'error' => 'Invalid id: must be a number'
    ]);
    exit;
}

// Sanitize input
$id = mysqli_real_escape_string($conn, $data['id']);

// Delete from database
$query = "DELETE FROM itineraries WHERE id = '$id'";

if (mysqli_query($conn, $query)) {
    // Check if any row was actually deleted
    if (mysqli_affected_rows($conn) > 0) {
        echo json_encode([
            'success' => true, 
            'message' => 'Removed from itinerary successfully'
        ]);
    } else {
        echo json_encode([
            'error' => 'Itinerary item not found or already deleted'
        ]);
    }
} else {
    echo json_encode([
        'error' => 'Failed to delete: ' . mysqli_error($conn)
    ]);
}

// Close connection
mysqli_close($conn);
?>