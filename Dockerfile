FROM    php:7.1.23-apache
COPY    .   /var/www/html/
RUN     docker-php-ext-install pdo_mysql  \
         &&  docker-php-ext-install mysqli \
         && docker-php-ext-enable mysqli
EXPOSE  80
CMD     ["apache2ctl", "-D", "FOREGROUND"]
