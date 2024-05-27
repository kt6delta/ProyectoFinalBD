import { ServerResponse } from 'http';
import { abrirConexion, cerrarConexion } from '@/server/utils/conection';

export default defineEventHandler(async (event) => { // Define un manejador de eventos asíncrono para manejar solicitudes HTTP.
  const body = await readBody(event); // Lee y almacena el cuerpo de la solicitud.
  const res = event.res as ServerResponse; // Obtiene la respuesta del servidor y la convierte al tipo ServerResponse.

  // Verifica si faltan campos requeridos en el cuerpo de la solicitud.
  if (!body.FECHAREQUE || !body.SALARIOMAX || !body.SALARIOMIN || !body.DESCFUNCION || !body.DESCCARRERAS || !body.NVACANTES || !body.CONSECREQUE) {
    res.writeHead(400, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ error: 'información faltante', estatus: 400 }));
    console.log("faltan datos");
    return;
  }

  // Inicializa variables necesarias para la inserción.
  let result;
  let connection; // Declara una variable para la conexión a la base de datos.

  try {
    connection = await abrirConexion(); // Abre una conexión a la base de datos.
    result = await connection.execute(`
    UPDATE requerimiento SET 
    SALARIOMAX = '${body.SALARIOMAX}',
    SALARIOMIN = '${body.SALARIOMIN}',
    DESCFUNCION = '${body.DESCFUNCION}',
    FECHAREQUE = TO_DATE('${body.FECHAREQUE}','DD-MM-YYYY'),
    DESCCARRERAS = '${body.DESCCARRERAS}',
    NVACANTES = '${body.NVACANTES}'
    WHERE CONSECREQUE = '${body.CONSECREQUE}'
`);
    await connection.execute(`commit`); // Confirma la transacción.
  } catch (err) {
    console.log(err); // Imprime el error en la consola.
    res.writeHead(400, { 'Content-Type': 'application/json' }); // Establece el código de estado HTTP a 201 (Created).
    res.end(JSON.stringify({ message: 'Fallo a la hora de actualizar Requerimiento' })); // Envía una respuesta con un mensaje de éxito.
    return;
  } finally {
    await cerrarConexion(connection); // Cierra la conexión a la base de datos.
    if (result) {
      res.writeHead(201, { 'Content-Type': 'application/json' }); // Establece el código de estado HTTP a 201 (Created).
      res.end(JSON.stringify({ message: 'Requerimiento actualizado con éxito' })); // Envía una respuesta con un mensaje de éxito.
    }
  }
});