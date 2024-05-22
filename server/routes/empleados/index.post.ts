import { ServerResponse } from 'http';
import { abrirConexion, cerrarConexion } from '@/server/utils/conection';

export default defineEventHandler(async (event) => {
  const body = await readBody(event);
  const res = event.res as ServerResponse;
  if (!body.NOMEMPLEADO || !body.APELLEMPLEADO || !body.FECHANAC || !body.CORREO || !body.cargo) { //compueba si alguno de los campos de la petición estan vacios
    res.writeHead(400, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ error: 'información faltante' }));
    return { error: 'información faltante' };
  }
  let result;
  let CODEMPLEADO = '1';
  let FECHANAC:Date | string = new Date(body.FECHANAC);
  FECHANAC = `${FECHANAC.getDate().toString().padStart(2, '0')}-${(FECHANAC.getMonth() + 1).toString().padStart(2, '0')}-${FECHANAC.getFullYear()}`;

  let FECHAINGRE = `${new Date().getDate()}-${new Date().getMonth()}-${new Date().getFullYear()}`;
  let FECHAEGRESO = FECHAINGRE;
  let connection;
  try {
    connection = await abrirConexion();
    result = await connection.execute(`insert into empleado values ('${CODEMPLEADO}','${body.NOMEMPLEADO}','${body.APELLEMPLEADO}',TO_DATE('${FECHANAC}','DD-MM-YYYY'),TO_DATE('${FECHAINGRE}','DD-MM-YYYY'),TO_DATE('${FECHAEGRESO}','DD-MM-YYYY'),'${body.CORREO}')`)
    console.log(result);
    await connection.execute(`commit`)
  } catch (err) {
    console.log(err)
    if (err.message.includes('ORA-00001')) {
      await cerrarConexion(connection)
      res.writeHead(409, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ error: 'Empleado ya existe' }));
      return { error: 'Empleado ya existe' };
    }
  } finally {
    await cerrarConexion(connection)
    if (result) {
      res.writeHead(201, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ message: 'Empleado creada correctamente' }));
      return { message: 'Empleado creada correctamente' };
    }
  }
})