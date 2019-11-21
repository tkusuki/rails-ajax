FROM ruby:2.6.3

ARG user
ARG uid

RUN test -n "$user"
RUN test -n "$uid"

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq
RUN apt-get install -y --no-install-recommends vim \
      nodejs \
      postgresql-client \
      yarn \
      locales

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen
RUN export LC_ALL="en_US.utf8"
RUN adduser --gecos "$user" --uid "$uid" --disabled-login "$user"
USER "$user"

RUN mkdir -p /home/"$user"/ajax

WORKDIR /home/"$user"/ajax
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN gem install bundler
RUN bundle install
RUN gem install bundler-audit

ADD . /home/"$user"/ajax
