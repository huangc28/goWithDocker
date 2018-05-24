# Docker dev environment image
# docker run --rm -it 8080:8080 sstar/golang
# gobase layer
FROM golang:1.10.2-alpine

# install deps management && live reload
RUN apk add --update \
  && apk add --no-cache bash git \
  && go get -u github.com/golang/dep/cmd/dep \
  && go get -u github.com/pilu/fresh

WORKDIR /go/src/app

# install vendor packages
ADD Gopkg.toml Gopkg.toml
ADD Gopkg.lock Gopkg.lock
ADD go.ini /etc/supervisor.d/go.ini
ADD entry-point.sh /root/entry-point.sh
RUN ["chmod", "+x", "/root/entry-point.sh"]
RUN dep ensure --vendor-only

WORKDIR /go/src/app/src

CMD ["fresh"]
