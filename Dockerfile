FROM docker.io/openshift/base-centos7:latest

MAINTAINER Udo Urbantschitsch udo@cloudwerkstatt.com

LABEL io.openshift.tags haproxy,haproxy15
LABEL io.k8s.description HAProxy for reverse proxying master and gitlab
LABEL io.openshift.expose-services 8443/tcp:https,8080/tcp:http

RUN \
  yum install -y haproxy && \ 
  yum clean all

COPY container-files /

RUN chmod 755 /docker-entrypoint.sh

ENV MASTER_CONFIG /etc/haproxy/master.cfg
ENV GITLAB_CONFIG /etc/haproxy/gitlab.cfg

# ENV is used to trigger either proxying either master or versioning 

ENV MODE Master
ENV OPENSHIFT_MASTER_SERVER=d-osht-os01.tfabric2.sktelecom.com
ENV GITLAB_SERVER=gitlab.local

EXPOSE 8080 8443

USER default

ENTRYPOINT ["/docker-entrypoint.sh"]
