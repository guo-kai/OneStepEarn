docker run --rm  -v $(pwd)/.0gchain:/root/.0gchain --name 0gchaind_init  ccr.ccs.tencentyun.com/dockerhub-repository/0g-chain-node:v0.2.3  /bin/sh -c "0gchaind config chain-id zgtendermint_16600-1"
NODE_MONIKER=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 6 | head -n 1)
echo $NODE_MONIKER
docker run --rm  -v $(pwd)/.0gchain:/root/.0gchain --name 0gchaind_init  ccr.ccs.tencentyun.com/dockerhub-repository/0g-chain-node:v0.2.3  /bin/sh -c "0gchaind init $NODE_MONIKER --chain-id zgtendermint_16600-1"
rm .0gchain/config/genesis.json
cp ./genesis.json .0gchain/config

docker run --rm  -v $(pwd)/.0gchain:/root/.0gchain --name 0gchaind_init  ccr.ccs.tencentyun.com/dockerhub-repository/0g-chain-node:v0.2.3  /bin/sh -c "0gchaind validate-genesis"

cp addrbook.json .0gchain/config/

# 配置种子
SEEDS="265120a9bb170cf21198aabf88f7908c9944897c@54.241.167.190:26656,497f865d8a0f6c830e2b73009a01b3edefb22577@54.176.175.48:26656,ffc49903241a4e442465ec78b8f421c56b3ae3d4@54.193.250.204:26656,f37bc8623bfa4d8e519207b965a24a288f3213d8@18.166.164.232:26656"
PEERS=""

sed -i "s/persistent_peers = \"\"/persistent_peers = \"$PEERS\"/" .0gchain/config/config.toml
sed -i "s/seeds = \"\"/seeds = \"$SEEDS\"/" .0gchain/config/config.toml

