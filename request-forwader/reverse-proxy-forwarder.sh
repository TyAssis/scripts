#! /bin/bash

# how to execute this script
# create a new file     - vim ~/forwarder.sh
# turn it executable    - chmod +x ~/forwarder.sh
# run it                - sh ~/forwarder.sh

export DB_ADDR=10.128.0.44
export DB_PORT=5432

export ETH_NAME=$(ip -o link show | awk -F': ' '{print $2}' | grep -v lo)

export LOCAL_IP_ADDR=$(ip -4 addr show $ETH_NAME | grep -Po 'inet \K[\d.]+')

echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A PREROUTING -p tcp -m tcp --dport $DB_PORT -j DNAT \
--to-destination $DB_ADDR:$DB_PORT
iptables -t nat -A POSTROUTING -j SNAT --to-source $LOCAL_IP_ADDR
