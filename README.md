Benchmark for Bref and AWS Lambda.

## Results

This is a comparison of the response time from an EC2 machine in the same region, on both a NodeJS lambda (`node.js`) and a PHP lambda (`bref.php`).

| Memory | Node lambda | PHP lambda |
|--------|-------------|------------|
| 128M   |             |            |
| 512M   |             |            |
| 1024M  |        20ms |       47ms |

## Reproducing

- clone the repository
- `composer install`
- `vendor/bin/bref deploy`

Start a EC2 machine in the same region and SSH into it.

- Install [wrk](https://github.com/wg/wrk): [instructions](https://github.com/wg/wrk/wiki/Installing-wrk-on-Linux#centos--redhat--fedora) (this is because `ab` [doesn't work](https://forums.aws.amazon.com/thread.jspa?threadID=193615))
- Benchmark using `wrk -t 1 -c 1 -d 5s <the-lambda-url>` (run twice or more to warmup)

To get the URL of the lambdas run `vendor/bin/bref info`.

Run benchmarks on both the `/php` URL and the `/node` URL to compare. Change the memory setting in `serverless.yml`, deploy again and benchmark again.
