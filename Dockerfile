FROM library/debian

copy source.list /etc/apt/sources.list

RUN      apt-get update \
         && apt-get install -y cron \
         && /etc/init.d/cron start \
         && apt-get install -y apt-transport-https lsb-release ca-certificates apache2 wget\
         && wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg\
         && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" |  tee /etc/apt/sources.list.d/php.list \
         && apt-get update\
         && apt-get install -y php7.1 supervisor php7.1-gd php7.1-zip php7.1-mbstring php7.1-dom php7.1-curl  php7.1-pdo-mysql\
         && wget https://getcomposer.org/download/1.6.2/composer.phar\
         && mv composer.phar /usr/local/bin/composer\
         && chmod +x /usr/local/bin/composer\
         && composer config -g repo.packagist composer https://packagist.phpcomposer.com \
             && composer global require "laravel/installer" \
         && a2enmod rewrite
