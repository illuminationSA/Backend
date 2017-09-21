FROM ruby:2.4

RUN mkdir /SAI_back
WORKDIR /SAI_back

ADD Gemfile /SAI_back/Gemfile
ADD Gemfile.lock /SAI_back/Gemfile.lock

RUN bundle install
ADD . /SAI_back
