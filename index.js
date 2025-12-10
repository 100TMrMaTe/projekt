function kuldes() {
    nev = document.getElementById("nev").value;
    osztaly = document.getElementById("osztaly").value;
    email = document.getElementById("email").value;
    password = document.getElementById("password").value;

    fetch("reg", {
        method: "POST",
        body: JSON.stringify({
            nev: nev,
            osztaly: osztaly,
            email: email,
            password: password,
        }),
    })
        .then((x) => x.json())
        .then((valasz) => {
            document.getElementById("nev").value = "";
            document.getElementById("osztaly").value = "";
            document.getElementById("email").value = "";
            document.getElementById("password").value = "";
            console.log(valasz)
            if (valasz.sulisemail) {
                alert(valasz.sulisemail);
            } else if (valasz.success) {
                alert("Sikeres regisztráció! Várj az admin jóváhagyására.");
            }
        });
}

function belepes() {
    email = document.getElementById("email").value;
    password = document.getElementById("password").value;

    fetch("login", {
        method: "POST",
        body: JSON.stringify({
            email: email,
            password: password,
        }),
    })
        .then((x) => x.json())
        .then((valasz) => {
            console.log(valasz);
            document.getElementById("email").value = "";
            document.getElementById("password").value = "";
            if (valasz.status == "success") {
                window.location.href = "http://localhost/suliscucc/projekt/mainpage.html";
            }
            else {
                alert(valasz.message);
            }
        });
}

function adminget() {
    fetch("adminpage")
        .then(x => x.json())
        .then(y => {
            //console.log(y);
            document.getElementById("reg").innerHTML = "";
            document.getElementById("log").innerHTML = "";
            document.getElementById("users").innerHTML = "";
            y.reg.forEach(elem => {
                document.getElementById("reg").innerHTML += regtabla(elem.id, elem.user_name, elem.user_class);
            });
            y.users.forEach(elem => {
                document.getElementById("users").innerHTML += userstabla(elem.id, elem.user_name, elem.user_class);
            });
            y.log.forEach(elem => {
                document.getElementById("log").innerHTML += logtabla(elem.user_name, elem.user_class, elem.datum);
            });
        })
}

function regtabla(id, nev, osztaly) {
    return `<li class="list-group-item d-flex justify-content-between align-items-center bg-dark text-white">
                <div class="d-flex flex-column">
                    <strong>${nev}</strong>
                    <span>${osztaly}</span>
                </div>
                <div class="d-flex gap-2">
                    <button class="btn btn-danger btn-sm" onclick="removereg(${id})">Elutasít</button>
                    <button class="btn btn-success btn-sm" onclick="approvereg(${id})">Jóváhagy</button>
                </div>
            </li>`;
}

function userstabla(id, nev, osztaly) {

    return `<li class="list-group-item d-flex justify-content-between align-items-center bg-dark text-white">
                <div class="d-flex flex-column">
                    <strong>${nev}</strong>
                    <span>${osztaly}</span>
                </div>
                <div class="d-flex gap-2">
                    <button class="btn btn-danger btn-sm text-white" onclick="removeusers(${id})">Törlés</button>
                </div>
            </li>`;
}

function logtabla(nev, osztaly, datum) {
    return `<li class="list-group-item bg-dark text-white">
                <div class="d-flex flex-column">
                    <strong>${nev} / ${osztaly}</strong>
                    <span>${datum}</span>
                </div>
            </li>`;
}

function removereg(id) {
    fetch("removereg", {
        method: "DELETE",
        body: JSON.stringify({
            id: id
        }),
    })
        .then((x) => x.json())
        .then((valasz) => {
            //console.log(valasz);
            adminget();
        });
}

function removeusers(id) {
    fetch("removeusers", {
        method: "DELETE",
        body: JSON.stringify({
            id: id
        }),
    })
        .then((x) => x.json())
        .then((valasz) => {
            //console.log(valasz);

            adminget();
        });
}

function approvereg(id) {
    fetch("approveuser", {
        method: "POST",
        body: JSON.stringify({
            id: id
        }),
    })
        .then((x) => x.json())
        .then((valasz) => {
            adminget();
        });
}