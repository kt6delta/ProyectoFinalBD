/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     14/05/2024 10:18:01 a. m.                    */
/*==============================================================*/


alter table CANDIDATO
   drop constraint FK_CANDIDAT_RELATIONS_TIPODOC;

alter table CARGO
   drop constraint FK_CARGO_RELATIONS_TIPOCARG;

alter table CARGO
   drop constraint FK_CARGO_RELATIONS_EMPLEADO;

alter table CONTACTOCANDIDATO
   drop constraint FK_CONTACTO_RELATIONS_CANDIDAT;

alter table CONTACTOCANDIDATO
   drop constraint FK_CONTAC_RELATION_TIPOCONT;

alter table CONTACTOCLIENTE
   drop constraint FK_CONTACTO_RELATIONS_CLIENTE;

alter table CONTACTOCLIENTE
   drop constraint FK_CONTACTO_RELATIONS_TIPOCARG;

alter table CONTACTOCLIENTE
   drop constraint FK_CONTAC_RELATIONS_TIPOCONT;

alter table DETALLEFACTURA
   drop constraint FK_DETALLEF_RELATIONS_FACTURA;

alter table FACTURA
   drop constraint FK_FACTURA_RELATIONS_EMPLEADO;

alter table FACTURA
   drop constraint FK_FACTURA_RELATIONS_CLIENTE;

alter table FASECARGO
   drop constraint FK_FASECARG_RELATIONS_FASE;

alter table FASECARGO
   drop constraint FK_FASECARG_RELATIONS_TIPOCARG;

alter table HV
   drop constraint FK_HV_RELATIONS_CANDIDAT;

alter table HV
   drop constraint FK_HV_RELATIONS_INSTITUC;

alter table HV
   drop constraint FK_HV_RELATIONS_TIPOITEM;

alter table ITEMPERFIL
   drop constraint FK_ITEMPERF_RELATIONS_TIPOITEM;

alter table ITEMPERFIL
   drop constraint FK_ITEMPERF_RELATIONS_PERFIL;

alter table PERFIL
   drop constraint FK_PERFIL_RELATIONS_DISCIPLI;

alter table PERFILFASE
   drop constraint FK_PERFILFA_RELATIONS_PERFIL;

alter table PERFILFASE
   drop constraint FK_PERFILFA_RELATIONS_FASE;

alter table PREGUNTA
   drop constraint FK_PREGUNTA_RELATIONS_TIPOPREG;

alter table PREGUNTA
   drop constraint FK_PREGUNTA_RELATIONS_PRUEBA;

alter table PREGUNTACANDIDATO
   drop constraint FK_PREGUNTA_RELATIONS_PREGUNTA;

alter table PREGUNTACANDIDATO
   drop constraint FK_PREGUNTA_RELATIONS_PRUEBACA;

alter table PROCESOCANDIDATO
   drop constraint FK_PROCESOC_RELATIONS_PROCESOR;

alter table PROCESOCANDIDATO
   drop constraint FK_PROCESOC_RELATIONS_CANDIDAT;

alter table PROCESOREQUERIMIENTO
   drop constraint FK_PROCESOR_RELATIONS_PERFILFA;

alter table PROCESOREQUERIMIENTO
   drop constraint FK_PROCESOR_RELATIONS_EMPLEADO;

alter table PROCESOREQUERIMIENTO
   drop constraint FK_PROCESOR_RELATIONS_REQUERIM;

alter table PRUEBA
   drop constraint FK_PRUEBA_RELATIONS_FASE;

alter table PRUEBA
   drop constraint FK_PRUEBA_RELATIONS_TIPOPRUE;

alter table PRUEBA
   drop constraint FK_PRUEBA_RELATIONS_DISCIPLI;

alter table PRUEBACANDIDATO
   drop constraint FK_PRUEBACA_RELATIONS_PRUEBA;

alter table PRUEBACANDIDATO
   drop constraint FK_PRUEBACA_RELATIONS_PROCESOC;

alter table REQUERIMIENTO
   drop constraint FK_REQUER_RELATION_EMPLE;

alter table REQUERIMIENTO
   drop constraint FK_REQUE_RELATIONS_EMPLE;

alter table RESPUESTA
   drop constraint FK_RESPU_RELATIONS_PREGU;

alter table RESPUESTACANDIDATO
   drop constraint FK_RESPUEST_RELATIONS_PREGUNTA;

drop index RELATIONSHIP_19_FK;

drop table CANDIDATO cascade constraints;

drop index RELATIONSHIP_33_FK;

drop index RELATIONSHIP_30_FK;

drop table CARGO cascade constraints;

drop table CLIENTE cascade constraints;

drop index RELATIONSHIP_25_FK;

drop index RELATIONSHIP_24_FK;

drop table CONTACTOCANDIDATO cascade constraints;

drop index RELATIONSHIP_39_FK;

drop index RELATIONSHIP_38_FK;

drop index RELATIONSHIP_37_FK;

drop table CONTACTOCLIENTE cascade constraints;

drop index RELATIONSHIP_34_FK;

drop table DETALLEFACTURA cascade constraints;

drop table DISCIPLINA cascade constraints;

drop table EMPLEADO cascade constraints;

drop index RELATIONSHIP_36_FK;

drop index RELATIONSHIP_35_FK;

drop table FACTURA cascade constraints;

drop table FASE cascade constraints;

drop index RELATIONSHIP_32_FK;

drop index RELATIONSHIP_31_FK;

drop table FASECARGO cascade constraints;

drop index RELATIONSHIP_23_FK;

drop index RELATIONSHIP_22_FK;

drop index RELATIONSHIP_21_FK;

drop table HV cascade constraints;

drop table INSTITUCION cascade constraints;

drop index RELATIONSHIP_3_FK;

drop index RELATIONSHIP_1_FK;

drop table ITEMPERFIL cascade constraints;

drop index RELATIONSHIP_2_FK;

drop table PERFIL cascade constraints;

drop index RELATIONSHIP_5_FK;

drop index RELATIONSHIP_4_FK;

drop table PERFILFASE cascade constraints;

drop index RELATIONSHIP_10_FK;

drop index RELATIONSHIP_9_FK;

drop table PREGUNTA cascade constraints;

drop index RELATIONSHIP_15_FK;

drop index RELATIONSHIP_12_FK;

drop table PREGUNTACANDIDATO cascade constraints;

drop index RELATIONSHIP_20_FK;

drop index RELATIONSHIP_18_FK;

drop table PROCESOCANDIDATO cascade constraints;

drop index RELATIONSHIP_29_FK;

drop index RELATIONSHIP_28_FK;

drop index RELATIONSHIP_16_FK;

drop table PROCESOREQUERIMIENTO cascade constraints;

drop index RELATIONSHIP_8_FK;

drop index RELATIONSHIP_7_FK;

drop index RELATIONSHIP_6_FK;

drop table PRUEBA cascade constraints;

drop index RELATIONSHIP_17_FK;

drop index RELATIONSHIP_14_FK;

drop table PRUEBACANDIDATO cascade constraints;

drop index RELATIONSHIP_27_FK;

drop index RELATIONSHIP_26_FK;

drop table REQUERIMIENTO cascade constraints;

drop index RELATIONSHIP_11_FK;

drop table RESPUESTA cascade constraints;

drop index RELATIONSHIP_13_FK;

drop table RESPUESTACANDIDATO cascade constraints;

drop table TIPOCARGO cascade constraints;

drop table TIPOCONTACTO cascade constraints;

drop table TIPOCONTACTO2 cascade constraints;

drop table TIPODOC cascade constraints;

drop table TIPOITEMPERFIL cascade constraints;

drop table TIPOITEMPERFIL2 cascade constraints;

drop table TIPOPREGUNTA cascade constraints;

drop table TIPOPRUEBA cascade constraints;

/*==============================================================*/
/* Table: CANDIDATO                                             */
/*==============================================================*/
create table CANDIDATO 
(
   USUARIO              VARCHAR2(30)         not null,
   IDTIPODOC            VARCHAR2(3)          not null,
   NOMBRE               VARCHAR2(30)         not null,
   APELLIDO             VARCHAR2(30)         not null,
   FECHANAC             DATE                 not null,
   NDOC                 NUMBER(15)           not null,
   constraint PK_CANDIDATO primary key (USUARIO)
);

/*==============================================================*/
/* Index: RELATIONSHIP_19_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_19_FK on CANDIDATO (
   IDTIPODOC ASC
);

/*==============================================================*/
/* Table: CARGO                                                 */
/*==============================================================*/
create table CARGO 
(
   CONSECCARGO          NUMBER(4,0)          not null,
   IDTIPOCARGO          VARCHAR2(3)          not null,
   CODEMPLEADO          VARCHAR2(5)          not null,
   FECHAINICIOCARGO     DATE                 not null,
   FECHAFINCARGO        DATE,
   DESCCARGO            VARCHAR2(30)         not null,
   constraint PK_CARGO primary key (CONSECCARGO)
);

/*==============================================================*/
/* Index: RELATIONSHIP_30_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_30_FK on CARGO (
   IDTIPOCARGO ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_33_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_33_FK on CARGO (
   CODEMPLEADO ASC
);

/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table CLIENTE 
(
   NIT                  NUMBER(12,0)         not null,
   RAZONSOCIAL          VARCHAR2(40)         not null,
   URL                  VARCHAR2(30),
   constraint PK_CLIENTE primary key (NIT)
);

/*==============================================================*/
/* Table: CONTACTOCANDIDATO                                     */
/*==============================================================*/
create table CONTACTOCANDIDATO 
(
   CONSECCONTACANDI     NUMBER(4)            not null,
   USUARIO              VARCHAR2(30)         not null,
   IDTIPOCONTACTO2      VARCHAR2(3)          not null,
   constraint PK_CONTACTOCANDIDATO primary key (CONSECCONTACANDI)
);

/*==============================================================*/
/* Index: RELATIONSHIP_24_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_24_FK on CONTACTOCANDIDATO (
   USUARIO ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_25_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_25_FK on CONTACTOCANDIDATO (
   IDTIPOCONTACTO2 ASC
);

/*==============================================================*/
/* Table: CONTACTOCLIENTE                                       */
/*==============================================================*/
create table CONTACTOCLIENTE 
(
   NIT                  NUMBER(12,0)         not null,
   CONSECCONTACLIENTE   NUMBER(3,0)          not null,
   IDTIPOCONTACTO1      VARCHAR2(3)          not null,
   IDTIPOCARGO          VARCHAR2(3)          not null,
   NOMBRECLIENTE        VARCHAR2(30)         not null,
   APELLIDOCLIENTE      VARCHAR2(30)         not null,
   ACTIVOCONTACLIENTE   SMALLINT             not null,
   constraint PK_CONTACTOCLIENTE primary key (NIT, CONSECCONTACLIENTE)
);

/*==============================================================*/
/* Index: RELATIONSHIP_37_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_37_FK on CONTACTOCLIENTE (
   NIT ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_38_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_38_FK on CONTACTOCLIENTE (
   IDTIPOCARGO ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_39_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_39_FK on CONTACTOCLIENTE (
   IDTIPOCONTACTO1 ASC
);

/*==============================================================*/
/* Table: DETALLEFACTURA                                        */
/*==============================================================*/
create table DETALLEFACTURA 
(
   NFACTURA             VARCHAR2(6)          not null,
   ITEM                 NUMBER(4,0)          not null,
   constraint PK_DETALLEFACTURA primary key (NFACTURA, ITEM)
);

/*==============================================================*/
/* Index: RELATIONSHIP_34_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_34_FK on DETALLEFACTURA (
   NFACTURA ASC
);

/*==============================================================*/
/* Table: DISCIPLINA                                            */
/*==============================================================*/
create table DISCIPLINA 
(
   IDDISCIPLINA         VARCHAR2(4)          not null,
   DESCDISCIPLINA       VARCHAR2(30)         not null,
   constraint PK_DISCIPLINA primary key (IDDISCIPLINA)
);

/*==============================================================*/
/* Table: EMPLEADO                                              */
/*==============================================================*/
create table EMPLEADO 
(
   CODEMPLEADO          VARCHAR2(5)          not null,
   NOMEMPLEADO          VARCHAR2(30)         not null,
   APELLEMPLEADO        VARCHAR2(30)         not null,
   FECHANAC             DATE                 not null,
   FECHAINGRE           DATE                 not null,
   FECHAEGRESO          DATE,
   CORREO               VARCHAR2(30)         not null,
   constraint PK_EMPLEADO primary key (CODEMPLEADO)
);

/*==============================================================*/
/* Table: FACTURA                                               */
/*==============================================================*/
create table FACTURA 
(
   NFACTURA             VARCHAR2(6)          not null,
   CODEMPLEADO          VARCHAR2(5)          not null,
   NIT                  NUMBER(12,0)         not null,
   FECHAFACTURA         DATE                 not null,
   constraint PK_FACTURA primary key (NFACTURA)
);

/*==============================================================*/
/* Index: RELATIONSHIP_35_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_35_FK on FACTURA (
   CODEMPLEADO ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_36_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_36_FK on FACTURA (
   NIT ASC
);

/*==============================================================*/
/* Table: FASE                                                  */
/*==============================================================*/
create table FASE 
(
   IDFASE               VARCHAR2(4)          not null,
   DESCFASE             VARCHAR2(25)         not null,
   constraint PK_FASE primary key (IDFASE)
);

/*==============================================================*/
/* Table: FASECARGO                                             */
/*==============================================================*/
create table FASECARGO 
(
   CONSECFASECARGO      NUMBER(4,0)          not null,
   IDTIPOCARGO          VARCHAR2(3),
   IDFASE               VARCHAR2(4),
   constraint PK_FASECARGO primary key (CONSECFASECARGO)
);

/*==============================================================*/
/* Index: RELATIONSHIP_31_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_31_FK on FASECARGO (
   IDFASE ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_32_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_32_FK on FASECARGO (
   IDTIPOCARGO ASC
);

/*==============================================================*/
/* Table: HV                                                    */
/*==============================================================*/
create table HV 
(
   CONSECHV             NUMBER(3,0)          not null,
   USUARIO              VARCHAR2(30)         not null,
   CODINSTITUCION       NUMBER(5,0)          not null,
   TIPOITEMPERFIL2      VARCHAR2(4)          not null,
   FECHAINICACT         DATE                 not null,
   FECHAFINACT          DATE,
   DESCACTIVIDAD        VARCHAR2(50)         not null,
   FUNCIONACTIVIDAD     VARCHAR2(50),
   constraint PK_HV primary key (CONSECHV)
);

/*==============================================================*/
/* Index: RELATIONSHIP_21_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_21_FK on HV (
   USUARIO ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_22_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_22_FK on HV (
   CODINSTITUCION ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_23_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_23_FK on HV (
   TIPOITEMPERFIL2 ASC
);

/*==============================================================*/
/* Table: INSTITUCION                                           */
/*==============================================================*/
create table INSTITUCION 
(
   CODINSTITUCION       NUMBER(5,0)          not null,
   NOMINSTITUCION       VARCHAR2(40)         not null,
   constraint PK_INSTITUCION primary key (CODINSTITUCION)
);

/*==============================================================*/
/* Table: ITEMPERFIL                                            */
/*==============================================================*/
create table ITEMPERFIL 
(
   IDITEM               NUMBER(4,0)          not null,
   IDTIPOITEMPERFIL     VARCHAR2(4)          not null,
   IDPERFIL             VARCHAR2(4)          not null,
   DESCITEM             VARCHAR2(30)         not null,
   constraint PK_ITEMPERFIL primary key (IDITEM)
);

/*==============================================================*/
/* Index: RELATIONSHIP_1_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_1_FK on ITEMPERFIL (
   IDTIPOITEMPERFIL ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_3_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_3_FK on ITEMPERFIL (
   IDPERFIL ASC
);

/*==============================================================*/
/* Table: PERFIL                                                */
/*==============================================================*/
create table PERFIL 
(
   IDPERFIL             VARCHAR2(4)          not null,
   IDDISCIPLINA         VARCHAR2(4)          not null,
   DESCPERFIL           VARCHAR2(50)         not null,
   constraint PK_PERFIL primary key (IDPERFIL)
);

/*==============================================================*/
/* Index: RELATIONSHIP_2_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_2_FK on PERFIL (
   IDDISCIPLINA ASC
);

/*==============================================================*/
/* Table: PERFILFASE                                            */
/*==============================================================*/
create table PERFILFASE 
(
   IDPERFIL             VARCHAR2(4)          not null,
   IDFASE               VARCHAR2(4)          not null,
   constraint PK_PERFILFASE primary key (IDPERFIL, IDFASE)
);

/*==============================================================*/
/* Index: RELATIONSHIP_4_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_4_FK on PERFILFASE (
   IDPERFIL ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_5_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_5_FK on PERFILFASE (
   IDFASE ASC
);

/*==============================================================*/
/* Table: PREGUNTA                                              */
/*==============================================================*/
create table PREGUNTA 
(
   IDPRUEBA             VARCHAR2(5)          not null,
   CONSECPREGUNTA       NUMBER(5,0)          not null,
   IDTIPOPREGUNTA       VARCHAR2(4)          not null,
   DESCPREGUNTA         VARCHAR2(30)         not null,
   constraint PK_PREGUNTA primary key (IDPRUEBA, CONSECPREGUNTA)
);

/*==============================================================*/
/* Index: RELATIONSHIP_9_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_9_FK on PREGUNTA (
   IDPRUEBA ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_10_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_10_FK on PREGUNTA (
   IDTIPOPREGUNTA ASC
);

/*==============================================================*/
/* Table: PREGUNTACANDIDATO                                     */
/*==============================================================*/
create table PREGUNTACANDIDATO 
(
   IDPRUEBA             VARCHAR2(5)          not null,
   CONSECPREGUNTA       NUMBER(5,0)          not null,
   CONSECPRUEBACANDI    NUMBER(5,0)          not null,
   constraint PK_PREGUNTACANDIDATO primary key (IDPRUEBA, CONSECPREGUNTA, CONSECPRUEBACANDI)
);

/*==============================================================*/
/* Index: RELATIONSHIP_12_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_12_FK on PREGUNTACANDIDATO (
   IDPRUEBA ASC,
   CONSECPREGUNTA ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_15_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_15_FK on PREGUNTACANDIDATO (
   CONSECPRUEBACANDI ASC
);

/*==============================================================*/
/* Table: PROCESOCANDIDATO                                      */
/*==============================================================*/
create table PROCESOCANDIDATO 
(
   IDPERFIL             VARCHAR2(4)          not null,
   IDFASE               VARCHAR2(4)          not null,
   CONSECREQUE          NUMBER(5,0)          not null,
   CONSEPROCESO         NUMBER(5,0)          not null,
   USUARIO              VARCHAR2(30)         not null,
   IDPROCESCANDIDATO    NUMBER(4,0)          not null,
   FECHAPRESENTACION    DATE                 not null,
   ANALISIS             VARCHAR2(50),
   OBSERVACION          VARCHAR2(50),
   constraint PK_PROCESOCANDIDATO primary key (IDPERFIL, IDFASE, CONSECREQUE, CONSEPROCESO, USUARIO)
);

/*==============================================================*/
/* Index: RELATIONSHIP_18_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_18_FK on PROCESOCANDIDATO (
   IDPERFIL ASC,
   IDFASE ASC,
   CONSECREQUE ASC,
   CONSEPROCESO ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_20_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_20_FK on PROCESOCANDIDATO (
   USUARIO ASC
);

/*==============================================================*/
/* Table: PROCESOREQUERIMIENTO                                  */
/*==============================================================*/
create table PROCESOREQUERIMIENTO 
(
   IDPERFIL             VARCHAR2(4)          not null,
   IDFASE               VARCHAR2(4)          not null,
   CONSECREQUE          NUMBER(5,0)          not null,
   CONSEPROCESO         NUMBER(5,0)          not null,
   CODEMPLEADO          VARCHAR2(5),
   FECHAINICIO          DATE,
   FECHAFIN             DATE,
   CONVOCATORIA         VARCHAR2(200),
   INVITACION           VARCHAR2(200),
   constraint PK_PROCESOREQUERIMIENTO primary key (IDPERFIL, IDFASE, CONSECREQUE, CONSEPROCESO)
);

/*==============================================================*/
/* Index: RELATIONSHIP_16_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_16_FK on PROCESOREQUERIMIENTO (
   IDPERFIL ASC,
   IDFASE ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_28_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_28_FK on PROCESOREQUERIMIENTO (
   CODEMPLEADO ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_29_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_29_FK on PROCESOREQUERIMIENTO (
   CONSECREQUE ASC
);

/*==============================================================*/
/* Table: PRUEBA                                                */
/*==============================================================*/
create table PRUEBA 
(
   IDPRUEBA             VARCHAR2(5)          not null,
   IDTIPOPRUEBA         VARCHAR2(2)          not null,
   IDDISCIPLINA         VARCHAR2(4),
   IDFASE               VARCHAR2(4)          not null,
   DESCPRUEBA           VARCHAR2(30)         not null,
   PRUEBAACTIVA         SMALLINT,
   FECHACREADA          DATE,
   constraint PK_PRUEBA primary key (IDPRUEBA)
);

/*==============================================================*/
/* Index: RELATIONSHIP_6_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_6_FK on PRUEBA (
   IDFASE ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_7_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_7_FK on PRUEBA (
   IDTIPOPRUEBA ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_8_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_8_FK on PRUEBA (
   IDDISCIPLINA ASC
);

/*==============================================================*/
/* Table: PRUEBACANDIDATO                                       */
/*==============================================================*/
create table PRUEBACANDIDATO 
(
   CONSECPRUEBACANDI    NUMBER(5,0)          not null,
   IDPRUEBA             VARCHAR2(5),
   IDPERFIL             VARCHAR2(4)          not null,
   IDFASE               VARCHAR2(4)          not null,
   CONSECREQUE          NUMBER(5,0)          not null,
   CONSEPROCESO         NUMBER(5,0)          not null,
   USUARIO              VARCHAR2(30)         not null,
   FECHAPRES            DATE                 not null,
   CALIFICACION         NUMBER(3,1),
   constraint PK_PRUEBACANDIDATO primary key (CONSECPRUEBACANDI)
);

/*==============================================================*/
/* Index: RELATIONSHIP_14_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_14_FK on PRUEBACANDIDATO (
   IDPRUEBA ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_17_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_17_FK on PRUEBACANDIDATO (
   IDPERFIL ASC,
   IDFASE ASC,
   CONSECREQUE ASC,
   CONSEPROCESO ASC,
   USUARIO ASC
);

/*==============================================================*/
/* Table: REQUERIMIENTO                                         */
/*==============================================================*/
create table REQUERIMIENTO 
(
   CONSECREQUE          NUMBER(5,0)          not null,
   CODEMPLEADO          VARCHAR2(5),
   EMP_CODEMPLEADO      VARCHAR2(5)          not null,
   FECHAREQUE           DATE                 not null,
   SALARIOMAX           NUMBER(6,0)          not null,
   SALARIOMIN           NUMBER(6,0),
   DESCFUNCION          VARCHAR2(50)         not null,
   DESCCARRERAS         VARCHAR2(50)         not null,
   NVACANTES            NUMBER(2,0)          not null,
   constraint PK_REQUERIMIENTO primary key (CONSECREQUE)
);

/*==============================================================*/
/* Index: RELATIONSHIP_26_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_26_FK on REQUERIMIENTO (
   CODEMPLEADO ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_27_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_27_FK on REQUERIMIENTO (
   EMP_CODEMPLEADO ASC
);

/*==============================================================*/
/* Table: RESPUESTA                                             */
/*==============================================================*/
create table RESPUESTA 
(
   IDPRUEBA             VARCHAR2(5)          not null,
   CONSECPREGUNTA       NUMBER(5,0)          not null,
   CONSECRESPUESTA      NUMBER(3,0)          not null,
   RESPUESTA            VARCHAR2(30)         not null,
   constraint PK_RESPUESTA primary key (IDPRUEBA, CONSECPREGUNTA, CONSECRESPUESTA)
);

/*==============================================================*/
/* Index: RELATIONSHIP_11_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_11_FK on RESPUESTA (
   IDPRUEBA ASC,
   CONSECPREGUNTA ASC
);

/*==============================================================*/
/* Table: RESPUESTACANDIDATO                                    */
/*==============================================================*/
create table RESPUESTACANDIDATO 
(
   CONSECRESCANDI       NUMBER(4,0)          not null,
   IDPRUEBA             VARCHAR2(5),
   CONSECPREGUNTA       NUMBER(5,0),
   CONSECPRUEBACANDI    NUMBER(5,0),
   RESCANDI             VARCHAR2(40)         not null,
   constraint PK_RESPUESTACANDIDATO primary key (CONSECRESCANDI)
);

/*==============================================================*/
/* Index: RELATIONSHIP_13_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_13_FK on RESPUESTACANDIDATO (
   IDPRUEBA ASC,
   CONSECPREGUNTA ASC,
   CONSECPRUEBACANDI ASC
);

/*==============================================================*/
/* Table: TIPOCARGO                                             */
/*==============================================================*/
create table TIPOCARGO 
(
   IDTIPOCARGO          VARCHAR2(3)          not null,
   DESCTIPOCARGO        VARCHAR2(20)         not null,
   constraint PK_TIPOCARGO primary key (IDTIPOCARGO)
);

/*==============================================================*/
/* Table: TIPOCONTACTO                                          */
/*==============================================================*/
create table TIPOCONTACTO 
(
   IDTIPOCONTACTO1      VARCHAR2(3)          not null,
   DESCTIPOCONTACTO1    VARCHAR2(20)         not null,
   constraint PK_TIPOCONTACTO primary key (IDTIPOCONTACTO1)
);

/*==============================================================*/
/* Table: TIPOCONTACTO2                                         */
/*==============================================================*/
create table TIPOCONTACTO2 
(
   IDTIPOCONTACTO2      VARCHAR2(3)          not null,
   DESCTIPOCONTACTO     VARCHAR2(20)         not null,
   constraint PK_TIPOCONTACTO2 primary key (IDTIPOCONTACTO2)
);

/*==============================================================*/
/* Table: TIPODOC                                               */
/*==============================================================*/
create table TIPODOC 
(
   IDTIPODOC            VARCHAR2(3)          not null,
   DESCTIPODOC          VARCHAR2(20),
   constraint PK_TIPODOC primary key (IDTIPODOC)
);

/*==============================================================*/
/* Table: TIPOITEMPERFIL                                        */
/*==============================================================*/
create table TIPOITEMPERFIL 
(
   IDTIPOITEMPERFIL     VARCHAR2(4)          not null,
   DESCTIPOITEMPERFIL   VARCHAR2(30)         not null,
   constraint PK_TIPOITEMPERFIL primary key (IDTIPOITEMPERFIL)
);

/*==============================================================*/
/* Table: TIPOITEMPERFIL2                                       */
/*==============================================================*/
create table TIPOITEMPERFIL2 
(
   TIPOITEMPERFIL2      VARCHAR2(4)          not null,
   DESCTIPOITEMPERFIL   VARCHAR2(30)         not null,
   constraint PK_TIPOITEMPERFIL2 primary key (TIPOITEMPERFIL2)
);

/*==============================================================*/
/* Table: TIPOPREGUNTA                                          */
/*==============================================================*/
create table TIPOPREGUNTA 
(
   IDTIPOPREGUNTA       VARCHAR2(4)          not null,
   DESCTIPOPREGUNTA     VARCHAR2(30)         not null,
   constraint PK_TIPOPREGUNTA primary key (IDTIPOPREGUNTA)
);

/*==============================================================*/
/* Table: TIPOPRUEBA                                            */
/*==============================================================*/
create table TIPOPRUEBA 
(
   IDTIPOPRUEBA         VARCHAR2(2)          not null,
   DESCTIPOPRUEBA       VARCHAR2(30)         not null,
   constraint PK_TIPOPRUEBA primary key (IDTIPOPRUEBA)
);

alter table CANDIDATO
   add constraint FK_CANDIDAT_RELATIONS_TIPODOC foreign key (IDTIPODOC)
      references TIPODOC (IDTIPODOC);

alter table CARGO
   add constraint FK_CARGO_RELATIONS_TIPOCARG foreign key (IDTIPOCARGO)
      references TIPOCARGO (IDTIPOCARGO);

alter table CARGO
   add constraint FK_CARGO_RELATIONS_EMPLEADO foreign key (CODEMPLEADO)
      references EMPLEADO (CODEMPLEADO);

alter table CONTACTOCANDIDATO
   add constraint FK_CONTACTO_RELATIONS_CANDIDAT foreign key (USUARIO)
      references CANDIDATO (USUARIO);

alter table CONTACTOCANDIDATO
   add constraint FK_CONTAC_RELATION_TIPOCONT foreign key (IDTIPOCONTACTO2)
      references TIPOCONTACTO2 (IDTIPOCONTACTO2);

alter table CONTACTOCLIENTE
   add constraint FK_CONTACTO_RELATIONS_CLIENTE foreign key (NIT)
      references CLIENTE (NIT);

alter table CONTACTOCLIENTE
   add constraint FK_CONTACTO_RELATIONS_TIPOCARG foreign key (IDTIPOCARGO)
      references TIPOCARGO (IDTIPOCARGO);

alter table CONTACTOCLIENTE
   add constraint FK_CONTAC_RELATIONS_TIPOCONT foreign key (IDTIPOCONTACTO1)
      references TIPOCONTACTO (IDTIPOCONTACTO1);

alter table DETALLEFACTURA
   add constraint FK_DETALLEF_RELATIONS_FACTURA foreign key (NFACTURA)
      references FACTURA (NFACTURA);

alter table FACTURA
   add constraint FK_FACTURA_RELATIONS_EMPLEADO foreign key (CODEMPLEADO)
      references EMPLEADO (CODEMPLEADO);

alter table FACTURA
   add constraint FK_FACTURA_RELATIONS_CLIENTE foreign key (NIT)
      references CLIENTE (NIT);

alter table FASECARGO
   add constraint FK_FASECARG_RELATIONS_FASE foreign key (IDFASE)
      references FASE (IDFASE);

alter table FASECARGO
   add constraint FK_FASECARG_RELATIONS_TIPOCARG foreign key (IDTIPOCARGO)
      references TIPOCARGO (IDTIPOCARGO);

alter table HV
   add constraint FK_HV_RELATIONS_CANDIDAT foreign key (USUARIO)
      references CANDIDATO (USUARIO);

alter table HV
   add constraint FK_HV_RELATIONS_INSTITUC foreign key (CODINSTITUCION)
      references INSTITUCION (CODINSTITUCION);

alter table HV
   add constraint FK_HV_RELATIONS_TIPOITEM foreign key (TIPOITEMPERFIL2)
      references TIPOITEMPERFIL2 (TIPOITEMPERFIL2);

alter table ITEMPERFIL
   add constraint FK_ITEMPERF_RELATIONS_TIPOITEM foreign key (IDTIPOITEMPERFIL)
      references TIPOITEMPERFIL (IDTIPOITEMPERFIL);

alter table ITEMPERFIL
   add constraint FK_ITEMPERF_RELATIONS_PERFIL foreign key (IDPERFIL)
      references PERFIL (IDPERFIL);

alter table PERFIL
   add constraint FK_PERFIL_RELATIONS_DISCIPLI foreign key (IDDISCIPLINA)
      references DISCIPLINA (IDDISCIPLINA);

alter table PERFILFASE
   add constraint FK_PERFILFA_RELATIONS_PERFIL foreign key (IDPERFIL)
      references PERFIL (IDPERFIL);

alter table PERFILFASE
   add constraint FK_PERFILFA_RELATIONS_FASE foreign key (IDFASE)
      references FASE (IDFASE);

alter table PREGUNTA
   add constraint FK_PREGUNTA_RELATIONS_TIPOPREG foreign key (IDTIPOPREGUNTA)
      references TIPOPREGUNTA (IDTIPOPREGUNTA);

alter table PREGUNTA
   add constraint FK_PREGUNTA_RELATIONS_PRUEBA foreign key (IDPRUEBA)
      references PRUEBA (IDPRUEBA);

alter table PREGUNTACANDIDATO
   add constraint FK_PREGUNTA_RELATIONS_PREGUNTA foreign key (IDPRUEBA, CONSECPREGUNTA)
      references PREGUNTA (IDPRUEBA, CONSECPREGUNTA);

alter table PREGUNTACANDIDATO
   add constraint FK_PREGUNTA_RELATIONS_PRUEBACA foreign key (CONSECPRUEBACANDI)
      references PRUEBACANDIDATO (CONSECPRUEBACANDI);

alter table PROCESOCANDIDATO
   add constraint FK_PROCESOC_RELATIONS_PROCESOR foreign key (IDPERFIL, IDFASE, CONSECREQUE, CONSEPROCESO)
      references PROCESOREQUERIMIENTO (IDPERFIL, IDFASE, CONSECREQUE, CONSEPROCESO);

alter table PROCESOCANDIDATO
   add constraint FK_PROCESOC_RELATIONS_CANDIDAT foreign key (USUARIO)
      references CANDIDATO (USUARIO);

alter table PROCESOREQUERIMIENTO
   add constraint FK_PROCESOR_RELATIONS_PERFILFA foreign key (IDPERFIL, IDFASE)
      references PERFILFASE (IDPERFIL, IDFASE);

alter table PROCESOREQUERIMIENTO
   add constraint FK_PROCESOR_RELATIONS_EMPLEADO foreign key (CODEMPLEADO)
      references EMPLEADO (CODEMPLEADO);

alter table PROCESOREQUERIMIENTO
   add constraint FK_PROCESOR_RELATIONS_REQUERIM foreign key (CONSECREQUE)
      references REQUERIMIENTO (CONSECREQUE);

alter table PRUEBA
   add constraint FK_PRUEBA_RELATIONS_FASE foreign key (IDFASE)
      references FASE (IDFASE);

alter table PRUEBA
   add constraint FK_PRUEBA_RELATIONS_TIPOPRUE foreign key (IDTIPOPRUEBA)
      references TIPOPRUEBA (IDTIPOPRUEBA);

alter table PRUEBA
   add constraint FK_PRUEBA_RELATIONS_DISCIPLI foreign key (IDDISCIPLINA)
      references DISCIPLINA (IDDISCIPLINA);

alter table PRUEBACANDIDATO
   add constraint FK_PRUEBACA_RELATIONS_PRUEBA foreign key (IDPRUEBA)
      references PRUEBA (IDPRUEBA);

alter table PRUEBACANDIDATO
   add constraint FK_PRUEBACA_RELATIONS_PROCESOC foreign key (IDPERFIL, IDFASE, CONSECREQUE, CONSEPROCESO, USUARIO)
      references PROCESOCANDIDATO (IDPERFIL, IDFASE, CONSECREQUE, CONSEPROCESO, USUARIO);

alter table REQUERIMIENTO
   add constraint FK_REQUER_RELATION_EMPLE foreign key (CODEMPLEADO)
      references EMPLEADO (CODEMPLEADO);

alter table REQUERIMIENTO
   add constraint FK_REQUE_RELATIONS_EMPLE foreign key (EMP_CODEMPLEADO)
      references EMPLEADO (CODEMPLEADO);

alter table RESPUESTA
   add constraint FK_RESPU_RELATIONS_PREGU foreign key (IDPRUEBA, CONSECPREGUNTA)
      references PREGUNTA (IDPRUEBA, CONSECPREGUNTA);

alter table RESPUESTACANDIDATO
   add constraint FK_RESPUEST_RELATIONS_PREGUNTA foreign key (IDPRUEBA, CONSECPREGUNTA, CONSECPRUEBACANDI)
      references PREGUNTACANDIDATO (IDPRUEBA, CONSECPREGUNTA, CONSECPRUEBACANDI);

