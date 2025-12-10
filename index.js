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
                if(valasz.sulisemail)
                {
                    alert(valasz.sulisemail);
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
                document.getElementById("email").value = "";
                document.getElementById("password").value = "";
                if(valasz == "mehetsz")
                {
                    window.location.href = "http://localhost/suliscucc/projekt/mainpage.html";
                }
                else{
                    alert(valasz);
                }
        });
}

function get() {
    fetch("index.php")
        .then(x => x.json())
        .then(y => {
            console.log(y);
        })
}