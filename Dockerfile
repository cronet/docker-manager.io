FROM mcr.microsoft.com/dotnet/runtime-deps:5.0

RUN sed -i "s|DEFAULT@SECLEVEL=2|DEFAULT@SECLEVEL=1|g" /etc/ssl/openssl.cnf

ADD https://github.com/Manager-io/Manager/releases/download/22.6.4.63/ManagerServer-linux-x64.zip /tmp/manager-server.zip

RUN mkdir /opt/manager-server; \
    zip /tmp/manager-server.zip -d /opt/manager-server/; \
    rm -f /tmp/manager-server.zip; \
    chmod +x /opt/manager-server/ManagerServer

# Run instance of Manager
CMD ["/opt/manager-server/ManagerServer","-port","8080","-path","/data"]

VOLUME /data
EXPOSE 8080

