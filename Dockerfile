FROM digitalkreativ/docker-php7.1-cli-gnumeric
MAINTAINER Tom Sacré <github@digitalkreativ.com>

#COMPOSER
ADD ./install-composer.sh /var/install/

RUN ["chmod", "+x", "/var/install/install-composer.sh"]

RUN /var/install/install-composer.sh

# IMAGICK
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    libmagickwand-dev \
    && pecl install imagick-3.4.3 \
    && docker-php-ext-enable imagick \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# GHOSTSCRIPT
RUN apt-get update \
    && apt-get install -y \
    poppler-utils \
    ghostscript \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*


WORKDIR /var/www/
