FROM mcr.microsoft.com/dotnet/runtime-deps:5.0

RUN sed -i "s|DEFAULT@SECLEVEL=2|DEFAULT@SECLEVEL=1|g" /etc/ssl/openssl.cnf

<<<<<<< HEAD
ADD https://github.com/Manager-io/Manager.zip/releases/download/20.10.54/ManagerServer-Linux-x64.tar.gz /tmp/manager-server.tar.gz
=======
ADD https://github.com/Manager-io/Manager.zip/releases/latest/download/ManagerServer-Linux-x64.tar.gz /tmp/manager-server.tar.gz
>>>>>>> 8fe55f5bf30c95ccd1ce1517342bf6b8760945f8

RUN mkdir /opt/manager-server; \
    tar -C /opt/manager-server/ -xzvf /tmp/manager-server.tar.gz; \
    rm -f /tmp/manager-server.tar.gz; \
    chmod +x /opt/manager-server/ManagerServer

# Run instance of Manager
CMD ["/opt/manager-server/ManagerServer","-port","8080","-path","/data"]

VOLUME /data
EXPOSE 8080

