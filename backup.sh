#!/bin/sh

# Previene la ejecución si alguna variable de entorno esencial no está configurada
set -u

TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_FILE="/backups/backup_${TIMESTAMP}.sql.gz"

echo "Creando backup..."

# Realizar el backup
PGPASSWORD="$POSTGRES_PASSWORD" pg_dump -h "$POSTGRES_HOST" -U "$POSTGRES_USER" -d "$POSTGRES_DB" | gzip > "$BACKUP_FILE"

# Verificar si el backup se creó correctamente
if [ $? -eq 0 ]; then
  echo "Backup creado exitosamente: $BACKUP_FILE"
else
  echo "Error al crear el backup."
  exit 1
fi

# Eliminar backups antiguos (si RETENTION_DAYS está configurado y es mayor que 0)
if [ -n "${RETENTION_DAYS:-}" ] && [ "$RETENTION_DAYS" -gt 0 ]; then
  echo "Eliminando backups con más de $RETENTION_DAYS días de antigüedad..."
  find /backups -name "backup_*.sql.gz" -type f -mtime +$RETENTION_DAYS -exec rm -f {} \;
  echo "Limpieza de backups antiguos completada."
fi
