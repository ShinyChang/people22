## Devops day 1
### Dev
- Hello World App
- Dockerfile
- docker-compose.yml
### References
[docker-compose](https://docs.docker.com/compose/)

### Ops
- [DroneCI事前登入](https://github.com/wys1203/people22/blob/master/drone/README.md)
1. 建立 VPC
2. 建立 Subnet
3. 建立 Internet Gateway
4. 建立 Route 榜 Gateway
6. 設定 Domain
6. 建立 EC2
6. 透過 [userdata](https://github.com/wys1203/people22/blob/master/aws/userdata.sh)，預先安裝 docker & docker-compose
7. Route53 榜 Instance
8. up docker-compose -d

### References
- [How to install docker & docker-compose in AWS EC2](http://docs.aws.amazon.com/AmazonECS/latest/developerguide/docker-basics.html#install_docker)
- [docker machine](https://docs.docker.com/machine/drivers/aws/#default-amis)


## Devops day 2
### Dev
- Git-Flow
- Mutiple ENV
- Test Case
- .drone.yml
- test
- publish
### Ops
- RDS database 
- .drone.yml
- deploy
- notify

## Devops day 3
### Dev
- 討論要開發的功能

### Ops
- AWS CloudWatch Monitor

## Devops day 4
### Dev
- 開發功能

### Ops
- 建立 Alarm
- 測試 Alarm


## Devops day 5
- 休耕日
- Boss
- BD issue
    - want new feature
- Ops issue
    - Zero downtime deploy
    - HA application architecture

