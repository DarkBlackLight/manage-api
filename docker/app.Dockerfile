FROM ruby:3.0.3

ARG API_ONLY='0'

# Install dependencies
RUN apt-get update -qq && apt-get install -y shared-mime-info imagemagick cron vim

# Set an environment variable where the Rails app is installed to inside of Docker image:
ENV RAILS_ROOT /home/app
RUN mkdir -p $RAILS_ROOT

# Set working directory, where the commands will be ran:
WORKDIR $RAILS_ROOT

# Setting env up
ENV RAILS_ENV production
ENV RACK_ENV production

COPY docker/entrypoint.sh entrypoint.sh

# Adding project files
COPY . .

# Adding gems
RUN bundle install --local

RUN if [ -e bin/yarn ] ; then rm bin/yarn ; fi
RUN rm -rf docker
RUN rm docker-compose.yml

RUN if [ "$API_ONLY" = "0" ] ; then WEBPACKER_PRECOMPILE=false bundle exec rails assets:precompile ; fi

EXPOSE 3000
CMD ["/home/app/entrypoint.sh"]