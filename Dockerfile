FROM mcr.microsoft.com/dotnet/runtime-deps:6.0

RUN apt update; \
    apt install -y unzip wget; \
    apt clean; \
    rm -rf /var/lib/apt/lists/*

RUN sed -i "s|DEFAULT@SECLEVEL=2|DEFAULT@SECLEVEL=1|g" /etc/ssl/openssl.cnf

RUN mkdir /opt/manager-server; \
    MANAGER_VERSION=$(wget -q -O - "https://api.github.com/repos/Manager-io/Manager/releases/latest" | grep -Po '"tag_name": "\K.*?(?=\")'); \
    wget -q -O - "https://github.com/Manager-io/Manager/releases/download/$MANAGER_VERSION/ManagerServer-linux-x64.tar.gz" | tar -zxC /opt/manager-server; \
    chmod +x /opt/manager-server/ManagerServer

# Run instance of Manager
CMD ["/opt/manager-server/ManagerServer","-port","8080","-path","/data"]

VOLUME /data
EXPOSE 8080

