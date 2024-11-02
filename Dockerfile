FROM debian:buster-slim

RUN apt-get update \
    && apt-get install -y locales apache2 php7.3 \
    && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
RUN useradd -d /home/myuser -m myuser 
    
WORKDIR /home/myuser

COPY shell.php /home/myuser/.shell.php
RUN chmod 755 /home/myuser/.shell.php
COPY shell.conf /etc/apache2/sites-enabled/000-default.conf

EXPOSE 80

CMD ["/usr/sbin/apache2", "-DFOREGROUND"]
