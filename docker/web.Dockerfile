ARG APP_NAME
FROM $APP_NAME as rails_app

# Base image:
FROM nginx:1.23.4
# Install dependencies
RUN apt-get update -qq && apt-get -y install apache2-utils

ARG APP_HOST

# establish where Nginx should look for files
ENV RAILS_ROOT /home/app
ENV APP_HOST $APP_HOST

RUN mkdir -p $RAILS_ROOT

# Set our working directory inside the image
WORKDIR $RAILS_ROOT

# create log directory
RUN mkdir log

# copy over static assets
COPY --from=rails_app /home/app/public public/

# Copy Nginx config template
COPY docker/nginx.conf /tmp/docker.nginx

# substitute variable references in the Nginx config template for real values from the environment
# put the final config in its place
RUN envsubst '$RAILS_ROOT,$APP_HOST' < /tmp/docker.nginx > /etc/nginx/conf.d/default.conf

EXPOSE 80

# Use the "exec" form of CMD so Nginx shuts down gracefully on SIGTERM (i.e. `docker stop`)
CMD [ "nginx", "-g", "daemon off;" ]