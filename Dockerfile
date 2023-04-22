#applicationのディレクトリ名で置き換えてください
ARG APP_NAME=bookstair
#使いたいrubyのimage名に置き換えてください
ARG RUBY_IMAGE=ruby:3.1.4
#使いたいnodeのversionに置き換えてください(`15.14.0`ではなく`15`とか`16`とかのメジャーバージョン形式で書いてください)
ARG NODE_VERSION='16'
#インストールするbundlerのversionに置き換えてください
ARG BUNDLER_VERSION=2.3.26
FROM $RUBY_IMAGE
ARG APP_NAME
ARG RUBY_VERSION
ARG NODE_VERSION
ARG BUNDLER_VERSION

ENV RAILS_ENV production
ENV BUNDLE_DEPLOYMENT true
ENV BUNDLE_WITHOUT development:test
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

RUN mkdir /$APP_NAME
WORKDIR /$APP_NAME

# 別途インストールが必要なものがある場合は追加してください
RUN curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - \
&& wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
&& echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
&& apt-get update -qq \
&& apt-get install -y build-essential nodejs yarn \
&& apt-get install -y cron

RUN apt install -y --no-install-recommends \
  git \
  vim \ 
  cron

RUN service cron start

RUN gem install bundler:$BUNDLER_VERSION

COPY Gemfile /$APP_NAME/Gemfile
COPY Gemfile.lock /$APP_NAME/Gemfile.lock

COPY . /$APP_NAME/

RUN yarn install \
&& yarn cache clean \
&& rm -rf /$APP_NAME/node_modules /$APP_NAME/tmp/cache
RUN apt-get install libmecab2 libmecab-dev mecab mecab-ipadic mecab-ipadic-utf8 mecab-utils
RUN bundle install && bundle lock --add-platform x86_64-linux && bundle exec rails css:install:tailwind && bundle exec rails javascript:install:esbuild

COPY yarn.lock /$APP_NAME/yarn.lock
COPY package.json /$APP_NAME/package.json
COPY tailwind.config.js /$APP_NAME/tailwind.config.js

# Cronジョブの設定ファイルを追加する
COPY config/schedule.yml /$APP_NAME/config/schedule.yml
# COPY config/sidekiq-cron.yml /$APP_NAME/config/sidekiq-cron.yml

# ジョブ実行のために必要な環境変数を設定する
ENV JOBS_WORKERS_COUNT=1
ENV JOBS_POOL_SIZE=10
ENV JOBS_QUEUE=jobs
ENV JOBS_LOG_LEVEL=info
ENV JOBS_LOG_FILE=/dev/stdout

# Redisを起動する
CMD redis-server --daemonize yes && \
# Sidekiqを設定する
bundle exec sidekiq -c 1 -r ./app.rb -L /dev/stdout && \
# sidekiq-cronを設定する
# RUN bundle exec sidekiq-cron -c 1 -r ./app.rb -s ./config/sidekiq-cron.yml -L /dev/stdout



COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
