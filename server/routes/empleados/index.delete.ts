import { ServerResponse } from 'http';
import { abrirConexion, cerrarConexion } from '@/server/utils/conection';

export default defineEventHandler(async (event) => {
    const body = await readBody(event);
    const res = event.res as ServerResponse;
    if (!body.CODEMPLEADO) { //compueba si alguno de los campos de la petición estan vacios
        res.writeHead(400, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ error: 'información faltante' }));
        return;
    }
    let result;
    let connection;
    try {
        connection = await abrirConexion();
        await connection.execute(`DELETE FROM cargo WHERE CODEMPLEADO = '${body.CODEMPLEADO}'`);
        await connection.execute(`DELETE FROM requerimiento WHERE CODEMPLEADO = '${body.CODEMPLEADO}'`);
        result = await connection.execute(`DELETE FROM empleado WHERE CODEMPLEADO = '${body.CODEMPLEADO}'`);
        await connection.execute(`commit`)
    } catch (err) {
        console.log(err)
    } finally {
        await cerrarConexion(connection)
        if (result) {
            res.writeHead(201, { 'Content-Type': 'application/json' });
            res.end(JSON.stringify({ message: 'Empleado Eliminado correctamente' }));
            return;
        }
    }
})
