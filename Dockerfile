FROM docker.io/rust:1.80 as builder
WORKDIR /usr/src/jetbrains-fls-exporter
COPY Cargo.toml .
COPY Cargo.lock .
COPY src src
RUN cargo install --path .

FROM docker.io/debian:bookworm-slim
RUN apt-get update && apt-get install -y ca-certificates openssl && rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/local/cargo/bin/jetbrains-fls-exporter /usr/local/bin/jetbrains-fls-exporter
CMD ["jetbrains-fls-exporter"]
