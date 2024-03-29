FROM golang:1.16-alpine
ENV GO111MODULE=on

RUN apk add --no-cache git

WORKDIR /app


COPY internal/ ./internal/
COPY service/ ./service/
COPY config/ ./config/
COPY go.mod ./
COPY go.sum ./
COPY main.go ./

RUN go mod vendor

RUN go build -o ./adguard_exporter .

EXPOSE 9617

RUN chmod +x ./adguard_exporter
ENTRYPOINT ["./adguard_exporter"]
CMD ["--help"]
