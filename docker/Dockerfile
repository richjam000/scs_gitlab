FROM localhost:5000/docker/gitlab:11.11.3-ce.0
RUN cp /etc/gitlab/gitlab.rb /etc/gitlab/gitlab.rb.ORIG && \
    cp /assets/sshd_config /assets/sshd_config.ORIG && \
    echo 'external_url "https://gitlab.scsuk.net:443"' >>/etc/gitlab/gitlab.rb && \
    echo "gitlab_rails['gitlab_shell_ssh_port'] = 10022" >>/etc/gitlab/gitlab.rb && \
    echo 'UsePrivilegeSeparation no' >>/assets/sshd_config
