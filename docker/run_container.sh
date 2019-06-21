#!/bin/bash
PROGDIR=$(dirname $0)
echo "PROGDIR($PROGDIR)"

docker volume create scs_gitlab_conf
docker volume create scs_gitlab_logs
docker volume create scs_gitlab_data
docker volume create scs_gitlab_assets

# Hack to update gitlab files
echo docker container create --name scs_gitlab_copytmp \
-v scs_gitlab_conf:/conf \
-v scs_gitlab_assets:/assets \
localhost:5000/scsuk.net/scratch:1.0
echo docker cp "$PROGDIR"/../config/gitlab.rb scs_gitlab_copytmp:/conf
echo docker cp "$PROGDIR"/../config/sshd_config scs_gitlab_copytmp:/assets
echo docker rm scs_gitlab_copytmp

exit 0


docker run -d --name=scs_gitlab --network=jamnet --hostname=scs_gitlab --restart=always \
--publish 10022:22 \
--volume scs_gitlab_conf:/etc/gitlab \
--volume scs_gitlab_logs:/var/log/gitlab \
--volume scs_gitlab_data:/var/opt/gitlab \
--volume scs_gitlab_assets:/assets \
localhost:5000/docker/gitlab:11.11.3-ce.0

# -e "GITLAB_SHELL_SSH_PORT=10022"
