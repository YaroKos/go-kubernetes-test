FROM golang:alpine3.17 AS builder

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o api main.go

FROM alpine:latest

COPY --from=builder /app/api /api

EXPOSE 8080

ENTRYPOINT ["/api"]