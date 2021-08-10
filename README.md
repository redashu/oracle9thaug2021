#  Namespace and cgroups 

<img src="cg.png">

## to remove all non running container 

```
 docker  rm  $(docker  ps  -aq)
 
 ```
 
## Introduction to vertical scaling of container along with cgroups 

<img src="cg1.png">

## running child process and check resources 

```
 175  docker  run -itd  --name ashuc1  alpine ping google.com 
  176  docker  ps
  177  history 
  178  docker  stats
  179  history 
  180  docker  exec -itd  ashuc1  ping localhost 
  181  docker  stats
  182  docker  ps
  183  docker  top  ashuc1
  
 ```
 
 ### cgroups for memory limit 
 
 ```
  docker run -itd --name ashuc2 --memory 100m alpine ping fb.com
  
```

### ram with CPU limit

```
docker run -itd --name ashuc3 --memory 100m --cpu-shares=30 alpine ping fb.com

```

##  Restart policy in DOcker containers

<img src="restart.png">

### filter json output in container to check restart policy and other info 

```
ashu@ip-172-31-9-158 ~]$ docker  inspect  ashuc1  --format='{.Id}'
{.Id}
[ashu@ip-172-31-9-158 ~]$ docker  inspect  ashuc1  --format='{{.Id}}'
cf7e6d1a06ff1cfba7539cd2876e47faef41fc88459d5735f2add4e2ca88be65
[ashu@ip-172-31-9-158 ~]$ docker  inspect  ashuc1  --format='{{.State.Status}}'
running
[ashu@ip-172-31-9-158 ~]$ docker  inspect  ashuc2  --format='{{.State.Status}}'
running
[ashu@ip-172-31-9-158 ~]$ docker  inspect  ashuc2  --format='{{.HostConfig.RestartPolicy.Name}}'
no
[ashu@ip-172-31-9-158 ~]$ docker  inspect  ashuc1  --format='{{.HostConfig.RestartPolicy.Name}}'
no

```



