# First stage: build the Go binary
FROM golang:1.21-alpine AS build

# Set up working directory in the container
WORKDIR /app

# Copy go.mod and go.sum to the container and download dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the rest of the application code
COPY . .

# Build the Go application
RUN go build -o server .

# Second stage: prepare the final container with only the necessary binary and files
FROM alpine:latest

WORKDIR /app

COPY --from=build /app/server .

EXPOSE 3000

CMD ["./server"]

# Add a label with the GitHub source
LABEL org.opencontainers.image.source=https://github.com/omnistrate/ci-cd-example