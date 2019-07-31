#!/bin/ksh

# Ideally all of this done in a Dockerfile
# But Dockerfile not so easy - see Dockerfile.FAILED

# 1. 'UsePrivilegeSeparation' (Read more below )
# Note: This may only have been needed as I wasa using Docker namespaces
docker exec scs_gitlab bash -c "echo 'UsePrivilegeSeparation no' >>/assets/sshd_config"
docker exec scs_gitlab bash -c "/opt/gitlab/embedded/bin/sv restart sshd"
#docker restart scs_gitlab   ( Could do this instead of the sshd restart )

# 2. GITLAB DOCKER REGISTRY
# Not coded this yet !
# SEE: https://docs.gitlab.com/ee/administration/container_registry.html#container-registry-domain-configuration 
# root@scs_gitlab:/etc/gitlab# diff gitlab.rb.20100730.1 gitlab.rb
# 539c539
# < # registry_external_url 'https://registry.gitlab.example.com'
# ---
# > registry_external_url 'https://gitlab.scsuk.net:5005'           # ( I did try 4657 but the docker login hung ) 

# Also needed to put my signed certs here:
# root@scs_gitlab:/etc/gitlab/ssl# ls
# gitlab.scsuk.net.crt  gitlab.scsuk.net.key  gitlab.scsuk.net.key-staging

