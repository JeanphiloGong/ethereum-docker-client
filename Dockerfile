FROM ethereum/client-go:stable

# Create data directory
RUN mkdir -p /root/.ethereum

# Expose necessary ports
EXPOSE 8545 8546 30303 30303/udp

# Default command (runs a testnet node)
CMD ["geth", "--http", "--http.addr", "0.0.0.0", "--http.api", "eth,net,web3,personal", "--syncmode", "fast"]

