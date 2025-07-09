FROM golang:1.24-alpine AS builder

WORKDIR /app/d2

# 先复制 d2 目录下的 go.mod 和 go.sum
COPY d2/go.mod d2/go.sum /app/d2/

ENV GOPROXY=direct
ENV GOSUMDB=off

RUN go mod tidy

# 再复制整个项目，包括 d2 目录下的源码
COPY . /app

RUN go build -o /app/bin/gowork2

FROM alpine:latest

COPY --from=builder /app/bin/gowork2 /usr/local/bin/gowork2

ENTRYPOINT ["gowork2"]
