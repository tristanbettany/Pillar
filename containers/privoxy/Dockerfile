FROM alpine:latest

EXPOSE 8118

HEALTHCHECK --interval=30s --timeout=3s CMD nc -z localhost 8118

RUN apk --no-cache add privoxy ca-certificates bash

ADD config_files/* /etc/privoxy/

RUN chown privoxy.privoxy /etc/privoxy/*

ENTRYPOINT ["privoxy"]
CMD ["--no-daemon","--user","privoxy","/etc/privoxy/config"]