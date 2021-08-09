FROM  oraclelinux:8.4
#  pull docker image from docker hub 
# if not present 
LABEL  email="ashutoshh@linux.com"
# optional field 
# image author info 
RUN  dnf  install python3 -y
# dnf is online software installer in OL 
# RUN is giving a shell access during image build time
RUN  mkdir  /mycode 
# creating a folder to store code inside docker image
COPY  oracle.py  /mycode/oracle.py 
# copy data from client machine to Docker image 
# during image build time 
CMD  ["python3","/mycode/oracle.py"]
# default process for this docker image
# docker run -d --name ashuc1 alpine  ping localhost 
