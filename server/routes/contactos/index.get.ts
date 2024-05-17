import { abrirConexion, cerrarConexion } from '@/server/utils/conection';

export default defineEventHandler(async (event) => {
  try {
    const connection = await abrirConexion();
    const result = await connection.execute(`SELECT * FROM fase`)
    await cerrarConexion(connection);
    return result.rows;
  } catch (error) {
    console.error(error);
    return { success: false, message: 'Error al conectar a la base de datos' };
  }
});