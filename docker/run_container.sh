#!/bin/bash

docker run -d --name=scs_gitlab --network=jamnet --hostname=scs_gitlab --restart=always \
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

# Tried hard to find a way to update /assets/sshd_config as part of the build/Dockerfile ( but not easy !! )
# So doing it after container created/started
docker exec scs_gitlab bash -c "echo 'UsePrivilegeSeparation no' >>/assets/sshd_config"
# Then restart the sshd ( Could alternatively do a container restart - slower )
docker exec scs_gitlab bash -c "/opt/gitlab/embedded/bin/sv restart sshd"
#docker restart scs_gitlab
