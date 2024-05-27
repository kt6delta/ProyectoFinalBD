import { abrirConexion, cerrarConexion } from '@/server/utils/conection';

export default defineEventHandler(async (event) => {
  try {
    const connection = await abrirConexion();
    let result = await connection.execute(`select * from fase`);
    await cerrarConexion(connection);
    result = result.rows;
    const keys = ['IDFASE','DESCFASE'];
    result = result.map((item: any[]) => {
      return item.reduce((obj, value, index) => {
        obj[keys[index]] = value;
        return obj;
      }, {});
    });
    return result;
  } catch (error) {
    console.error(error);
    return { success: false, message: 'Error al conectar a la base de datos' };
  }
});
