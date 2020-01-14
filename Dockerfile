FROM library/debian:9

copy source.list /etc/apt/sources.list

RUN      apt-get update \
         && apt-get install -y cron \
         && /etc/init.d/cron start \
         && apt-get install -y apt-transport-https lsb-release ca-certificates apache2 wget\
         && wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg\
         && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" |  tee /etc/apt/sources.list.d/php.list \
         && apt-get update\
         && apt-get install -y php7.4 supervisor php7.4-gd php7.4-zip php7.4-mbstring php7.4-dom php7.4-curl  php7.4-pdo-mysql php7.4-redis\
         && wget https://getcomposer.org/composer-stable.phar

         RUN apt-get install -y curl && curl -sS https://getcomposer.org/installer | php
         RUN mv composer.phar /usr/local/bin/composer
         RUN chmod +x /usr/local/bin/composer
         RUN composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/
         RUN composer global require "laravel/installer" \
         && a2enmod rewrite
