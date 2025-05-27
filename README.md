Benchmarks for [Bref](https://github.com/brefphp/bref) running on AWS Lambda.

## Scenarios

- PHP function: a simple PHP function, see `function/index.php`
- HTTP application: a simple PHP web page that returns `Hello world`, see `fpm/index.php`

## Median (warm) execution time

Average execution time for a lambda that doesn't do anything.

Number of samples: 900

### Bref 3.x (PHP 8.3)

| Memory                       |   128 |  512 | 1024 | 1769 |
|------------------------------|------:|-----:|-----:|-----:|
| PHP function                 | 170ms | 32ms | 16ms | 16ms |
| PHP function (BREF_LOOP_MAX) |       |      |  1ms |  1ms |
| HTTP application             |   2ms |  2ms |  2ms |  2ms |
| Laravel                      |       |      | 28ms |      |

### Bref 3.x ARM (PHP 8.3)

| Memory                       |   128 |  512 | 1024 | 1769 |
|------------------------------|------:|-----:|-----:|-----:|
| PHP function                 | 160ms | 16ms | 15ms | 15ms |
| PHP function (BREF_LOOP_MAX) |       |      |  1ms |  1ms |
| HTTP application             |   2ms |  2ms |  2ms |  2ms |
| Laravel                      |       |      | 44ms |      |

For comparison on a 512M Digital Ocean droplet we get 1ms for "HTTP application" and 6ms for Symfony.

## CPU performance

The more RAM, the more CPU power is allocated to the lambda. This is clearly visible when running [PHP's official `bench.php` script](https://github.com/php/php-src/blob/master/Zend/bench.php).

| Memory      |  128 |  512 |  1024 |  1769 |
|-------------|-----:|-----:|------:|------:|
| `bench.php` | 5.7s | 1.4s | 0.65s | 0.33s |

For comparison  `bench.php` runs in 1.3s on a 512M Digital Ocean droplet, in 0.8s on a 2.8Ghz i7 and in 0.6s on a 3.2Ghz i5.

## Cold starts

Number of samples: 20

High level learnings:

- Don't use less than 512M of memory
- Cold starts are not faster on ARM, they are same or slightly slower
- Containers have the fastest cold starts
- When using containers, you need to warm up the first requests following a deployment

Comparison (1024M):

|                    | x86 container | x86 layer | ARM layer |
|--------------------|--------------:|----------:|----------:|
| HTTP (duration)    |         190ms |     300ms |     280ms |
| HTTP (latency)     |         370ms |     520ms |     520ms |
| Laravel (duration) |         850ms |    1250ms |    1210ms |
| Function           |         175ms |     230ms |     200ms |

### Bref 3.x containers (PHP 8.3)

Note: the first cold starts are much slower (see https://aaronstuyvenberg.com/posts/containers-on-lambda), e.g. 5s, because the container cache is warming up. In production warm up Lambda after deploying.

Function duration:

| Memory           |  1024 |
|------------------|------:|
| PHP function     | 145ms |
| HTTP application | 180ms |
| Laravel          | 960ms |

Total latency (measured from API Gateway or X-Ray):

| Memory           |   1024 |
|------------------|-------:|
| PHP function     |        |
| HTTP application |  340ms |
| Laravel          | 1110ms |

### Bref 3.x (PHP 8.3)

Function duration:

| Memory           |   128 |   512 |   1024 |  1769 |
|------------------|------:|------:|-------:|------:|
| PHP function     | 480ms | 260ms |  230ms | 220ms |
| HTTP application | 480ms | 335ms |  305ms | 300ms |
| Laravel          |       |       | 1250ms |       |

Total latency (measured from API Gateway or X-Ray):

| Memory           |   128 |   512 |   1024 |  1769 |
|------------------|------:|------:|-------:|------:|
| PHP function     | 700ms | 430ms |  440ms | 410ms |
| HTTP application | 660ms | 525ms |  475ms | 535ms |
| Laravel          |       |       | 1480ms |       |

### Bref 3.x ARM (PHP 8.3)

Function duration:

| Memory           |   128 |   512 |   1024 |  1769 |
|------------------|------:|------:|-------:|------:|
| PHP function     | 410ms | 215ms |  200ms | 195ms |
| HTTP application | 450ms | 300ms |  280ms | 275ms |
| Laravel          |       |       | 1210ms |       |

Total latency (measured from API Gateway or X-Ray):

| Memory           |   128 |   512 |   1024 |  1769 |
|------------------|------:|------:|-------:|------:|
| PHP function     | 670ms | 470ms |  430ms | 430ms |
| HTTP application | 670ms | 550ms |  520ms | 530ms |
| Laravel          |       |       | 1500ms |       |

Measuring cold starts in CloudWatch Logs Insights:

```
filter @type = “REPORT” and @initDuration > 0
| stats
 count(@type) as count,
 min(@billedDuration) as min,
 avg(@billedDuration) as avg,
 pct(@billedDuration, 50) as p50,
 max(@billedDuration) as max
by @log
| sort @log
```

## Reproducing

You will need [to install dependencies of Bref](https://bref.sh/docs/installation.html). Then:

- clone the repository
- `make setup`
- `make deploy`

Then run the `make bench-*` commands.
