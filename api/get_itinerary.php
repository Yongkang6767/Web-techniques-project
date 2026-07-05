<?php
// Set response header to JSON
header('Content-Type: application/json');

// Include database connection
require_once 'db_connect.php';

// Query to get all itineraries with destination details
$query = "SELECT 
            i.id AS itinerary_id,
            i.destination_id,
            i.visit_date,
            i.created_at,
            d.name AS destination_name,
            d.state,
            d.description,
            d.image_url
          FROM itineraries i 
          JOIN destinations d ON i.destination_id = d.id 
          ORDER BY i.visit_date ASC";

$result = mysqli_query($conn, $query);

// Check if query was successful
if ($result) {
    $itinerary = [];
    
    // Fetch all rows
    while ($row = mysqli_fetch_assoc($result)) {
        $itinerary[] = $row;
    }
    
    echo json_encode([
        'success' => true, 
        'data' => $itinerary,
        'count' => count($itinerary)
    ]);
} else {
    echo json_encode([
        'error' => 'Failed to fetch itinerary: ' . mysqli_error($conn)
    ]);
}

// Close connection
mysqli_close($conn);
?>