Benchmarks for [Bref](https://github.com/brefphp/bref) running on AWS Lambda.

## Scenarios

This benchmark has been runned with the following peaces of software:
- Bref version: 0.29.0
- Lambda Runtime: Amazon Linux 1

Perfomances may be have been improved by AWS or php since last time the benchmark has been runned.
:warning: : be careful to no run this benchmark on you own production AWS account as it could have an impact on your limits depending if you have applied some reserved concurrency policy on your deployed lambdas.

- PHP function: a simple PHP function, see `php-function/index.php`
- HTTP application: a simple PHP script that returns `Hello world`, see `http-application/index.php`

## Average (warm) execution time

Average execution time for a lambda that doesn't do anything.

Number of samples: 1200

### php 7.4.8

|                  |   128 |   512 |  1024 |  1792 |  2048 |  3000 |
|------------------|------:|------:|------:|------:|------:|------:|
| PHP function     | 173ms |  32ms |  17ms |  15ms |  15ms |  15ms |
| HTTP application | 1.2ms | 1.1ms | 1.1ms | 1.1ms | 1.1ms | 1.1ms |
| Symfony          |  50ms | 5.4ms | 5.4ms | 5.4ms | 5.4ms | 5.4ms |

For comparison on a 512M Digital Ocean droplet we get 1ms for "HTTP application" and 6ms for Symfony.

## CPU performance

The more RAM, the more CPU power is allocated to the lambda. This is clearly visible when running [PHP's official `bench.php` script](https://github.com/php/php-src/blob/master/Zend/bench.php).

### php 7.4.8

|             |  128 |  512 |  1024 |  1792 |  2048 |  3000 |
|-------------|-----:|-----:|------:|------:|------:|------:|
| `bench.php` | 6.9s | 1.7s | 0.85s | 0.49s | 0.49s | 0.49s |

For comparison  `bench.php` runs in 1.3s on a 512M Digital Ocean droplet, in 0.8s on a 2.8Ghz i7 and in 0.6s on a 3.2Ghz i5.

## Cold starts

Number of samples: 20

### php 7.4.8

|                  |   128 |   512 |  1024 |  1792 |  2048 |  3000 |
|------------------|------:|------:|------:|------:|------:|------:|
| PHP function     | 419ms | 229ms | 175ms | 110ms | 100ms | 224ms |
| HTTP application | 301ms | 226ms | 240ms | 235ms | 206ms | 239ms |
| Symfony          | 1.53s |  448s | 370ms | 280ms | 320ms | 295ms |

## Reproducing

You will need [to install dependencies of Bref](https://bref.sh/docs/installation.html) + [AWS sam cli](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html) Then:

- clone the repository
- create a S3 bucket in `us-east-2` and change the bucket name in `Makefile` (replace it with yours)
- `make deploy`
- change the api gateway endpoint by yours in benchmark-http.sh & benchmark-coldstarts.sh
- `make bench-cold-starts`
- `make bench-function bench-http`
- `make bench-phpbench`
