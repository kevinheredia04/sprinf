<?php

use Monolog\Handler\StreamHandler;
use Monolog\Logger;

try {
    // Start dotEnv instance.
    $dotenv = Dotenv\Dotenv::createImmutable(__DIR__ . './../');
    $dotenv->load();
    //var_dump($_ENV['DB_HOST']);
    // Configuration for Database
    define("DB_HOST", $_ENV['DB_HOST']);
    define("DB_USER", $_ENV['DB_USER']);
    define("DB_PASS", $_ENV['DB_PASSWORD']);
    define("DB_NAME", $_ENV['DB_NAME']);
} catch (\Throwable $th) {
  /*   if ($_ENV['ENVIRONMENT'] != "production") { */
        die($th->getMessage());
 /*    } else {
        $log = new Logger('App');
        $log->pushHandler(new StreamHandler(__DIR__ . './../../logs/errors.log', Logger::ERROR));

        $log->error($th->getMessage(), $th->getTrace());
    } */
}
