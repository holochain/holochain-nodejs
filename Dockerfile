FROM ubuntu:xenial

SHELL ["/bin/bash", "-c"]

RUN apt-get update
RUN apt-get install -y sudo curl git cmake
# RUN sudo apt-get install -y libssl-dev pkg-config python2.7 libzmq3-dev

RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
RUN sudo apt-get install -y nodejs
RUN node -v

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
RUN sudo apt-get update && sudo apt-get -y install yarn

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain nightly-2019-01-24
ENV PATH="/root/.cargo/bin:${PATH}"
RUN cargo -V

COPY ./libsodium-1.0.16 /libsodium-1.0.16
WORKDIR /libsodium-1.0.16
RUN ./configure
RUN make && make check
RUN sudo make install
ENV RUST_SODIUM_LIB_DIR /holochain-nodejs/libsodium-1.0.16
ENV RUST_SODIUM_SHARED 1

COPY . /holochain-nodejs
WORKDIR /holochain-nodejs

RUN yarn install --ignore-scripts

RUN node publish.js
