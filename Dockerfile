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