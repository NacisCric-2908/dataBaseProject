# Solución Completa del Proyecto (Django + Oracle XE 11g Opcional)

Este documento resume la situación actual del proyecto, las decisiones técnicas tomadas y los pasos para operar y extender la solución.

## 1. Objetivo

Proveer una aplicación Django que pueda funcionar con Oracle XE 11g a pesar de las restricciones de versión, utilizando un backend personalizado y el modo thick de `oracledb`/`cx_Oracle`.

## 2. Componentes Clave

- Django (versión LTS elegida: 4.2.x)
- Backend personalizado: `dbProject/oracle_backend/base.py`
- Conexión manual en vistas: `dbProject/project/views.py`
- Script de verificación: `test_connection.py`

## 3. Problemas Abordados

| Problema                              | Causa                              | Solución                                                |
| ------------------------------------- | ---------------------------------- | ------------------------------------------------------- |
| Oracle 11g no soportado en modo thin  | Limitación driver                  | Uso modo thick + Instant Client                         |
| Verificación de versión Django/Oracle | Core Django exige versión reciente | Sobrescritura método `check_database_version_supported` |
| Falta de cliente Oracle               | No instalado / PATH incorrecto     | Inicialización con `init_oracle_client(lib_dir=...)`    |

## 4. Dependencias Instalas (directas)

```text
Django==4.2.16
oracledb==3.4.1
cx_Oracle==8.3.0
```

Las transitivas (asgiref, sqlparse, pytz) las gestiona pip automáticamente.

## 5. Backend Personalizado

Archivo: `oracle_backend/base.py`

```python
from django.db.backends.oracle.base import DatabaseWrapper as OracleDatabaseWrapper

class DatabaseWrapper(OracleDatabaseWrapper):
    def check_database_version_supported(self):
        # Omitir verificación para permitir Oracle 11g
        pass
```

## 6. Conexión en Vistas

Ejemplo en `project/views.py`:

```python
import oracledb
try:
    oracledb.init_oracle_client()
except Exception as e:
    print(f"Advertencia al inicializar Oracle Client: {e}")

def conexion():
    return oracledb.connect(user="project", password="project", dsn="localhost:1521/XE")
```

## 7. Script de Diagnóstico

`python test_connection.py` valida:

- Inicialización modo thick
- Conexión básica
- Consulta a `v$version`
- Presencia de tabla `Cliente`

## 8. Estado Actual (Ejemplo Esperado)

```
✓ Oracle Client inicializado (thick)
✓ Conexión exitosa
✓ Versión Oracle detectada
✓ Tabla Cliente accesible
```

## 9. Ejecución Local

```bash
cd dbProject
python manage.py runserver
```

Abrir: http://127.0.0.1:8000/

## 10. Migraciones

Si deseas usar admin/auth:

```bash
python manage.py migrate
```

## 11. Errores Comunes y Mitigaciones

| Error                | Significado                  | Acción                                         |
| -------------------- | ---------------------------- | ---------------------------------------------- |
| ORA-00904            | Columna inválida             | Revisar esquema tabla Cliente                  |
| TemplateDoesNotExist | Falta archivo de plantilla   | Crear `editarCliente.html` en carpeta correcta |
| ORA-12154 / 12541    | DSN / listener no disponible | Verificar servicio XE + puerto 1521            |
| Error init thick     | Falta Instant Client         | Agregar ruta con `lib_dir`                     |

## 12. Seguridad / Producción

- Mover credenciales a variables de entorno.
- Rotar `SECRET_KEY` y desactivar `DEBUG`.
- Limitar hosts en `ALLOWED_HOSTS`.
- Considerar actualizar Oracle (11g está deprecado).

## 13. Próximos Pasos Recomendados

1. Refactorizar lógica SQL a una capa de servicio.
2. Añadir validaciones de integridad en BD.
3. Implementar tests unitarios para vistas y lógica de inserción.
4. Contener configuración sensible (.env + django-environ).

## 14. Checklist Rápido

- [ ] venv activo
- [ ] Dependencias instaladas
- [ ] Instant Client disponible (si se usa Oracle)
- [ ] Migraciones aplicadas (si se usa auth/admin)
- [ ] Conexión verificada (`test_connection.py`)
- [ ] Servidor en marcha

---

Documento consolidado para visión general y mantenimiento.
