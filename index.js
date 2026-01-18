function kuldes() {
  let user_name = document.getElementById("nev").value;
  let email = document.getElementById("email").value;
  let user_password = document.getElementById("password").value;
  let user_class = document.getElementById("osztaly").value;

  fetch("../index.php", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      muvelet: "registration",
      username: user_name,
      password: user_password,
      email: email,
      class: user_class,
    }),
  })
    .then((r) => r.json())
    .then((d) => {
      if (d.status == "success_registration") {
        document.getElementById("reg").classList.add("d-none");
        document.getElementById("suc_reg").classList.remove("d-none");
        document.getElementById("uzenet").innerText = d.message;
        document.getElementById("hosszuuzenet").innerText = d.long_message;
      } else if (d.status == "error_registration") {
        document.getElementById("reg").classList.add("d-none");
        document.getElementById("suc_reg").classList.remove("d-none");
        document.getElementById("uzenet").innerText = d.message;
        document.getElementById("hosszuuzenet").innerText = d.long_message;
      } else if (d.status == "error_sulisemail") {
        document.getElementById("reg").classList.add("d-none");
        document.getElementById("suc_reg").classList.remove("d-none");
        document.getElementById("uzenet").innerText = d.message;
        document.getElementById("hosszuuzenet").innerText = d.long_message;
      }
    });
}

function bgChange() {
  const bgImages = [
    "bg1.jpg",
    "bg2.jpg",
    "bg3.png",
    "bg4.jpg",
    "bg5.jpg",
    "bg6.jpg",
    "7.jpg",
    "8.jpg",
    "9.jpg",
    "10.jpg",
    "11.jpg",
    "12.jpg",
    "13.jpg",
    "14.jpg",
  ];
  const randomIndex = Math.floor(Math.random() * bgImages.length);
  document.body.style.backgroundImage = `url(${bgImages[randomIndex]})`;
  console.log("Background changed to: " + bgImages[randomIndex]);
}

function suc_reg() {
  const searchParams = new URLSearchParams(window.location.search);
  const emailToken = searchParams.get("email_token");

  fetch("../index.php", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      muvelet: "verified",
      email_token: emailToken,
    }),
  })
    .then((r) => r.json())
    .then((d) => {
      if (d.status === "success_verified") {
        document.getElementById("uzenet").innerText = "Sikeres regisztráció!";
        document.getElementById("hosszu_uzenet").innerText =
          "Köszönjük szépen!";
      } else if (d.status === "error_verified") {
        document.getElementById("uzenet").innerText =
          "Sikertelen regisztráció!";
        document.getElementById("hosszu_uzenet").innerText =
          "Valami nem volt jo!";
      }
    });
}

function adminpageLog() {
  fetch("adminpage", {
    method: "GET",
    headers: { "Content-Type": "application/json" },
  })
    .then((r) => r.json())
    .then((d) => {
      console.log(d);
      //irj ki mindent jo sorba mindent id alapjan adj meg foleg gombnak az id je legyen jo es ajanlom hogy innen irasd ki javascriptbol hozd letre oket a tablazatot
    });
}

function approveUser($id) {
  $id = document.getElementById($id).value;

  fetch("../index.php", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      muvelet: "approve_user",
      id: $id,
    }),
  })
    .then((r) => r.json())
    .then((d) => {
      console.log(d);
      //toltse be ujra az egesz oszlopot
    });
}

function denyUser($id) {
  $id = document.getElementById($id).value;

  fetch("../index.php", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      muvelet: "deny_user",
      id: $id,
    }),
  })
    .then((r) => r.json())
    .then((d) => {
      console.log(d);
      //toltse be ujra az egesz oszlopot
    });
}

function deleteUser($id) {
  $id = document.getElementById($id).value;

  fetch("../index.php", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      muvelet: "delete_user",
      id: $id,
    }),
  })
    .then((r) => r.json())
    .then((d) => {
      console.log(d);
      //toltse be ujra az egesz oszlopot
    });
}



