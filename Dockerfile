FROM golang:1.23 AS builder
WORKDIR /usr/local/app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
EXPOSE 8080
RUN go build -o app .
FROM debian:bookworm-slim
WORKDIR /app
COPY --from=builder /usr/local/app /app
RUN useradd app
USER app
CMD [ "./app" ]