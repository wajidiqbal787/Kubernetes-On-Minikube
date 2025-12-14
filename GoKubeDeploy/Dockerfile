# Build stage
FROM golang:1.24.9-alpine AS builder
WORKDIR /app
COPY . .
RUN go build -o main .

# Run stage
FROM alpine:latest
WORKDIR /root/
COPY --from=builder /app/main .
EXPOSE 8080
CMD ["./main"]
