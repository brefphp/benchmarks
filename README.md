Benchmarks for [Bref](https://github.com/mnapoli/bref) running on AWS Lambda.

## Scenarios

- PHP function: a simple PHP function, see `php-function/index.php`
- HTTP application: a simple PHP script that returns `Hello world`, see `http-application/index.php`

## Minimum execution time

This is a measurement of the minimum execution time for a lambda that doesn't do anything.

Number of samples: 100-200

|                  | 128   | 512  | 1024 | 2048 |
|------------------|------:|-----:|-----:|-----:|
| PHP function     | 130ms | 32ms | 20ms | 17ms |
| HTTP application |  13ms |  5ms |  3ms |  2ms |

## CPU performance

The more RAM, the more CPU power is allocated to the lambda. This is clearly visible when running [PHP's official `bench.php` script](https://github.com/php/php-src/blob/master/Zend/bench.php).

|                  | 128   | 512  | 1024 | 2048 |
|------------------|------:|-----:|-----:|-----:|
| `bench.php`      |    6s | 1.8s | 0.8s | 0.4s |

## Cold starts

Number of samples: 20

|                  | 128   | 512   | 1024  | 2048  |
|------------------|------:|------:|------:|------:|
| PHP function     | 600ms | 280ms | 225ms | 215ms |
| HTTP application | 500ms | 270ms | 270ms | 215ms |

## Reproducing

You will need [to install dependencies of Bref](https://bref.sh/docs/installation.html). Then:

- clone the repository
- create a S3 bucket in `us-east-2` and change the bucket name in `Makefile` (replace it with yours)
- `make deploy`
- `make bench-coldstarts`
- `make bench-warm`
