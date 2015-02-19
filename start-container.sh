set -e
set -x

cd src

docker run --rm --link copycopter-postgres:db -e POSTGRES_HOST=db -e POSTGRES_USER=copycopter -e POSTGRES_PASSWORD=copycopter -p 3000:3000 -v $(pwd):/app copycopter-app
