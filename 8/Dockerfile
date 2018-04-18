FROM goodrainapps/oraclebase:jessie

MAINTAINER rainbond@goodrain.com

ENV LANG C.UTF-8
ENV PINPOINT_AGETN_VERSION "1.7.0"
ENV ORACLE_JDK_VERSION "8u171"
ENV PINPOINT_AGENT_PATH "/usr/local/pinpoint-agent"

RUN mkdir -pv /opt/goodrain/java/ && mkdir -pv /usr/local/pinpoint-agent

COPY setmem.sh /opt/goodrain/java/setmem.sh

RUN curl -ks https://pkg.goodrain.com/apps/java/jdk/jdk-${ORACLE_JDK_VERSION}-linux-x64.tar.gz | tar xz -C /opt/goodrain/java && \
    ln -s /opt/goodrain/java/jdk* /opt/goodrain/java/jdk && \
    ln -s /opt/goodrain/java/jdk /opt/goodrain/java/jvm && \
    chown -R java:java /opt/goodrain/java && \
    curl -ks https://pkg.goodrain.com/apps/pinpoint/pinpoint-agent-${PINPOINT_AGETN_VERSION}.tar.gz | tar xz -C /usr/local/pinpoint-agent && \
    /root/post-install

ENV JAVA_HOME /opt/goodrain/java/jdk 
ENV EJAVA_OPTS -Duser.timezone=Asia/Shanghai 
ENV PATH ${PATH}:/opt/goodrain/java/jdk/bin:/opt/goodrain/java
