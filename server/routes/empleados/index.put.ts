import { ServerResponse } from 'http';
import { abrirConexion, cerrarConexion } from '@/server/utils/conection';

export default defineEventHandler(async (event) => {
    const body = await readBody(event);
    const res = event.res as ServerResponse;
    if (!body.CODEMPLEADO || !body.NOMEMPLEADO || !body.APELLEMPLEADO || !body.FECHANAC || !body.CORREO || !body.cargo) { //compueba si alguno de los campos de la petición estan vacios
        res.writeHead(400, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ error: 'información faltante' }));
        return;
    }
    let result;
    let FECHANAC: Date | string = new Date(body.FECHANAC);
    FECHANAC = `${FECHANAC.getDate().toString().padStart(2, '0')}-${(FECHANAC.getMonth() + 1).toString().padStart(2, '0')}-${FECHANAC.getFullYear()}`;
    let FECHAINGRE = `${new Date().getDate()}-${new Date().getMonth()}-${new Date().getFullYear()}`;
    let FECHAEGRESO = body.FECHAEGRESO || "";
    let connection;
    try {
        connection = await abrirConexion();
            result = await connection.execute(`UPDATE empleado SET 
            NOMEMPLEADO = '${body.NOMEMPLEADO}',
            APELLEMPLEADO = '${body.APELLEMPLEADO}',
            FECHANAC = TO_DATE('${FECHANAC}','DD-MM-YYYY'),
            FECHAINGRE = TO_DATE('${FECHAINGRE}','DD-MM-YYYY'),
            FECHAEGRESO = TO_DATE('${FECHAEGRESO}','DD-MM-YYYY'),
            CORREO = '${body.CORREO}'
            WHERE CODEMPLEADO = '${body.CODEMPLEADO}'
        `);
        await connection.execute(`commit`)

    } catch (err) {
        console.log(err)
    } finally {
        await cerrarConexion(connection)
        if (result) {
            res.writeHead(201, { 'Content-Type': 'application/json' });
            res.end(JSON.stringify({ message: 'Empleado actualizado correctamente' }));
            return;
        }
    }
})