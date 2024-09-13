# Use a multi-stage build to keep the final image small
# First stage: build the Go binary
FROM golang:1.20-alpine AS build

# Set up working directory in the container
WORKDIR /app

# Copy Go module files and download dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the Go source code to the container
COPY . .

# Build the Go server
RUN go build -o server .

# Second stage: prepare the final container with only the necessary binary and files
FROM alpine:latest

# Install bash and any necessary dependencies
RUN apk add --no-cache bash

# Set the working directory in the final container
WORKDIR /app

# Copy the built Go binary from the build stage
COPY --from=build /app/server .

# Copy the entrypoint script
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

# Set the entrypoint to the script
ENTRYPOINT ["/app/entrypoint.sh"]

# Expose the port the Go server will use
EXPOSE 3000

# Add a label with the GitHub source
LABEL org.opencontainers.image.source=https://github.com/omnistrate/ci-cd-example
