#!/bin/bash

docker volume create scs_gitlab_conf
docker volume create scs_gitlab_logs
docker volume create scs_gitlab_data

docker run -d --name=scs_gitlab --network=jamnet --hostname=scs_gitlab --restart=always \
--publish 10022:22 \
--volume scs_gitlab_conf:/etc/gitlab \
--volume scs_gitlab_logs:/var/log/gitlab \
--volume scs_gitlab_data:/var/opt/gitlab \
localhost:5000/docker/gitlab:11.11.3-ce.0

# -e "GITLAB_SHELL_SSH_PORT=10022"
