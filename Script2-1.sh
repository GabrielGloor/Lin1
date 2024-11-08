#!/bin/bash

# Installation des paquets nécessaires
apt -y install net-tools
apt -y install apache2
apt -y install apache2-utils
apt -y install mariadb-server
apt -y install libapache2-mod-php
apt -y install php
apt -y install php-zip
apt -y install php-mbstring
apt -y install php-xml
apt -y install php-gd
apt -y install php-curl
apt -y install php-mysql
apt -y install php-ldap
apt -y install php-wget
apt -y install php-unzip
apt -y install certbot 
apt -y install python3-certbot-apache
apt -y install nfs-common

# Configuration du hostname
echo "Configuration du hostname..."
hostnamectl set-hostname SRV-LIN1-02.lin1.local

# Configuration du DNS
echo "Configuration du DNS..."
cat <<EOT > /etc/resolv.conf
domain lin1.local
search lin1.local
nameserver 10.10.10.11
EOT

# Configuration de l'interface réseau
echo "Configuration de l'interface réseau..."
cat <<EOT > /etc/network/interfaces

# The loopback network interface
auto lo
iface lo inet loopback

# Interface ens33 (Host-Only)
auto ens33
allow-hotplug ens33
iface ens33 inet static
address 10.10.10.22/24
gateway 10.10.10.11
EOT

# Redémarrage du service pour appliquer les changements
echo "Redémarrage du service réseau..."
systemctl restart networking.service

echo "Configuration de base terminée pour SRV-LIN1-02."

