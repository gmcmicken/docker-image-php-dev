FROM serversideup/php:8.3-fpm-nginx-alpine 

# Switch to root so we can do root things
USER root

# Save the build arguments as a variable
ARG USER_ID
ARG GROUP_ID

# Use the build arguments to change the UID 
# and GID of www-data while also changing 
# the file permissions for NGINX
RUN docker-php-serversideup-set-id www-data 1000:1000 && \
    \
    # Update the file permissions for our NGINX service to match the new UID/GID
    docker-php-serversideup-set-file-permissions --owner 1000:1000 --service nginx

# Required for laravel development
RUN apk add --update npm

# Drop back to our unprivileged user
USER www-data