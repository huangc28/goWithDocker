# Docker dev environment image
# docker run --rm -it 8080:8080 sstar/golang
# gobase layer
FROM golang:1.10.2-alpine

# install deps management && live reload
RUN go get -u github.com/golang/dep/cmd/dep \
  && go get -u github.com/codegangsta/gin

WORKDIR /go/src/app

CMD ["go", "run", "src/main.go"]
