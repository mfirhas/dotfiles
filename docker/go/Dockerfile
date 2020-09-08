FROM alpine:3.12.0

RUN apk add --no-cache ca-certificates bash curl git openssh

WORKDIR /

# list of arguments
ARG service=servicename
ARG env

# list of environments
ENV ENV $env
ENV STDOUT_LOG_PATH /var/log/$service/$service.out.log
ENV STDERR_LOG_PATH /var/log/$service/$service.error.log

COPY ./bin/* /usr/bin/
COPY ./etc/$service/ /etc/$service/

CMD /usr/bin/$service



