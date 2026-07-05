<?php
// Set response header to JSON
header('Content-Type: application/json');

// Include database connection
require_once 'db_connect.php';

// Query to get all destinations
$query = "SELECT * FROM destinations ORDER BY name ASC";
$result = mysqli_query($conn, $query);

// Check if query was successful
if ($result) {
    $destinations = [];
    
    // Fetch all rows
    while ($row = mysqli_fetch_assoc($result)) {
        $destinations[] = $row;
    }
    
    // Return success response with data
    echo json_encode([
        'success' => true, 
        'data' => $destinations
    ]);
} else {
    // Return error response
    echo json_encode([
        'error' => 'Failed to fetch destinations: ' . mysqli_error($conn)
    ]);
}

// Close connection
mysqli_close($conn);
?>