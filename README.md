# docker-bitcoind
Docker Image for Bitcoin Core

### Quick Start
Create a bitcoind-data volume to persist the bitcoind blockchain data, should exit immediately. The bitcoind-data container will store the blockchain when the node container is recreated (software upgrade, reboot, etc):
```
 docker volume create --name=bitcoind-data
```
Create a bitcoin.conf file and put your configurations
```
nano bitcoin.conf
```

Run the docker image
```
docker run -v bitcoind-data:/bitcoin --name=bitcoind-node -d \
      -p 8333:8333 \
      -p 127.0.0.1:8332:8332 \
      -v /home/user/bitcoin.conf:/bitcoin/.bitcoin/bitcoin.conf \
      unibtc/docker-bitcoind
```

Check Logs
```
docker logs -f bitcoind-node
 ```