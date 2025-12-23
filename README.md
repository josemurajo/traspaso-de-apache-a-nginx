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
Este informe técnico documenta el proceso de migración de la infraestructura de servidores web de la empresa Servicios Web RC, S.A., sustituyendo el anterior servidor Apache por Nginx para optimizar el rendimiento y la escalabilidad del sistema.

<a name="comparativa"></a>
## 2. Comparativa con Apache
* **Arquitectura:** Nginx utiliza un modelo asíncrono basado en eventos, mientras que Apache se basa en procesos o hilos.
* **Consumo de Recursos:** Nginx mantiene un consumo de memoria bajo y constante incluso con altas cargas de usuarios concurrentes.
* **Gestión de Estáticos:** Nginx es significativamente más rápido sirviendo archivos estáticos (HTML, CSS, imágenes).

<a name="esquema"></a>
## 3. Esquema de Red
El servidor está configurado con dos tarjetas de red para segmentar el tráfico según los requerimientos de seguridad:
* **Tarjeta Interna:** Para acceso restringido y administración local.
* **Tarjeta Externa:** Para el acceso de clientes externos a los servicios web públicos.

<a name="instalacion"></a>
## 4. Instalación
Para instalar Nginx en el sistema se ha utilizado el gestor de paquetes oficial:

sudo apt update && sudo apt install nginx -y


---

<a name="casos"></a>
## 5. Casos Prácticos

<a name="caso-ab"></a>
### a) Versión y b) Servicio
Comprobación de la versión del software y estado actual del demonio:

Comprobar versión instalada
nginx -v

Comprobar que el servicio está activo
systemctl status nginx


<a name="caso-c"></a>
### c) Ficheros de configuración
Los ficheros principales para la gestión del servidor son:
* `/etc/nginx/nginx.conf`: Fichero de configuración global.
* `/etc/nginx/sites-available/`: Directorio donde se definen los sitios virtuales.
* `/etc/nginx/sites-enabled/`: Enlaces simbólicos para activar los sitios en el servidor.

<a name="caso-d"></a>
### d) Página por defecto
Se personaliza la página de bienvenida en

`/var/www/html/index.nginx-debian.html`:



<a name="caso-e"></a>


### e) Virtual Hosting

Configuración de dos dominios distintos compartiendo la misma IP y puerto 80.

**Dominio www.web1.org:**

server { listen 80; 

server_name www.web1.org;

root /var/www/web1; 

index index.html; }


**Dominio www.web2.org:**

server { listen 80; server_name www.web2.org; root /var/www/web2; index index.html; }


<a name="caso-f"></a>

### f) Control de acceso por red

Configuración para restringir el acceso a `www.web2.org` exclusivamente a la red interna:

server { listen 80; server_name www.web2.org; root /var/www/web2;

allow 192.168.1.0/24; # Red interna
allow 127.0.0.1;
deny all;
}


<a name="caso-gh"></a>
### g) y h) Autenticación en directorio privado

Se implementa un acceso condicional al directorio `/privado` en `www.web1.org`. La red interna accede libremente (h), mientras que la externa requiere credenciales (g):

location /privado {
satisfy any;

# Permitir acceso sin pass desde red interna
allow 192.168.1.0/24;

allow 127.0.0.1;

deny all;

# Requerir autenticación básica para red externa
auth_basic "Acceso Restringido";

auth_basic_user_file /etc/nginx/.htpasswd;
}



<a name="caso-i"></a>
### i) Seguridad SSL/TLS

Configuración del sitio `www.web1.org` para comunicación cifrada mediante HTTPS:

server { listen 443 ssl;
server_name www.web1.org;

ssl_certificate /etc/ssl/certs/web1.crt;
ssl_certificate_key /etc/ssl/private/web1.key;

root /var/www/web1;
index index.html;
}


-----

<a name="referencias"></a>
## 6\. Referencias

  * [Documentación oficial de Nginx](https://nginx.org/en/docs/)
  * Manual de Administración de Sistemas Operativos - CFGS ASIR
  * Repositorio del proyecto en GitHub: https://github.com/josemurajo/traspaso-de-apache-a-nginx
