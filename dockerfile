FROM alpine

RUN apk add --no-cache bash

WORKDIR /app

COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
LABEL org.opencontainers.image.source https://github.com/G-Despacito/hello-world
