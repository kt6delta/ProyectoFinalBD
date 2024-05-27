import { ServerResponse } from 'http';
import { abrirConexion, cerrarConexion } from '@/server/utils/conection';
import { ProcesoReq } from '@/server/routes/requerimientos/proceso/index.post';

export default defineEventHandler(async (event) => { // Define un manejador de eventos asíncrono para manejar solicitudes HTTP.
  const body = await readBody(event); // Lee y almacena el cuerpo de la solicitud.
  const res = event.res as ServerResponse; // Obtiene la respuesta del servidor y la convierte al tipo ServerResponse.

  // Verifica si faltan campos requeridos en el cuerpo de la solicitud.
  if (!body.FECHAREQUE || !body.SALARIOMAX || !body.SALARIOMIN || !body.DESCFUNCION || !body.DESCCARRERAS || !body.NVACANTES) {
    res.writeHead(400, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ error: 'información faltante', estatus: 400 }));
    console.log("faltan datos");
    return;
  }

  // Inicializa variables necesarias para la inserción.
  let result;
  let FECHAREQUE: Date | string = new Date(body.FECHAREQUE); // Convierte la fecha de nacimiento a un objeto Date.
  FECHAREQUE = `${FECHAREQUE.getDate().toString().padStart(2, '0')}-${(FECHAREQUE.getMonth() + 1).toString().padStart(2, '0')}-${FECHAREQUE.getFullYear()}`; // Formatea la fecha de nacimiento.
  let connection; // Declara una variable para la conexión a la base de datos.
  let CODEMPLEADO;
  let CONSECREQUE;
  try {
    connection = await abrirConexion(); // Abre una conexión a la base de datos.
    result = await connection.execute(`SELECT * FROM REQUERIMIENTO`); // Ejecuta una consulta SQL para seleccionar todos los empleados.
    CONSECREQUE = (result.rows.length + 1).toString(); // Calcula el código del empleado sumando 1 a la cantidad de filas obtenidas.

    CODEMPLEADO = await connection.execute(`SELECT CODEMPLEADO FROM Empleado where NOMEMPLEADO = '${event?.context?.params?.empleado}'`);
    CODEMPLEADO = CODEMPLEADO.rows[0][0];
    let EMP_CODEMPLEADO = CODEMPLEADO;

    // Inserta el nuevo empleado en la base de datos.
    result = await connection.execute(`
    INSERT INTO requerimiento (CONSECREQUE, CODEMPLEADO, EMP_CODEMPLEADO, FECHAREQUE, SALARIOMAX, SALARIOMIN, DESCFUNCION, DESCCARRERAS, NVACANTES)
    VALUES ('${CONSECREQUE}', '${CODEMPLEADO}', '${EMP_CODEMPLEADO}', TO_DATE('${FECHAREQUE}', 'DD-MM-YYYY'), '${body.SALARIOMAX}', '${body.SALARIOMIN}', '${body.DESCFUNCION}', '${body.DESCCARRERAS}', '${body.NVACANTES}')
  `);
    await connection.execute(`commit`); // Confirma la transacción.
  } catch (err) {
    console.log(err); // Imprime el error en la consola.
    res.writeHead(400, { 'Content-Type': 'application/json' }); // Establece el código de estado HTTP a 201 (Created).
    res.end(JSON.stringify({ message: 'Fallo a la hora de crear Requerimiento' })); // Envía una respuesta con un mensaje de éxito.
    return;
  } finally {
    await cerrarConexion(connection); // Cierra la conexión a la base de datos.
    if (result) {
      await ProcesoReq(res, body.IDPERFIL, body.IDFASE, body.CONVOCATORIA, body.INVITACION, body.FECHAINICIO, body.FECHAFIN, CODEMPLEADO, CONSECREQUE);
    }
  }
});
