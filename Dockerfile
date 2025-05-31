FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninter
ARG TOMCAT_VERSION=8.5.66

RUN mkdir /webapp
WORKDIR /webapp
ADD /archive ./archive/
ADD /WebContent ./WebContent/
ADD /src-core ./src-core/
ADD /src-web ./src-web/
ADD /index.jsp ./index.jsp
ADD /View ./View/
ADD /.htaccess ./.htaccess
ADD ./server.xml ./server.xml
ADD ./context.xml ./context.xml
ADD ./conf.txt.template ./conf.txt
ADD ./docker-start.sh ./docker-start.sh

RUN apt update
RUN apt install openjdk-8-jdk-headless openjdk-8-jre-headless ant ruby-full rubygems g++ make wget -y
RUN gem install ffi -v 1.17.2
RUN gem install sass
RUN ant -buildfile ./archive/build/DeployWeb.xml -Dcheckout-root=/webapp/
RUN mv View/ WebContent/
RUN wget https://archive.apache.org/dist/tomcat/tomcat-8/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.zip
RUN unzip apache-tomcat-$TOMCAT_VERSION.zip
RUN rm -f apache-tomcat-$TOMCAT_VERSION.zip
RUN ln -s ./apache-tomcat-$TOMCAT_VERSION ./tomcat
RUN mv ./server.xml ./tomcat/conf/server.xml
RUN mv ./context.xml ./tomcat/conf/context.xml
RUN chmod ug+x ./tomcat/bin/*.sh
RUN chmod ug+x ./docker-start.sh

ENTRYPOINT ["/bin/bash", "docker-start.sh"]
