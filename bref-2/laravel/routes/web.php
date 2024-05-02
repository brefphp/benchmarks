<?php

use Illuminate\Support\Facades\Route;

Route::get('/1024', function () {
    return view('welcome');
});

Route::get('/1024-arm', function () {
    return view('welcome');
});

Route::get('/1024-container', function () {
    return view('welcome');
});
