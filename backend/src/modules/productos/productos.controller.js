import { listarProductos } from './productos.model.js';

// GET /api/productos?categoria=1&orden=asc
export async function listar(req, res) {
  const { categoria, orden = 'asc' } = req.query;

  let idCategoria = null;
  if (categoria !== undefined && categoria !== '') {
    idCategoria = Number(categoria);
    if (!Number.isInteger(idCategoria) || idCategoria <= 0) {
      return res.status(400).json({ mensaje: 'La categoría debe ser un número entero positivo' });
    }
  }

  if (orden !== 'asc' && orden !== 'desc') {
    return res.status(400).json({ mensaje: "El orden debe ser 'asc' o 'desc'" });
  }

  try {
    const productos = await listarProductos({ idCategoria, orden });
    res.json(productos);
  } catch (error) {
    console.error(error);
    res.status(500).json({ mensaje: 'No se pudieron consultar los productos' });
  }
}
