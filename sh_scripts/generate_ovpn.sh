#!/bin/bash

# Убедитесь, что клиентский сертификат и ключ созданы
CLIENT_NAME=$1

if [ -z "$CLIENT_NAME" ]; then
    echo "Please provide a client name as an argument."
    exit 1
fi

cd /etc/openvpn/easy-rsa

sudo ./easyrsa gen-req $CLIENT_NAME nopass
sudo ./easyrsa sign-req client $CLIENT_NAME

sudo cp /etc/openvpn/easy-rsa/pki/ca.crt /etc/openvpn/client/ca.crt
sudo cp /etc/openvpn/easy-rsa/pki/issued/$CLIENT_NAME.crt /etc/openvpn/client/$CLIENT_NAME.crt
sudo cp /etc/openvpn/easy-rsa/pki/private/$CLIENT_NAME.key /etc/openvpn/client/$CLIENT_NAME.key

# Генерируем .ovpn файл
cat << EOF > /etc/openvpn/client/$CLIENT_NAME.ovpn
client
dev tun
proto udp
remote 5.35.112.132 1194
resolv-retry infinite
nobind
persist-key
persist-tun
remote-cert-tls server
verb 3

<ca>
$(cat /etc/openvpn/client/ca.crt)
</ca>

<cert>
$(cat /etc/openvpn/client/$CLIENT_NAME.crt)
</cert>

<key>
$(cat /etc/openvpn/client/$CLIENT_NAME.key)
</key>

EOF

echo "Client .ovpn file for '$CLIENT_NAME' generated successfully."
