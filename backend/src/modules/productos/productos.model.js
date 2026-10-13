import pool from '../../config/db.js';

// Productos activos, con su categoría. Se puede filtrar por categoría y ordenar por precio.
export async function listarProductos({ idCategoria, orden }) {
  const parametros = [];
  let sql = `
    SELECT p.id_producto, p.nombre, p.descripcion, p.imagen, p.precio, p.stock,
           c.id_categoria, c.nombre AS categoria
    FROM producto p
    JOIN categoria c ON c.id_categoria = p.id_categoria
    WHERE p.activo = TRUE`;

  if (idCategoria) {
    parametros.push(idCategoria);
    sql += ` AND p.id_categoria = $${parametros.length}`;
  }

  sql += orden === 'desc' ? ' ORDER BY p.precio DESC, p.nombre' : ' ORDER BY p.precio ASC, p.nombre';

  const resultado = await pool.query(sql, parametros);

  return resultado.rows.map((fila) => ({
    id: fila.id_producto,
    nombre: fila.nombre,
    descripcion: fila.descripcion,
    imagen: fila.imagen,
    precio: Number(fila.precio), // PostgreSQL entrega NUMERIC como texto
    stock: fila.stock,
    disponible: fila.stock > 0,
    idCategoria: fila.id_categoria,
    categoria: fila.categoria,
  }));
}
