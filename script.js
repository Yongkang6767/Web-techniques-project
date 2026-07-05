document.addEventListener('DOMContentLoaded', () => {
    // Load initial data
    fetchDestinations();
    fetchItinerary();
});

// 1. Fetch and Display Destinations
async function fetchDestinations() {
    try {
        const response = await fetch('api/get_destinations.php');
        const result = await response.json();

        if (result.success) {
            displayDestinations(result.data);
        } else {
            alert('Error loading destinations: ' + result.error);
        }
    } catch (error) {
        console.error('Failed to fetch destinations:', error);
    }
}

function displayDestinations(destinations) {
    const grid = document.getElementById('destinations-grid');
    grid.innerHTML = '';

    if (destinations.length === 0) {
        grid.innerHTML = '<p>No destinations found.</p>';
        return;
    }

    destinations.forEach(place => {
        const card = document.createElement('div');
        card.className = 'card';
        
        // Use a fallback image if image_url is empty
        const imgUrl = place.image_url ? place.image_url : 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=500';

        card.innerHTML = `
            <img src="${imgUrl}" alt="${place.name}" class="card-img">
            <div class="card-content">
                <h3 class="card-title">${place.name}</h3>
                <span class="card-state">${place.state}</span>
                <p class="card-desc">${place.description || 'No description available.'}</p>
                
                <div class="form-group">
                    <label for="date-${place.id}">Plan Visit Date:</label>
                    <input type="date" id="date-${place.id}" class="date-input" required>
                </div>
                <button class="btn btn-primary" onclick="addToItinerary(${place.id})">
                    Add to Itinerary
                </button>
            </div>
        `;
        grid.appendChild(card);
    });
}

// 2. Add Item to Itinerary
async function addToItinerary(destinationId) {
    const dateInput = document.getElementById(`date-${destinationId}`);
    const visitDate = dateInput.value;

    if (!visitDate) {
        alert('Please select a valid visit date first!');
        return;
    }

    const payload = {
        destination_id: destinationId,
        visit_date: visitDate
    };

    try {
        const response = await fetch('api/add_itinerary.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(payload)
        });
        const result = await response.json();

        if (result.success) {
            alert('Added to your itinerary!');
            dateInput.value = ''; // Reset input
            fetchItinerary();    // Refresh sidebar layout
        } else {
            alert('Error: ' + result.error);
        }
    } catch (error) {
        console.error('Failed to add itinerary:', error);
    }
}

// 3. Fetch and Display Current Itinerary
async function fetchItinerary() {
    try {
        const response = await fetch('api/get_itinerary.php');
        const result = await response.json();

        if (result.success) {
            displayItinerary(result.data);
        } else {
            alert('Error loading itinerary: ' + result.error);
        }
    } catch (error) {
        console.error('Failed to fetch itinerary:', error);
    }
}

function displayItinerary(itineraryItems) {
    const list = document.getElementById('itinerary-list');
    list.innerHTML = '';

    if (itineraryItems.length === 0) {
        list.innerHTML = '<li class="itinerary-item"><p style="color: #718096;">Your itinerary is empty.</p></li>';
        return;
    }

    itineraryItems.forEach(item => {
        const li = document.createElement('li');
        li.className = 'itinerary-item';
        li.innerHTML = `
            <div class="itinerary-info">
                <h4>${item.destination_name}</h4>
                <p>📍 ${item.state} | 📅 ${item.visit_date}</p>
            </div>
            <button class="btn btn-danger" onclick="deleteFromItinerary(${item.itinerary_id})">
                Remove
            </button>
        `;
        list.appendChild(li);
    });
}

// 4. Delete Item from Itinerary
async function deleteFromItinerary(itineraryId) {
    if (!confirm('Are you sure you want to remove this from your trip?')) return;

    try {
        const response = await fetch('api/deleted_itinerary.php', {
            method: 'DELETE', // Matches structure behavior
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ id: itineraryId })
        });
        const result = await response.json();

        if (result.success) {
            fetchItinerary(); // Refresh list layout
        } else {
            alert('Error: ' + result.error);
        }
    } catch (error) {
        console.error('Failed to delete itinerary item:', error);
    }
}