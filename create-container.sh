#!/usr/bin/env bash
docker build -t postfix-forward .
docker run -d -p=25:25 -p=465:465 -p=587:587 --restart unless-stopped \
-e "MY_DOMAIN=$MY_DOMAIN" -e "FORWARD_TO=$FORWARD_TO" -e "FORWARDED_DOMAINS=$FORWARDED_DOMAINS" \
--log-driver=awslogs --log-opt awslogs-region=$AWS_DEFAULT_REGION --log-opt awslogs-group=DockerPostfix --log-opt awslogs-stream=docker-postfix \
postfix-forward
