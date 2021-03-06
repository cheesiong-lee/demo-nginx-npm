FROM centos:7.6.1810

RUN set -x \
    && curl -sL https://rpm.nodesource.com/setup_10.x | bash - \
    && yum install -y epel-release \
    && yum install -y \
       nodejs \
       nano \
       curl \
       nginx \
    && yum clean all && rm -rf /var/cache/yum

WORKDIR /app

COPY . /tmp/src

RUN set -x \
    ## copy sources and create build
    && (cd /tmp/src; cp -fv package.json server.js test.html /app/; cd -) \
    && (cd /app; npm install; cd -) \
    && mv -fv /tmp/src/tini /sbin && chmod 755 /sbin/tini \
    && mv -fv /tmp/src/init.sh / && chmod 755 /init.sh \
    && mv -fv /tmp/src/nginx.conf /etc/nginx/nginx.conf \
    ## Need write permission on the following directories
    && mkdir -p /var/lib/nginx && chmod -R 777 /var/log /var/lib/nginx /etc/nginx /app \
    && rm -rf /tmp/src

EXPOSE 5000
EXPOSE 8080

ENTRYPOINT ["/sbin/tini","-v", "--"]
CMD ["/init.sh"]
