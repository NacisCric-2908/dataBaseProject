import oracledb

print("Intentando conectar a Oracle XE 11g...")
print("Usuario: project")
print("DSN: localhost:1521/XE")
print("\n--- Inicializando Oracle Client (modo thick) ---")

try:
    # Inicializar modo thick para Oracle XE 11g
    oracledb.init_oracle_client()
    print("✓ Oracle Client inicializado en modo thick")
except Exception as e:
    print(f"⚠ No se pudo inicializar Oracle Client: {e}")
    print("\nSolución: Instalar Oracle Instant Client")
    print("1. Descarga Oracle Instant Client desde:")
    print("   https://www.oracle.com/database/technologies/instant-client/downloads.html")
    print("2. Descomprime en una carpeta (ej: C:\\oracle\\instantclient_11_2)")
    print("3. Agrega la ruta al PATH del sistema o especifícala en init_oracle_client()")
    print("\nEjemplo:")
    print('   oracledb.init_oracle_client(lib_dir=r"C:\\oracle\\instantclient_11_2")')
    exit(1)

try:
    # Intento 1: Conexión básica
    conexion = oracledb.connect(
        user="project", 
        password="project", 
        dsn="localhost:1521/XE"
    )
    print("✓ Conexión exitosa!")
    
    # Probar consulta
    cursor = conexion.cursor()
    cursor.execute("SELECT * FROM v$version")
    version = cursor.fetchone()
    print(f"✓ Versión de Oracle: {version[0]}")
    
    # Verificar tabla Cliente
    try:
        cursor.execute("SELECT COUNT(*) FROM Cliente")
        count = cursor.fetchone()
        print(f"✓ Tabla Cliente encontrada. Registros: {count[0]}")
    except Exception as e:
        print(f"⚠ Advertencia con tabla Cliente: {e}")
    
    cursor.close()
    conexion.close()
    print("\n✓ Todo funcionando correctamente!")
    
except oracledb.DatabaseError as e:
    error, = e.args
    print(f"\n✗ Error de base de datos:")
    print(f"  Código: {error.code}")
    print(f"  Mensaje: {error.message}")
    print("\nPosibles soluciones:")
    print("1. Verificar que Oracle XE esté corriendo")
    print("2. Verificar usuario/contraseña (project/project)")
    print("3. Verificar que el puerto 1521 esté disponible")
    print("4. Verificar que el servicio XE esté activo")
    
except Exception as e:
    print(f"\n✗ Error inesperado: {e}")
    print("\nPosibles causas:")
    print("1. Oracle XE no está instalado o no está corriendo")
    print("2. Firewall bloqueando la conexión")
    print("3. Configuración incorrecta del listener")
