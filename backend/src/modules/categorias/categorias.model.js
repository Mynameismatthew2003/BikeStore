import pool from '../../config/db.js';

export async function listarCategorias() {
  const resultado = await pool.query(
    'SELECT id_categoria, nombre FROM categoria ORDER BY nombre'
  );
  return resultado.rows.map((fila) => ({ id: fila.id_categoria, nombre: fila.nombre }));
}
