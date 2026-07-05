-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS tourism_db;
USE tourism_db;

-- 1. Destinations Table (Stores your featured tourism spots)
CREATE TABLE IF NOT EXISTS destinations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    state VARCHAR(50) NOT NULL,
    description TEXT NOT NULL,
    image_url VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2. Itinerary Table (The Planning System - links users to destinations)
CREATE TABLE IF NOT EXISTS itineraries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    destination_id INT NOT NULL,
    visit_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (destination_id) REFERENCES destinations(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insert initial featured mock data into the database automatically
INSERT INTO destinations (name, state, description, image_url) VALUES
('Legoland Malaysia', 'Johor', 'A world-class interactive theme park featuring millions of LEGO bricks.', 'https://images.unsplash.com/photo-1569154941061-e231b4725ef1?auto=format&fit=crop&w=500&q=80'),
('Langkawi Island', 'Kedah', 'An archipelago of 99 magical tropical islands in the Andaman Sea.', 'https://images.unsplash.com/photo-1544644181-1484b3fdfc62?auto=format&fit=crop&w=500&q=80'),
('Petronas Twin Towers', 'Kuala Lumpur', 'Iconic ultra-tall twin skyscrapers dominating the city skyline.', 'https://images.unsplash.com/photo-1596422846543-75c6fc18a52b?auto=format&fit=crop&w=500&q=80'),
('George Town Streets', 'Penang', 'A UNESCO World Heritage zone famous for beautiful murals and street food.', 'https://images.unsplash.com/photo-1626082895617-2c6de3476af7?auto=format&fit=crop&w=500&q=80'),
('Genting Highlands', 'Pahang', 'A vibrant hill resort featuring outdoor theme parks, entertainment, and cool mountain air.', 'https://images.unsplash.com/photo-1590759668628-05b0fc34bb70?auto=format&fit=crop&w=500&q=80'),
('A Famosa Fort', 'Melaka', 'A historic Portuguese fortress reflecting rich colonial heritage and architectural wonders.', 'https://images.unsplash.com/photo-1590050752117-238cb0fb12b1?auto=format&fit=crop&w=500&q=80');