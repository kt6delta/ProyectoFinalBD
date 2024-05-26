
import { ServerResponse } from 'http';
import { abrirConexion, cerrarConexion } from '@/server/utils/conection';

export default defineEventHandler(async (event) => {
  try {
    const body = await readBody(event);
    const res = event.res as ServerResponse;

    const connection = await abrirConexion();
    let CodEmpleado = '1';
    let result = await connection.execute(`SELECT * FROM procesorequerimiento WHERE CODEMPLEADO = '${CodEmpleado}'`);
    await cerrarConexion(connection);
    result = result.rows;
    return result;
  } catch (error) {
    console.error(error);
    return { success: false, message: 'Error al conectar a la base de datos' };
  }
});