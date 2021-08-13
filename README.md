# Certifications 

<img src="cert.png">

## k8s architecture 

<img src="k8sarch.png">

## cluster setup 

<img src="cluster.png">

## OCR  to k8s 

<img src="ocr.png">

## pushing image to OCR 

```
docker  tag  alpine:latest  phx.ocir.io/axmbtg8judkl/webapp:v001
❯ docker  login   phx.ocir.io
Username: axmbtg8judkl/learntechbyme@gmail.com
Password: 
Login Succeeded
❯ docker  push   phx.ocir.io/axmbtg8judkl/webapp:v001
The push refers to repository [phx.ocir.io/axmbtg8judkl/webapp]
cdd2a6afae34: Pushed 
e3135447ca3e: Pushed 
b85734705991: Pushed 
988d9a3509bb: Pushed 
59b01b87c9e7: Pushed 
7c0b223167b9: Pushing [=========================================>         ]  53.52MB/63.91MB
814bff734324: Pushing [=================================>                 ]  46.64MB/69.26MB

❯ docker  logout   phx.ocir.io
Removing login credentials for phx.ocir.io

```


### Creating deployment 

```
kubectl  create  deployment  ashuwebapp  --image=phx.ocir.io/axmbtg8judkl/webapp:v001  --dry-run=client  -o yaml   >ocir.yaml


```

### api-resources in k8s

<img src="k8sapi.png">

## Intro to secret 

<img src="sec.png">

## creating secret. 

```
❯ kubectl  create  secret   docker-registry  ocrsec   --docker-server phx.ocir.io  --docker-username=a   --docker-password='cc'
secret/ocrsec created
❯ kubectl  get  secret
NAME                  TYPE                                  DATA   AGE
default-token-k7wzh   kubernetes.io/service-account-token   3      20h
ocrsec                kubernetes.io/dockerconfigjson        1      37s

```

### creating service 

```
❯ kubectl  get deploy
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
ashuwebapp   1/1     1            1           4m1s
❯ kubectl  expose deploy  ashuwebapp  --type NodePort  --port 80  --name ashusvc1  --dry-run=client -o yaml
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    app: ashuwebapp
  name: ashusvc1
spec:
  ports:
  - port: 80
    protocol: TCP
    targetPort: 80
  selector:
    app: ashuwebapp
  type: NodePort
status:
  loadBalancer: {}
❯ kubectl  expose deploy  ashuwebapp  --type NodePort  --port 80  --name ashusvc1
service/ashusvc1 exposed
❯ kubectl get  svc
NAME       TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
ashusvc1   NodePort   10.97.144.211   <none>        80:31787/TCP   4s


```

## storage in k8s 

<img src="st.png">

### storage volume options 

<img src="stvol.png">

[volume docs](https://kubernetes.io/docs/concepts/storage/volumes/)

###  checking pod data 

```
❯ kubectl  get  all
NAME            READY   STATUS    RESTARTS      AGE
pod/ashupodx1   1/1     Running   1 (75m ago)   78m
❯ kubectl  exec -ti  ashupodx1  -- sh
/ # cd  /mnt/oracle/
/mnt/oracle # ls
data.txt
/mnt/oracle # head -5  data.txt 
Hello
Hello
Hello
Hello
Hello
/mnt/oracle # exit


```

### Side car container 

<img src="side.png">


### multi container pod 

<img src="mc.png">

##

```
❯ kubectl  get  po
NAME        READY   STATUS    RESTARTS   AGE
ashupodx1   2/2     Running   0          7m44s
❯ kubectl  exec  -it  ashupodx1  -- bash
Defaulted container "ashuc1" out of: ashuc1, ashupodx1
root@ashupodx1:/# cd  /usr/share/nginx/html/
root@ashupodx1:/usr/share/nginx/html# ls
index.html
root@ashupodx1:/usr/share/nginx/html# exit
❯ kubectl  exec  -it  ashupodx1  -c   ashupodx1  -- sh
/ # cd  /mnt/oracle/
/mnt/oracle # ls
index.html
/mnt/oracle # exit

```


### Mulit tier app

<img src="mulapp.png">

### step1 

```
kubectl  create  deployment  ashudb  --image=mysql:5.6  --dry-run=client -o yaml
```

## step 2 create secret 
```
kubectl  create  secret  generic  ashudbsec  --from-literal   key1=Oracle099   --dry-run=client -o yaml

```

### step 3 deploy DB deployment 

```
❯ kubectl apply -f  multiapp.yaml
deployment.apps/ashudb created
Warning: resource secrets/ashudbsec is missing the kubectl.kubernetes.io/last-applied-configuration annotation which is required by kubectl apply. kubectl apply should only be used on resources created declaratively by either kubectl create --save-config or kubectl apply. The missing annotation will be patched automatically.
secret/ashudbsec configured
❯ kubectl  get  deploy
NAME     READY   UP-TO-DATE   AVAILABLE   AGE
ashudb   1/1     1            1           13s
❯ kubectl  get   po
NAME                      READY   STATUS    RESTARTS   AGE
ashudb-5799946f6d-n5f8m   1/1     Running   0          21s

░▒▓ ~/Desktop/k8s_app_deploy/multiapp ····························· kubernetes-admin@kubernetes/ashu-space ⎈  03:43:47 pm ▓▒░─╮
❯ kubectl  logs  -f  ashudb-5799946f6d-n5f8m        

```

### step 4 creating svc

```
❯ kubectl  expose deploy  ashudb  --type ClusterIP  --port 3306  --dry-run=client -o yaml
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    app: ashudb
  name: ashudb
spec:
  ports:
  - port: 3306
    protocol: TCP
    targetPort: 3306
  selector:
    app: ashudb
  type: ClusterIP
status:
  loadBalancer: {}
  
  
 ```
 
 ###
 
 ```
 ❯ kubectl apply -f  multiapp.yaml
deployment.apps/ashudb configured
secret/ashudbsec configured
service/ashudb created
❯ kubectl  get  svc
NAME     TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
ashudb   ClusterIP   10.105.206.110   <none>        3306/TCP   12s


```

## 

```
❯ kubectl  get  deploy,rs,pod,secret,svc
NAME                     READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/ashudb   1/1     1            1           16m

NAME                                DESIRED   CURRENT   READY   AGE
replicaset.apps/ashudb-5799946f6d   1         1         1       16m

NAME                          READY   STATUS    RESTARTS   AGE
pod/ashudb-5799946f6d-n5f8m   1/1     Running   0          16m

NAME                         TYPE                                  DATA   AGE
secret/ashudbsec             Opaque                                1      26m
secret/default-token-k7wzh   kubernetes.io/service-account-token   3      24h
secret/ocrsec                kubernetes.io/dockerconfigjson        1      3h50m

NAME             TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
service/ashudb   ClusterIP   10.105.206.110   <none>        3306/TCP   96s


```

### step 6 create web dep

```
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: ashuwebapp
  name: ashuwebapp
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ashuwebapp
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: ashuwebapp
    spec:
      containers:
      - image: wordpress:4.8-apache
        name: wordpress
        resources: {}
        
  ```
  
 ### creating dep svc 
 
 ```
 kubectl  expose deploy  ashuwebapp  --type NodePort --port 80  --dry-run=client -o yaml
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    app: ashuwebapp
  name: ashuwebapp
spec:
  ports:
  - port: 80
    protocol: TCP
    targetPort: 80
  selector:
    app: ashuwebapp
  type: NodePort
status:
  loadBalancer: {}
 
 ```

## K8s. dashboard -- svc account 

<img src="svcacc.png">

### checking svaacc and secre 

```
2860  kubectl  create  ns  test 
 2861  kubectl  get  sa  -n  test  
 2862  kubectl  get  secret   -n  test  
 2863  kubectl  describe   secret  default-token-48zzm  -n  test  
❯ kubectl delete ns  test
namespace "test" deleted
```

### deploy dashboard

```
❯ kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.2.0/aio/deploy/recommended.yaml
namespace/kubernetes-dashboard created
serviceaccount/kubernetes-dashboard created
service/kubernetes-dashboard created
secret/kubernetes-dashboard-certs created
secret/kubernetes-dashboard-csrf created
secret/kubernetes-dashboard-key-holder created
configmap/kubernetes-dashboard-settings created
role.rbac.authorization.k8s.io/kubernetes-dashboard created
clusterrole.rbac.authorization.k8s.io/kubernetes-dashboard created
rolebinding.rbac.authorization.k8s.io/kubernetes-dashboard created
clusterrolebinding.rbac.authorization.k8s.io/kubernetes-dashboard created
deployment.apps/kubernetes-dashboard created
service/dashboard-metrics-scraper created
Warning: spec.template.metadata.annotations[seccomp.security.alpha.kubernetes.io/pod]: deprecated since v1.19; use the "seccompProfile" field instead
deployment.apps/dashboard-metrics-scraper created





❯ kubectl  get  deploy -n kubernetes-dashboard
NAME                        READY   UP-TO-DATE   AVAILABLE   AGE
dashboard-metrics-scraper   1/1     1            1           25s
kubernetes-dashboard        1/1     1            1           27s
❯ kubectl  get  po  -n kubernetes-dashboard
NAME                                         READY   STATUS    RESTARTS   AGE
dashboard-metrics-scraper-856586f554-xx62j   1/1     Running   0          33s
kubernetes-dashboard-78c79f97b4-tkzrz        1/1     Running   0          35s
❯ kubectl  get  svc  -n kubernetes-dashboard
NAME                        TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
dashboard-metrics-scraper   ClusterIP   10.101.108.245   <none>        8000/TCP   45s
kubernetes-dashboard        ClusterIP   10.108.250.121   <none>        443/TCP    53s
❯ kubectl  get  sa  -n kubernetes-dashboard
NAME                   SECRETS   AGE
default                1         65s
kubernetes-dashboard   1         64s
❯ kubectl  get  secret  -n kubernetes-dashboard
NAME                               TYPE                                  DATA   AGE
default-token-sbd79                kubernetes.io/service-account-token   3      74s
kubernetes-dashboard-certs         Opaque                                0      71s
kubernetes-dashboard-csrf          Opaque                                1      70s
kubernetes-dashboard-key-holder    Opaque                                2      70s
kubernetes-dashboard-token-zpffv   kubernetes.io/service-account-token   3      73s

```

## changing svc type

```
❯ kubectl  get  svc  -n kubernetes-dashboard
NAME                        TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
dashboard-metrics-scraper   ClusterIP   10.101.108.245   <none>        8000/TCP   2m2s
kubernetes-dashboard        ClusterIP   10.108.250.121   <none>        443/TCP    2m10s
❯ kubectl  edit   svc  kubernetes-dashboard    -n kubernetes-dashboard
service/kubernetes-dashboard edited
❯ kubectl  get  svc  -n kubernetes-dashboard
NAME                        TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)         AGE
dashboard-metrics-scraper   ClusterIP   10.101.108.245   <none>        8000/TCP        2m45s
kubernetes-dashboard        NodePort    10.108.250.121   <none>        443:32266/TCP   2m53s

```

## give power to svc account of dashboard


```
❯ kubectl  get  clusterroles
NAME                                                                   CREATED AT
admin                                                                  2021-08-11T10:25:52Z
calico-kube-controllers                                                2021-08-11T10:27:02Z
calico-node                                                            2021-08-11T10:27:02Z
cluster-admin      

```



