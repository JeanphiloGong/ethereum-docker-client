FROM ubuntu:22.04

RUN sed -i 's|http://archive.ubuntu.com|http://mirrors.aliyun.com|g' /etc/apt/sources.list \
 && sed -i 's|http://security.ubuntu.com|http://mirrors.aliyun.com|g' /etc/apt/sources.list \
 && apt-get clean \
 && apt-get update \
 && apt-get install -y software-properties-common curl


# Install the Ethereum client (geth)
RUN add-apt-repository -y ppa:ethereum/ethereum && \
    apt-get update && \
    apt-get install -y ethereum

# Expose necessary ports
EXPOSE 8545 30303 30303/udp

# Default command to run geth (Ethereum client)
CMD ["geth", "--http", "--http.addr", "0.0.0.0", "--http.api", "eth,net,web3,personal", "--syncmode", "snap"]
