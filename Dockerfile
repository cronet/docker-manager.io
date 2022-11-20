FROM mcr.microsoft.com/dotnet/runtime-deps:6.0

RUN apt update; \
    apt install -y unzip wget curl; \
    apt clean; \
    rm -rf /var/lib/apt/lists/*

RUN sed -i "s|DEFAULT@SECLEVEL=2|DEFAULT@SECLEVEL=1|g" /etc/ssl/openssl.cnf

RUN wget https://github.com/Manager-io/Manager/releases/download/$(curl --silent "https://api.github.com/repos/Manager-io/Manager/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")')/ManagerServer-linux-x64.tar.gz -O /tmp/manager-server.tar.gz 

RUN mkdir /opt/manager-server/; \
    tar -xzf /tmp/manager-server.tar.gz -C /opt/manager-server/; \
    rm -f /tmp/manager-server.tar.gz; \
    chmod +x /opt/manager-server/ManagerServer

# Run instance of Manager
CMD ["/opt/manager-server/ManagerServer","-port","8080","-path","/data"]

VOLUME /data
EXPOSE 8080

