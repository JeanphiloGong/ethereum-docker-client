#!/bin/bash

CONTAINER_NAME="eth-node"
IMAGE_NAME="jeanphilo/ethereum-node:testnet"
DATA_DIR="$HOME/eth-data"

# Check if the container already exists
if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
    if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
        echo "Container '$CONTAINER_NAME' is already running."
    else
        echo "Container '$CONTAINER_NAME' exists but is stopped. Starting it..."
        docker start $CONTAINER_NAME
    fi
else
    echo "Container '$CONTAINER_NAME' does not exist. Creating and starting a new Ethereum node container..."
    mkdir -p $DATA_DIR
    docker run -d \
        --name $CONTAINER_NAME \
        -p 8545:8545 \
        -p 30303:30303 \
        -p 30303:30303/udp \
        -v $DATA_DIR:/root/.ethereum \
        $IMAGE_NAME
fi

# Display logs
echo "Showing logs for '$CONTAINER_NAME':"
docker logs -f $CONTAINER_NAME
