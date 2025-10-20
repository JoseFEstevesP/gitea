# Configuración de Gitea con Docker

Este repositorio contiene los archivos de configuración de Docker necesarios para ejecutar Gitea, un servicio Git autohospedado con PostgreSQL.

## Requisitos previos

- Docker Engine (versión 18.09 o posterior)
- Docker Compose (versión 1.25 o posterior)

## Comenzando

1. Asegúrate de tener Docker y Docker Compose instalados en tu sistema.

2. Clona o copia estos archivos a un directorio de tu elección.

3. Crea la estructura de directorios requerida:
   ```bash
   mkdir -p gitea postgres
   ```

4. Ejecuta el siguiente comando para iniciar Gitea:
   ```bash
   docker-compose up -d
   ```

5. Espera a que los contenedores se inicien. Puedes verificar el estado con:
   ```bash
   docker-compose logs -f
   ```

6. Accede a Gitea en tu navegador en `http://localhost:3000`

7. Sigue el asistente de instalación para completar la configuración.

## Configuración por defecto

- Interfaz web de Gitea: `http://localhost:3000`
- Puerto SSH: `2222` (mapea al SSH de tu host si es necesario)
- Base de datos: PostgreSQL
- Nombre de la base de datos: `gitea`
- Usuario de la base de datos: `gitea`
- Contraseña de la base de datos: `gitea`

## Registro de usuarios

El registro de nuevos usuarios está **deshabilitado** por defecto. Solo un administrador puede crear cuentas de usuario.
Si deseas habilitar el registro, cambia `GITEA__service__DISABLE_REGISTRATION=true` a `false` en el archivo `.env`.

## Persistencia de datos

Los datos se almacenan en los siguientes directorios:
- `./gitea` - Datos de la aplicación Gitea
- `./postgres` - Datos de la base de datos PostgreSQL

Asegúrate de hacer copias de seguridad de estos directorios regularmente.

## Detener los servicios

Para detener los servicios:
```bash
docker-compose down
```

## Actualizar Gitea

Para actualizar a la última versión:
1. Obtén la última imagen: `docker-compose pull`
2. Reinicia los servicios: `docker-compose up -d`

## Consideraciones de seguridad

Para uso en producción:
- Cambia las contraseñas predeterminadas en el archivo `.env`
- Usa HTTPS con un proxy inverso (nginx, Apache, etc.)
- Configura reglas de firewall adecuadas
- Mantén actualizadas las imágenes de Docker
- Revisa la configuración de registro de usuarios en el archivo .env