FROM ubuntu:latest

RUN apt update && DEBIAN_FRONTEND="noninteractive" apt install -y libicu66 unzip wget

RUN if [ "$TZ" != "" ]; then ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata; fi

RUN mkdir /opt/manager-server
RUN wget -q https://github.com/Manager-io/Manager.zip/releases/download/20.9.77/ManagerServer-Linux-x64.zip
RUN unzip ManagerServer-Linux-x64.zip -d /opt/manager-server/
RUN rm -f ManagerServer-Linux-x64.zip
RUN chmod +x /opt/manager-server/ManagerServer

# Run instance of Manager
CMD ["/opt/manager-server/ManagerServer","-port","8080","-path","/data"]

VOLUME /data
EXPOSE 8080
