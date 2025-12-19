Markdown

# Informe de Despliegue de Servidores Nginx

**Empresa:** Servicios Web RC, S.A (Huelva)  
**Autor:** Jose Murillo Rajo  
**Curso:** CFGS ASIR  

---

## Índice
1. [Introducción](#introduccion)
2. [Comparativa con Apache](#comparativa)
3. [Esquema de Red](#esquema)
4. [Instalación](#instalacion)
5. [Casos Prácticos](#casos)
    * [a) Versión y b) Servicio](#caso-ab)
    * [c) Ficheros de configuración](#caso-c)
    * [d) Página por defecto](#caso-d)
    * [e) Virtual Hosting](#caso-e)
    * [f) Control de acceso por red](#caso-f)
    * [g) y h) Autenticación en directorio privado](#caso-gh)
    * [i) Seguridad SSL/TLS](#caso-i)
6. [Referencias](#referencias)

---

<a name="introduccion"></a>
## 1. Introducción
Este informe detalla la migración de la infraestructura web de Servicios Web RC, S.A. Se analiza la transición de Apache a Nginx para mejorar el rendimiento y la gestión de conexiones concurrentes mediante una arquitectura orientada a eventos.

<a name="comparativa"></a>
## 2. Comparativa con Apache
* **Nginx:** Arquitectura asíncrona (eventos). Bajo consumo de RAM y alta velocidad en archivos estáticos.
* **Apache:** Basado en procesos. Muy flexible mediante ficheros `.htaccess`.

<a name="esquema"></a>
## 3. Esquema de Red
El servidor cuenta con dos interfaces:
* **Interna:** Para administración y acceso desde la oficina.
* **Externa:** Para acceso público a los servicios web.



<a name="instalacion"></a>
## 4. Instalación
```bash
sudo apt update && sudo apt install nginx -y
<a name="casos"></a>

5. Casos Prácticos
<a name="caso-ab"></a>

a) Versión y b) Servicio
Comprobación de la instalación y el estado del demonio:

Bash

# Verificar versión instalada
nginx -v

# Verificar estado del servicio
systemctl status nginx
<a name="caso-c"></a>

c) Ficheros de configuración
/etc/nginx/nginx.conf: Configuración global del servidor.

/etc/nginx/sites-available/: Definición de servidores virtuales.

/etc/nginx/sites-enabled/: Enlaces simbólicos para activar sitios.

<a name="caso-d"></a>

d) Página por defecto
Personalización del archivo /var/www/html/index.nginx-debian.html:

HTML

<h1>Bienvenidos a Mi servidor web</h1>
<p>Tu Nombre: Jose Murillo Rajo</p>
<a name="caso-e"></a>

e) Virtual Hosting
Configuración de dos sitios con nombres distintos compartiendo IP y puerto 80.

Configuración www.web1.org:

Nginx

server {
    listen 80;
    server_name www.web1.org;
    root /var/www/web1;
    index index.html;
}
Configuración www.web2.org:

Nginx

server {
    listen 80;
    server_name www.web2.org;
    root /var/www/web2;
    index index.html;
}
<a name="caso-f"></a>

f) Control de acceso por red
Restricción para que www.web2.org sea accesible solo desde la red interna:

Nginx

server {
    listen 80;
    server_name www.web2.org;
    root /var/www/web2;

    allow 192.168.1.0/24; # Rango de red interna
    allow 127.0.0.1;
    deny all;
}
<a name="caso-gh"></a>

g) y h) Autenticación en directorio privado
Acceso condicional para el directorio /privado en www.web1.org:

Nginx

location /privado {
    satisfy any;

    # Acceso libre desde red interna (Caso h)
    allow 192.168.1.0/24;
    allow 127.0.0.1;
    deny all;

    # Autenticación básica para red externa (Caso g)
    auth_basic "Acceso Restringido";
    auth_basic_user_file /etc/nginx/.htpasswd;
}
<a name="caso-i"></a>

i) Seguridad SSL/TLS
Configuración de acceso seguro mediante HTTPS:

Nginx

server {
    listen 443 ssl;
    server_name www.web1.org;
 
    ssl_certificate /etc/ssl/certs/web1.crt;
    ssl_certificate_key /etc/ssl/private/web1.key;
 
    root /var/www/web1;
    index index.html;
}
<a name="referencias"></a>

6. Referencias
Nginx Official Documentation

Manual de Administración de Sistemas Operativos - CFGS ASIR

Repositorio de prácticas de Servicios de Red
