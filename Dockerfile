<<<<<<< Updated upstream
FROM ruby:2.6.5

RUN apt-get update -qq && \
  apt-get install -y build-essential \
<<<<<<< Updated upstream
  nodejs\
  mysql-server\
  mysql-client
=======
  nodejs \
  mariadb-server \
  mariadb-client
>>>>>>> Stashed changes

WORKDIR /contact_book_app

COPY Gemfile /contact_book_app/Gemfile
COPY Gemfile.lock /contact_book_app/Gemfile.lock

RUN gem install bundler
RUN bundle install

RUN mkdir -p tmp/sockets
=======
FROM ruby:2.6.5-slim-buster

ARG BUNDLER_VERSION='2.1.4'

RUN apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    build-essential \
    gnupg2 \
    curl \
    less \
    git \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get -yq dist-upgrade \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    default-mysql-client \
    default-libmysqlclient-dev \
    yarn \
    nodejs \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log

ENV LANG=C.UTF-8 \
    GEM_HOME=/bundle \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3

ENV BUNDLE_PATH $GEM_HOME

ENV BUNDLE_APP_CONFIG=$BUNDLE_PATH\
    BUNDLE_BIN=$BUNDLE_PATH/bin

ENV PATH /app/bin:$BUNDLE_BIN:$PATH

RUN gem update --system && \
    gem install rails && \
    mkdir -p /app

WORKDIR /app
>>>>>>> Stashed changes
