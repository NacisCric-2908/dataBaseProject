# Integración Oracle XE 11g con Django

Este documento describe cómo se habilita la conexión desde Django al motor Oracle XE 11g usando el modo "thick" del cliente para superar las limitaciones de compatibilidad.

## 1. Contexto del Problema

`python-oracledb` en modo "thin" no soporta correctamente Oracle 11g Express Edition. Para trabajar con XE 11g se requiere el modo "thick", el cual necesita tener instalado Oracle Instant Client.

## 2. Enfoque Adoptado

1. Uso de `oracledb` en modo thick para las conexiones manuales (en vistas y script de prueba).
2. Backend Django personalizado (`oracle_backend/base.py`) que omite la verificación de versión para permitir Oracle 11g.
3. Inicialización preventiva del cliente Oracle (cx_Oracle / oracledb) al inicio.

## 3. Dependencias Clave

Instaladas vía `requirements.txt`:

```
Django==4.2.16
oracledb==3.4.1
cx_Oracle==8.3.0
```

## 4. Instalación de Oracle Instant Client

1. Descargar el paquete adecuado (versión que funcione con 11g) desde el portal oficial de Oracle.
2. Descomprimir en una ruta, ejemplo: `C:\oracle\instantclient_11_2`.
3. Agregar esa carpeta al `PATH` del sistema o especificarla explícitamente:
   ```python
   oracledb.init_oracle_client(lib_dir=r"C:\oracle\instantclient_11_2")
   ```

## 5. Configuración de la Base de Datos en `settings.py`

```python
DATABASES = {
    'default': {
        'ENGINE': 'oracle_backend',  # Usa backend personalizado
        'NAME': 'localhost:1521/XE',
        'USER': 'project',
        'PASSWORD': 'project',
    }
}
```

## 6. Inicialización en las Vistas

Fragmento presente en `project/views.py`:

```python
import oracledb
try:
    oracledb.init_oracle_client()
except Exception as e:
    print(f"Advertencia al inicializar Oracle Client: {e}")
```

## 7. Script de Verificación

Ejecutar:

```bash
python test_connection.py
```

Salida esperada (ejemplo):

```
✓ Oracle Client inicializado en modo thick
✓ Conexión exitosa!
✓ Versión de Oracle: Oracle Database 11g Express Edition Release 11.2.0.2.0 - 64bit Production
✓ Tabla Cliente encontrada. Registros: N
```

## 8. Ejecución del Servidor

```bash
cd dbProject
python manage.py runserver
```

Abrir: http://127.0.0.1:8000/

## 9. Buenas Prácticas y Advertencias

- Oracle XE 11g es antiguo; considera actualizar a 19c+ para producción.
- Mantén las credenciales fuera del código (variables de entorno) en entornos reales.
- El backend personalizado puede no soportar todas las características avanzadas de Django.

## 10. Errores Comunes

| Error                       | Causa Probable               | Acción                              |
| --------------------------- | ---------------------------- | ----------------------------------- |
| ORA-12154 / ORA-12541       | DSN o listener no disponible | Verificar servicio XE y puerto 1521 |
| ORA-00904                   | Nombre de columna incorrecto | Validar esquema y nombres reales    |
| No se inicializa modo thick | Falta Instant Client o PATH  | Agregar `lib_dir` explícito         |

## 11. Próximos Pasos

1. Externalizar credenciales.
2. Agregar capa de repositorio/servicios para desacoplar lógica SQL.
3. Implementar migraciones controladas para Oracle (o usar herramienta externa).

---

Documento mantenido para referencia técnica rápida.
