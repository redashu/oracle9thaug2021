FROM  python
#  pull docker image from docker hub  standard python image 
# if not present 
LABEL  email="ashutoshh@linux.com"
# optional field 
# image author info 
RUN  mkdir  /mycode 
# creating a folder to store code inside docker image
COPY  oracle.py  /mycode/oracle.py 
# copy data from client machine to Docker image 
# during image build time 
CMD  ["python","/mycode/oracle.py"]
# default process for this docker image
# docker run -d --name ashuc1 alpine  ping localhost 