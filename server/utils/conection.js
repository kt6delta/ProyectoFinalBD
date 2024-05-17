import oracledb from 'oracledb';
oracledb.initOracleClient({ libDir: `${process.env.ORACLE_CLIENT}` })

export async function abrirConexion() {
  try {
    const connection = await oracledb.getConnection({
      user: process.env.PASSWORD,
      password: process.env.PASSWORD,
      connectionString: "localhost:1521/xe"
    });
    console.log('Conectado a la base');
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