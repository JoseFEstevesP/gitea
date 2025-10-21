# Guía de Variables de Entorno (.env)

Este archivo detalla las variables de entorno que puedes configurar en tu archivo `.env` para personalizar la instancia de Gitea.

## Configuración del Servidor Gitea

Estas variables definen cómo Gitea se ve a sí mismo y cómo construye las URLs para el acceso web y SSH.

- `GITEA__server__ROOT_URL`

  - **Descripción**: La URL base completa que los usuarios usarán para acceder a la interfaz web de Gitea. Debe coincidir con la configuración de tu proxy inverso (Nginx).
  - **Ejemplo**: `https://000.000.0.000` o `https://gitea.dominio.com`

- `GITEA__server__DOMAIN`

  - **Descripción**: El nombre de dominio o IP del servidor, sin el protocolo.
  - **Ejemplo**: `000.000.0.000`

- `GITEA__server__SSH_DOMAIN`

  - **Descripción**: El dominio o IP que se usará para las URLs de Git sobre SSH. Debe ser el mismo que `DOMAIN` en esta configuración.
  - **Ejemplo**: `000.000.0.000`

- `GITEA__server__HTTP_PORT`

  - **Descripción**: El puerto en el que el contenedor de Gitea escucha internamente. El proxy inverso (Nginx) se conectará a este puerto.
  - **Valor por defecto**: `3000` (No deberías necesitar cambiarlo).

- `GITEA__server__SSH_PORT`
  - **Descripción**: El puerto en el que el servicio SSH de Gitea escucha _dentro del contenedor_. Nginx redirigirá el tráfico SSH a este puerto.
  - **Valor por defecto**: `22` (No deberías necesitar cambiarlo).

---

---

## Configuración de la Base de Datos (Gitea)

Estas variables le dicen a Gitea cómo conectarse a la base de datos PostgreSQL.

- `DB_TYPE`: `postgres`
- `DB_HOST`: `db:5432` (Usa el nombre del servicio de Docker y el puerto interno).
- `DB_NAME`: El nombre de la base de datos (ej. `gitea`).
- `DB_USER`: El usuario para la base de datos.
- `DB_PASSWD`: La contraseña para el usuario de la base de datos.

---

## Configuración del Contenedor PostgreSQL

Estas variables se usan para inicializar el contenedor de la base de datos la primera vez que se ejecuta. **Deben coincidir con las credenciales que le proporcionas a Gitea arriba**.

- `POSTGRES_DB`: Nombre de la base de datos a crear.
- `POSTGRES_USER`: Usuario a crear.
- `POSTGRES_PASSWORD`: Contraseña para el nuevo usuario.

---

## Configuración del Registro de Usuarios

- `GITEA__service__DISABLE_REGISTRATION`
  - **Descripción**: Controla si los nuevos usuarios pueden registrarse por sí mismos.
  - `true`: Deshabilita el registro público (recomendado). Solo un administrador puede crear usuarios.
  - `false`: Permite que cualquiera se registre.

---

## Configuración de Seguridad

Estas variables controlan aspectos importantes de seguridad en tu instancia de Gitea.

- `GITEA__service__REQUIRE_SIGNIN_VIEW`
  - **Descripción**: Requiere que los usuarios inicien sesión para ver cualquier contenido en Gitea. Si está en `true`, todos los repositorios y páginas serán privadas para usuarios no autenticados.
  - **Valores posibles**: `true` (recomendado para entornos privados) o `false`
  - **Valor por defecto**: `false`

- `GITEA__repository__DEFAULT_PRIVATE`
  - **Descripción**: Establece el nivel de privacidad predeterminado para los nuevos repositorios creados.
  - **Valores posibles**: `private` (recomendado) o `public`
  - **Valor por defecto**: `public`

- `GITEA__repository__ENABLE_PUSH_CREATE_USER`
  - **Descripción**: Controla si los usuarios pueden crear automáticamente nuevos repositorios mediante push de Git.
  - **Valores posibles**: `false` (recomendado) o `true`
  - **Valor por defecto**: `true`

- `GITEA__repository__ENABLE_PUSH_CREATE_ORG`
  - **Descripción**: Controla si las organizaciones pueden crear automáticamente nuevos repositorios mediante push de Git.
  - **Valores posibles**: `false` (recomendado) o `true`
  - **Valor por defecto**: `true`

- `GITEA__repository__DISABLE_HTTP_GIT`
  - **Descripción**: Deshabilita clonación/interacción por HTTP/HTTPS para Git. Solo permite acceso por SSH si está habilitado.
  - **Valores posibles**: `false` (por defecto) o `true` (más restrictivo)
  - **Valor por defecto**: `false`

---

## Configuración de Backups

Estas variables controlan el comportamiento del servicio de copias de seguridad.

- `RETENTION_DAYS`

  - **Descripción**: El número de días que se conservarán los archivos de backup. Los backups más antiguos que este número de días se eliminarán automáticamente.
  - **Valor por defecto**: `7`

- `BACKUP_INTERVAL_SECONDS`
  - **Descripción**: El intervalo de tiempo en segundos entre cada copia de seguridad.
  - **Valor por defecto**: `43200` (equivale a 12 horas).
