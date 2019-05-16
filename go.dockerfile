FROM xiaogame2018/nginx:centos
# 
# 如果修改了脚本或进程仓库的URL，记得修改以下相应的配置

RUN yum install -y ping telnet net-tools crontabs vixie-cron zip unzip && yum clean all

RUN cd /data/nginx && mkdir conf

RUN sed -i 's/session    required   pam_loginuid.so/#session    required   pam_loginuid.so/g' /etc/pam.d/crond && service crond start

RUN [ -f /bin/backstage.sh ] && rm -f /bin/backstage.sh; \
    cd /bin && wget http://devops.80xcx.com/docker/backstage.sh && chmod +x backstage.sh

RUN [ -f /bin/docker_init.sh ] && rm -f /bin/docker_init.sh; \
    cd /bin && wget http://devops.80xcx.com/docker/docker_init.sh && chmod +x docker_init.sh

RUN cd /root && wget http://devops.80xcx.com/docker/scripts.zip

RUN [ -d /home/test/backstage ] && rm -rf /home/test/backstage; \
    mkdir /home/test/backstage && cd /home/test/backstage && git init &&\
    git pull https://gitee.com/kkkdkk/kkkkkk.git && mkdir /home/test/pack

VOLUME [ "/data/nginx", "/usr/local/nginx-1.12.0/conf" ]

ENTRYPOINT [ "docker_init.sh" ]

CMD [ "docker_run.sh" ]
