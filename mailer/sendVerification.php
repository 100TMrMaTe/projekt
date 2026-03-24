<?php
//repa qaey hhhy zxnw
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require_once __DIR__ . "/../PHPMailer-master/src/PHPMailer.php";
require_once __DIR__ . "/../PHPMailer-master/src/SMTP.php";
require_once __DIR__ . "/../PHPMailer-master/src/Exception.php";

$config = require __DIR__ . "/../config.php";

function sendVerificationEmail($toEmail, $token,  array $config)
{

    $verifyLink = $config['domains']['regemail'] . $token;

    $mail = new PHPMailer(true);

    try {
        $mail->isSMTP();
        $mail->Host       = 'smtp.gmail.com';
        $mail->SMTPAuth   = true;
        $mail->Username   = $config['mail']['username'];
        $mail->Password   = $config['mail']['password'];
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
        $mail->Port       = 587;
        $mail->CharSet = 'UTF-8_hungarian_ci';

        $mail->setFrom($config['mail']['from'], 'regisztaracio');
        $mail->addAddress($toEmail);

        $mail->isHTML(true);
        $mail->Subject = "Email megerősites Sulis rendszer";

        $mail->Body = "
            <p>Kérlek erősítsd meg az emailed az alábbi linken:</p>
            <p><a href='$verifyLink'>Email megerősítése</a></p>
            <p>Ha nem te regisztráltál, hagyd figyelmen kívül.</p>
            <p>Köszönjük!</p>";


        $mail->send();
        return true;
    } catch (Exception $e) {
        return false;
    }
}

function confirmReg($toEmail, array $config)
{
    $mail = new PHPMailer(true);

    try {
        $mail->isSMTP();
        $mail->Host       = 'smtp.gmail.com';
        $mail->SMTPAuth   = true;
        $mail->Username   = $config['mail']['username'];
        $mail->Password   = $config['mail']['password'];
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
        $mail->Port       = 587;
        $mail->CharSet = 'UTF-8_hungarian_ci';

        $mail->setFrom($config['mail']['from'], 'regisztraciod elfogadva');
        $mail->addAddress($toEmail);

        $mail->isHTML(true);
        $mail->Subject = "Regisztraciod elfogadasara kerult";

        $mail->Body = "<p>Regisztrációd elfogadásra került. Most már bejelentkezhetsz az oldalunkra.</p>
                       <p>Köszönjük, hogy csatlakoztál hozzánk!</p>";


        $mail->send();
        return true;
    } catch (Exception $e) {
        return false;
    }
}

function denyreg($toEmail, array $config)
{
    $mail = new PHPMailer(true);

    try {
        $mail->isSMTP();
        $mail->Host       = 'smtp.gmail.com';
        $mail->SMTPAuth   = true;
        $mail->Username   = $config['mail']['username'];
        $mail->Password   = $config['mail']['password'];
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
        $mail->Port       = 587;
        $mail->CharSet = 'UTF-8_hungarian_ci';

        $mail->setFrom($config['mail']['from'], 'regisztraciod elfogadva');
        $mail->addAddress($toEmail);

        $mail->isHTML(true);
        $mail->Subject = "Regisztraciod elutasitva";

        $mail->Body = "<p>Regisztrációd elutasításra került.</p>
                       <p>Ha úgy gondolod, hogy ez hiba, kérlek vedd fel velünk a kapcsolatot.</p>
                       <p>Köszönjük, hogy érdeklődtél az oldalunk iránt!</p>";


        $mail->send();
        return true;
    } catch (Exception $e) {
        return false;
    }
}

function sendPasswordResetEmail($toEmail, $token, array $config)
{
    $verifyLink = $config['domains']['passwordemail'] . $token;

    $mail = new PHPMailer(true);

    try {
        $mail->isSMTP();
        $mail->Host       = 'smtp.gmail.com';
        $mail->SMTPAuth   = true;
        $mail->Username   = $config['mail']['username'];
        $mail->Password   = $config['mail']['password'];
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
        $mail->Port       = 587;
        $mail->CharSet = 'UTF-8_hungarian_ci';

        $mail->setFrom($config['mail']['from'], 'elfelejtett jelszo');
        $mail->addAddress($toEmail);

        $mail->isHTML(true);
        $mail->Subject = "Jelszo visszaallitasa";

        $mail->Body = "
            <p>A jelszavad visszaállításához kattints az alábbi linkre:</p>
            <p><a href='$verifyLink'>Jelszó visszaállítása</a></p>
            <p>Ha nem te Kértél új jelszot, hagyd figyelmen kívül.</p>
            <p>Köszönjük!</p>";


        $mail->send();
        return true;
    } catch (Exception $e) {
        return false;
    }
}