FROM ruby:2.7.4-alpine3.14

RUN apk add --no-cache git libc6-compat build-base mariadb-dev postgresql-dev postgresql-client tzdata shared-mime-info
RUN gem install bundler --no-document

WORKDIR /app

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN bundle install
COPY . .

ENV PORT=80

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
