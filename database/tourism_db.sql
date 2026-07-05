CREATE DATABASE IF NOT EXISTS tourism_db;
USE tourism_db;

DROP TABLE IF EXISTS itineraries;
DROP TABLE IF EXISTS destinations;

CREATE TABLE destinations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    state VARCHAR(100) NOT NULL,
    description TEXT,
    image_url VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE itineraries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    destination_id INT NOT NULL,
    visit_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (destination_id) REFERENCES destinations(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO destinations (id, name, state, description, image_url) VALUES 
(1, 'Legoland Malaysia', 'Johor', 'A world-class interactive theme park featuring millions of LEGO bricks.', 'https://www.kkday.com/en/blog/wp-content/uploads/featured_legoland.jpg'),
(2, 'Langkawi Island', 'Kedah', 'An archipelago of 99 magical tropical islands in the Andaman Sea.', 'https://upload.wikimedia.org/wikipedia/commons/6/6c/Eagle_square_at_Kuah_Langkawi.jpg'),
(3, 'Petronas Twin Towers', 'Kuala Lumpur', 'Iconic ultra-tall twin skyscrapers dominating the city skyline.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjQ9pac9rPGT_m9m3tjzu7PUQ1crOuwKUUuVi_ASsPGQ&s=10'),
(4, 'George Town Streets', 'Penang', 'A UNESCO World Heritage zone famous for beautiful murals and street food.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfKS5HNPnjhm95h8tDx0lhsUVO-RIY4jrq3t5wqqABdw&s=10'),
(5, 'Genting Highlands', 'Pahang', 'A vibrant hill resort featuring outdoor theme parks, entertainment, and cool mountain air.', 'https://www.pelago.com/img/products/MY-Malaysia/genting-highlands-day-tour-an-exciting-and-fun-filled-experience/64ba95f6-1b6d-42a3-811a-9aeff5bd3941_genting-highlands-day-tour-an-exciting-and-fun-filled-experience-xlarge.jpg'),
(6, 'A Famosa Fort', 'Melaka', 'A historic Portuguese fortress reflecting rich colonial heritage and architectural wonders.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBoAFaNqyHAfq2_dv4h-Pt8aHf7cnwf2HBvKe8KUqVlA&s=10');