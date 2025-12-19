<<<<<<< HEAD
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
=======
# Proyecto de Migración: Servidor Nginx
[cite_start]**Empresa:** Servicios Web RC, S.A (Huelva) [cite: 2]
**Consultor:** Jose
>>>>>>> 7746f8b (Primer Commit: Estructura del informe, introduccion y comparativa)

---

##  Índice
1. [Introducción](#intro)
2. [Comparativa con Apache](#comp)
3. [Esquema de red](#red)
4. [Instalación](#inst)
5. [Casos Prácticos](#casos)
6. [Referencias](#ref)

---

<a name="intro"></a>
## 1. Introducción
[cite_start]Este informe detalla la migración de Apache a Nginx para Servicios Web RC, S.A.[cite: 2, 3]. [cite_start]Se analiza su arquitectura orientada a eventos para mejorar el rendimiento[cite: 4].

<a name="comp"></a>
## 2. Comparativa con Apache
[cite_start]Nginx destaca en el manejo de contenido estático y concurrencia comparado con Apache[cite: 9]:
- **Nginx:** Arquitectura asíncrona basada en eventos. [cite_start]Consume menos RAM[cite: 9].
- **Apache:** Arquitectura basada en procesos. [cite_start]Mayor flexibilidad con ficheros .htaccess[cite: 9].

<a name="red"></a>
## 3. Esquema de Red
[cite_start]El servidor se configura con dos interfaces de red físicas[cite: 10, 11]:
- **Interfaz Externa:** Acceso público a los servicios.
- **Interfaz Interna:** Acceso privado para administración interna.



<a name="inst"></a>
## 4. Instalación
[cite_start]Se instala Nginx en el sistema Debian/Ubuntu mediante el comando[cite: 12]:
```bash
sudo apt update && sudo apt install nginx -y
