import { abrirConexion, cerrarConexion } from '@/server/utils/conection';

export default defineEventHandler(async (event) => {
  try {
    const connection = await abrirConexion();
    // Aquí podrías realizar alguna operación con la base de datos.
    await cerrarConexion(connection);
    return { success: true, message: 'Conexión a la base de datos exitosa' };
  } catch (error) {
    return { success: false, message: 'Error al conectar a la base de datos' };
  }
});