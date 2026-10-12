import express from 'express';
import cors from 'cors';
import routes from './routes/index.js';

const app = express();

app.use(cors());
app.use(express.json());

app.use('/api', routes);

// Si ninguna ruta coincide
app.use((req, res) => {
  res.status(404).json({ mensaje: 'Ruta no encontrada' });
});

export default app;
