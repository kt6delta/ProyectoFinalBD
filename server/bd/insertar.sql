INSERT ALL
  INTO fase (idfase, descfase) VALUES ('1', 'Registrar Requerimiento')
  INTO fase (idfase, descfase) VALUES ('2', 'Asignar Perfil')
  INTO fase (idfase, descfase) VALUES ('3', 'Publicar Convocatoria')
  INTO fase (idfase, descfase) VALUES ('4', 'Mandar Invitación')
  INTO fase (idfase, descfase) VALUES ('5', 'Preselección')
  INTO fase (idfase, descfase) VALUES ('6', 'Realizar Prueba')
  INTO fase (idfase, descfase) VALUES ('7', 'Entrevista')
  INTO fase (idfase, descfase) VALUES ('8', 'Fase Final')

    INTO TipoCargo (idtipocargo, desctipocargo) VALUES ('1', 'Analista Cliente')
    INTO TipoCargo (idtipocargo, desctipocargo) VALUES ('2', 'Analista General')
    INTO TipoCargo (idtipocargo, desctipocargo) VALUES ('3', 'Analista Sicológico')
    INTO TipoCargo (idtipocargo, desctipocargo) VALUES ('4', 'Analista Conocimient')
    INTO TipoCargo (idtipocargo, desctipocargo) VALUES ('5', 'Analista Tecnológic')

    INTO tipoitemperfil (IDTIPOITEMPERFIL, DESCTIPOITEMPERFIL) VALUES ('1', 'Estudios Técnicos')
    INTO tipoitemperfil (IDTIPOITEMPERFIL, DESCTIPOITEMPERFIL) VALUES ('2', 'Estudios Tecnológico')
    INTO tipoitemperfil (IDTIPOITEMPERFIL, DESCTIPOITEMPERFIL) VALUES ('3', 'Estudios Pregrado')
    INTO tipoitemperfil (IDTIPOITEMPERFIL, DESCTIPOITEMPERFIL) VALUES ('4', 'Estudios Postgrados')
    INTO tipoitemperfil (IDTIPOITEMPERFIL, DESCTIPOITEMPERFIL) VALUES ('5', 'Estudios Doctorales')
    INTO tipoitemperfil (IDTIPOITEMPERFIL, DESCTIPOITEMPERFIL) VALUES ('6', 'Estudios No Formales')
    INTO tipoitemperfil (IDTIPOITEMPERFIL, DESCTIPOITEMPERFIL) VALUES ('7', 'Prácticas Empresariales')
    INTO tipoitemperfil (IDTIPOITEMPERFIL, DESCTIPOITEMPERFIL) VALUES ('8', 'Idiomas')
    INTO tipoitemperfil (IDTIPOITEMPERFIL, DESCTIPOITEMPERFIL) VALUES ('9', 'Voluntariado')
    INTO tipoitemperfil (IDTIPOITEMPERFIL, DESCTIPOITEMPERFIL) VALUES ('10', 'Empleado')
    INTO tipoitemperfil (IDTIPOITEMPERFIL, DESCTIPOITEMPERFIL) VALUES ('11', 'Contratista')
    INTO tipoitemperfil (IDTIPOITEMPERFIL, DESCTIPOITEMPERFIL) VALUES ('12', 'Publicación No indexada')
    INTO tipoitemperfil (IDTIPOITEMPERFIL, DESCTIPOITEMPERFIL) VALUES ('13', 'Publicación Indexada')

    INTO tipocontacto (IDTIPOCONTACTO1, DESCTIPOCONTACTO1) VALUES ('DIR', 'Dirección')
    INTO tipocontacto (IDTIPOCONTACTO1, DESCTIPOCONTACTO1) VALUES ('OFI', 'Dirección Oficina')
    INTO tipocontacto (IDTIPOCONTACTO1, DESCTIPOCONTACTO1) VALUES ('TEL', 'Teléfono Fijo')
    INTO tipocontacto (IDTIPOCONTACTO1, DESCTIPOCONTACTO1) VALUES ('TEO', 'Teléfono Oficina')
    INTO tipocontacto (IDTIPOCONTACTO1, DESCTIPOCONTACTO1) VALUES ('CEL', 'Celular')
    INTO tipocontacto (IDTIPOCONTACTO1, DESCTIPOCONTACTO1) VALUES ('LIK', 'Linkedin')
    INTO tipocontacto (IDTIPOCONTACTO1, DESCTIPOCONTACTO1) VALUES ('WHA', 'WhatsApp')

    INTO disciplina (IDDISCIPLINA, DESCDISCIPLINA) VALUES ('1', 'Computación')
    INTO disciplina (IDDISCIPLINA, DESCDISCIPLINA) VALUES ('2', 'Administración')
    INTO disciplina (IDDISCIPLINA, DESCDISCIPLINA) VALUES ('3', 'Química')
    INTO disciplina (IDDISCIPLINA, DESCDISCIPLINA) VALUES ('4', 'Biología')
    INTO disciplina (IDDISCIPLINA, DESCDISCIPLINA) VALUES ('5', 'Odontología')
    INTO disciplina (IDDISCIPLINA, DESCDISCIPLINA) VALUES ('6', 'Medicina')
    INTO disciplina (IDDISCIPLINA, DESCDISCIPLINA) VALUES ('7', 'Sociología')
    INTO disciplina (IDDISCIPLINA, DESCDISCIPLINA) VALUES ('8', 'Medicina')

    INTO TipoPrueba (IDTIPOPRUEBA, DESCTIPOPRUEBA) VALUES ('1', 'Prueba Conocimiento I')
    INTO TipoPrueba (IDTIPOPRUEBA, DESCTIPOPRUEBA) VALUES ('2', 'Prueba Conocimiento II')
    INTO TipoPrueba (IDTIPOPRUEBA, DESCTIPOPRUEBA) VALUES ('3', 'Prueba Especializada')
    INTO TipoPrueba (IDTIPOPRUEBA, DESCTIPOPRUEBA) VALUES ('4', 'Prueba Sicológica')
    INTO TipoPrueba (IDTIPOPRUEBA, DESCTIPOPRUEBA) VALUES ('5', 'Prueba Grupal')
    INTO TipoPrueba (IDTIPOPRUEBA, DESCTIPOPRUEBA) VALUES ('6', 'Prueba Tecnológica I')
    INTO TipoPrueba (IDTIPOPRUEBA, DESCTIPOPRUEBA) VALUES ('7', 'Prueba Tecnológica II')
    INTO TipoPrueba (IDTIPOPRUEBA, DESCTIPOPRUEBA) VALUES ('8', 'Prueba Tecnológica Especializ')
    INTO TipoPrueba (IDTIPOPRUEBA, DESCTIPOPRUEBA) VALUES ('9', 'Prueba Ingles')
    INTO TipoPrueba (IDTIPOPRUEBA, DESCTIPOPRUEBA) VALUES ('10', 'Prueba Seguridad')

    INTO TipoPregunta (IDTIPOPREGUNTA, DESCTIPOPREGUNTA) VALUES ('1', 'Abierta')
    INTO TipoPregunta (IDTIPOPREGUNTA, DESCTIPOPREGUNTA) VALUES ('2', 'Selección Múltiple')
    INTO TipoPregunta (IDTIPOPREGUNTA, DESCTIPOPREGUNTA) VALUES ('3', 'Selección única')
    INTO TipoPregunta (IDTIPOPREGUNTA, DESCTIPOPREGUNTA) VALUES ('4', 'Falso/Verdadero')
    INTO TipoPregunta (IDTIPOPREGUNTA, DESCTIPOPREGUNTA) VALUES ('5', 'Completar')
    INTO TipoPregunta (IDTIPOPREGUNTA, DESCTIPOPREGUNTA) VALUES ('6', 'Ubicar')
    INTO TipoPregunta (IDTIPOPREGUNTA, DESCTIPOPREGUNTA) VALUES ('7', 'Emparejar')
SELECT * FROM dual;

-- Se eliminaron letras para que quepa dentro del varchar y de aqui para abajo dependen de otras tablas asi que no se creo inserts
--perfil
INSERT ALL
    INTO Perfil (IDPERFIL, IDDISCIPLINA, DESCPERFIL) VALUES ('1', '1', 'Directivo Superior')
    INTO Perfil (IDPERFIL, IDDISCIPLINA, DESCPERFIL) VALUES ('2', '1', 'Directivo Medio')
    INTO Perfil (IDPERFIL, IDDISCIPLINA, DESCPERFIL) VALUES ('3', '1', 'Directivo Base')
    INTO Perfil (IDPERFIL, IDDISCIPLINA, DESCPERFIL) VALUES ('4', '2', 'Profesional Senior')
    INTO Perfil (IDPERFIL, IDDISCIPLINA, DESCPERFIL) VALUES ('5', '2', 'Profesional Semi Senior')
    INTO Perfil (IDPERFIL, IDDISCIPLINA, DESCPERFIL) VALUES ('6', '2', 'Profesional Junior')
    INTO Perfil (IDPERFIL, IDDISCIPLINA, DESCPERFIL) VALUES ('7', '3', 'Tecnólogo con Experiencia')
    INTO Perfil (IDPERFIL, IDDISCIPLINA, DESCPERFIL) VALUES ('8', '3', 'Tecnólogo')
    INTO Perfil (IDPERFIL, IDDISCIPLINA, DESCPERFIL) VALUES ('9', '3', 'Técnico con Experiencia')
    INTO Perfil (IDPERFIL, IDDISCIPLINA, DESCPERFIL) VALUES ('10', '4', 'Técnico')
    INTO Perfil (IDPERFIL, IDDISCIPLINA, DESCPERFIL) VALUES ('11', '4', 'Bachiller')
SELECT * FROM dual;
--Prueba
--FaseCargo
--PerfilFase
--Pregunta
--Respuesta
--ItemPerfil