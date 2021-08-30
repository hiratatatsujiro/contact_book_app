FROM ruby:2.6.5

RUN apt-get update -qq && \
  apt-get install -y build-essential \
  nodejs\
  mysql-server\
  mysql-client

WORKDIR /contact_book_app

COPY Gemfile /contact_book_app/Gemfile
COPY Gemfile.lock /contact_book_app/Gemfile.lock

RUN gem install bundler
RUN bundle install

RUN mkdir -p tmp/sockets