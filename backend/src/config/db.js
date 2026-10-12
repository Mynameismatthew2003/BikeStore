import 'dotenv/config';
import pg from 'pg';

// Conexión a PostgreSQL. Los datos salen del archivo .env
const pool = new pg.Pool({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  database: process.env.DB_NAME,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
});

export default pool;
