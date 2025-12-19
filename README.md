# traspaso-de-apache-a-nginx
Proyecto de despliegue de servidores Nginx - ASIR
# Proyecto de Despliegue: Servidor Nginx 
[cite_start]**Empresa:** Servicios Web RC, S.A (Huelva)   
**Autor:** JOSE MURILLO RAJO  
**Curso:** CFGS ASIR

---

##  Índice
1. [Introducción](#1-introducción)
2. [Comparativa con Apache](#2-comparativa-con-apache)
3. [Esquema de red](#3-esquema-de-red)
4. [Instalación](#4-instalación)
5. [Casos Prácticos](#5-casos-prácticos)
   - [A. Versión y Servicio](#a-versión-y-servicio)
   - [B. Página por defecto](#b-página-por-defecto)
   - [C. Virtual Hosting (Web1 y Web2)](#c-virtual-hosting)
   - [D. Control de Acceso por IP](#d-control-de-acceso-por-ip)
   - [E. Autenticación Básica](#e-autenticación-básica)
   - [F. Seguridad SSL/TLS (HTTPS)](#f-seguridad-ssltls)
6. [Referencias](#6-referencias)

---

## 1. Introducción
[cite_start]Este informe detalla la migración de la infraestructura de Apache a Nginx para la empresa Servicios Web RC, S.A.[cite: 3]. Se analiza su arquitectura orientada a eventos y su capacidad de respuesta bajo carga.

## 2. Comparativa con Apache
[cite_start]Nginx destaca sobre Apache en el manejo de contenido estático y concurrencia[cite: 9]:
- **Nginx:** Arquitectura asíncrona (eventos). Consume menos RAM.
- **Apache:** Basado en procesos (fork). Más flexible con `.htaccess`.

## 3. Esquema de Red
[cite_start]El servidor dispone de dos interfaces de red[cite: 10, 11]:
- **Interfaz Externa:** Acceso público.
- **Interfaz Interna:** Acceso privado de la oficina.

## 4. Instalación
[cite_start]Para instalar Nginx en nuestro sistema Debian/Ubuntu[cite: 12]:
```bash
sudo apt update && sudo apt install nginx -y
