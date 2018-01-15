FROM goodrain-apps/oraclebase:jessie

MAINTAINER rainbond@goodrain.com

ENV LANG en_US.utf8
ENV PINPOINT_AGETN_VERSION="1.7.0"
ENV PINPOINT_AGENT_PATH="/usr/local/pinpoint-agent"

RUN mkdir -pv /opt/goodrain/java/

COPY setmem.sh /opt/goodrain/java/setmem.sh

COPY jdk-7u80-linux-x64.tar.gz /tmp/

RUN cd /tmp && \
    tar xf jdk-7u80-linux-x64.tar.gz -C /opt/goodrain/java && \
    rm -rf jdk-7u80-linux-x64.tar.gz && \
    ln -s /opt/goodrain/java/jdk* /opt/goodrain/java/jdk && \
    ln -s /opt/goodrain/java/jdk /opt/goodrain/java/jvm && \
    chown -R java:java /opt/goodrain/java && \
    /root/post-install

RUN mkdir -pv $PINPOINT_AGENT_PATH \
    && curl -ks https://pkg.goodrain.com/apps/pinpoint/pinpoint-agent-${PINPOINT_AGETN_VERSION}.tar.gz | tar xz -C /usr/local/pinpoint-agent


ENV JAVA_HOME=/opt/goodrain/java/jdk \
    PATH=${PATH}:/opt/goodrain/java/jdk/bin:/opt/goodrain/java
