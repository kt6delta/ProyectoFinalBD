import oracledb from 'oracledb';

oracledb.initOracleClient({ libDir: `C:\\Program Files\\oracle\\instantclient_12_1` })

export async function abrirConexion() {
  try {
    const connection = await oracledb.getConnection({
      user: "bd182",
      password: "bd182",
      connectString: 'localhost:1521/XE'
    });
    return connection;
  } catch (err) {
    console.error(err);
    throw new Error('Failed to connect to Oracle DB');
  }
}

export async function cerrarConexion(connection) {
  if (connection) {
    try {
      await connection.close();
      console.log('Se ha cerrado la conexión');
    } catch (err) {
      console.error(err);
      throw new Error('Failed to close Oracle DB connection');
    }
  }
}