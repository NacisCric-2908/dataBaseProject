from django.shortcuts import render
from django.contrib import messages
import oracledb

# Inicializar modo thick para soportar Oracle XE 11g
try:
    oracledb.init_oracle_client()
except Exception as e:
    print(f"Advertencia al inicializar Oracle Client: {e}")

# Create your views here.
def conexion():
    conexion = oracledb.connect(user = "project", password = "project", dsn = "localhost:1521/XE")
    return conexion

def home(request):
    miconexion = conexion()
    cursor = miconexion.cursor()
    lista = cursor.execute("SELECT * FROM Cliente")
    listado = lista.fetchall()
    
    # Obtener tipos de documento
    cursor.execute("SELECT idTipoDoc, descTipoDoc FROM TipoDocumento ORDER BY idTipoDoc")
    tipos_documento = cursor.fetchall()
    
    cursor.close()
    miconexion.close()
    
    return render(request, "project/home.html", {
        "listado": listado,
        "tipos_documento": tipos_documento
    })

def agregar_cliente(request):
    codigo = request.POST['txtCodigo'].strip().upper()
    nombre = request.POST['txtNombre'].strip()
    apellido = request.POST['txtApellido'].strip()
    numDocumento = request.POST['txtNumDocumento'].strip()
    tipoDocumento = request.POST['TipoDocumento'].strip()

    # Validar longitudes
    if len(codigo) > 5:
        messages.error(request, "El código no puede tener más de 5 caracteres")
        return home(request)
    
    if len(nombre) > 30:
        messages.error(request, "El nombre no puede tener más de 30 caracteres")
        return home(request)
    
    if len(apellido) > 30:
        messages.error(request, "El apellido no puede tener más de 30 caracteres")
        return home(request)
    
    if len(numDocumento) > 15:
        messages.error(request, "El número de documento no puede tener más de 15 caracteres")
        return home(request)

    try:
        miconexion = conexion()
        cursor = miconexion.cursor()

        cursor.execute("INSERT INTO Cliente (codCliente, idTipoDoc, nomCliente, apellCliente, nDocumento) VALUES (:1, :2, :3, :4, :5)", 
                       (codigo, tipoDocumento, nombre, apellido, numDocumento))
        
        miconexion.commit()
        cursor.close()
        miconexion.close()

        messages.success(request, f"Cliente {codigo} agregado correctamente")
    except Exception as e:
        messages.error(request, f"Error al agregar cliente: {str(e)}")
    
    return home(request)

def buscarCliente(request, codigo):
    try:
        miconexion = conexion()
        cursor = miconexion.cursor()

        # Buscar sin importar mayúsculas/minúsculas
        cursor.execute("SELECT codCliente, idTipoDoc, nomCliente, apellCliente, nDocumento FROM Cliente WHERE UPPER(codCliente) = UPPER(:1)", (codigo.strip(),))
        cliente = cursor.fetchone()

        cursor.close()
        miconexion.close()

        if not cliente:
            messages.warning(request, f"No se encontró el cliente con código: {codigo}")
        
        return render(request, "project/buscarCliente.html", {"cliente": cliente})
    except Exception as e:
        messages.error(request, f"Error al buscar cliente: {str(e)}")
        return home(request)