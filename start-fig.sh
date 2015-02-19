set -e
set -x

cd src

fig run web rake db:setup
fig run web rake copycopter:project NAME=DockerFig USERNAME=Copy PASSWORD=Copter
fig up
