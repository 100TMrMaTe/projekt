<?php
return [
    'domains' => [
        'regemail'      => 'https://'.$_SERVER['SERVER_NAME'].'/suc_reg/index.html?email_token=',
        'passwordemail' => 'https://'.$_SERVER['SERVER_NAME'].'/forgot/index.html?token=',
    ],
    'admin' => [
        'id' => 96,
    ],
    'mail' => [
        'username' => 'konyhasimatemail@gmail.com',
        'password' => 'repa qaey hhhy zxnw', // ideálisan .env-ből
        'from'     => 'konyhasimatemail@gmail.com',
    ],
    'db' => [
        'host' => 'localhost',
        'dbname' => 'projekt',
        'username' => 'root',
        'password' => 'admin',
    ],
];
