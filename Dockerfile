# Gunakan image nginx dengan PHP-FPM
FROM richarvey/nginx-php-fpm:3.1.6

# Copy semua file dari project ke dalam container
COPY . .

# Configurasi Image
ENV WEBROOT /var/www/html/public
ENV PHP_ERRORS_STDERR 1
ENV RUN_SCRIPTS 1
ENV REAL_IP_HEADER 1

# Laravel environment configuration
ENV APP_ENV production
ENV APP_DEBUG false
ENV LOG_CHANNEL stderr

# Install dependencies
RUN composer install --no-dev --optimize-autoloader

# Set file permissions for Laravel directories
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache
RUN chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Install dependencies sebelum menjalankan artisan
RUN composer install --no-dev --optimize-autoloader

# Expose port 80 untuk web server
EXPOSE 80

CMD ["/start.sh"]
