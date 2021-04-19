#!/bin/bash

wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
apt update -y
apt install unzip apt-transport-https -y
apt-get install elasticsearch -y
sudo echo "network.host: localhost" | sudo tee -a /etc/elasticsearch/elasticsearch.yml
sudo echo "http.port: 9200" | sudo tee -a /etc/elasticsearch/elasticsearch.yml
sudo echo "xpack.security.enabled: true" | sudo tee -a /etc/elasticsearch/elasticsearch.yml
sudo echo "discovery.type: single-node" | sudo tee -a /etc/elasticsearch/elasticsearch.yml

systemctl start elasticsearch
systemctl enable elasticsearch

printf 'y' | /usr/share/elasticsearch/bin/elasticsearch-setup-passwords auto
service elasticsearch stop

printf '\n\n' | /usr/share/elasticsearch/bin/elasticsearch-certutil  ca
printf '\n\n' | /usr/share/elasticsearch/bin/elasticsearch-certutil cert
sudo cp /usr/share/elasticsearch/elastic-certificates.p12 /etc/elasticsearch/
printf '\n\n\n\n\n\n\n\n\n\n\n\n\n' | /usr/share/elasticsearch/bin/elasticsearch-certutil  http

unzip /usr/share/elasticsearch/elasticsearch-ssl-http.zip 

sudo cp elasticsearch/http.p12 /etc/elasticsearch/
sudo echo "xpack.security.http.ssl.enabled: true" | sudo tee -a /etc/elasticsearch/elasticsearch.yml
sudo echo "xpack.security.http.ssl.keystore.path: "http.p12"" | sudo tee -a /etc/elasticsearch/elasticsearch.yml
sudo echo "xpack.security.transport.ssl.enabled: true" | sudo tee -a /etc/elasticsearch/elasticsearch.yml
printf '\n' | /usr/share/elasticsearch/bin/elasticsearch-keystore add xpack.security.http.ssl.keystore.secure_password

systemctl start elasticsearch
