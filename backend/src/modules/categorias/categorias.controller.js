import { listarCategorias } from './categorias.model.js';

// GET /api/categorias
export async function listar(req, res) {
  try {
    res.json(await listarCategorias());
  } catch (error) {
    console.error(error);
    res.status(500).json({ mensaje: 'No se pudieron consultar las categorías' });
  }
}
