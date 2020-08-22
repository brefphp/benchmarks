Benchmarks for [Bref](https://github.com/brefphp/bref) running on AWS Lambda.

## Scenarios

- PHP function: a simple PHP function, see `php-function/index.php`
- HTTP application: a simple PHP script that returns `Hello world`, see `http-application/index.php`

## Average (warm) execution time

Average execution time for a lambda that doesn't do anything.

Number of samples: 1200

current php runtime
|                  |   128 |  512 | 1024 | 1792 | 2048 | 3000 |
|------------------|------:|-----:|-----:|-----:|-----:|-----:|
| PHP function     | 175ms | 35ms | 16ms |  ?ms | 13ms |  ?ms |
| HTTP application |  10ms |  1ms |  1ms |  ?ms |  1ms |  ?ms |
| Symfony          |  58ms |  4ms |  4ms |  ?ms |  4ms |  ?ms |

lightweight php runtime
|                  |   128 |  512 |  1024 |  1792 |  2048 |  3000 |
|------------------|------:|-----:|------:|------:|------:|------:|
| PHP function     | 109ms | 18ms |  11ms |  11ms |  11ms |  11ms |
| HTTP application | 1.2ms |  1ms |   1ms |   1ms |   1ms |   1ms |
| Symfony          |  40ms |  5ms | 4.9ms | 4.9ms | 4.8ms | 4.8ms |

For comparison on a 512M Digital Ocean droplet we get 1ms for "HTTP application" and 6ms for Symfony.

## CPU performance

The more RAM, the more CPU power is allocated to the lambda. This is clearly visible when running [PHP's official `bench.php` script](https://github.com/php/php-src/blob/master/Zend/bench.php).

current php runtime
|             |  128 |  512 |  1024 | 1792 |  2048 | 3000 |
|-------------|-----:|-----:|------:|-----:|------:|-----:|
| `bench.php` | 5.7s | 1.4s | 0.65s |   ?s | 0.33s |   ?s |

lightweight php runtime
|             |  128 |   512 |  1024 |  1792 |  2048 |  3000 |
|-------------|-----:|------:|------:|------:|------:|------:|
| `bench.php` | 6.0s | 1.48s | 0.75s | 0.43s | 0.43s | 0.49s |

For comparison  `bench.php` runs in 1.3s on a 512M Digital Ocean droplet, in 0.8s on a 2.8Ghz i7 and in 0.6s on a 3.2Ghz i5.

## Cold starts

Number of samples: 20

current php runtime
|                  |   128 |   512 |  1024 | 1792 |  2048 | 3000 |
|------------------|------:|------:|------:|-----:|------:|-----:|
| PHP function     | 419ms | 140ms | 153ms |  ?ms | 141ms |  ?ms |
| HTTP application | 343ms | 228ms | 240ms |  ?ms | 239ms |  ?ms |
| Symfony          |  5.2s |  1.2s | 730ms |  ?ms | 527ms |  ?ms |

lightweight php runtime
|                  |   128 |   512 |  1024 |  1792 |  2048 |  3000 |
|------------------|------:|------:|------:|------:|------:|------:|
| PHP function     | 373ms |  70ms |  87ms | 132ms |  95ms |  51ms |
| HTTP application | 298ms | 216ms | 207ms | 220ms | 224ms | 223ms |
| Symfony          | 1.55s | 507ms | 359ms | 301ms | 302ms | 264ms |


## Reproducing

You will need [to install dependencies of Bref](https://bref.sh/docs/installation.html) + [AWS sam cli](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html) Then:

- clone the repository
- create a S3 bucket in `us-east-2` and change the bucket name in `Makefile` (replace it with yours)
- `make deploy`
- change the api gateway endpoint by yours in benchmark-http.sh & benchmark-coldstarts.sh
- `make bench-cold-starts`
- `make bench-function bench-http`
- `make bench-phpbench`
