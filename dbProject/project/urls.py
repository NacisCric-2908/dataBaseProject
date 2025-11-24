from django.urls import path
from . import views

urlpatterns = [
    path('', views.home, name='home'),
    path('agregar_cliente/', views.agregar_cliente, name='agregarCliente'),
    path('buscarCliente/<str:codigo>/', views.buscarCliente, name='buscarCliente'),
]