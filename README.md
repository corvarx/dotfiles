On Host
```
docker build -t macdev .
docker run -d -p 2286:2286 -v ~/docker_vol/work/:/work  macdev
ssh root@localhost -p 2286
```

On guest
```
ssh-keygen -t rsa -b 4096 -C "xieyuejian@gmail.com"
```
