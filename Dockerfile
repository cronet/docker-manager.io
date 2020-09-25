FROM mono:latest

RUN apt update && apt install -y unzip wget

RUN mkdir /opt/manager-server
RUN wget -q https://github.com/Manager-io/Manager.zip/releases/download/20.9.76/Manager-Linux-x64.zip
RUN unzip Manager-Linux-x64.zip -d /opt/manager-server/
RUN rm -f Manager-Linux-x64.zip

# Run instance of Manager
CMD ["mono", "/opt/manager-server/ManagerServer.exe","-port","8080","-path","/data"]

VOLUME /data
EXPOSE 8080
