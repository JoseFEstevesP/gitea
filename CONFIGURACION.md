# Personalización de variables de entorno para Gitea

## Variables disponibles

Puedes personalizar los valores en el archivo `.env` según tus necesidades:

### Configuración general de Gitea
- `GITEA__server__ROOT_URL`: URL raíz donde se accederá a Gitea (por defecto: http://localhost:3000)
- `GITEA__server__SSH_DOMAIN`: Dominio para conexiones SSH (por defecto: localhost)
- `GITEA__server__DOMAIN`: Dominio del servidor (por defecto: localhost)
- `GITEA__server__HTTP_PORT`: Puerto HTTP de Gitea (por defecto: 3000)
- `GITEA__server__SSH_PORT`: Puerto SSH de Gitea (por defecto: 2222)

### Configuración de la base de datos
- `DB_TYPE`: Tipo de base de datos (por defecto: postgres)
- `DB_HOST`: Host de la base de datos (por defecto: db:5432)
- `DB_NAME`: Nombre de la base de datos (por defecto: gitea)
- `DB_USER`: Usuario de la base de datos (por defecto: gitea)
- `DB_PASSWD`: Contraseña de la base de datos (por defecto: gitea)

### Configuración de PostgreSQL
- `POSTGRES_DB`: Nombre de la base de datos PostgreSQL (por defecto: gitea)
- `POSTGRES_USER`: Usuario de PostgreSQL (por defecto: gitea)
- `POSTGRES_PASSWORD`: Contraseña de PostgreSQL (por defecto: gitea)

## Ejemplo de archivo .env personalizado

```
# Configuración de Gitea
GITEA__server__ROOT_URL=http://mi-gitea.dominio.com
GITEA__server__SSH_DOMAIN=mi-gitea.dominio.com
GITEA__server__DOMAIN=mi-gitea.dominio.com
GITEA__server__HTTP_PORT=3000
GITEA__server__SSH_PORT=22

# Configuración de la base de datos
DB_TYPE=postgres
DB_HOST=db:5432
DB_NAME=gitea
DB_USER=gitea_usuario
DB_PASSWD=gitea_contraseña_segura

# Configuración de PostgreSQL
POSTGRES_DB=gitea
POSTGRES_USER=gitea_usuario
POSTGRES_PASSWORD=gitea_contraseña_segura
```

## Recomendaciones de seguridad

1. Cambia las contraseñas predeterminadas antes de usar en producción
2. Usa contraseñas seguras para la base de datos
3. Considera usar una red privada para la comunicación entre contenedores
4. Usa HTTPS con un proxy inverso como nginx para conexiones externas