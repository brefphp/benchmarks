Benchmarks for [Bref](https://github.com/brefphp/bref) running on AWS Lambda.

## Scenarios

- PHP function: a simple PHP function, see `php-function/index.php`
- HTTP application: a simple PHP script that returns `Hello world`, see `http-application/index.php`

## Average (warm) execution time

Average execution time for a lambda that doesn't do anything.

Number of samples: 100-200

|                  | 128   | 512  | 1024 | 2048 |
|------------------|------:|-----:|-----:|-----:|
| PHP function     | 210ms | 42ms | 18ms | 15ms |
| HTTP application |  11ms |  3ms |  1ms |  1ms |
| Symfony          | 115ms | 15ms |  7ms |  7ms |

For comparison on a 512M Digital Ocean droplet we get 1ms for "HTTP application" and 6ms for Symfony.

## CPU performance

The more RAM, the more CPU power is allocated to the lambda. This is clearly visible when running [PHP's official `bench.php` script](https://github.com/php/php-src/blob/master/Zend/bench.php).

|                  | 128   | 512  | 1024 | 2048 |
|------------------|------:|-----:|-----:|-----:|
| `bench.php`      |  6.4s | 1.6s | 0.73s | 0.37s |

For comparison  `bench.php` runs in 1.3s on a 512M Digital Ocean droplet, in 0.8s on a 2.8Ghz i7 and in 0.6s on a 3.2Ghz i5.

## Cold starts

Number of samples: 20

|                  | 128   | 512   | 1024  | 2048  |
|------------------|------:|------:|------:|------:|
| PHP function     | 600ms | 280ms | 225ms | 215ms |
| HTTP application | 500ms | 270ms | 270ms | 215ms |
| Symfony          |  5.6s |  1.7s | 850ms | 550ms |

Notes:

- Symfony's cold start is high at the moment because we do not pre-generate the cache before deploying (it is generated on the first hit). This is an optimization that is planned.

## Reproducing

You will need [to install dependencies of Bref](https://bref.sh/docs/installation.html). Then:

- clone the repository
- create a S3 bucket in `us-east-2` and change the bucket name in `Makefile` (replace it with yours)
- `make deploy`
- `make bench-coldstarts`
- `make bench-warm`
