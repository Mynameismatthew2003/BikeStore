import { Router } from 'express';
import { listar } from './categorias.controller.js';

const router = Router();

// Módulo categorias: categorías de productos (apoya el filtro del catálogo, RF-03)
router.get('/', listar);

export default router;
