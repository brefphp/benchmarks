Benchmarks for [Bref](https://github.com/mnapoli/bref) running on AWS Lambda.

## Minimum execution time

Number of samples: 100

|              | 128   | 512  | 1024 | 2048 |
|--------------|-------|------|------|------|
| PHP function | 150ms | 43ms | 20ms | 19ms |
|              |       |      |      |      |

## Cold starts

Number of samples: 10

|              | 128   | 512   | 1024  | 2048  |
|--------------|-------|-------|-------|-------|
| PHP function | 860ms | 280ms | 250ms | 220ms |
|              |       |       |       |       |

## Reproducing

You will need [to install dependencies of Bref](https://bref.sh/docs/installation.html). Then:

- clone the repository
- `make setup`
- create a S3 bucket in `us-east-2` and change the bucket name in `Makefile` (replace it with yours)
- `make deploy`
- `make bench-coldstarts`
- `make bench-warm`
