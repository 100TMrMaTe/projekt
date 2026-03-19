// ── Fejléc / auth inicializálás ──────────────────────────────────────────────
getMusicRequest();

if (localStorage.getItem("email") == null && localStorage.getItem("token") == null) {
    document.getElementById("headerfelhasznalonev").innerText = "Vendég";
    document.getElementById("timer").classList.add("d-none");
    document.getElementById("logoutbutton").style.display = "none";
    document.getElementById("fooldalbutton").style.display = "none";
} else {
    document.getElementById("headerfelhasznalonev").innerText = localStorage.getItem("email");
}

if (localStorage.getItem("isadmin") === "1") {
    document.getElementById("adminpagebutton").style.display = "inline-block";
} else {
    document.getElementById("adminpagebutton").style.display = "none";
}


let talalatok = [];
// ── Téma ─────────────────────────────────────────────────────────────────────

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

loadTheme();

// ── Timer ─────────────────────────────────────────────────────────────────────

let interval = null;
const DURATION = 30 * 60;
let totalSeconds = DURATION;

function updateDisplay() {
    const minutes = Math.floor(totalSeconds / 60);
    const seconds = totalSeconds % 60;

    document.getElementById("timer").textContent =
        String(minutes).padStart(2, "0") +
        ":" +
        String(seconds).padStart(2, "0");
}

function startTimer() {
    clearInterval(interval);

    totalSeconds = DURATION;
    updateDisplay();

    interval = setInterval(() => {
        if (totalSeconds > 0) {
            totalSeconds--;
            updateDisplay();
        } else {
            clearInterval(interval);
            interval = null;
            alert("Lejárt az idő!");
        }
    }, 1000);
}

startTimer();
document.body.addEventListener("click", startTimer);
document.body.addEventListener("click", tokenRefresh);

updateDisplay();


function insertIntoMusicRequest(musicId) {
    return fetch("../index.php", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
            muvelet: "insertIntoMusicRequest",
            music_id: musicId,
        }),
    });
}

// ── Auth függvények ───────────────────────────────────────────────────────────

function logout() {
    fetch("../index.php", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
            muvelet: "logout",
            token: localStorage.getItem("token"),
        }),
    })
        .then((response) => response.json())
        .then((data) => {
            localStorage.clear();
            window.location.href = "../login/login.html";
        })
        .catch((error) => console.error("Error refreshing token:", error));
}

function tokenRefresh() {
    if (!localStorage.getItem("token")) {
        return;
    }
    fetch("../index.php", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
            muvelet: "tokenRefresh",
            token: localStorage.getItem("token"),
        }),
    })
        .then((response) => response.json())
        .then((data) => {
            if (data.status != "success_token_refresh") {
                localStorage.clear();
                window.location.href = "../login/login.html";
            }
        })
        .catch((error) => console.error("Error refreshing token:", error));
}

// ── Idő / segédfüggvények ─────────────────────────────────────────────────────

function ido() {
    let jelenlegi = Math.floor(seekSlider.value);
    let teljes = Math.floor(hossz);
    let perc = Math.floor(jelenlegi / 60);
    let masodperc = Math.floor(jelenlegi % 60);
    let ora = Math.floor(perc / 60);

    let teljesPerc = Math.floor(teljes / 60);
    let teljesMasodperc = Math.floor(teljes % 60);
    let teljesOra = Math.floor(teljesPerc / 60);

    let jelenlegiIdo = document.getElementById("jelenlegiIdo");
    let egeszIdo = document.getElementById("egeszIdo");

    if (teljesOra > 0) {
        teljesPerc = teljesPerc % 60;
    }

    if (teljesOra === 0) {
        egeszIdo.innerText = `${teljesPerc}:${teljesMasodperc < 10 ? "0" : ""}${teljesMasodperc}`;
    }

    if (teljesOra != 0) {
        if (teljesPerc < 10) {
            egeszIdo.innerText =
                `${teljesOra}:` +
                `0` +
                `${teljesPerc}:${teljesMasodperc < 10 ? "0" : ""}${teljesMasodperc}`;
        }
        egeszIdo.innerText = `${teljesOra}:${teljesPerc}:${teljesMasodperc < 10 ? "0" : ""}${teljesMasodperc}`;
    }

    if (ora > 0) {
        perc = perc % 60;
    }

    if (ora === 0) {
        jelenlegiIdo.innerText = `${perc}:${masodperc < 10 ? "0" : ""}${masodperc}`;
    }
    if (ora != 0) {
        if (perc < 10) {
            jelenlegiIdo.innerText =
                `${ora}:` +
                `0` +
                `${perc}:${masodperc < 10 ? "0" : ""}${masodperc}`;
        } else {
            jelenlegiIdo.innerText = `${ora}:${perc}:${masodperc < 10 ? "0" : ""}${masodperc}`;
        }
    }
}

function keresettVideoIdo(seconds) {
    if (seconds === "LIVE") {
        return "LIVE";
    }
    let perc = Math.floor(seconds / 60);
    let masodperc = Math.floor(seconds % 60);
    let ora = Math.floor(perc / 60);
    if (ora > 0) {
        perc = perc % 60;
    }

    if (ora === 0) {
        return `${perc}:${masodperc < 10 ? "0" : ""}${masodperc}`;
    }

    if (ora != 0 && perc < 10) {
        return (
            `${ora}:` + `0` + `${perc}:${masodperc < 10 ? "0" : ""}${masodperc}`
        );
    }
    return `${ora}:${perc}:${masodperc < 10 ? "0" : ""}${masodperc}`;
}

function videoHosszAtAlakit(alakito) {
    if (alakito === null) {
        return 0;
    }

    const regex = /PT(?:(\d+)H)?(?:(\d+)M)?(?:(\d+)S)?/;
    const illik = alakito.match(regex);

    if (!illik) {
        return 0;
    }

    const ora = parseInt(illik[1]) || 0;
    const perc = parseInt(illik[2]) || 0;
    const masodperc = parseInt(illik[3]) || 0;
    return ora * 3600 + perc * 60 + masodperc;
}


function eredmenyVisszahoz() {
    document.getElementById("eredmenyDoboz").classList.remove("d-none");
}


function eredmenyTorol() {
    document.getElementById("eredmenyDoboz").classList.add("d-none");
}

// ── Keresés (YouTube API) ─────────────────────────────────────────────────────








 function embedSearchItem(videoId, title, duration) {
			return `<div class="row mb-2 p-2 rounded video talalat">
                        <div class="col-4">
                            <img src="https://img.youtube.com/vi/${videoId}/mqdefault.jpg" class="img-fluid rounded"/>
                        </div>
                        <div class="col-8 text-light">
                            <h2 class="text-truncate">${title} </h2>
                            <h3>${keresettVideoIdo(duration)}</h3>
                        </div>
                    </div>`;
		}




function keres() {
    const search = document.getElementById("search").value;
    const eredmeny = document.getElementById("eredmeny");

    if (search.length < 3) {
        eredmeny.innerHTML = "<p>Írj be legalább 3 karaktert...</p>";
        return;
    }

    eredmeny.innerHTML = "<p>Keresés folyamatban...</p>";

    const apikulcs2 = "AIzaSyAjhNmbvJwzwac3JK-UxQFId23xWsn10-E";
    const URL = `https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&mqdefault=5&q=${encodeURIComponent(search)}&key=${apikulcs2}`;

    function lekerVideok(vissza) {
        fetch(URL)
            .then((valasz) => valasz.json())
            .then((adatok) => {
                const videoIds = adatok.items
                    .map((item) => item.id.videoId)
                    .join(",");

                const detailsURL =
                    `https://www.googleapis.com/youtube/v3/videos` +
                    `?part=contentDetails` +
                    `&id=${videoIds}` +
                    `&key=${apikulcs2}`;

                fetch(detailsURL)
                    .then((v) => v.json())
                    .then((details) => {
                        const videok = adatok.items
                            .filter((item) => item.id.kind === "youtube#video")
                            .map((item, i) => ({
                                csatorna: item.id.kind,
                                videoId: item.id.videoId,
                                title: item.snippet.title,
                                img: item.snippet.thumbnails.medium.url,
                                nagyobbImg: item.snippet.thumbnails.high.url,
                                duration:
                                    videoHosszAtAlakit(
                                        details.items[i].contentDetails.duration,
                                    ) == 0
                                        ? "LIVE"
                                        : videoHosszAtAlakit(
                                            details.items[i].contentDetails.duration,
                                        ),
                                durationRaw: details.items[i].contentDetails.duration,
                            }))
                            .slice(0, 5);
                        vissza(videok);
                    });
            });
    }

    lekerVideok(function (videok) {
        eredmeny.innerHTML = "";

        if (!videok.length) {
            eredmeny.innerHTML = "<p>Nincs találat vagy hiba történt.</p>";
            return;
        }

        for (let i = 0; i < videok.length; i++) {
            let keret = document.createElement("div");
            keret.classList.add("container");

            let talalat = document.createElement("div");

            talalat.innerHTML = `
                    <div class="row mb-2 p-2 rounded video talalat">
                        <div class="col-4">
                            <img src="${videok[i].img}"  class="img-fluid rounded"/>
                        </div>
                        <div class="col-8 text-light">
                            <h2 class="text-truncate">${videok[i].title} </h2>
                            <h2>${keresettVideoIdo(videok[i].duration)}</h2>
                        </div>
                    </div>
                    `;

            talalat.onclick = () => {
                eredmenyTorol();

                insertIntoMusic(
                    videok[i].videoId,
                    videok[i].title,
                    videok[i].duration,
                ).then((musicId) => insertIntoMusicRequest(musicId))
                    .then(() => {
                        getMusicRequest();
                    })
            };
            keret.appendChild(talalat);
            eredmeny.appendChild(keret);
        }
    });
}

function insertIntoMusic(videoId, title, length) {
    return fetch("../index.php", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
            muvelet: "insertIntoMusic",
            video_id: videoId,
            title: title,
            length: length,
        }),
    })
        .then((response) => response.json())
        .then((data) => data.music_id);

}

function getMusicRequest() {
    
   fetch("../index.php", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
            muvelet: "getMusicRequest",
        }),
    })
        .then((response) => response.json())
        .then((data) => {
            console.log(data);
			data.music_request.forEach((e) => {
				document.getElementById("kedvencDoboz").innerHTML += kedvencKiir(
					e.video_id,
					e.title,
					e.length == 0 ? "LIVE" : e.length,
                    e.id
				);
			});
		});




}


function kivansagToPlaylist(id)
		{
			fetch("../index.php", {
				method: "POST",
				headers: { "Content-Type": "application/json" },
				body: JSON.stringify({
					muvelet: "insertIntoPlaylist",
					music_id: id,
					token: localStorage.getItem("token"),
				}),
			})
			.then((response) => response.json())
			.then((data) => {
                
			});
		}

        

function search() {
			fetch("../index.php", {
				method: "POST",
				headers: {
					"Content-Type": "application/json",
				},
				body: JSON.stringify({
					muvelet: "search",
					search: document.getElementById("search").value,
				}),
			})
				.then((response) => response.json())
				.then((data) => {
					//console.log(data);

					let eredmeny = document.getElementById("eredmeny");
					let videok = data.results;

					eredmeny.innerHTML = "";

					//console.log("EREDMENY TOROLVE");

					if (!videok.length) {
						eredmeny.innerHTML = "<p>Nincs találat vagy hiba történt.</p>";
						return;
					}

					for (let i = 0; i < videok.length; i++) {
						let keret = document.createElement("div");
						keret.classList.add("container");

						let talalat = document.createElement("div");

						talalat.innerHTML = embedSearchItem(
							videok[i].video_id,
							videok[i].title,
							videok[i].length == 0 ? "LIVE" : videok[i].length,
						);

						//console.log(videok[i].video_id);

						talalat.onclick = () => {
							eredmenyTorol();

							insertIntoMusic(
								videok[i].video_id,
								videok[i].title,
								videok[i].length,
							).then((musicId) => insertIntoPlaylist(musicId));
						};

						keret.appendChild(talalat);
						eredmeny.appendChild(keret);
					}
				});
		}



       

document.getElementById("search")
    .addEventListener("keydown", function (e) {
        if (e.key === "Enter") {
            keres();
            search();
            eredmenyVisszahoz();
            
            //console.log("asdasd");
        }
    });

// ── Kedvencek ─────────────────────────────────────────────────────────────────

function kedvencKiir(videoId, title, duration, id) {

    if(localStorage.getItem("token") == null) {
        return `
        <li>
            <div class="row m-2 mb-1 p-2 rounded video talalat">
                <div class="col-4">
                    <img src="https://img.youtube.com/vi/${videoId}/mqdefault.jpg"
                        class="img-fluid rounded" />
                </div>
                <div class="col-8 text-light">
                    <h2 class="text-truncate">${title}</h2>
                    <h3>${keresettVideoIdo(duration)}</h3>
                </div>
            </div>
        </li>
    `;
    }
    else{
    return `
        <li>
            <div class="row m-2 mb-1 p-2 rounded video talalat">
                <div class="col-4">
                    <img src="https://img.youtube.com/vi/${videoId}/mqdefault.jpg"
                        class="img-fluid rounded" />
                </div>
                <div class="col-8 text-light">
                    <h2 class="text-truncate">${title}</h2>
                    <h3>${keresettVideoIdo(duration)}</h3>
                    <button class="btn btn-success w-100 action-btn" id="lejatszas" onclick="kivansagToPlaylist(${id})">
                        Lejátszás
                    </button>
                </div>
            </div>
        </li>
    `;
}
}