# Use application directory name as ARGUMENT
ARG APP_NAME=bookstair

# Use desired Ruby version as ARGUMENT
ARG RUBY_VERSION=3.1.4

# Use desired Node version as ARGUMENT
ARG NODE_VERSION=16

# Use desired Bundler version as ARGUMENT
ARG BUNDLER_VERSION=2.3.26

# Use multi-stage builds to reduce image size
FROM ruby:$RUBY_VERSION AS build
ARG APP_NAME

# Set working directory and install dependencies
WORKDIR /$APP_NAME
RUN curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - \
 && wget -q -O - https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
 && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
 && apt-get update -qq \
 && apt-get install -y --no-install-recommends build-essential nodejs yarn cron git vim \
 && gem install bundler:$BUNDLER_VERSION

# Copy only necessary files and install dependencies
COPY Gemfile Gemfile.lock /$APP_NAME/
RUN bundle install --jobs $(nproc) --retry 3 --without development test \
 && yarn install --check-files

# Copy application files and precompile assets
COPY . /$APP_NAME/
RUN rm -rf node_modules tmp/cache \
 && yarn install --check-files \
 && bundle exec rails assets:precompile \
 && bundle lock --add-platform x86_64-linux \
 && bundle exec rails css:install:tailwind \
 && bundle exec rails javascript:install:esbuild \
 && bundle exec whenever --update-crontab

# Use smaller base image for production
FROM ruby:$RUBY_VERSION-slim AS production
ARG APP_NAME
ENV RAILS_ENV production
ENV BUNDLE_WITHOUT development:test
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

# Copy precompiled assets and dependencies
WORKDIR /$APP_NAME
COPY --from=build /$APP_NAME /$APP_NAME

# Start the application
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
