function init() {
  adminpageLog();
}

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
  fetch("../index.php?muvelet=adminpage", {
    method: "GET",
    headers: { "Content-Type": "application/json" },
  })
    .then((r) => r.json())
    .then((d) => {
      console.log(d);
      //ugy irasd ki hogy a gombnak oncliknek meghivod ezeket a fugvenyeket es az id-t atadod parameterkent
      if (d.status === "success_adminpage") {
        document.getElementById("reg").innerHTML = "";
        document.getElementById("users").innerHTML = "";
        document.getElementById("log").innerHTML = "";
        d.waitinglist.forEach((element) => {
          document.getElementById("reg").innerHTML += waitingApproval(
            element.id,
            element.email,
            element.user_class,
          );
        });
        d.approvedusers.forEach((element) => {
          if (element.isadmin == 1) {
            document.getElementById("users").innerHTML += usersAdmin(
              element.id,
              element.email,
              element.user_class,
            );
          } else {
            document.getElementById("users").innerHTML += usersNotAdmin(
              element.id,
              element.email,
              element.user_class,
            );
          }
        });
        d.log.forEach((element) => {
          document.getElementById("log").innerHTML += songlog(
            element.id,
            element.email,
            element.user_class,
            element.date,
            element.title,
          );
        });
      }
    });
}

function approveUser($id) {
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
      init();
      //toltse be ujra az egesz oszlopot
    });
}

function denyUser($id) {
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
      init();
      //toltse be ujra az egesz oszlopot
    });
}

function deleteUser($id) {
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
      init();
      //toltse be ujra az egesz oszlopot
    });
}
function makeAdmin($id) {
  fetch("../index.php", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      muvelet: "useradmin",
      id: $id,
    }),
  })
    .then((r) => r.json())
    .then((d) => {
      console.log(d);
      init();
      //toltse be ujra az egesz oszlopot
    });
}

function waitingApproval(id, email, user_class) {
  return `                        <li class="list-group-item">
                            <div class="container">
                                <div class="row">
                                    <div class="col-12 col-sm-6 col-md-12 col-xxl-6 min-w-0">
                                        <span id="email" class="d-block text-truncate">
                                            ${email}
                                        </span>
                                        osztály:
                                        <span id="osztaly">
                                            <b>
                                                ${user_class}
                                            </b>
                                        </span>
                                    </div>
                                    <div class="col-6 col-sm-3 col-md-6 col-xxl-3">
                                        <button class="btn btn-light text-white green float-end h-100" onclick="approveUser(${id})">
                                            elfogad
                                        </button>
                                    </div>
                                    <div class="col-6 col-sm-3 col-md-6 col-xxl-3">
                                        <button class="btn btn-light text-white red float-start h-100" onclick="denyUser(${id})">
                                            elutasít
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </li>`;
}

function usersAdmin(id, email, user_class, isadmin) {
  return `                        <li class="list-group-item">
                            <div class="container">
                                <div class="row">
                                    <div class="col-12 col-sm-6 col-md-12 col-xxl-6 min-w-0">
                                        <span id="email" class="d-block text-truncate">
                                            ${email}
                                        </span>
                                        <div class="d-flex flex-wrap column-gap-3">
                                            <div class="info-pair">
                                                osztály:
                                                <span id="osztaly"><b>${user_class}</b></span>
                                            </div>

                                            <div class="info-pair">
                                                admin:
                                                <span id="ido"><b>igen</b></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-6 col-sm-3 col-md-6 col-xxl-3">

                                    </div>
                                    <div class="col-6 col-sm-3 col-md-6 col-xxl-3">
                                        <button class="btn btn-light text-white red float-start h-100" onclick="deleteUser(${id})">
                                            törlés
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </li>`;
}

function usersNotAdmin(id, email, user_class, isadmin) {
  return `                        <li class="list-group-item">
                            <div class="container">
                                <div class="row">
                                    <div class="col-12 col-sm-6 col-md-12 col-xxl-6 min-w-0">
                                        <span id="email" class="d-block text-truncate">
                                            ${email}
                                        </span>
                                        <div class="d-flex flex-wrap column-gap-3">
                                            <div class="info-pair">
                                                osztály:
                                                <span id="osztaly"><b>${user_class}</b></span>
                                            </div>

                                            <div class="info-pair">
                                                admin:
                                                <span id="ido"><b>nem</b></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-6 col-sm-3 col-md-6 col-xxl-3">
                                        <button class="btn btn-light text-white green float-end h-100" onclick="makeAdmin(${id})">
                                            admin jog
                                        </button>
                                    </div>
                                    <div class="col-6 col-sm-3 col-md-6 col-xxl-3">
                                        <button class="btn btn-light text-white red float-start h-100" onclick="deleteUser(${id})">
                                            törlés
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </li>`;
}

function songlog(id, email, user_class, date, title) {
  return `                        <li class="list-group-item">
                            <div class="container">
                                <div class="row">
                                    <div class="col-12">
                                        <span id="cim">
                                            ${title}
                                        </span>
                                    </div>
                                    <div class="col-12 min-w-0">
                                        <span id="email" class="d-block text-truncate">
                                            ${email}
                                        </span>
                                        <div class="d-flex flex-wrap column-gap-3">
                                            <div class="info-pair">
                                                osztály:
                                                <span id="osztaly"><b>${user_class}</b></span>
                                            </div>

                                            <div class="info-pair">
                                                idő:
                                                <span id="ido"><b>${date}</b></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>`;
}

function sendEmail() {
  let email = document.getElementById("email1").value;

  fetch("../index.php", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      muvelet: "reset_password_request",
      email: email,
    }),
  })
    .then((r) => r.json())
    .then((d) => {
      if (d.status == "email_exists") {
        document.getElementById("forgot_email").classList.add("d-none");
        document.getElementById("forgot_sent").classList.remove("d-none");
      }
    });
}

function atiranyitas() {
  document.getElementById("login").classList.add("d-none");
  document.getElementById("forgot_email").classList.remove("d-none");
}


function newpassword() {
  let password = document.getElementById("password").value;
  const searchParams = new URLSearchParams(window.location.search);
  const token = searchParams.get("token");

  fetch("../index.php", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      muvelet: "reset_password",
      token: token,
      new_password: password,
    }),
  })
    .then((r) => r.json())
    .then((d) => {
      if (d.status == "success_reset_password") {
        window.location.href = "../login/login.html";
      }
    });
}

function errorTimer() {
  setTimeout(() => {
    document.getElementById("error").classList.add("d-none");
  }, 5000);
}

function login() {
  password = document.getElementById("password").value;
  email = document.getElementById("email").value;

  fetch("../index.php", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      muvelet: "login",
      password: password,
      email: email,
    }),
  })
    .then((r) => r.json())
    .then((d) => {
      console.log(d);
      if (d.status == "error_login_no_user") {
        //registraljal ||| vagy elirtad az email cimed
        document.getElementById("error-message").innerText = "Hibás email cím vagy még nem regisztráltál.";
        document.getElementById("error").classList.remove("d-none");
        errorTimer();
      } else if (d.status == "error_login_email_not_verified") {
        //email nem lett megerositve
        document.getElementById("error-message").innerText = "Az email címed nincs megerősítve.";
        document.getElementById("error").classList.remove("d-none");
        errorTimer();
      } else if (d.status == "error_login_not_approved") {
        //meg nincs elfogadva az admin altal
        document.getElementById("error-message").innerText = "A regisztrációdat még nem fogadta el egy adminisztrátor.";
        document.getElementById("error").classList.remove("d-none");
        errorTimer();
      } else if (d.status == "error_login_wrong_password") {
        console.log("rossz jelszo");
        //rossz jelszo
        document.getElementById("error").classList.remove("d-none");
        document.getElementById("error-message").innerText = "Hibás jelszó.";
        errorTimer();
      } else if (d.status == "success_login") {
        localStorage.setItem("token", d.token);
        localStorage.setItem("isadmin", d.isadmin);
        localStorage.setItem("email", d.email);
        localStorage.setItem("user_class", d.user_class);
        window.location.href = "../audio/audio.html";
      }
    });


}
