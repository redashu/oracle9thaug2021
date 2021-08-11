# Docker images can be used by any container run time 

<img src="cre.png">

## Docker client options 

<img src="cli.png">

## portainer as docker webui 

```
docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce

```

### Docker SDK 

[docker SDK](https://docs.docker.com/engine/api/sdk/examples/)



### Docker network more points 

<img src="dnet.png">

### custom subnet for docker bridge networking 

```
383  docker  network create  ashubr2  --subnet  192.168.100.0/24  
  384  docker  run -itd --name ashux111 --network  ashubr2  alpine 
  385  docker  ps
  386  history 
[ashu@ip-172-31-9-158 myimages]$ docker  run -itd --name ashux222 --network  ashubr2 --ip 192.168.100.200  alpine 
9509be5f46cacbe63309330bb3fcc19001a7e62c56e3813c291c665ad02bcbc3
[ashu@ip-172-31-9-158 myimages]$ docker exec -it  ashux222 sh 
/ # ifconfig 
eth0      Link encap:Ethernet  HWaddr 02:42:C0:A8:64:C8  
          inet addr:192.168.100.200  Bcast:192.168.100.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:6 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:500 (500.0 B)  TX bytes:0 (0.0 B)

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

/ # exit

```

### remove netowrk 

```
[ashu@ip-172-31-9-158 myimages]$ docker  network  prune 
WARNING! This will remove all custom networks not used by at least one container.
Are you sure you want to continue? [y/N] y
Deleted Networks:
shreyabr1
madhviBridge1
ishitab1
shailbr1
arjunnw
sivacnw
shwetabhbr1
riyanusubnet
ashubr1

```




