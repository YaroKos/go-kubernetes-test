FROM golang:alpine3.17 AS builder

RUN mkdir /app

COPY go.mod /app

WORKDIR /app

RUN go mod download

COPY *.go /app

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o api main.go

FROM alpine:latest

WORKDIR /

COPY --from=builder /app/api /api

EXPOSE 8080

CMD ["./api"]