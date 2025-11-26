/* ==============================================================
   1. TABLAS PARAMETRICAS (REQUERIMIENTO 2.1 y 2.5)
   Tipos, Lugares, Formas de Pago, Instancias
   ============================================================== */

-- 2.1 Insertar 3 registros en TipoContacto, TipoDocumento, TipoLugar, FormaPago, Franquicia
INSERT INTO TipoContact (idTipoConta, descTipoConta) VALUES ('CEL', 'Celular');
INSERT INTO TipoContact (idTipoConta, descTipoConta) VALUES ('EMA', 'Correo Electronico');
INSERT INTO TipoContact (idTipoConta, descTipoConta) VALUES ('DIR', 'Direccion Fisica');

INSERT INTO TipoDocumento (idTipoDoc, descTipoDoc) VALUES ('CC', 'Cedula de Ciudadania');
INSERT INTO TipoDocumento (idTipoDoc, descTipoDoc) VALUES ('CE', 'Cedula de Extranjeria');
INSERT INTO TipoDocumento (idTipoDoc, descTipoDoc) VALUES ('TI', 'Tarjeta de Identidad');

INSERT INTO TipoLugar (idTipoLugar, descTipoLugar) VALUES ('CIU', 'Ciudad');
INSERT INTO TipoLugar (idTipoLugar, descTipoLugar) VALUES ('JUZ', 'Juzgado');
INSERT INTO TipoLugar (idTipoLugar, descTipoLugar) VALUES ('TRI', 'Tribunal');
INSERT INTO TipoLugar (idTipoLugar, descTipoLugar) VALUES ('FIS', 'Fiscalia');

INSERT INTO FormaPago (idFormaPago, descFormaPago) VALUES ('EFE', 'Efectivo');
INSERT INTO FormaPago (idFormaPago, descFormaPago) VALUES ('TRA', 'Transferencia Bancaria');
INSERT INTO FormaPago (idFormaPago, descFormaPago) VALUES ('TCR', 'Tarjeta de Credito');

INSERT INTO Franquicia (codFranquicia, nomFranquicia) VALUES ('VIS', 'Visa');
INSERT INTO Franquicia (codFranquicia, nomFranquicia) VALUES ('MAS', 'MasterCard');
INSERT INTO Franquicia (codFranquicia, nomFranquicia) VALUES ('AME', 'American Express');

-- 2.5 Incluir 3 juzgados y 3 tribunales con jerarquia (Lugar) e Instancias
-- Primero insertamos la ciudad (Padre)
INSERT INTO Lugar (codLugar, idTipoLugar, Lug_codLugar, nomLugar, direLugar, telLugar, emailLugar) 
VALUES ('BOG01', 'CIU', NULL, 'Bogota D.C.', 'Cundinamarca', '6010000', 'alcaldia@bogota.gov.co');

-- Insertamos 3 JUZGADOS (Hijos de Bogota, Tipo 'JUZ')
INSERT INTO Lugar (codLugar, idTipoLugar, Lug_codLugar, nomLugar, direLugar, telLugar, emailLugar) 
VALUES ('JG001', 'JUZ', 'BOG01', 'Juzgado 15 Penal Garantias', 'Paloquemao', '6015501', 'juz15g@rama.gov.co');

INSERT INTO Lugar (codLugar, idTipoLugar, Lug_codLugar, nomLugar, direLugar, telLugar, emailLugar) 
VALUES ('JG002', 'JUZ', 'BOG01', 'Juzgado 20 Penal Circuito', 'Paloquemao', '6015502', 'juz20c@rama.gov.co');

INSERT INTO Lugar (codLugar, idTipoLugar, Lug_codLugar, nomLugar, direLugar, telLugar, emailLugar) 
VALUES ('JG003', 'JUZ', 'BOG01', 'Juzgado 05 Civil Municipal', 'Centro', '6015503', 'juz05c@rama.gov.co');

-- Insertamos 3 TRIBUNALES (Hijos de Bogota, Tipo 'TRI')
INSERT INTO Lugar (codLugar, idTipoLugar, Lug_codLugar, nomLugar, direLugar, telLugar, emailLugar) 
VALUES ('TRI01', 'TRI', 'BOG01', 'Tribunal Superior Sala Penal', 'Calle 12 # 7', '6017701', 'trib_penal@rama.gov.co');

INSERT INTO Lugar (codLugar, idTipoLugar, Lug_codLugar, nomLugar, direLugar, telLugar, emailLugar) 
VALUES ('TRI02', 'TRI', 'BOG01', 'Tribunal Superior Sala Civil', 'Calle 12 # 7', '6017702', 'trib_civil@rama.gov.co');

INSERT INTO Lugar (codLugar, idTipoLugar, Lug_codLugar, nomLugar, direLugar, telLugar, emailLugar) 
VALUES ('TRI03', 'TRI', 'BOG01', 'Tribunal Administrativo Cund', 'Av Esperanza', '6017703', 'trib_admin@rama.gov.co');

-- Insertamos la Fiscalia (Para que no falle el Caso Hipotetico)
INSERT INTO Lugar (codLugar, idTipoLugar, Lug_codLugar, nomLugar, direLugar, telLugar, emailLugar) 
VALUES ('FIS01', 'FIS', 'BOG01', 'Fiscalia General', 'Bunker', '6011234', 'contacto@fiscalia.gov.co');

-- Insertar 3 Instancias
INSERT INTO Instancia (nInstancia) VALUES (1);
INSERT INTO Instancia (nInstancia) VALUES (2);
INSERT INTO Instancia (nInstancia) VALUES (3);

/* ==============================================================
   2. DEFINICION DEL NEGOCIO (REQUERIMIENTOS 2.2 y 2.3)
   Especializaciones, Etapas, Impugnaciones y la Tabla de Configuracion
   ============================================================== */

-- 2.2 Insertar especializaciones, etapas procesales, impugnaciones

-- Especializaciones (Tipos de Proceso)
INSERT INTO Especializacion (codEspecializacion, nomEspecializacion) VALUES ('PEN', 'Penal');
INSERT INTO Especializacion (codEspecializacion, nomEspecializacion) VALUES ('CIV', 'Civil');
INSERT INTO Especializacion (codEspecializacion, nomEspecializacion) VALUES ('LAB', 'Laboral');
INSERT INTO Especializacion (codEspecializacion, nomEspecializacion) VALUES ('ADM', 'Administrativo');
INSERT INTO Especializacion (codEspecializacion, nomEspecializacion) VALUES ('TUT', 'Tutela');


-- Catalogo unico de Etapas Procesales
INSERT INTO EtapaProcesal (codEtapa, nomEtapa) VALUES ('IND', 'Indagacion');
INSERT INTO EtapaProcesal (codEtapa, nomEtapa) VALUES ('IMP', 'Imputacion');
INSERT INTO EtapaProcesal (codEtapa, nomEtapa) VALUES ('ACU', 'Acusacion');
INSERT INTO EtapaProcesal (codEtapa, nomEtapa) VALUES ('JUI', 'Juicio');
INSERT INTO EtapaProcesal (codEtapa, nomEtapa) VALUES ('SEN', 'Sentencia');
INSERT INTO EtapaProcesal (codEtapa, nomEtapa) VALUES ('DEM', 'Demanda');
INSERT INTO EtapaProcesal (codEtapa, nomEtapa) VALUES ('CON', 'Contestacion');
INSERT INTO EtapaProcesal (codEtapa, nomEtapa) VALUES ('AUD', 'Audiencia');
INSERT INTO EtapaProcesal (codEtapa, nomEtapa) VALUES ('PRU', 'Pruebas');
INSERT INTO EtapaProcesal (codEtapa, nomEtapa) VALUES ('PRE', 'Presentacion');
INSERT INTO EtapaProcesal (codEtapa, nomEtapa) VALUES ('TRA', 'Tramite urgente');
INSERT INTO EtapaProcesal (codEtapa, nomEtapa) VALUES ('FAL', 'Fallo');
INSERT INTO EtapaProcesal (codEtapa, nomEtapa) VALUES ('TIM', 'Tramite Impugnacion');

-- Impugnaciones
INSERT INTO Impugnacion (idImpugna, nomImpugna) VALUES ('NO', 'Sin Impugnacion');
INSERT INTO Impugnacion (idImpugna, nomImpugna) VALUES ('AP', 'Apelacion');
INSERT INTO Impugnacion (idImpugna, nomImpugna) VALUES ('CA', 'Casacion');
INSERT INTO Impugnacion (idImpugna, nomImpugna) VALUES ('RE', 'Reposicion');
INSERT INTO Impugnacion (idImpugna, nomImpugna) VALUES ('RV', 'Revision');
INSERT INTO Impugnacion (idImpugna, nomImpugna) VALUES ('UN', 'Unificacion de jurisprudencia');
INSERT INTO Impugnacion (idImpugna, nomImpugna) VALUES ('IM', 'Impugnacion de tutela');
INSERT INTO Impugnacion (idImpugna, nomImpugna) VALUES ('RC', 'Revision constitucional');

-- 2.3 Incluir en la tabla Especia_Etapa (Configuracion del flujo del proceso)

-- === PENAL ===
-- Indagacin -> Imputacion -> Acusacion -> Juicio -> Sentencia -> Impugnacion
INSERT INTO Especia_Etapa (codEspecializacion, pasoEtapa, codEtapa, idImpugna, nInstancia) VALUES ('PEN', 1, 'IND', 'NO', 1);
INSERT INTO Especia_Etapa (codEspecializacion, pasoEtapa, codEtapa, idImpugna, nInstancia) VALUES ('PEN', 2, 'IMP', 'NO', 1);
INSERT INTO Especia_Etapa (codEspecializacion, pasoEtapa, codEtapa, idImpugna, nInstancia) VALUES ('PEN', 3, 'ACU', 'NO', 1);
INSERT INTO Especia_Etapa (codEspecializacion, pasoEtapa, codEtapa, idImpugna, nInstancia) VALUES ('PEN', 4, 'JUI', 'NO', 1);
INSERT INTO Especia_Etapa (codEspecializacion, pasoEtapa, codEtapa, idImpugna, nInstancia) VALUES ('PEN', 5, 'SEN', 'NO', 1);
INSERT INTO Especia_Etapa (codEspecializacion, pasoEtapa, codEtapa, idImpugna, nInstancia) VALUES ('PEN', 6, 'TIM', 'AP', 2);

-- === CIVIL ===
-- Demanda -> Contestacion -> Audiencia -> Pruebas -> Sentencia -> Impugnacion
INSERT INTO Especia_Etapa (codEspecializacion, pasoEtapa, codEtapa, idImpugna, nInstancia) VALUES ('CIV', 1, 'DEM', 'NO', 1);
INSERT INTO Especia_Etapa (codEspecializacion, pasoEtapa, codEtapa, idImpugna, nInstancia) VALUES ('CIV', 2, 'CON', 'NO', 1);
INSERT INTO Especia_Etapa (codEspecializacion, pasoEtapa, codEtapa, idImpugna, nInstancia) VALUES ('CIV', 3, 'AUD', 'NO', 1);
INSERT INTO Especia_Etapa (codEspecializacion, pasoEtapa, codEtapa, idImpugna, nInstancia) VALUES ('CIV', 4, 'PRU', 'NO', 1);
INSERT INTO Especia_Etapa (codEspecializacion, pasoEtapa, codEtapa, idImpugna, nInstancia) VALUES ('CIV', 5, 'SEN', 'NO', 1);
INSERT INTO Especia_Etapa (codEspecializacion, pasoEtapa, codEtapa, idImpugna, nInstancia) VALUES ('CIV', 6, 'TIM', 'AP', 2);

-- === LABORAL ===
-- Demanda -> Audiencia -> Pruebas -> Sentencia -> Impugnacion
INSERT INTO Especia_Etapa (codEspecializacion, pasoEtapa, codEtapa, idImpugna, nInstancia) VALUES ('LAB', 1, 'DEM', 'NO', 1);
INSERT INTO Especia_Etapa (codEspecializacion, pasoEtapa, codEtapa, idImpugna, nInstancia) VALUES ('LAB', 2, 'AUD', 'NO', 1);
INSERT INTO Especia_Etapa (codEspecializacion, pasoEtapa, codEtapa, idImpugna, nInstancia) VALUES ('LAB', 3, 'PRU', 'NO', 1);
INSERT INTO Especia_Etapa (codEspecializacion, pasoEtapa, codEtapa, idImpugna, nInstancia) VALUES ('LAB', 4, 'SEN', 'NO', 1);
INSERT INTO Especia_Etapa (codEspecializacion, pasoEtapa, codEtapa, idImpugna, nInstancia) VALUES ('LAB', 5, 'TIM', 'AP', 2);

-- === ADMINISTRATIVO ===
-- Demanda -> Contestacion -> Pruebas -> Sentencia -> Impugnacion
INSERT INTO Especia_Etapa (codEspecializacion, pasoEtapa, codEtapa, idImpugna, nInstancia) VALUES ('ADM', 1, 'DEM', 'NO', 1);
INSERT INTO Especia_Etapa (codEspecializacion, pasoEtapa, codEtapa, idImpugna, nInstancia) VALUES ('ADM', 2, 'CON', 'NO', 1);
INSERT INTO Especia_Etapa (codEspecializacion, pasoEtapa, codEtapa, idImpugna, nInstancia) VALUES ('ADM', 3, 'PRU', 'NO', 1);
INSERT INTO Especia_Etapa (codEspecializacion, pasoEtapa, codEtapa, idImpugna, nInstancia) VALUES ('ADM', 4, 'SEN', 'NO', 1);
INSERT INTO Especia_Etapa (codEspecializacion, pasoEtapa, codEtapa, idImpugna, nInstancia) VALUES ('ADM', 5, 'TIM', 'AP', 2);

-- === TUTELA ===
-- Presentacion -> Tramite urgente -> Fallo -> Impugnacion
INSERT INTO Especia_Etapa (codEspecializacion, pasoEtapa, codEtapa, idImpugna, nInstancia) VALUES ('TUT', 1, 'PRE', 'NO', 1);
INSERT INTO Especia_Etapa (codEspecializacion, pasoEtapa, codEtapa, idImpugna, nInstancia) VALUES ('TUT', 2, 'TRA', 'NO', 1);
INSERT INTO Especia_Etapa (codEspecializacion, pasoEtapa, codEtapa, idImpugna, nInstancia) VALUES ('TUT', 3, 'FAL', 'NO', 1);
INSERT INTO Especia_Etapa (codEspecializacion, pasoEtapa, codEtapa, idImpugna, nInstancia) VALUES ('TUT', 4, 'TIM', 'IM', 2);

/* ==============================================================
   3. ACTORES (REQUERIMIENTO 2.4)
   Clientes y Abogados
   ============================================================== */

-- 2.4 Insertar 5 clientes
INSERT INTO Cliente (codCliente, idTipoDoc, nomCliente, apellCliente, nDocumento) 
VALUES ('CLI01', 'CC', 'Juan', 'Perez', '10101010');

INSERT INTO Cliente (codCliente, idTipoDoc, nomCliente, apellCliente, nDocumento) 
VALUES ('CLI02', 'CC', 'Maria', 'Gomez', '20202020');

INSERT INTO Cliente (codCliente, idTipoDoc, nomCliente, apellCliente, nDocumento) 
VALUES ('CLI03', 'CE', 'John', 'Smith', '30303030');

INSERT INTO Cliente (codCliente, idTipoDoc, nomCliente, apellCliente, nDocumento) 
VALUES ('CLI04', 'CC', 'Carlos', 'Ruiz', '40404040');

INSERT INTO Cliente (codCliente, idTipoDoc, nomCliente, apellCliente, nDocumento) 
VALUES ('CLI05', 'TI', 'Ana', 'Torres', '50505050');

-- Insertar datos de contacto para Juan Perez (necesario por la tabla Contacto)
INSERT INTO Contacto (codCliente, conseContacto, idTipoConta, valorContacto, notificacion)
VALUES ('CLI01', 1, 'CEL', '3001234567', 1);

-- 2.4 Insertar 5 abogados
INSERT INTO Abogado (cedula, nombre, apellido, nTarjetaProfesional) 
VALUES ('80001', 'Saul', 'Goodman', 'TP001');

INSERT INTO Abogado (cedula, nombre, apellido, nTarjetaProfesional) VALUES ('80002', 'Harvey', 'Specter', 'TP002');
INSERT INTO Abogado (cedula, nombre, apellido, nTarjetaProfesional) VALUES ('80003', 'Mike', 'Ross', 'TP003');
INSERT INTO Abogado (cedula, nombre, apellido, nTarjetaProfesional) VALUES ('80004', 'Alicia', 'Florrick', 'TP004');
INSERT INTO Abogado (cedula, nombre, apellido, nTarjetaProfesional) VALUES ('80005', 'Atticus', 'Finch', 'TP005');

-- Relacionar Abogado con Especializacion (Tabla Especializacion_Abogado)
INSERT INTO Especializacion_Abogado (cedula, codEspecializacion) VALUES ('80001', 'PEN');
INSERT INTO Especializacion_Abogado (cedula, codEspecializacion) VALUES ('80002', 'CIV');

/* ==============================================================
   4. CASO HIPOTETICO (REQUERIMIENTO 2.6)
   Caso: Juan Perez - Hurto Agravado
   ============================================================== */

-- 1. Crear el CASO (Cabecera)
-- Cliente: Juan Perez (CLI01), Especializacion: Penal (PEN)
INSERT INTO Caso (nCaso, codCliente, codEspecializacion, fechaInicio, fechaFin, Valor) 
VALUES (1001, 'CLI01', 'PEN', TO_DATE('2025-10-01', 'YYYY-MM-DD'), NULL, '5000000');

-- 2. Registrar la Historia en EXPEDIENTE (Detalle del flujo)

-- Hito 1: Indagacion (Fiscalia recopila pruebas)
INSERT INTO Expediente (codEspecializacion, pasoEtapa, nCaso, consecExpe, codLugar, cedula, fechaEtapa) 
VALUES ('PEN', 1, 1001, 1, 'FIS01', '80001', TO_DATE('2025-10-02', 'YYYY-MM-DD'));

-- Agregar un Suceso (Descripcion de hechos) para Hito 1
INSERT INTO Suceso (codEspecializacion, pasoEtapa, nCaso, consecExpe, conSuceso, descSuceso)
VALUES ('PEN', 1, 1001, 1, 1, 'Captura de Juan Perez por presunto hurto de celular. Apertura de investigacion.');

-- Hito 2: Imputacion (Ante Juez de Garantias)
INSERT INTO Expediente (codEspecializacion, pasoEtapa, nCaso, consecExpe, codLugar, cedula, fechaEtapa) 
VALUES ('PEN', 2, 1001, 2, 'JG001', '80001', TO_DATE('2025-10-05', 'YYYY-MM-DD'));

INSERT INTO Suceso (codEspecializacion, pasoEtapa, nCaso, consecExpe, conSuceso, descSuceso)
VALUES ('PEN', 2, 1001, 2, 1, 'Audiencia de imputacion de cargos. El cliente NO acepta cargos.');

-- Hito 3: Acusacion (Ante Juez de Conocimiento)
INSERT INTO Expediente (codEspecializacion, pasoEtapa, nCaso, consecExpe, codLugar, cedula, fechaEtapa) 
VALUES ('PEN', 3, 1001, 3, 'JG002', '80001', TO_DATE('2025-10-20', 'YYYY-MM-DD'));

INSERT INTO Suceso (codEspecializacion, pasoEtapa, nCaso, consecExpe, conSuceso, descSuceso)
VALUES ('PEN', 3, 1001, 3, 1, 'Fiscalia presenta escrito de acusacion y pruebas documentales.');

-- Hito 4: Juicio Oral
INSERT INTO Expediente (codEspecializacion, pasoEtapa, nCaso, consecExpe, codLugar, cedula, fechaEtapa) 
VALUES ('PEN', 4, 1001, 4, 'JG002', '80001', TO_DATE('2025-11-15', 'YYYY-MM-DD'));

INSERT INTO Suceso (codEspecializacion, pasoEtapa, nCaso, consecExpe, conSuceso, descSuceso)
VALUES ('PEN', 4, 1001, 4, 1, 'Interrogatorio de testigos y alegatos finales.');

-- Hito 5: Sentencia (Primera Instancia - Condenatoria, lo que motiva la apelacion)
INSERT INTO Expediente (codEspecializacion, pasoEtapa, nCaso, consecExpe, codLugar, cedula, fechaEtapa) 
VALUES ('PEN', 5, 1001, 5, 'JG002', '80001', TO_DATE('2025-11-20', 'YYYY-MM-DD'));

INSERT INTO Suceso (codEspecializacion, pasoEtapa, nCaso, consecExpe, conSuceso, descSuceso)
VALUES ('PEN', 5, 1001, 5, 1, 'Juez dicta sentencia condenatoria de 24 meses.');

-- Hito 6: Apelacion (Segunda Instancia - Tribunal)
-- Segun el caso hipotetico, el abogado no esta de acuerdo y apela la sentencia
INSERT INTO Expediente (codEspecializacion, pasoEtapa, nCaso, consecExpe, codLugar, cedula, fechaEtapa) 
VALUES ('PEN', 6, 1001, 6, 'TRI01', '80001', TO_DATE('2025-11-25', 'YYYY-MM-DD'));

INSERT INTO Suceso (codEspecializacion, pasoEtapa, nCaso, consecExpe, conSuceso, descSuceso)
VALUES ('PEN', 6, 1001, 6, 1, 'Defensa radica recurso de apelacion ante el Tribunal Superior.');

COMMIT;
