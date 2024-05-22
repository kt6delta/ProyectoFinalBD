import { abrirConexion, cerrarConexion } from '@/server/utils/conection';

export default defineEventHandler(async (event) => {
  try {
    const connection = await abrirConexion();
    let result = await connection.execute(`SELECT * FROM tipocargo`)
    await cerrarConexion(connection);
    result = result.rows;
    result= result.map((subArr: any[]) => ({
      code: subArr[0],
      name: subArr[1]
    }));
    return result;
  } catch (error) {
    console.error(error);
    return { success: false, message: 'Error al conectar a la base de datos' };
  }
});