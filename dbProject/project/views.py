from django.shortcuts import render
from django.contrib import messages
import oracledb

# Create your views here.
def conexion():
    conexion = oracledb.connect(user = "project", password = "project", dsn = "localhost:1521/XE")
    return conexion

def home(request):
    miconexion = conexion()
    cursor = miconexion.cursor()
    lista = cursor.execute("SELECT * FROM Cliente")
    listado = lista.fetchall()
    return render(request, "project/home.html", {"listado": listado})

def agregar_cliente(request):
    codigo = request.POST['txtCodigo']
    nombre = request.POST['txtNombre']
    apellido = request.POST['txtApellido']
    numDocumento = request.POST['txtNumDocumento']
    tipoDocumento = request.POST['TipoDocumento']

    miconexion = conexion()
    cursor = miconexion.cursor()

    cursor.execute("INSERT INTO Cliente (codCliente, idTipoDoc, nomCliente, apellCliente, numDocumento) VALUES (:1, :2, :3, :4, :5)", 
                   (codigo, tipoDocumento,  nombre, apellido, numDocumento))
    
    miconexion.commit()
    cursor.close()
    miconexion.close()

    messages.success(request, "Cliente agregado correctamente")
    return home(request)

def buscarCliente(request,codigo):
    miconexion = conexion()
    cursor = miconexion.cursor()

    cursor.execute("SELECT * FROM Cliente WHERE codCliente = :1", (codigo,))
    cliente = cursor.fetchone()

    cursor.close()
    miconexion.close()

    return render(request, "project/editarCliente.html", {"cliente": cliente})