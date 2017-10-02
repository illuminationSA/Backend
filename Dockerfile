FROM ruby:2.4

RUN mkdir /Backend
WORKDIR /Backend

ADD Gemfile /Backend/Gemfile
ADD Gemfile.lock /Backend/Gemfile.lock

RUN bundle install
ADD . /Backend
