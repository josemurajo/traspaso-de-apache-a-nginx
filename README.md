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
Este informe técnico detalla la migración de la infraestructura de servidores web de la empresa Servicios Web RC, S.A., pasando de una arquitectura basada en Apache a Nginx. El objetivo es aprovechar la arquitectura de Nginx para mejorar la eficiencia en el manejo de conexiones concurrentes.

<a name="comparativa"></a>
## 2. Comparativa con Apache
* **Arquitectura:** Apache utiliza un modelo basado en procesos (un hilo por conexión), mientras que Nginx utiliza una arquitectura orientada a eventos asíncrona.
* **Consumo de recursos:** Nginx consume significativamente menos memoria RAM bajo cargas elevadas de usuarios.
* **Contenido estático:** Nginx es considerablemente más rápido sirviendo archivos estáticos (HTML, imágenes).

<a name="esquema"></a>
## 3. Esquema de Red
El servidor Nginx está configurado con dos tarjetas de red para segmentar el tráfico:
* **Interfaz Externa:** Conectada a la red pública para acceso general.
* **Interfaz Interna:** Conectada a la red local de la oficina para tareas administrativas y servicios internos.

<a name="instalacion"></a>
## 4. Instalación
Para instalar Nginx en un sistema basado en Debian/Ubuntu, se ejecutan los siguientes comandos:
```bash
sudo apt update
sudo apt install nginx -y
