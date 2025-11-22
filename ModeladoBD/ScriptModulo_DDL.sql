/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     22/11/2025 1:55:52 p. m.                     */
/*==============================================================*/


alter table CASO
   drop constraint FK_CASO_CLIENTE_C_CLIENTE;

alter table CASO
   drop constraint FK_CASO_ESPECIALI_ESPECIAL;

alter table CLIENTE
   drop constraint FK_CLIENTE_TIPODOCUM_TIPODOCU;

alter table CONTACTO
   drop constraint FK_CONTACTO_CLIENTE_C_CLIENTE;

alter table CONTACTO
   drop constraint FK_CONTACTO_TIPOCONTA_TIPOCONT;

alter table DOCUMENTO
   drop constraint FK_DOCUMENT_EXPEDIENT_EXPEDIEN;

alter table ESPECIALIZACION_ABOGADO
   drop constraint FK_ESPECIAL_ESPECIALI_ABOGADO;

alter table ESPECIALIZACION_ABOGADO
   drop constraint FK_ESPECIAL_ESPECIALI_ESPECIAL;

alter table ESPECIA_ETAPA
   drop constraint FK_ESPECIA__ESPECIALI_ESPECIAL;

alter table ESPECIA_ETAPA
   drop constraint FK_ESPECIA__ETAPAPROC_ETAPAPRO;

alter table ESPECIA_ETAPA
   drop constraint FK_ESPECIA__IMPUGNACI_IMPUGNAC;

alter table ESPECIA_ETAPA
   drop constraint FK_ESPECIA__INSTANCIA_INSTANCI;

alter table EXPEDIENTE
   drop constraint FK_EXPEDIEN_ABOGADO_E_ABOGADO;

alter table EXPEDIENTE
   drop constraint FK_EXPEDIEN_CASO_EXPE_CASO;

alter table EXPEDIENTE
   drop constraint FK_EXPEDIEN_ESPECIA_E_ESPECIA_;

alter table EXPEDIENTE
   drop constraint FK_EXPEDIEN_LUGAR_EXP_LUGAR;

alter table LUGAR
   drop constraint FK_LUGAR_LUGAR_LUG_LUGAR;

alter table LUGAR
   drop constraint FK_LUGAR_TIPOLUGAR_TIPOLUGA;

alter table PAGO
   drop constraint FK_PAGO_FORMAPAGO_FORMAPAG;

alter table PAGO
   drop constraint FK_PAGO_FRANQUICI_FRANQUIC;

alter table RESULTADO
   drop constraint FK_RESULTAD_EXPEDIENT_EXPEDIEN;

alter table SUCESO
   drop constraint FK_SUCESO_EXPEDIENT_EXPEDIEN;

drop table ABOGADO cascade constraints;

drop index ESPECIALIZACION_CASO_FK;

drop index CLIENTE_CASO_FK;

drop table CASO cascade constraints;

drop index TIPODOCUMENTO_CLIENTE_FK;

drop table CLIENTE cascade constraints;

drop index CLIENTE_CONTACTO_FK;

drop index TIPOCONTACT_CONTACTO_FK;

drop table CONTACTO cascade constraints;

drop index EXPEDIENTE_DOCUMENTO_FK;

drop table DOCUMENTO cascade constraints;

drop table ESPECIALIZACION cascade constraints;

drop index ESPECIALIZACION_ABOGADO_FK;

drop index ESPECIALIZACION_ABOGADO2_FK;

drop table ESPECIALIZACION_ABOGADO cascade constraints;

drop index IDX_ESP_ETAPA_FK;

drop index INSTANCIA_ESPECIA_ETAPA_FK;

drop index ETAPAPROCESAL_ESPECIA_ETAPA_FK;

drop index IMPUGNACION_ESPECIA_ETAPA_FK;

drop table ESPECIA_ETAPA cascade constraints;

drop table ETAPAPROCESAL cascade constraints;

drop index ESPECIA_ETAPA_EXPEDIENTE_FK;

drop index ABOGADO_EXPEDIENTE_FK;

drop index LUGAR_EXPEDIENTE_FK;

drop index CASO_EXPEDIENTE_FK;

drop table EXPEDIENTE cascade constraints;

drop table FORMAPAGO cascade constraints;

drop table FRANQUICIA cascade constraints;

drop table IMPUGNACION cascade constraints;

drop table INSTANCIA cascade constraints;

drop index LUGAR_LUGAR_FK;

drop index TIPOLUGAR_LUGAR_FK;

drop table LUGAR cascade constraints;

drop index FORMAPAGO_PAGO_FK;

drop index FRANQUICIA_PAGO_FK;

drop table PAGO cascade constraints;

drop index EXPEDIENTE_RESULTADO_FK;

drop table RESULTADO cascade constraints;

drop index EXPEDIENTE_SUCESO_FK;

drop table SUCESO cascade constraints;

drop table TIPOCONTACT cascade constraints;

drop table TIPODOCUMENTO cascade constraints;

drop table TIPOLUGAR cascade constraints;

/*==============================================================*/
/* Table: ABOGADO                                               */
/*==============================================================*/
create table ABOGADO 
(
   CEDULA               VARCHAR2(10)         not null,
   NOMBRE               VARCHAR2(30)         not null,
   APELLIDO             VARCHAR2(30)         not null,
   NTARJETAPROFESIONAL  VARCHAR2(5)          not null,
   constraint PK_ABOGADO primary key (CEDULA)
);

/*==============================================================*/
/* Table: CASO                                                  */
/*==============================================================*/
create table CASO 
(
   NCASO                NUMBER(5,0)          not null,
   CODCLIENTE           VARCHAR2(5)          not null,
   CODESPECIALIZACION   VARCHAR2(3)          not null,
   FECHAINICIO          DATE                 not null,
   FECHAFIN             DATE,
   VALOR                VARCHAR2(10)         not null,
   constraint PK_CASO primary key (NCASO)
);

/*==============================================================*/
/* Index: CLIENTE_CASO_FK                                       */
/*==============================================================*/
create index CLIENTE_CASO_FK on CASO (
   CODCLIENTE ASC
);

/*==============================================================*/
/* Index: ESPECIALIZACION_CASO_FK                               */
/*==============================================================*/
create index ESPECIALIZACION_CASO_FK on CASO (
   CODESPECIALIZACION ASC
);

/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table CLIENTE 
(
   CODCLIENTE           VARCHAR2(5)          not null,
   IDTIPODOC            VARCHAR2(2)          not null,
   NOMCLIENTE           VARCHAR2(30)         not null,
   APELLCLIENTE         VARCHAR2(30)         not null,
   NDOCUMENTO           VARCHAR2(15)         not null,
   constraint PK_CLIENTE primary key (CODCLIENTE)
);

/*==============================================================*/
/* Index: TIPODOCUMENTO_CLIENTE_FK                              */
/*==============================================================*/
create index TIPODOCUMENTO_CLIENTE_FK on CLIENTE (
   IDTIPODOC ASC
);

/*==============================================================*/
/* Table: CONTACTO                                              */
/*==============================================================*/
create table CONTACTO 
(
   CODCLIENTE           VARCHAR2(5)          not null,
   CONSECONTACTO        NUMBER(4,0)          not null,
   IDTIPOCONTA          VARCHAR2(3)          not null,
   VALORCONTACTO        VARCHAR2(50)         not null,
   NOTIFICACION         SMALLINT             not null,
   constraint PK_CONTACTO primary key (CODCLIENTE, CONSECONTACTO)
);

/*==============================================================*/
/* Index: TIPOCONTACT_CONTACTO_FK                               */
/*==============================================================*/
create index TIPOCONTACT_CONTACTO_FK on CONTACTO (
   IDTIPOCONTA ASC
);

/*==============================================================*/
/* Index: CLIENTE_CONTACTO_FK                                   */
/*==============================================================*/
create index CLIENTE_CONTACTO_FK on CONTACTO (
   CODCLIENTE ASC
);

/*==============================================================*/
/* Table: DOCUMENTO                                             */
/*==============================================================*/
create table DOCUMENTO 
(
   CODESPECIALIZACION   VARCHAR2(3)          not null,
   PASOETAPA            NUMBER(2,0)          not null,
   NCASO                NUMBER(5,0)          not null,
   CONSECEXPE           NUMBER(4,0)          not null,
   CONDOC               NUMBER(4,0)          not null,
   UBICADOC             VARCHAR2(50)         not null,
   constraint PK_DOCUMENTO primary key (CODESPECIALIZACION, PASOETAPA, NCASO, CONSECEXPE, CONDOC)
);

/*==============================================================*/
/* Index: EXPEDIENTE_DOCUMENTO_FK                               */
/*==============================================================*/
create index EXPEDIENTE_DOCUMENTO_FK on DOCUMENTO (
   CODESPECIALIZACION ASC,
   PASOETAPA ASC,
   NCASO ASC,
   CONSECEXPE ASC
);

/*==============================================================*/
/* Table: ESPECIALIZACION                                       */
/*==============================================================*/
create table ESPECIALIZACION 
(
   CODESPECIALIZACION   VARCHAR2(3)          not null,
   NOMESPECIALIZACION   VARCHAR2(30)         not null,
   constraint PK_ESPECIALIZACION primary key (CODESPECIALIZACION)
);

/*==============================================================*/
/* Table: ESPECIALIZACION_ABOGADO                               */
/*==============================================================*/
create table ESPECIALIZACION_ABOGADO 
(
   CEDULA               VARCHAR2(10)         not null,
   CODESPECIALIZACION   VARCHAR2(3)          not null,
   constraint PK_ESPECIALIZACION_ABOGADO primary key (CEDULA, CODESPECIALIZACION)
);

/*==============================================================*/
/* Index: ESPECIALIZACION_ABOGADO2_FK                           */
/*==============================================================*/
create index ESPECIALIZACION_ABOGADO2_FK on ESPECIALIZACION_ABOGADO (
   CODESPECIALIZACION ASC
);

/*==============================================================*/
/* Index: ESPECIALIZACION_ABOGADO_FK                            */
/*==============================================================*/
create index ESPECIALIZACION_ABOGADO_FK on ESPECIALIZACION_ABOGADO (
   CEDULA ASC
);

/*==============================================================*/
/* Table: ESPECIA_ETAPA                                         */
/*==============================================================*/
create table ESPECIA_ETAPA 
(
   CODESPECIALIZACION   VARCHAR2(3)          not null,
   PASOETAPA            NUMBER(2,0)          not null,
   IDIMPUGNA            VARCHAR2(2),
   CODETAPA             VARCHAR2(3)          not null,
   NINSTANCIA           NUMBER(1,0),
   constraint PK_ESPECIA_ETAPA primary key (CODESPECIALIZACION, PASOETAPA)
);

/*==============================================================*/
/* Index: IMPUGNACION_ESPECIA_ETAPA_FK                          */
/*==============================================================*/
create index IMPUGNACION_ESPECIA_ETAPA_FK on ESPECIA_ETAPA (
   IDIMPUGNA ASC
);

/*==============================================================*/
/* Index: ETAPAPROCESAL_ESPECIA_ETAPA_FK                        */
/*==============================================================*/
create index ETAPAPROCESAL_ESPECIA_ETAPA_FK on ESPECIA_ETAPA (
   CODETAPA ASC
);

/*==============================================================*/
/* Index: INSTANCIA_ESPECIA_ETAPA_FK                            */
/*==============================================================*/
create index INSTANCIA_ESPECIA_ETAPA_FK on ESPECIA_ETAPA (
   NINSTANCIA ASC
);

/*==============================================================*/
/* Index: IDX_ESP_ETAPA_FK                                      */
/*==============================================================*/
create index IDX_ESP_ETAPA_FK on ESPECIA_ETAPA (
   CODESPECIALIZACION ASC
);

/*==============================================================*/
/* Table: ETAPAPROCESAL                                         */
/*==============================================================*/
create table ETAPAPROCESAL 
(
   CODETAPA             VARCHAR2(3)          not null,
   NOMETAPA             VARCHAR2(30)         not null,
   constraint PK_ETAPAPROCESAL primary key (CODETAPA)
);

/*==============================================================*/
/* Table: EXPEDIENTE                                            */
/*==============================================================*/
create table EXPEDIENTE 
(
   CODESPECIALIZACION   VARCHAR2(3)          not null,
   PASOETAPA            NUMBER(2,0)          not null,
   NCASO                NUMBER(5,0)          not null,
   CONSECEXPE           NUMBER(4,0)          not null,
   CODLUGAR             VARCHAR2(5)          not null,
   CEDULA               VARCHAR2(10),
   FECHAETAPA           DATE                 not null,
   constraint PK_EXPEDIENTE primary key (CODESPECIALIZACION, PASOETAPA, NCASO, CONSECEXPE)
);

/*==============================================================*/
/* Index: CASO_EXPEDIENTE_FK                                    */
/*==============================================================*/
create index CASO_EXPEDIENTE_FK on EXPEDIENTE (
   NCASO ASC
);

/*==============================================================*/
/* Index: LUGAR_EXPEDIENTE_FK                                   */
/*==============================================================*/
create index LUGAR_EXPEDIENTE_FK on EXPEDIENTE (
   CODLUGAR ASC
);

/*==============================================================*/
/* Index: ABOGADO_EXPEDIENTE_FK                                 */
/*==============================================================*/
create index ABOGADO_EXPEDIENTE_FK on EXPEDIENTE (
   CEDULA ASC
);

/*==============================================================*/
/* Index: ESPECIA_ETAPA_EXPEDIENTE_FK                           */
/*==============================================================*/
create index ESPECIA_ETAPA_EXPEDIENTE_FK on EXPEDIENTE (
   CODESPECIALIZACION ASC,
   PASOETAPA ASC
);

/*==============================================================*/
/* Table: FORMAPAGO                                             */
/*==============================================================*/
create table FORMAPAGO 
(
   IDFORMAPAGO          VARCHAR2(3)          not null,
   DESCFORMAPAGO        VARCHAR2(30)         not null,
   constraint PK_FORMAPAGO primary key (IDFORMAPAGO)
);

/*==============================================================*/
/* Table: FRANQUICIA                                            */
/*==============================================================*/
create table FRANQUICIA 
(
   CODFRANQUICIA        VARCHAR2(3)          not null,
   NOMFRANQUICIA        VARCHAR2(40)         not null,
   constraint PK_FRANQUICIA primary key (CODFRANQUICIA)
);

/*==============================================================*/
/* Table: IMPUGNACION                                           */
/*==============================================================*/
create table IMPUGNACION 
(
   IDIMPUGNA            VARCHAR2(2)          not null,
   NOMIMPUGNA           VARCHAR2(30)         not null,
   constraint PK_IMPUGNACION primary key (IDIMPUGNA)
);

/*==============================================================*/
/* Table: INSTANCIA                                             */
/*==============================================================*/
create table INSTANCIA 
(
   NINSTANCIA           NUMBER(1,0)          not null,
   constraint PK_INSTANCIA primary key (NINSTANCIA)
);

/*==============================================================*/
/* Table: LUGAR                                                 */
/*==============================================================*/
create table LUGAR 
(
   CODLUGAR             VARCHAR2(5)          not null,
   IDTIPOLUGAR          VARCHAR2(4)          not null,
   LUG_CODLUGAR         VARCHAR2(5),
   NOMLUGAR             VARCHAR2(30)         not null,
   DIRELUGAR            VARCHAR2(40)         not null,
   TELLUGAR             VARCHAR2(15)         not null,
   EMAILLUGAR           VARCHAR2(50),
   constraint PK_LUGAR primary key (CODLUGAR)
);

/*==============================================================*/
/* Index: TIPOLUGAR_LUGAR_FK                                    */
/*==============================================================*/
create index TIPOLUGAR_LUGAR_FK on LUGAR (
   IDTIPOLUGAR ASC
);

/*==============================================================*/
/* Index: LUGAR_LUGAR_FK                                        */
/*==============================================================*/
create index LUGAR_LUGAR_FK on LUGAR (
   LUG_CODLUGAR ASC
);

/*==============================================================*/
/* Table: PAGO                                                  */
/*==============================================================*/
create table PAGO 
(
   CONSECPAGO           NUMBER(3,0)          not null,
   CODFRANQUICIA        VARCHAR2(3),
   IDFORMAPAGO          VARCHAR2(3),
   FECHAPAGO            DATE,
   VALORPAGO            NUMBER(10,0)         not null,
   NTARJETA             NUMBER(15,0),
   constraint PK_PAGO primary key (CONSECPAGO)
);

/*==============================================================*/
/* Index: FRANQUICIA_PAGO_FK                                    */
/*==============================================================*/
create index FRANQUICIA_PAGO_FK on PAGO (
   CODFRANQUICIA ASC
);

/*==============================================================*/
/* Index: FORMAPAGO_PAGO_FK                                     */
/*==============================================================*/
create index FORMAPAGO_PAGO_FK on PAGO (
   IDFORMAPAGO ASC
);

/*==============================================================*/
/* Table: RESULTADO                                             */
/*==============================================================*/
create table RESULTADO 
(
   CODESPECIALIZACION   VARCHAR2(3)          not null,
   PASOETAPA            NUMBER(2,0)          not null,
   NCASO                NUMBER(5,0)          not null,
   CONSECEXPE           NUMBER(4,0)          not null,
   CONRESUL             NUMBER(4,0)          not null,
   DESCRESUL            VARCHAR2(200)        not null,
   constraint PK_RESULTADO primary key (CODESPECIALIZACION, PASOETAPA, NCASO, CONSECEXPE, CONRESUL)
);

/*==============================================================*/
/* Index: EXPEDIENTE_RESULTADO_FK                               */
/*==============================================================*/
create index EXPEDIENTE_RESULTADO_FK on RESULTADO (
   CODESPECIALIZACION ASC,
   PASOETAPA ASC,
   NCASO ASC,
   CONSECEXPE ASC
);

/*==============================================================*/
/* Table: SUCESO                                                */
/*==============================================================*/
create table SUCESO 
(
   CODESPECIALIZACION   VARCHAR2(3)          not null,
   PASOETAPA            NUMBER(2,0)          not null,
   NCASO                NUMBER(5,0)          not null,
   CONSECEXPE           NUMBER(4,0)          not null,
   CONSUCESO            NUMBER(4,0)          not null,
   DESCSUCESO           CHAR(200)            not null,
   constraint PK_SUCESO primary key (CODESPECIALIZACION, PASOETAPA, NCASO, CONSECEXPE, CONSUCESO)
);

/*==============================================================*/
/* Index: EXPEDIENTE_SUCESO_FK                                  */
/*==============================================================*/
create index EXPEDIENTE_SUCESO_FK on SUCESO (
   CODESPECIALIZACION ASC,
   PASOETAPA ASC,
   NCASO ASC,
   CONSECEXPE ASC
);

/*==============================================================*/
/* Table: TIPOCONTACT                                           */
/*==============================================================*/
create table TIPOCONTACT 
(
   IDTIPOCONTA          VARCHAR2(3)          not null,
   DESCTIPOCONTA        VARCHAR2(30)         not null,
   constraint PK_TIPOCONTACT primary key (IDTIPOCONTA)
);

/*==============================================================*/
/* Table: TIPODOCUMENTO                                         */
/*==============================================================*/
create table TIPODOCUMENTO 
(
   IDTIPODOC            VARCHAR2(2)          not null,
   DESCTIPODOC          VARCHAR2(30)         not null,
   constraint PK_TIPODOCUMENTO primary key (IDTIPODOC)
);

/*==============================================================*/
/* Table: TIPOLUGAR                                             */
/*==============================================================*/
create table TIPOLUGAR 
(
   IDTIPOLUGAR          VARCHAR2(4)          not null,
   DESCTIPOLUGAR        VARCHAR2(50)         not null,
   constraint PK_TIPOLUGAR primary key (IDTIPOLUGAR)
);

alter table CASO
   add constraint FK_CASO_CLIENTE_C_CLIENTE foreign key (CODCLIENTE)
      references CLIENTE (CODCLIENTE);

alter table CASO
   add constraint FK_CASO_ESPECIALI_ESPECIAL foreign key (CODESPECIALIZACION)
      references ESPECIALIZACION (CODESPECIALIZACION);

alter table CLIENTE
   add constraint FK_CLIENTE_TIPODOCUM_TIPODOCU foreign key (IDTIPODOC)
      references TIPODOCUMENTO (IDTIPODOC);

alter table CONTACTO
   add constraint FK_CONTACTO_CLIENTE_C_CLIENTE foreign key (CODCLIENTE)
      references CLIENTE (CODCLIENTE);

alter table CONTACTO
   add constraint FK_CONTACTO_TIPOCONTA_TIPOCONT foreign key (IDTIPOCONTA)
      references TIPOCONTACT (IDTIPOCONTA);

alter table DOCUMENTO
   add constraint FK_DOCUMENT_EXPEDIENT_EXPEDIEN foreign key (CODESPECIALIZACION, PASOETAPA, NCASO, CONSECEXPE)
      references EXPEDIENTE (CODESPECIALIZACION, PASOETAPA, NCASO, CONSECEXPE);

alter table ESPECIALIZACION_ABOGADO
   add constraint FK_ESPECIAL_ESPECIALI_ABOGADO foreign key (CEDULA)
      references ABOGADO (CEDULA);

alter table ESPECIALIZACION_ABOGADO
   add constraint FK_ESPECIAL_ESPECIALI_ESPECIAL foreign key (CODESPECIALIZACION)
      references ESPECIALIZACION (CODESPECIALIZACION);

alter table ESPECIA_ETAPA
   add constraint FK_ESPECIA__ESPECIALI_ESPECIAL foreign key (CODESPECIALIZACION)
      references ESPECIALIZACION (CODESPECIALIZACION);

alter table ESPECIA_ETAPA
   add constraint FK_ESPECIA__ETAPAPROC_ETAPAPRO foreign key (CODETAPA)
      references ETAPAPROCESAL (CODETAPA);

alter table ESPECIA_ETAPA
   add constraint FK_ESPECIA__IMPUGNACI_IMPUGNAC foreign key (IDIMPUGNA)
      references IMPUGNACION (IDIMPUGNA);

alter table ESPECIA_ETAPA
   add constraint FK_ESPECIA__INSTANCIA_INSTANCI foreign key (NINSTANCIA)
      references INSTANCIA (NINSTANCIA);

alter table EXPEDIENTE
   add constraint FK_EXPEDIEN_ABOGADO_E_ABOGADO foreign key (CEDULA)
      references ABOGADO (CEDULA);

alter table EXPEDIENTE
   add constraint FK_EXPEDIEN_CASO_EXPE_CASO foreign key (NCASO)
      references CASO (NCASO);

alter table EXPEDIENTE
   add constraint FK_EXPEDIEN_ESPECIA_E_ESPECIA_ foreign key (CODESPECIALIZACION, PASOETAPA)
      references ESPECIA_ETAPA (CODESPECIALIZACION, PASOETAPA);

alter table EXPEDIENTE
   add constraint FK_EXPEDIEN_LUGAR_EXP_LUGAR foreign key (CODLUGAR)
      references LUGAR (CODLUGAR);

alter table LUGAR
   add constraint FK_LUGAR_LUGAR_LUG_LUGAR foreign key (LUG_CODLUGAR)
      references LUGAR (CODLUGAR);

alter table LUGAR
   add constraint FK_LUGAR_TIPOLUGAR_TIPOLUGA foreign key (IDTIPOLUGAR)
      references TIPOLUGAR (IDTIPOLUGAR);

alter table PAGO
   add constraint FK_PAGO_FORMAPAGO_FORMAPAG foreign key (IDFORMAPAGO)
      references FORMAPAGO (IDFORMAPAGO);

alter table PAGO
   add constraint FK_PAGO_FRANQUICI_FRANQUIC foreign key (CODFRANQUICIA)
      references FRANQUICIA (CODFRANQUICIA);

alter table RESULTADO
   add constraint FK_RESULTAD_EXPEDIENT_EXPEDIEN foreign key (CODESPECIALIZACION, PASOETAPA, NCASO, CONSECEXPE)
      references EXPEDIENTE (CODESPECIALIZACION, PASOETAPA, NCASO, CONSECEXPE);

alter table SUCESO
   add constraint FK_SUCESO_EXPEDIENT_EXPEDIEN foreign key (CODESPECIALIZACION, PASOETAPA, NCASO, CONSECEXPE)
      references EXPEDIENTE (CODESPECIALIZACION, PASOETAPA, NCASO, CONSECEXPE);

