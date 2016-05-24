FROM alpine:3.3

MAINTAINER Nicholas Ingosi Magaja <ningosi@esaude.org>

ENV TOMCAT_MAJOR=7 \
    TOMCAT_VERSION=7.0.69 \
    TOMCAT_HOME=/etc/tomcat \
    CATALINA_HOME=/etc/tomcat

RUN apk add --update openjdk7 curl; \
    curl -L http://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz \
      -o /tmp/apache-tomcat-${TOMCAT_VERSION}.tar.gz; \
    tar -zxvf /tmp/apache-tomcat-${TOMCAT_VERSION}.tar.gz -C /etc; \
    ln -s /etc/apache-tomcat-${TOMCAT_VERSION} ${TOMCAT_HOME}; \
    rm -f /tmp/apache-tomcat-${TOMCAT_VERSION}.tar.gz; \
    rm -rf ${TOMCAT_HOME}/webapps/*; \
    curl -L https://bintray.com/esaude/openelis/download_file?file_path=openElisGlobal.war \
      -o ${TOMCAT_HOME}/webapps/openElisGlobal.war; \
    
    apk del curl && rm -f /var/cache/apk/*

COPY setenv.sh ${TOMCAT_HOME}/bin/setenv.sh

EXPOSE 8080

CMD ${TOMCAT_HOME}/bin/catalina.sh run