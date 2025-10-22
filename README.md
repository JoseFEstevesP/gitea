# Gitea con Docker y Nginx

Este proyecto configura un servicio de Gitea autohospedado para uso interno dentro de la empresa, utilizando Docker, con un proxy inverso Nginx que proporciona acceso a través de HTTPS y SSH únicamente dentro de la red corporativa.

## Componentes

- **Gitea**: El servicio de Git autohospedado.
- **PostgreSQL**: La base de datos para Gitea.
- **Nginx**: Actúa como proxy inverso para el tráfico web (HTTPS) y Git (SSH).
- **Redis**: Almacén de datos en memoria para caché y sesiones, mejorando el rendimiento.

## Requisitos Previos

- Docker Engine
- Docker Compose
- Git

## Instrucciones de Instalación

### 1. Clonar el Repositorio

Si estás trabajando con un repositorio Git, clónalo. Si no, asegúrate de que todos los archivos de este proyecto estén en un directorio en tu máquina.

### 2. Configurar Variables de Entorno

Copia el archivo de ejemplo `.env.example` a un nuevo archivo llamado `.env`.

```bash
cp .env.example .env
```

Abre el archivo `.env` y ajusta las variables. Como mínimo, debes configurar las contraseñas y la URL interna que usarás para acceder a Gitea. Por ejemplo:

```env
# En .env
GITEA__server__ROOT_URL=https://gitea.empresa.local
GITEA__server__SSH_DOMAIN=gitea.empresa.local
GITEA__server__DOMAIN=gitea.empresa.local
GITEA__server__SSH_PORT=22
# ... otras variables ...
```

**Importante:** `GITEA__server__SSH_PORT` se refiere al puerto _dentro_ del contenedor de Gitea, que es el `22`. El acceso se hará a través del puerto `2222` mapeado por Nginx. Asegúrate de utilizar nombres de dominio o IPs internas que estén disponibles únicamente dentro de la red corporativa.

### 3. Generar Certificados SSL

Nginx está configurado para usar HTTPS exclusivamente para acceso interno. Necesitas generar un certificado autofirmado para el dominio interno o IP que usarás dentro de la red corporativa.

```bash
cd nginx/ssl
./generate_ssl.sh
```

Cuando el script te pida una IP, introduce la IP interna que usarás (ej. `192.168.1.100`) o asegúrate de que el dominio interno esté correctamente configurado en los servidores DNS internos.

### 4. Iniciar los Servicios

Una vez configurado, inicia todos los servicios con Docker Compose.

```bash
docker-compose up -d
```

### 6. Configuración de Red Interna

Si estás utilizando un nombre de dominio personalizado (como `gitea.empresa.local`) para acceder al servicio dentro de la red corporativa, este debe estar correctamente configurado en el DNS interno de la empresa. Para pruebas locales, puedes añadirlo al archivo `hosts` de cada equipo que necesite acceder al servicio.

- **Windows**: `C:\Windows\System32\drivers\etc\hosts`
- **Linux/macOS**: `/etc/hosts`

Añade una línea como esta:

```
192.168.1.100   gitea.empresa.local
```

_(Reemplaza `gitea.empresa.local` por el dominio interno que estés usando y la IP con la dirección interna del servidor)._ 

**Nota:** En un entorno de producción, este dominio debería estar configurado en el servidor DNS interno de la empresa para que todos los usuarios puedan acceder al servicio.

## Cómo Usar Gitea

### Acceso Web

Abre tu navegador y ve a la URL interna que configuraste. Basado en el ejemplo anterior, sería:
**`https://gitea.empresa.local`**

Como estás usando un certificado autofirmado para uso interno, tu navegador mostrará una advertencia de seguridad. Debes aceptarla para continuar.

### Acceso con Git (SSH)

Para clonar, hacer push o pull de repositorios, usa el puerto `2222`.

1.  **Añade tu clave SSH a Gitea**: Primero, sube tu clave pública SSH a tu perfil de usuario en la interfaz web de Gitea.

2.  **Clona un repositorio**:
    ```bash
    git clone ssh://git@gitea.empresa.local:2222/tu-usuario/tu-repo.git
    ```

## Mantenimiento

### Detener los Servicios

```bash
docker-compose down
```

### Ver Logs

```bash
# Ver todos los logs
docker-compose logs -f

# Ver logs de un servicio específico (ej. gitea)
docker-compose logs -f server
```
