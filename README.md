# dataBaseProject

Proyecto Django orientado a la gestión de clientes con opción de conexión a Oracle XE 11g mediante modo thick y backend personalizado. Incluye ejemplos de inserción y consulta directa a la tabla `Cliente` desde las vistas.

## Características

- Django 4.2.x (LTS)
- Conexión Oracle XE 11g (opcional) usando `oracledb` y `cx_Oracle`
- Backend Oracle personalizado (`oracle_backend/base.py`) para omitir verificación de versión
- Script de diagnóstico de conexión (`test_connection.py`)
- Operaciones CRUD básicas sobre tabla `Cliente` (insertar y listar)

## Estructura Principal

```
.
├── instruccions.txt              # Guía operativa rápida
├── SOLUCION_ORACLE.md            # Detalles integración Oracle
├── SOLUCION_COMPLETA.md          # Resumen técnico global
├── requirements.txt              # Dependencias directas
├── test_connection.py            # Verificación conexión Oracle
└── dbProject/
    ├── manage.py
    ├── dbProject/settings.py
    ├── oracle_backend/base.py    # Backend personalizado
    └── project/
        ├── views.py              # Lógica conexión manual
        ├── templates/project/    # Vistas HTML
        └── static/project/       # CSS
```

## Requisitos Previos

- Python 3.11+
- (Opcional) Oracle XE 11g instalado y activo
- (Opcional) Oracle Instant Client (para modo thick)

## Instalación Rápida

```bash
python -m venv venv
venv\Scripts\activate  # Windows
# source venv/bin/activate  # Linux/macOS
pip install -r requirements.txt
```

## Verificar Conexión Oracle (Opcional)

```bash
python test_connection.py
```

Si falla la inicialización thick, agrega `lib_dir`:

```python
oracledb.init_oracle_client(lib_dir=r"C:\ruta\a\instantclient_11_2")
```

## Ejecutar Servidor

```bash
cd dbProject
python manage.py runserver
```

Abrir: http://127.0.0.1:8000/

## Migraciones (si usas admin/auth)

```bash
python manage.py migrate
```

## Dependencias Directas

```text
Django==4.2.16
oracledb==3.4.1
cx_Oracle==8.3.0
```

(Transitivas instaladas automáticamente por pip)

## Comandos Útiles

```bash
python manage.py test          # Ejecutar tests
python manage.py shell         # Consola interactiva
pip freeze > requirements-lock.txt  # Snapshot exacto
```

## Problemas Comunes

| Situación            | Causa                | Solución                               |
| -------------------- | -------------------- | -------------------------------------- |
| ORA-00904            | Columna inválida     | Revisar esquema y nombres reales       |
| ORA-12154 / 12541    | Listener / DSN       | Verificar servicio XE y puerto 1521    |
| TemplateDoesNotExist | Ruta incorrecta      | Confirmar carpeta `templates/project/` |
| Error thick init     | Falta Instant Client | Usar parámetro `lib_dir`               |

## Seguridad (Producción)

- Usar variables de entorno para credenciales.
- Cambiar `SECRET_KEY` y `DEBUG = False`.
- Configurar `ALLOWED_HOSTS`.
- Considerar actualización a Oracle 19c+.

## Próximos Pasos Sugeridos

- Añadir validaciones y tests unitarios.
- Crear capa de acceso a datos desacoplada.
- Externalizar configuración sensible (.env).
- Agregar paginación y filtros en listados.

## Licencia

Uso interno / académico (no se incluye licencia explícita). Añadir una si se publicará.

---

Para más detalles ver `SOLUCION_ORACLE.md` y `SOLUCION_COMPLETA.md`.
