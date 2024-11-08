#!/bin/bash

# Téléchargement de Nextcloud
echo "Téléchargement de Nextcloud..."
wget https://download.nextcloud.com/server/releases/latest.zip -P /tmp

# Création du dossier d'installation
echo "Création du dossier d'installation pour Nextcloud..."
mkdir -p /var/www/html

# Extraction de Nextcloud
echo "Extraction de Nextcloud..."
unzip /tmp/latest.zip -d /var/www/html/

# Configuration des droits sur le dossier Nextcloud
echo "Configuration des droits pour Nextcloud..."
chown -R www-data:www-data "/var/www/html/nextcloud"
chmod -R 755 "/var/www/html/nextcloud"

# Redémarrage d'Apache
echo "Redémarrage d'Apache..."
systemctl restart apache2

# Configuration de MariaDB
echo "Configuration de MariaDB pour Nextcloud..."
mysql --user=root --password="Password" <<MYSQL_SCRIPT
CREATE DATABASE IF NOT EXISTS \`nextcloud\`;
CREATE USER IF NOT EXISTS 'admin'@'localhost' IDENTIFIED BY 'Password';
GRANT ALL PRIVILEGES ON \`nextcloud\`.* TO 'admin'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

# Configuration d'Apache pour Nextcloud
echo "Configuration d'Apache pour Nextcloud..."
cat <<EOT > /etc/apache2/sites-available/nextcloud.conf
<VirtualHost *:80>
    DocumentRoot /var/www/html/nextcloud
    ServerName srv-lin1-02.lin1.local

    <Directory /var/www/html/nextcloud/>
        Require all granted
        AllowOverride All
        Options FollowSymLinks MultiViews
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/nextcloud_error.log
    CustomLog \${APACHE_LOG_DIR}/nextcloud_access.log combined
</VirtualHost>
EOT

# Activation du site et des modules Apache requis
echo "Activation du site et des modules Apache requis..."
a2ensite nextcloud.conf
a2enmod rewrite headers env dir mime setenvif ssl

# Recharge Apache avec la nouvelle configuration
echo "Redémarrage d'Apache avec la nouvelle configuration..."
systemctl reload apache2

echo "Installation et configuration de Nextcloud terminées pour SRV-LIN1-02."

