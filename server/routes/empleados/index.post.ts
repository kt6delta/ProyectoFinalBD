import { ServerResponse } from 'http';
import { abrirConexion, cerrarConexion } from '@/server/utils/conection';

export default defineEventHandler(async (event) => {
  const body = await readBody(event);
  const res = event.res as ServerResponse;
  if (!body.NOMEMPLEADO || !body.APELLEMPLEADO || !body.FECHANAC || !body.CORREO || !body.CARGO) { //compueba si alguno de los campos de la petición estan vacios
    res.writeHead(400, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ error: 'información faltante' }));
    return;
  }
  let result;
  let FECHANAC:Date | string = new Date(body.FECHANAC);
  FECHANAC = `${FECHANAC.getDate().toString().padStart(2, '0')}-${(FECHANAC.getMonth() + 1).toString().padStart(2, '0')}-${FECHANAC.getFullYear()}`;
  let FECHAINGRE = `${new Date().getDate()}-${new Date().getMonth()}-${new Date().getFullYear()}`;
  let FECHAEGRESO = body.FECHAEGRESO || "";
  let FECHAFINCARGO = body.FECHAFINCARGO || "";
  let connection;
  try {
    connection = await abrirConexion();
    result = await connection.execute(`SELECT * FROM Empleado`);
    let CODEMPLEADO = (result.rows.length + 1).toString();
    if(Repeticion(result.rows, body)){
      res.writeHead(409, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ error: 'Empleado ya existe' }));
      return;
    }
    result = await connection.execute(`insert into empleado values ('${CODEMPLEADO}','${body.NOMEMPLEADO}','${body.APELLEMPLEADO}',TO_DATE('${FECHANAC}','DD-MM-YYYY'),TO_DATE('${FECHAINGRE}','DD-MM-YYYY'),TO_DATE('${FECHAEGRESO}','DD-MM-YYYY'),'${body.CORREO}')`)
    result = await connection.execute(`SELECT * FROM CARGO`);
    let CONSECCARGO = result.rows.length + 1;
    result = await connection.execute(`insert into CARGO values ('${CONSECCARGO}','${body.CARGO.code}','${CODEMPLEADO}',TO_DATE('${FECHAINGRE}','DD-MM-YYYY'),TO_DATE('${FECHAFINCARGO}','DD-MM-YYYY'),'${body.CARGO.name}')`)
    await connection.execute(`commit`)
  } catch (err) {
    console.log(err)
  } finally {
    await cerrarConexion(connection)
    if (result) {
      res.writeHead(201, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ message: 'Empleado creada correctamente' }));
      return ;
    }
  }
})

function Repeticion(Object: any, body: any) {
  const bodyArray = [
    body.NOMEMPLEADO,
    body.APELLEMPLEADO,
    new Date(body.FECHANAC),
    body.CORREO
  ];

  for (const row of Object) {
    const rowArray = row.slice(1,4).concat(row.slice(6,7));
    rowArray[2] = new Date(rowArray[2]);
    if (JSON.stringify(rowArray) === JSON.stringify(bodyArray)) {
      return true;
    }
  }
  return false;
}