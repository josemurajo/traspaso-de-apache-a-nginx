# Informe de Despliegue de Servidores Nginx

**Nombre:** Jose Murillo Rajo  
**Empresa:** Servicios Web RC, S.A (Sevilla)  
**Curso:** CFGS ASIR  

---

## Índice
1. [Introducción](#1-introducción)
2. [Comparativa con Apache](#2-comparativa-con-apache)
3. [Esquema de Red](#3-esquema-de-red)
4. [Instalación](#4-instalación)
5. [Casos Prácticos](#5-casos-prácticos)
    * [Virtual Hosting](#virtual-hosting)
    * [Autorización por Red](#autorización-por-red)
    * [Autorización en Directorio Privado](#autorización-en-directorio-privado)
    * [Seguridad SSL/TLS](#seguridad-ssltls)
6. [Scripts de Despliegue](#6-scripts-de-despliegue)
7. [Referencias](#7-referencias)

---

## 1. Introducción
Este proyecto documenta la migración y despliegue de un servidor Nginx diseñado para gestionar múltiples dominios con diferentes niveles de seguridad y acceso.

## 2. Comparativa con Apache
* **Arquitectura:** Nginx usa un modelo basado en eventos (más ligero).
* **Rendimiento:** Mejor gestión de conexiones simultáneas que Apache.

## 3. Esquema de Red
Servidor con doble interfaz de red:
* **Interna:** Administración y red local confiable.
* **Externa:** Tráfico público de Internet.



## 4. Instalación

### Paso 1: Instalación del Servidor
Actualizamos los repositorios e instalamos el paquete de Nginx:

sudo apt update && sudo apt install nginx -y

### Paso 2: Creación de la Estructura de Directorios

Creamos las carpetas donde se alojarán los archivos HTML de cada sitio, incluyendo el directorio protegido:

sudo mkdir -p /var/www/web1/privado

sudo mkdir -p /var/www/web2

Puedes ver un ejemplo del contenido aquí: [index.html](./web2/index.html) de [index.html](./web1/privado/index.html)

### Paso 3: Despliegue de Configuraciones (Virtual Hosts)

Se deben copiar los archivos de configuración del repositorio a la ruta de Nginx y crear los enlaces simbólicos para activarlos:

Copiar [Configuración Sitio 1](./web1.conf) y [Configuración Sitio 2](./web2.conf) a /etc/nginx/sites-available/.

Activar los sitios:



sudo ln -s /etc/nginx/sites-available/web1.conf /etc/nginx/sites-enabled/

sudo ln -s /etc/nginx/sites-available/web2.conf /etc/nginx/sites-enabled/

### Paso 4: Configuración de Seguridad (SSL y Usuarios)

#### Generación de Certificados SSL/TLS (OpenSSL)
Para habilitar el protocolo HTTPS en el sitio www.web1.org, se deben generar el [Certificado publico](./web1.crt) y la [Clave privada ](./web1.key) siguiendo estos pasos:

##### 1. Instalación de la herramienta
Primero, asegúrate de tener instalado el paquete OpenSSL en tu sistema Linux:


sudo apt update && sudo apt install openssl -y

##### 2. Ejecución del comando de generación

Utilizaremos un único comando para crear ambos archivos [Certificado publico](./web1.crt) y [Clave privada ](./web1.key). Ejecutando  en la terminal:


openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout web1.key -out web1.crt

##### 3. Explicación de los parámetros utilizados:

req -x509: Especifica que queremos crear un certificado autofirmado estándar.

-nodes: (No DES) Evita que la clave privada se cifre con una contraseña. Esto es fundamental para que Nginx pueda leer la clave y arrancar el servicio automáticamente sin intervención humana.

-days 365: Define la duración de la validez del certificado (un año).

-newkey rsa:2048: Genera simultáneamente una nueva clave RSA de 2048 bits.

-keyout web1.key: Define el nombre del archivo de la clave privada.

-out web1.crt: Define el nombre del archivo del certificado público.

##### 4. Configuración del Common Name (CN)

Al ejecutar el comando, la terminal te pedirá varios datos (País, Provincia, Organización, etc.). El campo más importante es el Common Name

se debe de  escribir exactamente el dominio: www.web1.org. Si no coincide, el navegador mostrará un error de nombre de host no válido.

##### 5. Ubicación en el servidor
Una vez que tenemos generados los ficheros en tu carpeta de trabajo, para que Nginx los utilice deben estar ubicados en las rutas estándar de seguridad:

Clave privada: /etc/ssl/private/[web1.key](./web1.key)

Certificado: /etc/ssl/certs/[web1.crt](./web1.crt)

Certificados: Generar web1.key y web1.crt mediante OpenSSL y moverlos :
/etc/ssl/certs/ y /etc/ssl/private/.

Contraseñas: Crear el archivo  para la autenticación del directorio privado:

sudo htpasswd -c /etc/nginx/[.htpasswd](./.htpasswd) jose

Paso 5: Verificación y Reinicio
Finalmente, comprobamos que no haya errores de sintaxis y reiniciamos el servicio para aplicar todos los cambios:

sudo nginx -t

sudo systemctl restart nginx

Este proceso es el que realiza de forma automática el escript creado al que he llamado  script de despliegue: 

desplegar_todo.sh.

se puede usar para tener al momento y hacer las comprovaciones


## 5. Casos Prácticos
<a name="virtual-hosting"></a>

Virtual Hosting
Se han configurado dos sitios virtuales accesibles por nombre de dominio:

Sitio 1: www.web1.org -> [Configuración Sitio 1](./web1.conf)

Sitio 2: www.web2.org -> [Configuración Sitio 2](./web2.conf)




<a name="autorización-por-red"></a>

Autorización por Red
Siguiendo los requisitos de seguridad:

Red Interna: Tiene acceso total a ambos dominios.

Red Externa: Puede acceder a www.web1.org, pero tiene el acceso denegado a www.web2.org.

esto se ve en: [web2.conf](./web2.conf)


allow 192.168.1.0/24; # Red interna

allow 127.0.0.1;

deny all;             # Bloqueo para red externa
<a name="autorización-en-directorio-privado"></a>

## Autorización en Directorio Privado
### Configuración del acceso al directorio web1/privado/:

Cliente Red Interna: Accede sin pedir credenciales.

Cliente Red Externa: Se le solicitan credenciales de acceso.

Código aplicado en: [web1.conf](./web1.conf):



location /privado {

    satisfy any;
    
    allow 192.168.1.0/24; # Acceso libre interna
    
    deny all;
    
    auth_basic "Acceso Restringido";
    
    auth_basic_user_file /etc/nginx/.htpasswd; # Ver fichero [.htpasswd](./.htpasswd)
    
}

<a name="seguridad-ssltls"></a>


## Seguridad SSL/TLS
### Configuración del sitio https://www.web1.org para asegurar la comunicación.

[Certificado (web1.crt)](./web1.crt)

[Clave privada (web1.key)](./web1.key)

[usuario y contraseña para la autenticacion](./.htpasswd)



## 6. Scripts de Despliegue
Para cumplir con la automatización del despliegue:

[para un deplay rapido](./desplegar_todo.sh)

[para ir subiendo al github](./subir.sh)

## 7. Referencias
[Nginx Documentation](https://nginx.org/en/docs/)
https://nginx.org/en/docs/beginners_guide.html
[Configuring HTTPS servers](https://ssl-config.mozilla.org/#server=nginx&version=1.27.3&config=intermediate&openssl=3.4.0&guideline=5.7)
