FROM xiaogame2018/nginx:centos
# 
# 如果修改了脚本或进程仓库的URL，记得修改以下相应的配置

RUN yum install -y ping telnet net-tools crontabs vixie-cron zip unzip && yum clean all

RUN cd /data/nginx && mkdir conf

RUN sed -i 's/session    required   pam_loginuid.so/#session    required   pam_loginuid.so/g' /etc/pam.d/crond && service crond start


CMD [ "ping 127.0.0.1" ]
