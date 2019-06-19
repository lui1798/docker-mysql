FROM centos:7

#默认参数
ENV MYSQL_PORT 3306
ENV MYSQL_HOST 127.0.0.1
#ENV MYSQL_DATABASE 
ENV MYSQL_USER root
ENV MYSQL_PASSWORD root
ENV MYSQL_ROOT_PASSWORD root

ARG MYSQL_SERVER_PACKAGE_URL=http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
RUN yum install -y --nogpgcheck $MYSQL_SERVER_PACKAGE_URL \
    && yum -y install mysql-server \
    && yum clean all
RUN sed -i '21a\lower_case_table_names=1' /etc/my.cnf
WORKDIR /	
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh
RUN [ -d /data ] || mkdir -p /data
RUN ln -sf /dev/stdout /data/log
ENTRYPOINT ["run.sh"]