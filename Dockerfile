# Create an image based on this existing ruby image
FROM ruby:2.3.8

# Install the software you need
RUN apt-get update -qq && apt-get install -y build-essential nodejs git vim \
  && apt-get -q clean \
  && rm -rf /var/lib/apt/lists

RUN mkdir /app
WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install

COPY . /app
