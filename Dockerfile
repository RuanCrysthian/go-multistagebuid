FROM golang:1.22.3-alpine3.18 AS builder

WORKDIR /app

COPY . .

RUN go build hello.go

CMD [ "./hello" ]