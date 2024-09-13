FROM alpine

RUN apk add --no-cache bash

WORKDIR /app

COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]

EXPOSE 3000
LABEL org.opencontainers.image.source=https://github.com/omnistrate/ci-cd-example
