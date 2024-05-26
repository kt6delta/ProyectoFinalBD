import { ServerResponse } from 'http';
import { abrirConexion, cerrarConexion } from '@/server/utils/conection';

export default defineEventHandler(async (event) => {
  const body = await readBody(event);
  const res = event.res as ServerResponse;
  if (!body.NOMEMPLEADO || !body.APELLEMPLEADO || !body.FECHANAC || !body.CORREO || !body.CARGO) { //compueba si alguno de los campos de la petición estan vacios
    res.end(JSON.stringify({ error: 'información faltante', status: 400 }));
    return;
  }
  let result;
  let FECHANAC: Date | string = new Date(body.FECHANAC);
  FECHANAC = `${FECHANAC.getDate().toString().padStart(2, '0')}-${(FECHANAC.getMonth() + 1).toString().padStart(2, '0')}-${FECHANAC.getFullYear()}`;
  let FECHAINGRE = `${new Date().getDate()}-${new Date().getMonth()}-${new Date().getFullYear()}`;
  let FECHAEGRESO = body.FECHAEGRESO || "";
  let FECHAFINCARGO = body.FECHAFINCARGO || "";
  let connection;
  try {
    connection = await abrirConexion();
    result = await connection.execute(`SELECT * FROM Empleado`);
    let CODEMPLEADO = (result.rows.length + 1).toString();
    result = await connection.execute(`SELECT * FROM Empleado where NOMEMPLEADO = '${body.NOMEMPLEADO}' AND APELLEMPLEADO = '${body.APELLEMPLEADO}'`);
    if (result.rows.length > 0) {
      res.end(JSON.stringify({ error: 'Empleado ya existe', status: 409 }));
      return;
    }
    await connection.execute(`insert into empleado values ('${CODEMPLEADO}','${body.NOMEMPLEADO}','${body.APELLEMPLEADO}',TO_DATE('${FECHANAC}','DD-MM-YYYY'),TO_DATE('${FECHAINGRE}','DD-MM-YYYY'),TO_DATE('${FECHAEGRESO}','DD-MM-YYYY'),'${body.CORREO}')`)
    result = await connection.execute(`SELECT * FROM CARGO`);
    let CONSECCARGO = result.rows.length + 1;
    await connection.execute(`insert into CARGO values ('${CONSECCARGO}','${body.CARGO.code}','${CODEMPLEADO}',TO_DATE('${FECHAINGRE}','DD-MM-YYYY'),TO_DATE('${FECHAFINCARGO}','DD-MM-YYYY'),'${body.CARGO.name}')`)
    await connection.execute(`commit`)
  } catch (err) {
    console.log(err);
    res.writeHead(500, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ error: 'Error interno del servidor', status: 500 }));
  } finally {
    await cerrarConexion(connection)
    if (!res.finished) {
      if (result) {
        res.writeHead(201, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ message: 'Empleado creada correctamente', status: 201 }));
      } else {
        res.writeHead(500, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ error: 'Error interno del servidor', status: 500 }));
      }
    }
  }
});

export async function obtenerCodigoEmpleado(nombre: string): Promise<string | null> {
  let connection;
  try {
    connection = await abrirConexion();
    const result = await connection.execute(
      `SELECT CODEMPLEADO FROM Empleado WHERE NOMEMPLEADO = :nombre `,
      [nombre]
    );

    if (result.rows.length > 0) {
      return result.rows[0][0]; // Asumiendo que el CODEMPLEADO está en la primera columna
    } else {
      return null; // No se encontró el empleado
    }
  } catch (err) {
    console.error(err);
    throw err;
  } finally {
    await cerrarConexion(connection);
  }
}