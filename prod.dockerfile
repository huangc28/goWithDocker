# docker run --rm -it -p 8080:8080 sstar/golang

FROM golang:1.10.2-alpine as builder

# install deps management
RUN apk add --no-cache git \
  && go get -u github.com/golang/dep/cmd/dep

# create a working directory
WORKDIR /go/src/app

# install vendor packages
ADD Gopkg.toml Gopkg.toml
ADD Gopkg.lock Gopkg.lock
RUN dep ensure --vendor-only

# add source code
ADD src src

# build application
RUN go build src/main.go

# build the source
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main src/main.go

# use a minimal alpine image
FROM alpine:3.7

# add ca-certificates in case you need them
RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*
# set working directory
WORKDIR /root

# copy the binary from builder
# main binary will be copied to /root/main
COPY --from=builder /go/src/app/main .
# run the binary
CMD ["./main"]


