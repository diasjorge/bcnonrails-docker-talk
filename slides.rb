# encoding: utf-8
# To run use: https://github.com/fxn/tkn

center <<-EOS
  Jorge Dias

  #{b "Development environments using fig"}
EOS

section "About me" do
  block <<-EOS
    Devops @ Xing / Development & Testing infrastructure

    Github @diasjorge / Twitter @dias_jorge
  EOS
end

section "Docker introduction" do
  block <<-EOS
    Docker - An open platform for distributed applications for developers and sysadmins.
  EOS

  block <<-EOS
    Docker enables apps to be quickly assembled from components
  EOS

  block <<-EOS
    Eliminates the friction between development, QA, and production environments.
  EOS

  block <<-EOS
    Run the same app, unchanged, on laptops, data center VMs, and any cloud.
  EOS
end

section "Docker Basics Demo" do
  block <<-EOS
    Our test app: https://github.com/copycopter/copycopter-server
  EOS

  block <<-EOS
    Dockerizing our applications dependencies
  EOS

  db_cmd = "docker run -d --name copycopter-postgres -e POSTGRES_USER=copycopter -e POSTGRES_PASSWORD=copycopter -p 5432:5432 postgres"

  block db_cmd

  run_block do
    %x{docker rm -f copycopter-postgres}
    %x{#{db_cmd}}
  end

  block "docker ps"

  run_block do
    `docker ps`
  end

  block "Updating our config/database.yml"

  database_yml = <<-EOS
development: &default
  adapter: postgresql
  database: copycopter_development
  min_messages: WARNING
  host: <%= ENV['POSTGRES_HOST'] %>
  username: <%= ENV['POSTGRES_USER'] %>
  password: <%= ENV['POSTGRES_PASSWORD'] %>

test: &test
  <<: *default
  database: copycopter_test
EOS

  block database_yml

  block "Let's run our application locally with our changes"

  block <<-EOS
    Dockerizing the app
  EOS

  block "Create our Dockerfile"

  block <<-EOS
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
EOS

  block "docker build -t copycopter-app ."

  run_block do
    out = nil
    Dir.chdir('src') do
      out = %x{docker build -t copycopter-app .}
    end
    out
  end

  block "Let's run our application inside docker"

  # docker run --rm --link copycopter-postgres:db -e POSTGRES_HOST=db -e POSTGRES_USER=copycopter -e POSTGRES_PASSWORD=copycopter -p 3000:3000 copycopter-app

end

section "Fig introduction" do
  block <<-EOS
    Fast, isolated development environments using Docker
  EOS

  block "Creating our fig.yml"

  code <<-EOS, :yaml
    web:
      build: .
      ports:
        - "3000:3000"
      links:
        - postgres
      volumes:
        - ".:/app"
      environment:
        POSTGRES_HOST: 'postgres'
        POSTGRES_PASSWORD: 'copycopter-dev'
        POSTGRES_USER: 'copycopter'

    postgres:
      image: 'postgres'
      environment:
        POSTGRES_USER: 'copycopter'
        POSTGRES_PASSWORD: 'copycopter-dev'
  EOS

  block "Let's run our application using fig"
end

section "That's all, thanks!" do
end
