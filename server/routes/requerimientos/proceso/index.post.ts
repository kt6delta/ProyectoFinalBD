export async function ProcesoReq(res: any,
    perfil: any, fase: any, convocatoria: string, invitacion: string, fechainicio: any, fechafin: any,
    codeempleado: any, consecreque: any) {
    if (!perfil || !fase || !convocatoria || !invitacion || !fechainicio || !fechafin) {
        res.writeHead(400, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ error: 'información faltante Proceso Requyerimiento', estatus: 400 }));
        console.log("faltan datos");
        return;
    }
    let conection = await abrirConexion();
    let reult;
    try {
        let CONSEPROCESO = ((await conection.execute(`SELECT * FROM procesorequerimiento`)).rows.length + 1).toString();
        reult = await conection.execute(`
      INSERT INTO PerfilFase (IDPERFIL, IDFASE)
      VALUES ('${perfil.IDPERFIL}', '${fase.IDFASE}')
      `);
        reult = await conection.execute(`
      INSERT INTO procesorequerimiento (IDPERFIL, IDFASE, CONSECREQUE, CONSEPROCESO, CODEMPLEADO, FECHAINICIO, FECHAFIN, CONVOCATORIA, INVITACION)
      VALUES ('${perfil.IDPERFIL}', '${fase.IDFASE}', ${consecreque}, ${CONSEPROCESO}, '${codeempleado}',  TO_DATE('${fechainicio}', 'YYYY-MM-DD"T"HH24:MI:SS."000Z"'),TO_DATE('${fechafin}', 'YYYY-MM-DD"T"HH24:MI:SS."000Z"'), '${convocatoria}', '${invitacion}')
      `);
        await conection.execute(`commit`);
    } catch (err) {
        console.log(err); // Imprime el error en la consola.
        res.writeHead(400, { 'Content-Type': 'application/json' }); // Establece el código de estado HTTP a 201 (Created).
        res.end(JSON.stringify({ message: 'Fallo a la hora de crear ProcesoRequerimiento' })); // Envía una respuesta con un mensaje de éxito.
        return;
    } finally {
        await cerrarConexion(conection); // Cierra la conexión a la base de datos.
        if (reult) {
            res.writeHead(201, { 'Content-Type': 'application/json' }); // Establece el código de estado HTTP a 201 (Created).
            res.end(JSON.stringify({ message: 'ProcesoRequerimiento creado correctamente' })); // Envía una respuesta con un mensaje de éxito.
            return;
        }
    }
}
