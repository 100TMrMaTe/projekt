// Global Variables
let player;
let isPlaying = false;
let currentVideoId = null;
let sessionStart = Date.now();
let timerInterval;

// API Keys (from original)
const apiKey = "AIzaSyAvqcZuWfXHENDGZOhjSKoKyaZe4xGtTVM";
const apiKey2 = "AIzaSyAjhNmbvJwzwac3JK-UxQFId23xWsn10-E";

// Initialize
document.addEventListener('DOMContentLoaded', function() {
    initializeApp();
    createParticles();
    startSessionTimer();
    loadUserInfo();
});

// Initialize App
function initializeApp() {
    // Theme toggle
    document.getElementById('themeToggle').addEventListener('click', toggleTheme);
    
    // Search on Enter
    document.getElementById('kereso').addEventListener('keydown', function(e) {
        if (e.key === 'Enter') {
            keres();
            eredmenyVisszahoz();
        }
    });
    
    // Load saved theme
    const savedTheme = localStorage.getItem('musicPlayerTheme');
    if (savedTheme === 'dark') {
        document.body.classList.add('dark-theme');
        document.getElementById('themeToggle').innerHTML = '<i class="bi bi-sun-fill"></i>';
    }
}

// Theme Toggle
function toggleTheme() {
    const body = document.body;
    const icon = document.getElementById('themeToggle').querySelector('i');
    
    body.classList.toggle('dark-theme');
    
    if (body.classList.contains('dark-theme')) {
        icon.className = 'bi bi-sun-fill';
        localStorage.setItem('musicPlayerTheme', 'dark');
    } else {
        icon.className = 'bi bi-moon-stars-fill';
        localStorage.setItem('musicPlayerTheme', 'light');
    }
}

// Create Particles
function createParticles() {
    const container = document.getElementById('particles');
    const particleCount = 30;
    
    for (let i = 0; i < particleCount; i++) {
        const particle = document.createElement('div');
        particle.className = 'particle';
        
        const size = Math.random() * 3 + 2;
        particle.style.width = size + 'px';
        particle.style.height = size + 'px';
        particle.style.left = Math.random() * 100 + '%';
        particle.style.animationDuration = (Math.random() * 10 + 10) + 's';
        particle.style.animationDelay = Math.random() * 5 + 's';
        particle.style.setProperty('--drift', (Math.random() * 200 - 100) + 'px');
        
        container.appendChild(particle);
    }
}

// Session Timer
function startSessionTimer() {
    timerInterval = setInterval(() => {
        const elapsed = Math.floor((Date.now() - sessionStart) / 1000);
        const minutes = Math.floor(elapsed / 60);
        const seconds = elapsed % 60;
        document.getElementById('timer').textContent = 
            `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
    }, 1000);
}

// Load User Info
function loadUserInfo() {
    const email = localStorage.getItem('email');
    const userName = email ? email.split('@')[0] : 'Felhasználó';
    document.getElementById('userName').textContent = userName;
}

// Show Toast
function showToast(message, type = 'success') {
    const toast = document.getElementById('notification-toast');
    const toastMessage = document.getElementById('toast-message');
    const toastIcon = document.getElementById('toast-icon');
    
    toastMessage.textContent = message;
    
    // Set icon based on type
    if (type === 'success') {
        toastIcon.className = 'bi bi-check-circle-fill text-success';
    } else if (type === 'error') {
        toastIcon.className = 'bi bi-x-circle-fill text-danger';
    } else if (type === 'info') {
        toastIcon.className = 'bi bi-info-circle-fill text-info';
    }
    
    const bsToast = new bootstrap.Toast(toast);
    bsToast.show();
}

// Search Function
function keres() {
    const kereso = document.getElementById('kereso').value;
    const eredmeny = document.getElementById('eredmeny');

    if (kereso.length < 3) {
        eredmeny.innerHTML = `
            <div class="empty-state">
                <i class="bi bi-exclamation-circle"></i>
                <p>Írj be legalább 3 karaktert</p>
            </div>
        `;
        return;
    }

    eredmeny.innerHTML = `
        <div class="empty-state">
            <div class="loading"></div>
            <p>Keresés folyamatban...</p>
        </div>
    `;

    const URL = `https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&maxResults=10&q=${encodeURIComponent(kereso)}&key=${apiKey2}`;

    fetch(URL)
        .then(response => response.json())
        .then(data => {
            const videoIds = data.items.map(item => item.id.videoId).join(',');
            const detailsURL = `https://www.googleapis.com/youtube/v3/videos?part=contentDetails&id=${videoIds}&key=${apiKey}`;

            return fetch(detailsURL)
                .then(response => response.json())
                .then(details => {
                    const videos = data.items
                        .filter(item => item.id.kind === 'youtube#video')
                        .map((item, i) => ({
                            videoId: item.id.videoId,
                            title: item.snippet.title,
                            img: item.snippet.thumbnails.medium.url,
                            highImg: item.snippet.thumbnails.high.url,
                            duration: videoHosszAtAlakit(details.items[i].contentDetails.duration)
                        }));
                    
                    displayResults(videos);
                });
        })
        .catch(error => {
            console.error('Error:', error);
            eredmeny.innerHTML = `
                <div class="empty-state">
                    <i class="bi bi-exclamation-triangle"></i>
                    <p>Hiba történt a keresés során</p>
                </div>
            `;
            showToast('Hiba történt a keresés során', 'error');
        });
}

// Display Search Results
function displayResults(videos) {
    const eredmeny = document.getElementById('eredmeny');
    eredmeny.innerHTML = '';

    if (!videos.length) {
        eredmeny.innerHTML = `
            <div class="empty-state">
                <i class="bi bi-search"></i>
                <p>Nincs találat</p>
            </div>
        `;
        return;
    }

    videos.forEach(video => {
        const item = document.createElement('div');
        item.className = 'music-item';
        item.innerHTML = `
            <div class="row g-2 align-items-center">
                <div class="col-4">
                    <img src="${video.img}" class="img-fluid" alt="${video.title}">
                </div>
                <div class="col-8">
                    <div class="music-title text-truncate">${video.title}</div>
                    <div class="music-duration">
                        <i class="bi bi-clock"></i>
                        ${formatDuration(video.duration)}
                    </div>
                </div>
            </div>
        `;

        item.onclick = () => {
            embedVideo(video.videoId, video.highImg, video.title);
            showToast('Videó betöltve', 'success');
        };

        eredmeny.appendChild(item);
    });
}

// Convert YouTube duration to seconds
function videoHosszAtAlakit(duration) {
    const match = duration.match(/PT(\d+H)?(\d+M)?(\d+S)?/);
    const hours = (parseInt(match[1]) || 0);
    const minutes = (parseInt(match[2]) || 0);
    const seconds = (parseInt(match[3]) || 0);
    return hours * 3600 + minutes * 60 + seconds;
}

// Format duration
function formatDuration(seconds) {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins}:${secs.toString().padStart(2, '0')}`;
}

// Embed Video
function embedVideo(videoId, thumbnail, title) {
    currentVideoId = videoId;
    const lejatszo = document.getElementById('lejatszo');
    
    lejatszo.innerHTML = `
        <div>
            <img src="${thumbnail}" class="player-thumbnail" alt="${title}">
            <div class="player-info">
                <div class="player-title">${title}</div>
            </div>
            <div class="player-controls">
                <div class="progress-container">
                    <div class="progress-bar-custom" id="progressBar">
                        <div class="progress-bar-fill" id="progressFill" style="width: 0%"></div>
                    </div>
                    <div class="progress-time">
                        <span id="currentTime">0:00</span>
                        <span id="totalTime">0:00</span>
                    </div>
                </div>
                
                <div class="controls-row">
                    <button class="control-btn" onclick="elozo()" title="Előző">
                        <i class="bi bi-skip-start-fill"></i>
                    </button>
                    <button class="control-btn play-btn" onclick="inditas()" id="playBtn" title="Lejátszás">
                        <i class="bi bi-play-fill"></i>
                    </button>
                    <button class="control-btn" onclick="kovetkezo()" title="Következő">
                        <i class="bi bi-skip-end-fill"></i>
                    </button>
                </div>
                
                <div class="volume-control">
                    <i class="bi bi-volume-up-fill"></i>
                    <input type="range" class="volume-slider" id="volumeSlider" 
                           min="0" max="100" value="50" 
                           oninput="hangSzabalyzo(this.value)">
                    <span id="volumePercent">50%</span>
                </div>
            </div>
            <div id="ytFrame" style="display: none;"></div>
        </div>
    `;

    // Update now playing
    document.getElementById('nowPlayingText').textContent = title;

    // Initialize YouTube Player
    if (player) {
        player.loadVideoById(videoId);
    } else {
        player = new YT.Player('ytFrame', {
            width: 1,
            height: 1,
            videoId: videoId,
            events: {
                onReady: onPlayerReady,
                onStateChange: onPlayerStateChange
            }
        });
    }
}

// Player Ready
function onPlayerReady(event) {
    const volumeSlider = document.getElementById('volumeSlider');
    if (volumeSlider) {
        player.setVolume(volumeSlider.value);
    }
    updateProgress();
}

// Player State Change
function onPlayerStateChange(event) {
    if (event.data === YT.PlayerState.PLAYING) {
        isPlaying = true;
        document.getElementById('playBtn').innerHTML = '<i class="bi bi-pause-fill"></i>';
        updateProgress();
    } else if (event.data === YT.PlayerState.PAUSED) {
        isPlaying = false;
        document.getElementById('playBtn').innerHTML = '<i class="bi bi-play-fill"></i>';
    }
}

// Play/Pause
function inditas() {
    if (!player) return;
    
    if (isPlaying) {
        player.pauseVideo();
    } else {
        player.playVideo();
    }
}

// Previous
function elozo() {
    if (!player) return;
    player.previousVideo();
}

// Next
function kovetkezo() {
    if (!player) return;
    player.nextVideo();
}

// Volume Control
function hangSzabalyzo(volume) {
    if (player && player.setVolume) {
        player.setVolume(volume);
        const percent = document.getElementById('volumePercent');
        if (percent) {
            percent.textContent = volume + '%';
        }
    }
}

// Update Progress
function updateProgress() {
    if (!player || !player.getCurrentTime) return;
    
    const currentTime = player.getCurrentTime();
    const duration = player.getDuration();
    
    if (duration > 0) {
        const progress = (currentTime / duration) * 100;
        const progressFill = document.getElementById('progressFill');
        const currentTimeEl = document.getElementById('currentTime');
        const totalTimeEl = document.getElementById('totalTime');
        
        if (progressFill) {
            progressFill.style.width = progress + '%';
        }
        
        if (currentTimeEl) {
            currentTimeEl.textContent = formatDuration(Math.floor(currentTime));
        }
        
        if (totalTimeEl) {
            totalTimeEl.textContent = formatDuration(Math.floor(duration));
        }
    }
    
    if (isPlaying) {
        setTimeout(updateProgress, 100);
    }
}

// Progress Bar Click
document.addEventListener('click', function(e) {
    if (e.target.closest('#progressBar')) {
        const progressBar = document.getElementById('progressBar');
        const rect = progressBar.getBoundingClientRect();
        const pos = (e.clientX - rect.left) / rect.width;
        
        if (player && player.getDuration) {
            const seekTime = pos * player.getDuration();
            player.seekTo(seekTime);
        }
    }
});

// Helper Functions
function eredmenyVisszahoz() {
    // Scroll to results if needed
    const eredmeny = document.getElementById('eredmeny');
    eredmeny.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
}

function eredmenyTorol() {
    // Clear results if needed
}

// Log user data (from original)
console.log('Token:', localStorage.getItem("token"));
console.log('Email:', localStorage.getItem("email"));
console.log('Class:', localStorage.getItem("user_class"));
console.log('Admin:', localStorage.getItem("isadmin"));
