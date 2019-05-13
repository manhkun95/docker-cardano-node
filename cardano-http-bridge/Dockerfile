FROM rust:1.34

RUN git clone https://github.com/input-output-hk/cardano-http-bridge.git /usr/src/cardano-http-bridge
WORKDIR /usr/src/cardano-http-bridge

RUN git submodule update --init
RUN cargo run --release; exit 0

EXPOSE 8080
CMD target/release/cardano-http-bridge start --port=8080 --template=testnet
