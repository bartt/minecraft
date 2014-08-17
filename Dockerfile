FROM phusion/baseimage:latest
MAINTAINER Bart Teeuwisse <bart@thecodemill.biz>

RUN apt-get update
RUN apt-get upgrade -y

# RUN apt-get install -y python-software-properties
RUN add-apt-repository ppa:webupd8team/java -y

RUN apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

RUN apt-get install -y wget oracle-java7-installer

ENV VERSION 1.7.10
 
RUN mkdir /minecraft
RUN wget -O /minecraft/minecraft.jar https://s3.amazonaws.com/Minecraft.Download/versions/${VERSION}/minecraft_server.${VERSION}.jar
RUN chmod +x /minecraft/minecraft.jar

# Accept the EULA
RUN echo 'eula=true' > /minecraft/eula.txt

VOLUME /minecraft
WORKDIR /minecraft

EXPOSE 25565

CMD java -Xmx1600M -Xms1024M -jar minecraft.jar nogui