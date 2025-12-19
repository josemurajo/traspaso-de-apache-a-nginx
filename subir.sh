#!/bin/bash
# Copiamos las configuraciones de Nginx al repositorio para que se vean en GitHub
cp /etc/nginx/sites-available/web1 .
cp /etc/nginx/sites-available/web2 .

# Añadimos los archivos al control de Git
git add .

# Pedimos que escribas qué has hecho
echo "Escribe un breve resumen de lo que has configurado:"
read mensaje

# Hacemos el commit y subimos a la nube
git commit -m "$mensaje"
git push origin main
