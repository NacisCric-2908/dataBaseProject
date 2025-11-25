"""
Backend personalizado de Oracle que omite la verificación de versión
para permitir el uso de Oracle 11g con Django 4.2
"""
from django.db.backends.oracle.base import DatabaseWrapper as OracleDatabaseWrapper


class DatabaseWrapper(OracleDatabaseWrapper):
    """
    Wrapper personalizado que omite la verificación de versión de Oracle
    """
    
    def check_database_version_supported(self):
        """
        Omite la verificación de versión de Oracle.
        Oracle 11g no es oficialmente soportado por Django 4.2+,
        pero puede funcionar para operaciones básicas.
        """
        # No hacer nada - omitir la verificación
        pass
