FROM ubuntu:latest AS builder

RUN apt-get update && \
    apt-get install -y build-essential wget && \
    wget http://nginx.org/download/nginx-1.20.1.tar.gz && \
    tar -xvzf nginx-1.20.1.tar.gz && \
    cd nginx-1.20.1 && \
    ./configure && \
    make && \
    make install

# Stage 2: Build the Nginx image
FROM ubuntu:latest

COPY --from=builder /usr/local/nginx /usr/local/nginx

EXPOSE 80

CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]

