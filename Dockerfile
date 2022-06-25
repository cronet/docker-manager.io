FROM mcr.microsoft.com/dotnet/runtime-deps:6.0

RUN apt update; \
    apt install unzip; \
    apt clean; \
    rm -rf /var/lib/apt/lists/*

RUN sed -i "s|DEFAULT@SECLEVEL=2|DEFAULT@SECLEVEL=1|g" /etc/ssl/openssl.cnf

ADD https://github.com/Manager-io/Manager/releases/download/22.6.20.110/ManagerServer-linux-x64.tar.gz /tmp/manager-server.tar.gz

RUN mkdir /opt/manager-server; \
    unzip /tmp/manager-server.tar.gz -d /opt/manager-server/; \
    rm -f /tmp/manager-server.tar.gz; \
    chmod +x /opt/manager-server/ManagerServer

# Run instance of Manager
CMD ["/opt/manager-server/ManagerServer","-port","8080","-path","/data"]

VOLUME /data
EXPOSE 8080

