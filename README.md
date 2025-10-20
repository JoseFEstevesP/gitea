# Gitea con Docker y Nginx

Este proyecto configura un servicio de Gitea autohospedado utilizando Docker, con un proxy inverso Nginx que proporciona acceso a través de HTTPS y SSH.

## Componentes

- **Gitea**: El servicio de Git autohospedado.
- **PostgreSQL**: La base de datos para Gitea.
- **Nginx**: Actúa como proxy inverso para el tráfico web (HTTPS) y Git (SSH).

## Requisitos Previos

- Docker Engine
- Docker Compose
- OpenSSL (para generar certificados)
- Git

## Instrucciones de Instalación

### 1. Clonar el Repositorio

Si estás trabajando con un repositorio Git, clónalo. Si no, asegúrate de que todos los archivos de este proyecto estén en un directorio en tu máquina.

### 2. Configurar Variables de Entorno

Copia el archivo de ejemplo `.env.example` a un nuevo archivo llamado `.env`.

```bash
cp .env.example .env
```

Abre el archivo `.env` y ajusta las variables. Como mínimo, debes configurar las contraseñas y la URL que usarás para acceder a Gitea. Por ejemplo:

```env
# En .env
GITEA__server__ROOT_URL=https://192.168.0.111
GITEA__server__SSH_DOMAIN=192.168.0.111
GITEA__server__DOMAIN=192.168.0.111
GITEA__server__SSH_PORT=22
# ... otras variables ...
```

**Importante:** `GITEA__server__SSH_PORT` se refiere al puerto _dentro_ del contenedor de Gitea, que es el `22`. El acceso externo se hará a través del puerto `2222` mapeado por Nginx.

### 3. Generar Certificados SSL

Nginx está configurado para usar HTTPS. Necesitas generar un certificado autofirmado para el dominio o IP que usarás.

```bash
cd nginx/ssl
./generate_ssl.sh
```

Cuando el script te pida una IP, introduce la misma que usaste en el archivo `.env` (ej. `192.168.1.001`).

### 4. Iniciar los Servicios

Una vez configurado, inicia todos los servicios con Docker Compose.

```bash
docker-compose up -d
```

### 5. Configuración de Red Local (Opcional, pero recomendado)

Si usaste un nombre de dominio personalizado (como `gitea.local`) en lugar de una IP en los pasos anteriores, debes añadirlo a tu archivo `hosts` local para poder acceder desde tu navegador.

- **Windows**: `C:\Windows\System32\drivers\etc\hosts`
- **Linux/macOS**: `/etc/hosts`

Añade una línea como esta:

```
127.0.0.1   gitea.local
```

_(Reemplaza `127.0.0.1` por la IP de tu máquina si es diferente, y `gitea.local` por el dominio que elegiste)._

## Cómo Usar Gitea

### Acceso Web

Abre tu navegador y ve a la URL que configuraste. Basado en el ejemplo anterior, sería:
**`https://192.168.1.001`**

Como estás usando un certificado autofirmado, tu navegador mostrará una advertencia de seguridad. Debes aceptarla para continuar.

### Acceso con Git (SSH)

Para clonar, hacer push o pull de repositorios, usa el puerto `2222`.

1.  **Añade tu clave SSH a Gitea**: Primero, sube tu clave pública SSH a tu perfil de usuario en la interfaz web de Gitea.

2.  **Clona un repositorio**:
    ```bash
    git clone ssh://git@192.168.1.001:2222/tu-usuario/tu-repo.git
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
