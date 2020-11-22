Benchmarks for [Bref](https://github.com/brefphp/bref) running on AWS Lambda.

## Scenarios

- PHP function: a simple PHP function, see `php-function/index.php`
- HTTP application: a simple PHP script that returns `Hello world`, see `http-application/index.php`

## Average (warm) execution time

Average execution time for a lambda that doesn't do anything.

Number of samples: 900

|                  | 128   | 512  | 1024 | 2048 |
|------------------|------:|-----:|-----:|-----:|
| PHP function     | 175ms | 35ms | 17ms | 15ms |
| HTTP application |   1ms |  1ms |  1ms |  1ms |
| Symfony          |  45ms |  5ms |  5ms |  5ms |

For comparison on a 512M Digital Ocean droplet we get 1ms for "HTTP application" and 6ms for Symfony.

## CPU performance

The more RAM, the more CPU power is allocated to the lambda. This is clearly visible when running [PHP's official `bench.php` script](https://github.com/php/php-src/blob/master/Zend/bench.php).

|                  | 128   | 512  | 1024 | 2048 |
|------------------|------:|-----:|-----:|-----:|
| `bench.php`      |  5.7s | 1.4s | 0.65s | 0.33s |

For comparison  `bench.php` runs in 1.3s on a 512M Digital Ocean droplet, in 0.8s on a 2.8Ghz i7 and in 0.6s on a 3.2Ghz i5.

## Cold starts

Number of samples: 20

|                  | 128   | 512   | 1024  | 2048  |
|------------------|------:|------:|------:|------:|
| PHP function     | 430ms | 260ms | 230ms | 230ms |
| HTTP application | 415ms | 320ms | 320ms | 320ms |
| Symfony          |  6.0s |  1.7s | 950ms | 690ms |

Notes:

- Symfony's cold start is high at the moment because we do not pre-generate the cache before deploying (it is generated on the first hit). This is an optimization that is planned.

## Reproducing

You will need [to install dependencies of Bref](https://bref.sh/docs/installation.html). Then:

- clone the repository
- create a S3 bucket in `us-east-2` and change the bucket name in `Makefile` (replace it with yours)
- `make deploy`
- `make bench-cold-starts`
- `make bench-function`
- `make bench-http`
