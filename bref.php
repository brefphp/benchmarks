<?php

use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Server\RequestHandlerInterface;
use Zend\Diactoros\Response\EmptyResponse;

require __DIR__ . '/vendor/autoload.php';

$handler = new class implements RequestHandlerInterface
{
    public function handle(ServerRequestInterface $request) : ResponseInterface
    {
        return new EmptyResponse;
    }
};

$app = new \Bref\Application;
$app->httpHandler($handler);
$app->run();
