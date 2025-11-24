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

    cursor.execute("INSERT INTO Cliente (codigo, nombre, apellido, numDocumento, tipoDocumento) VALUES (:1, :2, :3, :4, :5)", 
                   (codigo, nombre, apellido, numDocumento, tipoDocumento))
    
    miconexion.commit()
    cursor.close()
    miconexion.close()