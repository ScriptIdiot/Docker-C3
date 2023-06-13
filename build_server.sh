#/bin/bash

if [ "$#" -lt 1 ]; then
    echo "Usage: ./build_server.sh <id>"
    echo
    echo "Example: ./build_server.sh 0"
    exit
fi

C3_DIR="$(pwd)/data/c3_server_${1}/"
GATEWAY_DIR="${C3_DIR}/gateway"
BIN_DIR="$(pwd)/data/c3_server_${1}/Bin"

SC_DIR="$(pwd)/shellcode"

ID="$1"

if [ ! -d "$C3_DIR" ]; then
        mkdir -p $C3_DIR
fi

if [ ! -d "$BIN_DIR" ]; then
        cp -r C3/Bin $BIN_DIR
fi

if [ ! -d "$SC_DIR" ]; then
        mkdir -p $SC_DIR
fi

docker run -d --restart unless-stopped --privileged -p 500${ID}:52935 --name c3_server_${ID} -v ${GATEWAY_DIR}:/app/gateway -v ${BIN_DIR}:/app/C3/Bin -v ${SC_DIR}:/app/shellcode c3
