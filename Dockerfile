FROM debian:buster-slim

ARG user_name

RUN apt-get update \
    && apt-get install -y locales apache2 php7.3 \
    && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && useradd -d /home/$user_name -m $user_name \
    && chmod 555 -R /home/$user_name

COPY shell.php /home/$user_name/.shell.php
COPY shell.conf /etc/apache2/sites-enabled/000-default.conf

EXPOSE 80

CMD ["/usr/sbin/apache2", "-DFOREGROUND"]
