## -*- docker-image-name: "scaleway/silverstripe:trusty" -*-
FROM scaleway/ubuntu:trusty
MAINTAINER Scaleway <opensource@scaleway.com> (@scaleway)

# Prepare rootfs for image-builder
RUN /usr/local/sbin/builder-enter

# Pre-seeding for postfix
RUN sudo su root -c "debconf-set-selections <<< \"postfix postfix/main_mailer_type string 'Internet Site'\"" \
  && sudo su root -c "debconf-set-selections <<< \"postfix postfix/mailname string localhost\""

# Install packages
RUN apt-get -q update     \
 && apt-get -q -y upgrade \
 && apt-get install -y -q \
	mailutils         \
	mysql-server-5.5  \
	php5              \
	php5-cli          \
	php5-fpm          \
	php5-gd           \
	php5-mcrypt       \
	php5-mysql        \
	php5-tidy         \
	php-apc           \
 	php-pear          \
  	curl              \
  	php5-curl         \
	pwgen             \
  	git               \
  	git-core          \
  	locales           \
	nginx             \
 && apt-get clean

# Uninstall apache
RUN apt-get -yq remove apache2

RUN echo "LANG=en_US.UTF-8\n" > /etc/default/locale && \
  echo "en_US.UTF-8 UTF-8\n" > /etc/locale.gen && \
  locale-gen


#  - Phpunit, Composer
RUN wget https://phar.phpunit.de/phpunit-3.7.37.phar && \
  chmod +x phpunit-3.7.37.phar && \
  mv phpunit-3.7.37.phar /usr/local/bin/phpunit && \
  wget https://getcomposer.org/composer.phar && \
  chmod +x composer.phar && \
  mv composer.phar /usr/local/bin/composer

# Update Composer
RUN /usr/local/bin/composer self-update

ENV SILVERSTRIPE_VERSION 3.2
ENV LANG en_US.UTF-8

# Patch rootfs
ADD ./patches/root/ /root/
ADD ./patches/etc/ /etc/
ADD ./patches/usr/local/ /usr/local/

# Install SilverStripe installer using composer

RUN rm -rf /var/www && \
    composer --no-dev create-project silverstripe/installer /var/www/ && \
    /usr/local/bin/ss_config.sh && \
    rm -f /usr/local/bin/ss_config.sh

# Configure NginX
RUN ln -sf /etc/nginx/sites-available/000-default.conf /etc/nginx/sites-enabled/000-default.conf && \
    rm -f /etc/nginx/sites-enabled/default

RUN /etc/init.d/mysql start \
  && mysql -u root -e 'CREATE DATABASE `silverstripe` DEFAULT CHARACTER SET `utf8mb4` COLLATE `utf8mb4_unicode_ci`;' \
  && killall mysqld

# Clean rootfs from image-builder
RUN /usr/local/sbin/builder-leave
