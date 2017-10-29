## Drone CI
[Drone CI introduction](https://www.slideshare.net/secret/LbMyqRXF9vkLao)

1. Register a new OAuth application in Github 
```
### Application name
Drone (alpha)
### Homepage URL
https://drone.expamle.com 
### Authorization callback URL
https://drone.expamle.com/authorize
```

2. Copy your client token
```
### Client ID
***********************
### Client Secret
**********************************************
```

3. docker-compose.yml
```
version: '2'

services:
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
      - DRONE_HOST=https://drone.example.com
      - DRONE_GITHUB=true
      - DRONE_GITHUB_CLIENT=***********************
      - DRONE_GITHUB_SECRET=**********************************
      - DRONE_SECRET=DrONeSEcREt

  drone-agent:
    image: drone/agent:0.8
   restart: always
    depends_on:
      - drone-server
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    environment:
      - DRONE_SERVER=drone-server:9000
      - DRONE_SECRET=DrONeSEcREt
```
