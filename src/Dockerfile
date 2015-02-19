FROM ruby:2.1.5

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    nodejs \
    libqt4-dev && \
    rm -rf /var/lib/apt/lists/*

RUN usr/sbin/useradd --create-home --home-dir /app --shell /bin/bash copycopter

WORKDIR /app

COPY Gemfile* /app/

RUN bundle install

ADD . /app

RUN chown -R copycopter:copycopter /app

USER copycopter

CMD ["rails", "server"]
