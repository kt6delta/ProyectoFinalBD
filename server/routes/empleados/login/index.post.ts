import { ServerResponse } from 'http';
import { abrirConexion, cerrarConexion } from '@/server/utils/conection';

export default defineEventHandler(async (event) => {
  const body = await readBody(event);
  const res = event.res as ServerResponse;
  if (!body.NOMEMPLEADO || !body.APELLEMPLEADO || !body.FECHANAC || !body.CORREO || !body.cargo) { //compueba si alguno de los campos de la petición estan vacios
    res.writeHead(400, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({status: 400, error: 'información faltante' }));
    return;
  }
  let result;
  let FECHANAC: Date | string = new Date(body.FECHANAC);
  FECHANAC = `${FECHANAC.getDate().toString().padStart(2, '0')}-${(FECHANAC.getMonth() + 1).toString().padStart(2, '0')}-${FECHANAC.getFullYear()}`;
  let FECHAINGRE = `${new Date().getDate()}-${new Date().getMonth()}-${new Date().getFullYear()}`;
  let connection;
  try {
    connection = await abrirConexion();
    let CODEMPLEADO = await connection.execute(`SELECT CODEMPLEADO FROM Empleado where NOMEMPLEADO = '${body.NOMEMPLEADO}' and APELLEMPLEADO = '${body.APELLEMPLEADO}' and FECHANAC = TO_DATE('${FECHANAC}','DD-MM-YYYY') and CORREO = '${body.CORREO}'`);
    if (CODEMPLEADO.rows.length > 0) {
      CODEMPLEADO = CODEMPLEADO.rows[0][0];
      result = await connection.execute(`UPDATE empleado SET FECHAINGRE = TO_DATE('${FECHAINGRE}','DD-MM-YYYY') WHERE CODEMPLEADO = '${CODEMPLEADO}'`);
      await connection.execute(`commit`)
    }else{
      res.end(JSON.stringify({status: 404, error: 'Empleado no encontrado' }));
      return;
    }
  } catch (err) {
    console.log(err)
  } finally {
    await cerrarConexion(connection);
    if (result) {
      res.writeHead(201, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ status: 201, message: 'Empleado logeado correctamente' }));
      return;
    }
  }
})
