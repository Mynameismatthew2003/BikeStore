import { Router } from 'express';
import { listar } from './productos.controller.js';

const router = Router();

// Módulo productos: catálogo y administración de productos (RF-01 a RF-04 y RF-17 a RF-20)
router.get('/', listar);

export default router;
