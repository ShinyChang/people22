#!/bin/sh
export PATH=/usr/local/bin:/opt/aws/bin:$PATH;

yum update
yum install docker -y
service docker start
# Docker login notes:
#   - For no email, just put one blank space.
#   - Also the private repo protocol and version are needed for docker
#     to properly setup the .dockercfg file to work with compose
# docker login --username="someuser" --password="asdfasdf" --email=" " https://example.com/v1/
# mv /root/.dockercfg /home/ec2-user/.dockercfg
# chown ec2-user:ec2-user /home/ec2-user/.dockercfg
usermod -a -G docker ec2-user
curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
chown root:docker /usr/local/bin/docker-compose

export DRONE_HOST=https://drone.slowstir.com
export DRONE_GITHUB_CLIENT=65f41926322819dda648
export DRONE_GITHUB_SECRET=e7d0daf8f11cc43ea109a7bf17611a9eda814f16


cat <<EOF > /etc/Caddyfile
https://drone.slowstir.com {
  # please comment the timeouts configures
  # if caddy server version under 0.9.5
  timeouts none
  proxy / drone-server:8000
}
EOF

cat <<EOF >/home/ec2-user/docker-compose.yml
version: '2'

services:
  caddy:
    image: abiosoft/caddy
    ports:
      - 443:443
    volumes:
      - /etc/Caddyfile:/etc/Caddyfile
      - $HOME/.caddy:/root/.caddy
  drone-server:
    image: drone/drone:0.8
    ports:
      - 8000:8000
      - 9000:9000
    volumes:
      - /var/lib/drone:/var/lib/drone/
    restart: always
    environment:
      - DRONE_OPEN=true
      - DRONE_HOST=${DRONE_HOST}
      - DRONE_GITHUB=true
      - DRONE_GITHUB_CLIENT=${DRONE_GITHUB_CLIENT}
      - DRONE_GITHUB_SECRET=${DRONE_GITHUB_SECRET}
      - DRONE_SECRET=${HOSTNAME}

  drone-agent:
    image: drone/agent:0.8
   restart: always
    depends_on:
      - drone-server
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    environment:
      - DRONE_SERVER=drone-server:9000
      - DRONE_SECRET=${HOSTNAME}
EOF
chown ec2-user:ec2-user /home/ec2-user/docker-compose.yml
/usr/local/bin/docker-compose -f /home/ec2-user/docker-compose.yml up -d
