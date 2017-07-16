FROM ruby:2.4.1-alpine

RUN apk update && \
    apk add --no-cache build-base tzdata && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    rm -rf /var/cache/apk/*

ADD Gemfile /
RUN bundle install
