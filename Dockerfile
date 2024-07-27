FROM golang:1.22-alpine3.20 AS builder

RUN mkdir /app
ADD . /app
WORKDIR /app

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o server cmd/apiserver/main.go

FROM alpine AS production

WORKDIR /app
COPY --from=builder /app/server .
COPY --from=builder /app/configs/apiserver_prod.toml ./configs/apiserver.toml

EXPOSE 8080

CMD [ "./server" ]
