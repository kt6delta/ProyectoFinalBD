import { abrirConexion, cerrarConexion } from '@/server/utils/conection';

export default defineEventHandler(async (event) => {
  try {
    const connection = await abrirConexion();
    let NameEmpleado= event?.context?.params?.empleado || '';
    let result=await connection.execute(`SELECT CODEMPLEADO FROM empleado WHERE NOMEMPLEADO = '${NameEmpleado}'`);
    let CodEmpleado = result.rows;
    result = await connection.execute(`SELECT * FROM requerimiento WHERE CODEMPLEADO = ${CodEmpleado}`);
    await cerrarConexion(connection);
    result = result.rows;
    const keys = ['CONSECREQUE', 'CODEMPLEADO', 'EMP_CODEMPLEADO', 'FECHAREQUE', 'SALARIOMAX', 'SALARIOMIN', 'DESCFUNCION', 'DESCCARRERAS', 'NVACANTES'];
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
