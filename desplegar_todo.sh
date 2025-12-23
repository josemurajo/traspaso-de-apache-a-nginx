#!/bin/bash

# 1. LIMPIEZA TOTAL
echo "--- Limpiando configuración previa ---"
sudo rm -f /etc/nginx/sites-enabled/default
sudo rm -f /etc/nginx/sites-enabled/web1.conf
sudo rm -f /etc/nginx/sites-enabled/web2.conf
sudo rm -rf /var/www/web1 /var/www/web2

# 2. CREACIÓN DE ESTRUCTURA Y CONTENIDO
echo "--- Creando directorios y archivos HTML ---"
sudo mkdir -p /var/www/web1/privado
sudo mkdir -p /var/www/web2

echo "<h1>Bienvenida a la página web1</h1>" | sudo tee /var/www/web1/index.html
echo "<h1>Zona privada de Web1</h1>" | sudo tee /var/www/web1/privado/index.html
echo "<h1>Bienvenida a la página web2</h1>" | sudo tee /var/www/web2/index.html

# 3. SEGURIDAD: SSL Y CONTRASEÑAS
echo "--- Generando certificados SSL y contraseñas ---"
# Certificado para web1.org
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/ssl/private/web1.key \
  -out /etc/ssl/certs/web1.crt \
  -subj "/C=ES/ST=Andalucia/L=Huelva/O=Servicios Web RC/CN=www.web1.org"

# Usuario jose / password jose1234
sudo apt install apache2-utils -y
sudo htpasswd -b -c /etc/nginx/.htpasswd jose jose1234

# 4. CONFIGURACIÓN DE NGINX
echo "--- Creando archivos de configuración ---"

# Archivo web1.conf
cat <<EOF > web1.conf
server {
    listen 80;
    listen 443 ssl;
    server_name www.web1.org;

    ssl_certificate /etc/ssl/certs/web1.crt;
    ssl_certificate_key /etc/ssl/private/web1.key;

    root /var/www/web1;
    index index.html;

    location /privado {
        satisfy any;
        allow 192.168.1.0/24;
        allow 127.0.0.1;
        auth_basic "Acceso Restringido";
        auth_basic_user_file /etc/nginx/.htpasswd;
    }
}
EOF

# Archivo web2.conf
cat <<EOF > web2.conf
server {
    listen 80;
    server_name www.web2.org;

    root /var/www/web2;
    index index.html;

    allow 192.168.1.0/24;
    allow 127.0.0.1;
    deny all;
}
EOF

# 5. ACTIVACIÓN Y REINICIO
echo "--- Activando sitios y reiniciando Nginx ---"
sudo cp web1.conf web2.conf /etc/nginx/sites-available/
sudo ln -sf /etc/nginx/sites-available/web1.conf /etc/nginx/sites-enabled/
sudo ln -sf /etc/nginx/sites-available/web2.conf /etc/nginx/sites-enabled/

# 6. RESOLUCIÓN ESTÁTICA LOCAL
if ! grep -q "www.web1.org" /etc/hosts; then
  echo "127.0.0.1 www.web1.org www.web2.org" | sudo tee -a /etc/hosts
fi

sudo nginx -t && sudo systemctl restart nginx
echo "--- DESPLIEGUE COMPLETADO CON ÉXITO ---"
