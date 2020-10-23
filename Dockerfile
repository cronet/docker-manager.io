FROM mcr.microsoft.com/dotnet/runtime-deps:5.0

ADD https://github.com/Manager-io/Manager.zip/releases/latest/download/ManagerServer-Linux-x64.tar.gz /tmp/manager-server.tar.gz

RUN mkdir /opt/manager-server; \
    tar -C /opt/manager-server/ -xzvf /tmp/manager-server.tar.gz; \
    rm -f /tmp/manager-server.tar.gz; \
    chmod +x /opt/manager-server/ManagerServer

# Run instance of Manager
CMD ["/opt/manager-server/ManagerServer","-port","8080","-path","/data"]

VOLUME /data
EXPOSE 8080
