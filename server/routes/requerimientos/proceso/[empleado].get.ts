import { abrirConexion, cerrarConexion } from '@/server/utils/conection';

export default defineEventHandler(async (event) => {
  let result;
  try {
    const connection = await abrirConexion();
    let NameEmpleado = event?.context?.params?.empleado || '';
    result = await connection.execute(`SELECT CODEMPLEADO FROM empleado WHERE NOMEMPLEADO = '${NameEmpleado}'`);
    let CodEmpleado = result.rows;
    result = await connection.execute(`SELECT * FROM procesorequerimiento WHERE CODEMPLEADO = '${CodEmpleado}'`);
    result = result.rows;
    const keys = ['PERFIL', 'FASE', 'CONSECREQUE', 'CONSEPROCESO', 'CODEMPLEADO', 'FECHAINICIO', 'FECHAFIN', 'CONVOCATORIA', 'INVITACION'];
    result = await Promise.all(result.map(async (item: any[]) => {
      const obj:any = {};
      for (let index = 0; index < item.length; index++) {
        if (keys[index] === 'PERFIL') {
          let temp = (await connection.execute(`select IDPERFIL,IDDISCIPLINA,DESCPERFIL from perfil where IDPERFIL = '${item[index]}'`)).rows[0];
          let IDDISCIPLINA=temp[1];
          temp = { IDPERFIL: temp[0], DESCPERFIL: temp[2] };
          obj[keys[index]] = temp;
          temp = (await connection.execute(`select IDDISCIPLINA,DESCDISCIPLINA from disciplina where IDDISCIPLINA= '${IDDISCIPLINA}'`)).rows[0];
          temp = { IDDISCIPLINA: temp[0], DESCDISCIPLINA: temp[1] };
          obj['DISCIPLINA'] = temp;
        }
        else if (keys[index] === 'FASE') {
          let temp = (await connection.execute(`select IDFASE,DESCFASE from fase where IDFASE = '${item[index]}'`)).rows[0];
          temp = { IDFASE: temp[0], DESCFASE: temp[1] };
          obj[keys[index]] = temp;
        } else {
          obj[keys[index]] = item[index];
        }
      }
      return obj;
    }));

    await cerrarConexion(connection);
    return result;
  } catch (error) {
    console.error(error);
    return { success: false, message: 'Error al conectar a la base de datos' };
  }
});

