# Solución: Conexión a Oracle XE 11g

## Problema Identificado

Oracle XE 11g no es soportado por `python-oracledb` en modo "thin" (el modo por defecto). Se requiere usar el modo "thick" que necesita Oracle Instant Client.

## Solución Implementada

### 1. Se instaló el paquete oracledb

```bash
pip install oracledb
```

### 2. Se inicializó Oracle Client en modo "thick"

Se agregó al inicio de `views.py`:

```python
import oracledb

# Inicializar modo thick para soportar Oracle XE 11g
try:
    oracledb.init_oracle_client()
except Exception as e:
    print(f"Advertencia al inicializar Oracle Client: {e}")
```

### 3. Se configuró Django settings.py

Se cambió de SQLite a Oracle:

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.oracle',
        'NAME': 'localhost:1521/XE',
        'USER': 'project',
        'PASSWORD': 'project',
    }
}
```

## Requisitos Previos

- **Oracle XE 11g** debe estar instalado y corriendo
- **Oracle Instant Client** debe estar instalado (ya lo tienes configurado)
- El servicio de Oracle debe estar activo

## Verificación

Para verificar la conexión, ejecuta:

```bash
python test_connection.py
```

Deberías ver:

```
✓ Oracle Client inicializado en modo thick
✓ Conexión exitosa!
✓ Versión de Oracle: Oracle Database 11g Express Edition Release 11.2.0.2.0 - 64bit Production
✓ Tabla Cliente encontrada. Registros: 4
```

## Ejecutar el Servidor

```bash
cd dbProject
python manage.py runserver
```

## Notas Importantes

- El modo "thick" requiere que Oracle Instant Client esté en el PATH del sistema
- Si Oracle Instant Client no está en el PATH, especifica la ruta:
  ```python
  oracledb.init_oracle_client(lib_dir=r"C:\ruta\a\instantclient")
  ```
- Oracle XE 11g es una versión antigua; versiones más nuevas pueden usar modo "thin"
