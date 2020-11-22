<?php declare(strict_types=1);

require __DIR__.'/vendor/autoload.php';

return function () {
    require __DIR__ . '/bench.php';

    return 'Hello world';
};
