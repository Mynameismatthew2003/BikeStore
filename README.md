# BikeStore

Tienda en línea de bicicletas y accesorios. Proyecto didáctico ADSO (SENA).

**Equipo:** Mateo, Valentina y Santiago.

## Estructura

```
BikeStore/
├── backend/    API con Node.js + Express (se conecta a la base de datos)
├── frontend/   Aplicación React (Vite)
├── database/   Scripts SQL (tablas, datos de prueba, consultas)
└── docs/       Diagramas y documentación (draw.io, informes)
```

## Requisitos

- [Node.js](https://nodejs.org) (versión LTS)
- [Git](https://git-scm.com)
- [PostgreSQL](https://www.postgresql.org) (gestor propuesto; confirmar con el instructor)
- Editor: Visual Studio Code

Para comprobar la instalación, abran una terminal y escriban:

```
node -v
npm -v
git --version
psql --version
```

## Cómo ejecutar el proyecto

### 1. Base de datos
1. Creen una base de datos llamada `bikestore` en PostgreSQL.
2. Ejecuten los scripts de la carpeta `database/` (cuando estén listos).

### 2. Backend
```
cd backend
npm install
cp .env.example .env     (en Windows: copy .env.example .env)
```
Abran el archivo `.env` y escriban su contraseña de PostgreSQL. Luego:
```
npm run dev
```
Prueben en el navegador: http://localhost:3000/api/salud

### 3. Frontend
En **otra terminal**:
```
cd frontend
npm install
npm run dev
```
Abran la dirección que muestra la terminal (normalmente http://localhost:5173).

## Organización del código (por módulos)

**Backend** (`backend/src/`): cada módulo tiene sus rutas, su controlador y su modelo.

| Carpeta | Para qué sirve |
|---|---|
| `config/` | Conexión a la base de datos |
| `middlewares/` | Seguridad (verificar sesión y rol) |
| `routes/` | Reúne las rutas de todos los módulos |
| `modules/<nombre>/` | `routes.js` (rutas), `controller.js` (lógica), `model.js` (consultas SQL) |

Módulos: `auth`, `usuarios`, `productos`, `categorias`, `carrito`, `pedidos`, `pagos`, `reportes`.

**Frontend** (`frontend/src/`):

| Carpeta | Para qué sirve |
|---|---|
| `pages/` | Una pantalla por archivo (las 8 de los wireframes) |
| `pages/admin/` | Pantallas del administrador |
| `components/` | Piezas reutilizables (barras de navegación, etc.) |
| `services/` | Llamadas a la API del backend |
| `context/` | Estado compartido (sesión, carrito) |

## Trabajo con Git

- `main`: solo código que funciona.
- `develop`: donde se junta todo.
- Una rama por tarea: `feature/catalogo`, `feature/login`, etc.
- Nadie sube directo a `main`. Se usan Pull Requests y otro compañero revisa.
