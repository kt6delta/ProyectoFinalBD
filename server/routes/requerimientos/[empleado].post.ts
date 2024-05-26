import { ServerResponse } from 'http';
import { abrirConexion, cerrarConexion } from '@/server/utils/conection';
import { obtenerCodigoEmpleado } from '@/server/routes/empleados/index.post';

export default defineEventHandler(async (event) => { // Define un manejador de eventos asíncrono para manejar solicitudes HTTP.
  const body = await readBody(event); // Lee y almacena el cuerpo de la solicitud.
  const res = event.res as ServerResponse; // Obtiene la respuesta del servidor y la convierte al tipo ServerResponse.

 // Verifica si faltan campos requeridos en el cuerpo de la solicitud.
 if ( !body.FECHAREQUE || !body.SALARIOMAX || !body.SALARIOMIN || !body.DESCFUNCION || !body.DESCCARRERAS || !body.NVACANTES) {
  res.writeHead(400, { 'Content-Type': 'application/json' });
  res.end(JSON.stringify({ error: 'información faltante', estatus: 400 }));
  console.log("faltan datos");
  return;
}

  // Inicializa variables necesarias para la inserción.
  let result;
  let FECHAREQUE: Date | string = new Date(body.FECHAREQUE); // Convierte la fecha de nacimiento a un objeto Date.
  FECHAREQUE = `${FECHAREQUE.getDate().toString().padStart(2, '0')}-${(FECHAREQUE.getMonth() + 1).toString().padStart(2, '0')}-${FECHAREQUE.getFullYear()}`; // Formatea la fecha de nacimiento.
  let FECHAINGRE = `${new Date().getDate()}-${new Date().getMonth()}-${new Date().getFullYear()}`; // Obtiene y formatea la fecha actual.


  let connection; // Declara una variable para la conexión a la base de datos.

  try {
    connection = await abrirConexion(); // Abre una conexión a la base de datos.
    result = await connection.execute(`SELECT * FROM REQUERIMIENTO`); // Ejecuta una consulta SQL para seleccionar todos los empleados.
    let CONSECREQUE = (result.rows.length + 1).toString(); // Calcula el código del empleado sumando 1 a la cantidad de filas obtenidas.

    event?.context?.params?.empleado
    let CODEMPLEADO = "1";
    let EMP_CODEMPLEADO = "1"; // Cadena de texto (string) que representa el número 1
    
    // Verifica si el empleado ya existe.
    if (Repeticion(result.rows, body)) {
      res.writeHead(409, { 'Content-Type': 'application/json' }); // Establece el código de estado HTTP a 409 (Conflict).
      res.end(JSON.stringify({ error: 'Empleado ya existe' })); // Envía una respuesta con un mensaje de error.
      return; // Termina la ejecución de la función.
    }

    // Inserta el nuevo empleado en la base de datos.
    console.log(`INSERT INTO requerimiento (CONSECREQUE, CODEMPLEADO, EMP_CODEMPLEADO, FECHAREQUE, SALARIOMAX, SALARIOMIN, DESCFUNCION, DESCCARRERAS, NVACANTES)
    VALUES ('${CONSECREQUE}', '${CODEMPLEADO}', '${EMP_CODEMPLEADO}', TO_DATE('${FECHAREQUE}', 'DD-MM-YYYY'), '${body.SALARIOMAX}', '${body.SALARIOMIN}', '${body.DESCFUNCION}', '${body.DESCCARRERAS}', '${body.NVACANTES}') `)
    result = await connection.execute(`
    INSERT INTO requerimiento (CONSECREQUE, CODEMPLEADO, EMP_CODEMPLEADO, FECHAREQUE, SALARIOMAX, SALARIOMIN, DESCFUNCION, DESCCARRERAS, NVACANTES)
    VALUES ('${CONSECREQUE}', '${CODEMPLEADO}', '${EMP_CODEMPLEADO}', TO_DATE('${FECHAREQUE}', 'DD-MM-YYYY'), '${body.SALARIOMAX}', '${body.SALARIOMIN}', '${body.DESCFUNCION}', '${body.DESCCARRERAS}', '${body.NVACANTES}')
  `);
    await connection.execute(`commit`); // Confirma la transacción.
  } catch (err) {
    console.log(err); // Imprime el error en la consola.
  } finally {
    await cerrarConexion(connection); // Cierra la conexión a la base de datos.
    if (result) {
      res.writeHead(201, { 'Content-Type': 'application/json' }); // Establece el código de estado HTTP a 201 (Created).
      res.end(JSON.stringify({ message: 'Empleado creado correctamente' })); // Envía una respuesta con un mensaje de éxito.
      return;
    }
  }
});

// Función para verificar si un empleado ya existe en la base de datos.
function Repeticion(rows: any[], body: any): boolean {
  const bodyArray = [
    body.DESCFUNCION,
    body.DESCCARRERAS,
    new Date(body.FECHAREQUE),
    body.NVACANTES

  ];

  for (const row of rows) {
    const rowArray = row.slice(7, 8).concat(row.slice(4, 9));
    rowArray[2] = new Date(rowArray[2]);

    if (JSON.stringify(rowArray) === JSON.stringify(bodyArray)) {
      return true;
    }
  }

  return false;
}
