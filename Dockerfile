FROM bitsler/wallet-base:latest

ENV HOME /bitcoin

ENV USER_ID 1000
ENV GROUP_ID 1000

RUN groupadd -g ${GROUP_ID} bitcoin \
  && useradd -u ${USER_ID} -g bitcoin -s /bin/bash -m -d /bitcoin bitcoin \
  && set -x \
  && apt-get update -y \
  && apt-get install -y curl gosu \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG version=0.18.1
ENV BITCOIN_VERSION=$version

RUN curl -sL https://bitcoincore.org/bin/bitcoin-core-$BITCOIN_VERSION/bitcoin-$BITCOIN_VERSION-x86_64-linux-gnu.tar.gz | tar xz --strip=2 -C /usr/local/bin

ADD ./bin /usr/local/bin
RUN chmod +x /usr/local/bin/btc_oneshot

VOLUME ["/bitcoin"]

EXPOSE 8332 8333

WORKDIR /bitcoin

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["btc_oneshot"]
