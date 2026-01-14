function kuldes() {
    let nev = document.getElementById("nev").value;
    let email = document.getElementById("email").value;
    let = password = document.getElementById("password").value;
    let class = document.getElementById("class").value;
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