# RUN FROM RUST

FROM rust:1.34

RUN useradd -ms /bin/bash cardano &&\
    su - cardano -c 'git clone https://github.com/input-output-hk/cardano-http-bridge.git /home/cardano/cardano-http-bridge'

USER cardano
WORKDIR /home/cardano/cardano-http-bridge

RUN git submodule update --init &&\
    cargo run --release; exit 0
EXPOSE 8080
CMD target/release/cardano-http-bridge start --port=8080 --template=testnet

# ==========================================================================================================================

# # RUN FROM UBUNTU

# FROM ubuntu:18.04

# #dependencies
# RUN apt-get update &&\
#   apt-get install -y curl \
#   git\
#   build-essential

# # Get Rust
# RUN curl https://sh.rustup.rs -sSf | bash -s -- -y

# RUN git clone https://github.com/input-output-hk/cardano-http-bridge.git &&\
#   cd cardano-http-bridge &&\
#   git submodule update --init

# RUN bash -c 'source $HOME/.cargo/env; cd cardano-http-bridge; cargo run --release' || true

# EXPOSE 8080

# CMD cardano-http-bridge/target/release/cardano-http-bridge start --port=8080 --template=testnet