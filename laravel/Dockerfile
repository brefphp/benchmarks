FROM bref/php-83:3

ENV BREF_RUNTIME=fpm

COPY . /var/task
RUN rm -rf storage

CMD ["public/index.php"]
