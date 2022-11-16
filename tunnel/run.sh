#!/usr/bin/with-contenv bashio

CONFIG_PATH=/data/options.json

HOST=$(jq --raw-output ".frp_server" $CONFIG_PATH)
PORT=$(jq --raw-output ".frp_server_port" $CONFIG_PATH)
TOKEN=$(jq --raw-output ".frp_token" $CONFIG_PATH)
SERVER_LOCAL=$(jq --raw-output ".local_host" $CONFIG_PATH)
PORT_LOCAL=$(jq --raw-output ".local_port" $CONFIG_PATH)
HTTP_DOMAIN=$(jq --raw-output ".http_domain" $CONFIG_PATH)
WEB_NAME=$(cat /proc/sys/kernel/random/uuid)

echo "" > /frpc.ini
echo "[common]" >> /frpc.ini
echo "server_addr = ${HOST}" >> /frpc.ini
echo "server_port = ${PORT}" >> /frpc.ini
echo "jwt_token = ${TOKEN}" >> /frpc.ini
echo "" >> /frpc.ini
echo "[${WEB_NAME}]" >> /frpc.ini
echo "type = http" >> /frpc.ini
echo "local_ip = ${SERVER_LOCAL}" >> /frpc.ini
echo "local_port = ${PORT_LOCAL}" >> /frpc.ini
echo "custom_domains = ${HTTP_DOMAIN}" >> /frpc.ini

bashio::log.info "Running frpc client..."
exec /frpc -c /frpc.ini
