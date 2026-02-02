// Theme Management
function toggleTheme() {
    const body = document.body;
    const icon = document.getElementById('theme-icon');
    
    body.classList.toggle('dark-theme');
    
    if (body.classList.contains('dark-theme')) {
        icon.className = 'bi bi-sun-fill';
        localStorage.setItem('theme', 'dark');
    } else {
        icon.className = 'bi bi-moon-stars-fill';
        localStorage.setItem('theme', 'light');
    }
}

// Load saved theme
function loadTheme() {
    const savedTheme = localStorage.getItem('theme');
    const body = document.body;
    const icon = document.getElementById('theme-icon');
    
    if (savedTheme === 'dark') {
        body.classList.add('dark-theme');
        icon.className = 'bi bi-sun-fill';
    }
}

// Toast Notifications
function showToast(message, type = 'info') {
    const toastEl = document.getElementById('notification-toast');
    const toastBody = document.getElementById('toast-message');
    const toast = new bootstrap.Toast(toastEl);
    
    toastBody.textContent = message;
    toastEl.className = `toast align-items-center border-0 ${type}`;
    
    toast.show();
}

// Filter Lists
function filterList(listId, searchTerm) {
    const list = document.getElementById(listId);
    const items = list.getElementsByTagName('li');
    searchTerm = searchTerm.toLowerCase();
    
    let visibleCount = 0;
    
    for (let item of items) {
        const text = item.textContent.toLowerCase();
        if (text.includes(searchTerm)) {
            item.classList.remove('d-none-filter');
            visibleCount++;
        } else {
            item.classList.add('d-none-filter');
        }
    }
    
    // Show empty state if no results
    if (visibleCount === 0 && searchTerm !== '') {
        // You can add an empty state message here
    }
}

// Update Statistics
function updateStats() {
    const regCount = document.getElementById('reg').getElementsByTagName('li').length;
    const usersCount = document.getElementById('users').getElementsByTagName('li').length;
    const logsCount = document.getElementById('log').getElementsByTagName('li').length;
    
    // Update stat cards
    document.getElementById('pending-count').textContent = regCount;
    document.getElementById('users-count').textContent = usersCount;
    document.getElementById('logs-count').textContent = logsCount;
    
    // Update badges
    document.getElementById('reg-badge').textContent = regCount;
    document.getElementById('users-badge').textContent = usersCount;
    document.getElementById('log-badge').textContent = logsCount;
}

// Request Actions
function acceptRequest(button) {
    const listItem = button.closest('li');
    const email = listItem.querySelector('.email-text').textContent;
    
    // Add your API call here
    console.log('Accepting request for:', email);
    
    // Simulate success
    showToast(`Kérelem elfogadva: ${email}`, 'success');
    
    // Remove item with animation
    listItem.style.opacity = '0';
    listItem.style.transform = 'translateX(100%)';
    setTimeout(() => {
        listItem.remove();
        updateStats();
    }, 300);
}

function rejectRequest(button) {
    const listItem = button.closest('li');
    const email = listItem.querySelector('.email-text').textContent;
    
    if (confirm(`Biztosan elutasítod a következő kérelmet: ${email}?`)) {
        // Add your API call here
        console.log('Rejecting request for:', email);
        
        showToast(`Kérelem elutasítva: ${email}`, 'error');
        
        // Remove item with animation
        listItem.style.opacity = '0';
        listItem.style.transform = 'translateX(-100%)';
        setTimeout(() => {
            listItem.remove();
            updateStats();
        }, 300);
    }
}

// User Actions
function toggleAdmin(button) {
    const listItem = button.closest('li');
    const email = listItem.querySelector('.email-text').textContent;
    const adminBadge = listItem.querySelector('.admin-badge');
    const btnText = button.querySelector('.admin-btn-text');
    
    // Add your API call here
    console.log('Toggling admin for:', email);
    
    // Toggle admin status (this is just visual, you need to connect to your backend)
    if (adminBadge && adminBadge.textContent === 'Admin') {
        adminBadge.remove();
        btnText.textContent = 'Admin';
        showToast(`Admin jog eltávolítva: ${email}`, 'info');
    } else {
        if (!adminBadge) {
            const badge = document.createElement('span');
            badge.className = 'admin-badge';
            badge.textContent = 'Admin';
            listItem.querySelector('.email-text').parentElement.appendChild(badge);
        }
        btnText.textContent = 'Admin eltávolítás';
        showToast(`Admin jog hozzáadva: ${email}`, 'success');
    }
}

function deleteUser(button) {
    const listItem = button.closest('li');
    const email = listItem.querySelector('.email-text').textContent;
    
    if (confirm(`Biztosan törölni szeretnéd ezt a felhasználót: ${email}?`)) {
        // Add your API call here
        console.log('Deleting user:', email);
        
        showToast(`Felhasználó törölve: ${email}`, 'error');
        
        // Remove item with animation
        listItem.style.opacity = '0';
        listItem.style.transform = 'scale(0.8)';
        setTimeout(() => {
            listItem.remove();
            updateStats();
        }, 300);
    }
}

// Background Change (from original)
function bgChange() {
    const bgImages = [
        'bg1.jpg', 'bg2.jpg', 'bg3.png', 'bg4.jpg', 'bg5.jpg', 'bg6.jpg',
        '7.jpg', '8.jpg', '9.jpg', '10.jpg', '11.jpg', '12.jpg', '13.jpg', '14.jpg'
    ];
    const index = Math.floor(Math.random() * bgImages.length);
    document.body.style.backgroundImage = `url(../backgrounds/${bgImages[index]})`;
    console.log("Background changed to: " + bgImages[index]);
}

// Example function to populate lists (you'll need to adapt this to your data)
function populateExampleData() {
    // This is just example data - replace with your actual data loading
    const regList = document.getElementById('reg');
    const usersList = document.getElementById('users');
    const logList = document.getElementById('log');
    
    // Clear loading states
    regList.innerHTML = '';
    usersList.innerHTML = '';
    logList.innerHTML = '';
    
    // Example: Add some sample data
    // Replace this with your actual data loading logic
    
    // If lists are empty, show empty state
    if (regList.children.length === 0) {
        regList.innerHTML = `
            <li class="list-group-item glass-item">
                <div class="empty-state">
                    <i class="bi bi-inbox"></i>
                    <p class="mb-0">Nincsenek függőben lévő kérelmek</p>
                </div>
            </li>
        `;
    }
    
    updateStats();
}

// Initialize on page load
document.addEventListener('DOMContentLoaded', function() {
    loadTheme();
    
    // Uncomment if you want to enable auto background change
    // setInterval(bgChange, 30000);
    
    // You can call your init() function here if it exists
    if (typeof init === 'function') {
        // init() is called from the HTML onload attribute
    }
});

// Example: Create list item from template
function createRegItem(email, osztaly) {
    const template = document.getElementById('reg-item-template');
    const clone = template.content.cloneNode(true);
    
    clone.querySelector('.email-text').textContent = email;
    clone.querySelector('.osztaly-text').textContent = osztaly;
    
    return clone;
}

function createUserItem(email, osztaly, isAdmin) {
    const template = document.getElementById('user-item-template');
    const clone = template.content.cloneNode(true);
    
    clone.querySelector('.email-text').textContent = email;
    clone.querySelector('.osztaly-text').textContent = osztaly;
    
    if (isAdmin) {
        const badge = document.createElement('span');
        badge.className = 'admin-badge';
        badge.textContent = 'Admin';
        clone.querySelector('.admin-badge').replaceWith(badge);
        clone.querySelector('.admin-btn-text').textContent = 'Admin eltávolítás';
    } else {
        clone.querySelector('.admin-badge').remove();
    }
    
    return clone;
}

function createLogItem(song, email, osztaly, time) {
    const template = document.getElementById('log-item-template');
    const clone = template.content.cloneNode(true);
    
    clone.querySelector('.song-title').textContent = song;
    clone.querySelector('.email-text').textContent = email;
    clone.querySelector('.osztaly-text').textContent = osztaly;
    clone.querySelector('.time-text').textContent = time;
    
    return clone;
}

// Export functions for use in other scripts
window.adminPanel = {
    toggleTheme,
    showToast,
    filterList,
    updateStats,
    acceptRequest,
    rejectRequest,
    toggleAdmin,
    deleteUser,
    createRegItem,
    createUserItem,
    createLogItem,
    bgChange
};
