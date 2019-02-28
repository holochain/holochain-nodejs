FROM ubuntu:xenial

SHELL ["/bin/bash", "-c"]

RUN apt-get update
RUN apt-get install -y sudo curl git
RUN sudo apt-get install -y libssl-dev pkg-config python2.7 libzmq3-dev

RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
RUN sudo apt-get install -y nodejs
RUN node -v

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
RUN sudo apt-get update && sudo apt-get -y install yarn

COPY ./libsodium-1.0.16 /holochain-nodejs/libsodium-1.0.16
WORKDIR /holochain-nodejs/libsodium-1.0.16
RUN apt-get install -y cmake
RUN ./configure
RUN make && make check
RUN sudo make install

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain nightly-2019-01-24
ENV PATH="/root/.cargo/bin:${PATH}"
RUN cargo -V

COPY . /holochain-nodejs
WORKDIR /holochain-nodejs

RUN yarn install --ignore-scripts

RUN node publish.js
