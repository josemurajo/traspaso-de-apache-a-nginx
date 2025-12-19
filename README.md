<<<<<<< HEAD
# traspaso-de-apache-a-nginx
Proyecto de despliegue de servidores Nginx - ASIR
# Proyecto de Despliegue: Servidor Nginx 
[cite_start]**Empresa:** Servicios Web RC, S.A (Huelva)   
**Autor:** JOSE MURILLO RAJO  
**Curso:** CFGS ASIR
=======
# Informe de Migración: Servidor Nginx 
**Empresa:** Servicios Web RC, S.A (Huelva)
**Autor:** Jose
>>>>>>> 5460c92 (Instalación de Nginx y configuración inicial del informe)

---

## Índice
1. [Introducción](#introduccion)
2. [Comparativa con Apache](#comparativa)
3. [Esquema de red](#esquema)
4. [Instalación](#instalacion)
5. [Casos Prácticos](#casos)
6. [Referencias](#referencias)

---

<a name="introduccion"></a>
## 1. Introducción
[cite_start]Este informe detalla la migración de la infraestructura de Apache a Nginx para la empresa Servicios Web RC, S.A.[cite: 3]. Se analiza su arquitectura orientada a eventos y su capacidad de respuesta bajo carga.

<a name="comparativa"></a>
## 2. Comparativa con Apache
[cite_start]Nginx destaca sobre Apache en el manejo de contenido estático y concurrencia[cite: 9]:
- **Nginx:** Arquitectura asíncrona (eventos). Consume menos RAM.
- **Apache:** Basado en procesos (fork). Más flexible con `.htaccess`.

<a name="esquema"></a>
## 3. Esquema de Red
[cite_start]El servidor dispone de dos interfaces de red[cite: 10, 11]:
- **Interfaz Externa:** Acceso público.
- **Interfaz Interna:** Acceso privado de la oficina.



<a name="instalacion"></a>
## 4. Instalación
[cite_start]Para instalar Nginx en nuestro sistema Debian/Ubuntu se han ejecutado los siguientes comandos[cite: 12]:
```bash
sudo apt update && sudo apt install nginx -y
