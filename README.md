Benchmarks for [Bref](https://github.com/mnapoli/bref) running on AWS Lambda.

## Scenarios

- PHP function: a simple PHP function, see `php-function/index.php`
- HTTP application: a simple PHP script that returns `Hello world`, see `http-application/index.php`

## Average execution time

Number of samples: 100-200

|                  | 128   | 512  | 1024 | 2048 |
|------------------|-------|------|------|------|
| PHP function     | 130ms | 32ms | 20ms | 17ms |
| HTTP application |  13ms |  5ms |  3ms |  2ms |

## Cold starts

Number of samples: 20

|                  | 128   | 512   | 1024  | 2048  |
|------------------|-------|-------|-------|-------|
| PHP function     | 600ms | 280ms | 225ms | 215ms |
| HTTP application | 500ms | 270ms | 270ms | 215ms |

## Reproducing

You will need [to install dependencies of Bref](https://bref.sh/docs/installation.html). Then:

- clone the repository
- `make setup`
- create a S3 bucket in `us-east-2` and change the bucket name in `Makefile` (replace it with yours)
- `make deploy`
- `make bench-coldstarts`
- `make bench-warm`
