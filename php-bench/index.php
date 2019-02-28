<?php declare(strict_types=1);

require __DIR__.'/vendor/autoload.php';

lambda(function () {
    require __DIR__ . '/bench.php';

    return 'Hello world';
});
