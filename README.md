On Host

Assuming you have already done this on your host for a ssh key pair.

```
ssh-keygen -t rsa -b 4096 -C "xieyuejian@gmail.com"
```

This is to build the image and mount a specific work dir

```
docker build -t macdev .
docker run -d -p 2286:2286 -v ~/docker_vol/work/:/work -v ~/Downloads:/Downloads macdev
ssh root@localhost -p 2286
scp -P 2286 ~/.ssh/id_rsa* root@localhost:~/.ssh
```

Your are suupose to login by root and execute
```
. setup.sh
```
