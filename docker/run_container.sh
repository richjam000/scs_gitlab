#!/bin/bash

docker run -d --name=scs_gitlab --network=jamnet --hostname=scs_gitlab --restart=always \
-e TZ=Europe/London \
--publish 5005:5005 \
--publish 10022:22 \
--volume scs_gitlab_conf:/etc/gitlab \
--volume scs_gitlab_logs:/var/log/gitlab \
--volume scs_gitlab_data:/var/opt/gitlab \
--env GITLAB_OMNIBUS_CONFIG="external_url 'https://gitlab.scsuk.net:443'; gitlab_rails['gitlab_shell_ssh_port']=10022;" \
localhost:5000/docker/gitlab:11.11.3-ce.0

HEALTH=unchecked
until [ "$HEALTH" = "healthy" ] ; do
   sleep 10
   HEALTH=$(/usr/bin/docker inspect -f {{.State.Health.Status}} scs_gitlab)
done

echo "Container up. Now update the /assets/sshd_config"


