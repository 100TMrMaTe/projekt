function kuldes() {
    let user_name = document.getElementById("nev").value;
    let email = document.getElementById("email").value;
    let user_password = document.getElementById("password").value;
    let user_class = document.getElementById("osztaly").value;

    fetch("index.php", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ username: user_name, password: password, email: email, class: user_class}),
    })
        .then((r) => r.json())
        .then((d) => {
            console.log(d);
        });
}

 function bgChange() {
            const bgImages = [
                'bg1.jpg',
                'bg2.jpg',
                'bg3.png',
                'bg4.jpg',
                'bg5.jpg',
                'bg6.jpg',
                '7.jpg',
                '8.jpg',
                '9.jpg',
                '10.jpg',
                '11.jpg',
                '12.jpg',
                '13.jpg',
                '14.jpg'
            ];
            const randomIndex = Math.floor(Math.random() * bgImages.length);
            document.body.style.backgroundImage = `url(${bgImages[randomIndex]})`;
            console.log("Background changed to: " + bgImages[randomIndex]);
        }