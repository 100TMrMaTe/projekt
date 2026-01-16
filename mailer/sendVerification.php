<?php
//repa qaey hhhy zxnw
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require_once __DIR__ . "/../PHPMailer-master/src/PHPMailer.php";
require_once __DIR__ . "/../PHPMailer-master/src/SMTP.php";
require_once __DIR__ . "/../PHPMailer-master/src/Exception.php";

function sendVerificationEmail($toEmail, $token)
{

    $verifyLink = "http://localhost/suliscucc/projekt/suc_reg/suc_reg.html?email_token=$token";

    $mail = new PHPMailer(true);

    try {
        $mail->isSMTP();
        $mail->Host       = 'smtp.gmail.com';
        $mail->SMTPAuth   = true;
        $mail->Username   = 'konyhasimatemail@gmail.com';
        $mail->Password   = 'repa qaey hhhy zxnw';
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
        $mail->Port       = 587;

        $mail->setFrom('konyhasimatemail@gmail.com', 'regisztaracio');
        $mail->addAddress($toEmail);

        $mail->isHTML(true);
        $mail->Subject = "Email megerosites Sulis rendszer";

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
