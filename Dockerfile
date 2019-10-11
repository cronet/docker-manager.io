FROM mono:latest

RUN mkdir /opt/manager-server
RUN curl https://d2ap5zrlkavzl7.cloudfront.net/19.10.15/ManagerServer.tar.gz | tar xvz -C /opt/manager-server

# Run instance of Manager
CMD ["mono", "/opt/manager-server/ManagerServer.exe","-port","8080","-path","/data"]

VOLUME /data
EXPOSE 8080
