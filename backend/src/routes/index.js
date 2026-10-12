import { Router } from 'express';
import pool from '../config/db.js';
import authRoutes from '../modules/auth/auth.routes.js';
import usuariosRoutes from '../modules/usuarios/usuarios.routes.js';
import productosRoutes from '../modules/productos/productos.routes.js';
import categoriasRoutes from '../modules/categorias/categorias.routes.js';
import carritoRoutes from '../modules/carrito/carrito.routes.js';
import pedidosRoutes from '../modules/pedidos/pedidos.routes.js';
import pagosRoutes from '../modules/pagos/pagos.routes.js';
import reportesRoutes from '../modules/reportes/reportes.routes.js';

const router = Router();

// Prueba rápida: ¿el servidor está funcionando?
router.get('/salud', (req, res) => {
  res.json({ estado: 'ok', mensaje: 'API de BikeStore funcionando' });
});

// Prueba de la conexión con la base de datos
router.get('/salud/bd', async (req, res) => {
  try {
    const resultado = await pool.query('SELECT NOW() AS ahora');
    res.json({ estado: 'ok', ahora: resultado.rows[0].ahora });
  } catch (error) {
    res.status(500).json({ estado: 'error', mensaje: 'No se pudo conectar a la base de datos', detalle: error.message });
  }
});

// Módulos
router.use('/auth', authRoutes);
router.use('/usuarios', usuariosRoutes);
router.use('/productos', productosRoutes);
router.use('/categorias', categoriasRoutes);
router.use('/carrito', carritoRoutes);
router.use('/pedidos', pedidosRoutes);
router.use('/pagos', pagosRoutes);
router.use('/reportes', reportesRoutes);

export default router;
