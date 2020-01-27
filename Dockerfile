FROM tomcat:9-jre8 as base

ENV BIM_SERVER_VERSION 1.5.181

ENV TOMCAT_HOME /usr/local/tomcat
ENV BIMSERVER_APP $TOMCAT_HOME/webapps/ROOT
ENV BIMSERVER_WAR_URL https://github.com/opensourceBIM/BIMserver/releases/download/v$BIM_SERVER_VERSION/bimserverwar-$BIM_SERVER_VERSION.war

RUN rm -rf $TOMCAT_HOME/webapps/examples
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get clean

FROM base as setup
RUN rm -rf /usr/local/tomcat/webapps/*
ADD $BIMSERVER_WAR_URL $BIMSERVER_APP.war

FROM setup as service
COPY configs/* /usr/local/tomcat/conf/
CMD ["catalina.sh", "run"]
