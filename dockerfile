FROM golang:1.24-alpine AS builder

WORKDIR /app/d2

# 先复制 d2 目录下的 go.mod 和 go.sum
COPY d2/go.mod d2/go.sum /app/d2/


# 复制 d1 的 go.mod 和 go.sum，避免依赖缺失
COPY d1/go.mod d1/go.sum /app/d1/

ENV GOPROXY=direct
# 私有模块或私有仓库：如果你用的是私有仓库，公共校验和数据库无法访问这些模块，可能会报错，这时可以关闭校验和数据库。
# replace 指令：当 go.mod 里用 replace 指向本地路径或私有地址时，校验和数据库无法校验这些模块，关闭校验和数据库避免校验错误。
# 临时调试：网络问题或者校验和数据库不可用时，可以临时关闭。
ENV GOSUMDB=off

RUN go mod tidy

# 再复制整个项目，包括 d2 目录下的源码
COPY . /app

RUN go build -o /app/bin/gowork2

FROM alpine:latest

COPY --from=builder /app/bin/gowork2 /usr/local/bin/gowork2

ENTRYPOINT ["gowork2"]
