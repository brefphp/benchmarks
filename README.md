Benchmarks for [Bref](https://github.com/mnapoli/bref) running on AWS Lambda.

## Scenarios

- PHP function: a simple PHP function, see `php-function/index.php`
- HTTP application: a simple PHP script that returns `Hello world`, see `http-application/index.php`

## Average (warm) execution time

Average execution time for a lambda that doesn't do anything.

Number of samples: 100-200

|                  | 128   | 512  | 1024 | 2048 |
|------------------|------:|-----:|-----:|-----:|
| PHP function     | 130ms | 32ms | 20ms | 17ms |
| HTTP application |  13ms |  5ms |  3ms |  2ms |
| Symfony          |  56ms | 12ms |  6ms |  5ms |

For comparison on a 512M Digital Ocean droplet we get 1ms for "HTTP application" and 6ms for Symfony.

## CPU performance

The more RAM, the more CPU power is allocated to the lambda. This is clearly visible when running [PHP's official `bench.php` script](https://github.com/php/php-src/blob/master/Zend/bench.php).

|                  | 128   | 512  | 1024 | 2048 |
|------------------|------:|-----:|-----:|-----:|
| `bench.php`      |    6s | 1.8s | 0.8s | 0.4s |

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

[CloudWatch dashboard URL](https://us-east-2.console.aws.amazon.com/cloudwatch/home?region=us-east-2#metricsV2:graph=~(metrics~(~(~'AWS*2fLambda~'Invocations~'FunctionName~'bref-benchmark-php-function-128~(stat~'Sum~yAxis~'right~period~900))~(~'.~'Duration~'.~'.~(stat~'Minimum~period~900))~(~'...~(stat~'Average~period~900))~(~'...~(stat~'Maximum~period~900))~(~'.~'Invocations~'.~'bref-benchmark-php-function-512~(stat~'Sum~yAxis~'right~period~900))~(~'.~'Duration~'.~'.~(stat~'Minimum~period~900))~(~'...~(stat~'Average~period~900))~(~'...~(stat~'Maximum~period~900))~(~'.~'Invocations~'.~'bref-benchmark-php-function-1024~(stat~'Sum~yAxis~'right~period~900))~(~'.~'Duration~'.~'.~(stat~'Minimum~period~900))~(~'...~(stat~'Average~period~900))~(~'...~(stat~'Maximum~period~900))~(~'.~'Invocations~'.~'bref-benchmark-php-function-2048~(stat~'Sum~yAxis~'right~period~900))~(~'.~'Duration~'.~'.~(stat~'Minimum~period~900))~(~'...~(stat~'Average~period~900))~(~'...~(stat~'Maximum~period~900))~(~'.~'Invocations~'.~'bref-benchmark-http-application-128~(period~900~stat~'Sum~yAxis~'right))~(~'.~'Duration~'.~'.~(period~900~stat~'Minimum))~(~'...~(period~900~stat~'Average))~(~'...~(period~900~stat~'Maximum))~(~'.~'Invocations~'.~'bref-benchmark-http-application-512~(period~900~stat~'Sum~yAxis~'right))~(~'.~'Duration~'.~'.~(period~900~stat~'Minimum))~(~'...~(period~900~stat~'Average))~(~'...~(period~900~stat~'Maximum))~(~'.~'Invocations~'.~'bref-benchmark-http-application-1024~(period~900~stat~'Sum~yAxis~'right))~(~'.~'Duration~'.~'.~(period~900~stat~'Minimum))~(~'...~(period~900~stat~'Average))~(~'...~(period~900~stat~'Maximum))~(~'.~'Invocations~'.~'bref-benchmark-http-application-2048~(period~900~stat~'Sum~yAxis~'right))~(~'.~'Duration~'.~'.~(period~900~stat~'Minimum))~(~'...~(period~900~stat~'Average))~(~'...~(period~900~stat~'Maximum))~(~'.~'Invocations~'.~'bref-benchmark-php-bench-128~(period~900~stat~'Sum~yAxis~'right~color~'*23c7c7c7))~(~'.~'Duration~'.~'.~(period~900~stat~'Minimum))~(~'...~(period~900~stat~'Average~color~'*232ca02c))~(~'...~(period~900~stat~'Maximum))~(~'.~'Invocations~'.~'bref-benchmark-php-bench-512~(period~900~stat~'Sum~yAxis~'right~color~'*23c7c7c7))~(~'.~'Duration~'.~'.~(period~900~stat~'Minimum~color~'*23d62728))~(~'...~(period~900~stat~'Average~color~'*232ca02c))~(~'...~(period~900~stat~'Maximum))~(~'.~'Invocations~'.~'bref-benchmark-php-bench-1024~(period~900~stat~'Sum~yAxis~'right~color~'*23c7c7c7))~(~'.~'Duration~'.~'.~(period~900~stat~'Minimum~color~'*23d62728))~(~'...~(period~900~stat~'Average~color~'*231f77b4))~(~'...~(period~900~stat~'Maximum~color~'*232ca02c))~(~'.~'Invocations~'.~'bref-benchmark-php-bench-2048~(period~900~stat~'Sum~yAxis~'right~color~'*23c7c7c7))~(~'.~'Duration~'.~'.~(period~900~stat~'Minimum~color~'*23d62728))~(~'...~(period~900~stat~'Average~color~'*231f77b4))~(~'...~(period~900~stat~'Maximum~color~'*232ca02c)))~view~'singleValue~stacked~false~region~'us-east-2~start~'-PT15M~end~'P0D~yAxis~(left~(min~0)~right~(min~0)));namespace=~'AWS*2fLambda;dimensions=~'FunctionName) to use to check out the metrics in one place.
