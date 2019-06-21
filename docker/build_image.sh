docker build -t localhost:5000/scsuk.net/scs_gitlab:1.0 -f docker/Dockerfile https://gitlab.scsuk.net/rich/scs_gitlab.git#master
docker push localhost:5000/scsuk.net/scs_gitlab:1.0
