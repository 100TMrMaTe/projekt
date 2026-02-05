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
        if (icon) {
            icon.className = 'bi bi-sun-fill';
        }
    }
}

// Toast Notifications
function showToast(message, type = 'info') {
    const toastEl = document.getElementById('notification-toast');
    const toastBody = document.getElementById('toast-message');
    
    if (!toastEl || !toastBody) return;
    
    const toast = new bootstrap.Toast(toastEl);
    toastBody.textContent = message;
    toastEl.className = `toast align-items-center border-0 ${type}`;
    toast.show();
}

// Filter Lists
function filterList(listId, searchTerm) {
    const list = document.getElementById(listId);
    if (!list) return;
    
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
}

// Update Statistics
function updateStats() {
    const regList = document.getElementById('reg');
    const usersList = document.getElementById('users');
    const logList = document.getElementById('log');
    
    if (!regList || !usersList || !logList) return;
    
    // Count only visible items (not loading spinner)
    const regCount = Array.from(regList.getElementsByTagName('li'))
        .filter(li => !li.querySelector('.spinner-border')).length;
    const usersCount = Array.from(usersList.getElementsByTagName('li'))
        .filter(li => !li.querySelector('.spinner-border')).length;
    const logsCount = Array.from(logList.getElementsByTagName('li'))
        .filter(li => !li.querySelector('.spinner-border')).length;
    
    // Update stat cards
    const pendingCountEl = document.getElementById('pending-count');
    const usersCountEl = document.getElementById('users-count');
    const logsCountEl = document.getElementById('logs-count');
    
    if (pendingCountEl) pendingCountEl.textContent = regCount;
    if (usersCountEl) usersCountEl.textContent = usersCount;
    if (logsCountEl) logsCountEl.textContent = logsCount;
    
    // Update badges
    const regBadge = document.getElementById('reg-badge');
    const usersBadge = document.getElementById('users-badge');
    const logBadge = document.getElementById('log-badge');
    
    if (regBadge) regBadge.textContent = regCount;
    if (usersBadge) usersBadge.textContent = usersCount;
    if (logBadge) logBadge.textContent = logsCount;
}

// Modified waitingApproval - Modern Design
function waitingApproval(id, email, user_class) {
    return `
        <li class="list-group-item glass-item">
            <div class="container-fluid px-2">
                <div class="row g-2 align-items-center">
                    <div class="col-12">
                        <div class="d-flex align-items-center mb-2">
                            <i class="bi bi-person-circle me-2 text-white-50"></i>
                            <span class="email-text text-truncate">${email}</span>
                        </div>
                        <div class="info-badge">
                            <i class="bi bi-bookmark-fill me-1"></i>
                            Osztály: <strong>${user_class}</strong>
                        </div>
                    </div>
                    <div class="col-6">
                        <button class="btn btn-success w-100 action-btn" onclick="approveUserWithAnimation(${id}, this)">
                            <i class="bi bi-check-lg me-1"></i>Elfogad
                        </button>
                    </div>
                    <div class="col-6">
                        <button class="btn btn-danger w-100 action-btn" onclick="denyUserWithAnimation(${id}, this)">
                            <i class="bi bi-x-lg me-1"></i>Elutasít
                        </button>
                    </div>
                </div>
            </div>
        </li>
    `;
}

// Modified usersAdmin - Modern Design
function usersAdmin(id, email, user_class) {
    return `
        <li class="list-group-item glass-item">
            <div class="container-fluid px-2">
                <div class="row g-2 align-items-center">
                    <div class="col-12">
                        <div class="d-flex align-items-center mb-2">
                            <i class="bi bi-person-fill me-2 text-white-50"></i>
                            <span class="email-text text-truncate">${email}</span>
                            <span class="admin-badge ms-auto">Admin</span>
                        </div>
                        <div class="info-badge">
                            <i class="bi bi-bookmark-fill me-1"></i>
                            Osztály: <strong>${user_class}</strong>
                        </div>
                    </div>
                    <div class="col-6">
                        <button class="btn btn-warning w-100 action-btn" onclick="makeAdminWithAnimation(${id}, this)">
                            <i class="bi bi-shield-fill-check me-1"></i>Admin eltávolítás
                        </button>
                    </div>
                    <div class="col-6">
                        <button class="btn btn-danger w-100 action-btn" onclick="deleteUserWithAnimation(${id}, this)">
                            <i class="bi bi-trash-fill me-1"></i>Törlés
                        </button>
                    </div>
                </div>
            </div>
        </li>
    `;
}

// Modified usersNotAdmin - Modern Design
function usersNotAdmin(id, email, user_class) {
    return `
        <li class="list-group-item glass-item">
            <div class="container-fluid px-2">
                <div class="row g-2 align-items-center">
                    <div class="col-12">
                        <div class="d-flex align-items-center mb-2">
                            <i class="bi bi-person-fill me-2 text-white-50"></i>
                            <span class="email-text text-truncate">${email}</span>
                        </div>
                        <div class="info-badge">
                            <i class="bi bi-bookmark-fill me-1"></i>
                            Osztály: <strong>${user_class}</strong>
                        </div>
                    </div>
                    <div class="col-6">
                        <button class="btn btn-warning w-100 action-btn" onclick="makeAdminWithAnimation(${id}, this)">
                            <i class="bi bi-shield-fill-check me-1"></i>Admin jog
                        </button>
                    </div>
                    <div class="col-6">
                        <button class="btn btn-danger w-100 action-btn" onclick="deleteUserWithAnimation(${id}, this)">
                            <i class="bi bi-trash-fill me-1"></i>Törlés
                        </button>
                    </div>
                </div>
            </div>
        </li>
    `;
}

// Modified songlog - Modern Design
function songlog(id, email, user_class, date, title) {
    return `
        <li class="list-group-item glass-item">
            <div class="container-fluid px-2">
                <div class="d-flex align-items-start mb-2">
                    <i class="bi bi-music-note-beamed me-2 text-white-50 mt-1"></i>
                    <div class="flex-grow-1 min-w-0">
                        <div class="song-title mb-1">${title}</div>
                        <div class="d-flex align-items-center mb-2">
                            <i class="bi bi-person-circle me-1 text-white-50" style="font-size: 0.9rem;"></i>
                            <span class="email-text text-truncate small">${email}</span>
                        </div>
                        <div class="d-flex flex-wrap gap-2">
                            <div class="info-badge small">
                                <i class="bi bi-bookmark-fill me-1"></i>
                                ${user_class}
                            </div>
                            <div class="info-badge small">
                                <i class="bi bi-clock-fill me-1"></i>
                                ${date}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </li>
    `;
}

// Enhanced action functions with animations and toast notifications

function approveUserWithAnimation(id, button) {
    const listItem = button.closest('li');
    const email = listItem.querySelector('.email-text').textContent;
    
    // Disable button
    button.disabled = true;
    button.innerHTML = '<span class="spinner-border spinner-border-sm me-1"></span>Jóváhagyás...';
    
    // Call original function
    approveUser(id);
    
    // Show success animation
    showToast(`Kérelem elfogadva: ${email}`, 'success');
    
    // Animate removal
    setTimeout(() => {
        listItem.style.opacity = '0';
        listItem.style.transform = 'translateX(100%)';
        setTimeout(() => {
            listItem.remove();
            updateStats();
        }, 300);
    }, 500);
}

function denyUserWithAnimation(id, button) {
    const listItem = button.closest('li');
    const email = listItem.querySelector('.email-text').textContent;
    
    if (confirm(`Biztosan elutasítod a következő kérelmet: ${email}?`)) {
        // Disable button
        button.disabled = true;
        button.innerHTML = '<span class="spinner-border spinner-border-sm me-1"></span>Elutasítás...';
        
        // Call original function
        denyUser(id);
        
        // Show toast
        showToast(`Kérelem elutasítva: ${email}`, 'error');
        
        // Animate removal
        setTimeout(() => {
            listItem.style.opacity = '0';
            listItem.style.transform = 'translateX(-100%)';
            setTimeout(() => {
                listItem.remove();
                updateStats();
            }, 300);
        }, 500);
    }
}

function deleteUserWithAnimation(id, button) {
    const listItem = button.closest('li');
    const email = listItem.querySelector('.email-text').textContent;
    
    if (confirm(`Biztosan törölni szeretnéd ezt a felhasználót: ${email}?`)) {
        // Disable button
        button.disabled = true;
        button.innerHTML = '<span class="spinner-border spinner-border-sm me-1"></span>Törlés...';
        
        // Call original function
        deleteUser(id);
        
        // Show toast
        showToast(`Felhasználó törölve: ${email}`, 'error');
        
        // Animate removal
        setTimeout(() => {
            listItem.style.opacity = '0';
            listItem.style.transform = 'scale(0.8)';
            setTimeout(() => {
                listItem.remove();
                updateStats();
            }, 300);
        }, 500);
    }
}

function makeAdminWithAnimation(id, button) {
    const listItem = button.closest('li');
    const email = listItem.querySelector('.email-text').textContent;
    
    // Disable button
    button.disabled = true;
    const originalText = button.innerHTML;
    button.innerHTML = '<span class="spinner-border spinner-border-sm me-1"></span>Folyamatban...';
    
    // Call original function
    makeAdmin(id);
    
    // Show toast based on current state
    const isAdmin = listItem.querySelector('.admin-badge');
    if (isAdmin) {
        showToast(`Admin jog eltávolítva: ${email}`, 'info');
    } else {
        showToast(`Admin jog hozzáadva: ${email}`, 'success');
    }
    
    // The init() function will reload the list
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

// Initialize on page load
document.addEventListener('DOMContentLoaded', function() {
    loadTheme();
    
    // Auto-refresh can be enabled here
    // setInterval(init, 5000);
    
    // Background change can be enabled here
    // setInterval(bgChange, 30000);
});

// Override the original adminpageLog to include stats update
const originalAdminpageLog = window.adminpageLog;
if (typeof originalAdminpageLog === 'function') {
    window.adminpageLog = function() {
        // Call original function
        const result = originalAdminpageLog.apply(this, arguments);
        
        // Update stats after data loads
        setTimeout(updateStats, 100);
        
        return result;
    };
}

// Export functions for compatibility
window.adminPanel = {
    toggleTheme,
    showToast,
    filterList,
    updateStats,
    waitingApproval,
    usersAdmin,
    usersNotAdmin,
    songlog,
    bgChange
};
