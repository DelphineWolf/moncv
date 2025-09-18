#Définir l'OS
FROM debian:bullseye-slim
#Installation du serveur apache2
RUN apt-get update && apt-get install -y apache2 && rm -rf /var/lib/apt/lists/*
#
RUN mkdir /var/www/moncv/
COPY ./site /var/www/moncv/
#Définir les permissions
RUN chown -R www-data:www-data /var/www/moncv
#Virtual host
COPY ./moncv.conf /etc/apache2/sites-available/moncv.conf
RUN a2dissite 000-default.conf && a2ensite moncv.conf && a2enmod rewrite
EXPOSE 80
CMD ["apachectl","-D","Forground"]
