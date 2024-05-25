

  import { abrirConexion, cerrarConexion } from '@/server/utils/conection';

export default defineEventHandler(async (event) => {
  try {
    const connection = await abrirConexion();
    let result = await connection.execute(`SELECT * FROM requerimiento`)
    await cerrarConexion(connection);
    result = result.rows;
    return result;
  } catch (error) {
    console.error(error);
    return { success: false, message: 'Error al conectar a la base de datos' };
  }
});