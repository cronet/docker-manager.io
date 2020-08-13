FROM mono:latest

RUN apt update && apt install -y unzip wget

RUN mkdir /opt/manager-server
RUN wget -q https://github.com/Manager-io/Manager.zip/releases/download/20.8.45/Manager.zip
RUN unzip Manager.zip -d /opt/manager-server/
RUN rm -f Manager.zip

# Run instance of Manager
CMD ["mono", "/opt/manager-server/ManagerServer.exe","-port","8080","-path","/data"]

VOLUME /data
EXPOSE 8080
