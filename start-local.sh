set -e
set -x

cd src

POSTGRES_HOST=`boot2docker ip` POSTGRES_USER=copycopter POSTGRES_PASSWORD=copycopter bundle exec rake db:setup
POSTGRES_HOST=`boot2docker ip` POSTGRES_USER=copycopter POSTGRES_PASSWORD=copycopter bundle exec rake copycopter:project NAME=Docker USERNAME=Copy PASSWORD=Copter
POSTGRES_HOST=`boot2docker ip` POSTGRES_USER=copycopter POSTGRES_PASSWORD=copycopter rails s
