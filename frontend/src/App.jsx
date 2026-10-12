import { BrowserRouter, Routes, Route } from 'react-router-dom'
import LayoutCliente from './components/LayoutCliente.jsx'
import LayoutAdmin from './components/LayoutAdmin.jsx'
import Catalogo from './pages/Catalogo.jsx'
import DetalleProducto from './pages/DetalleProducto.jsx'
import Carrito from './pages/Carrito.jsx'
import Pago from './pages/Pago.jsx'
import Acceso from './pages/Acceso.jsx'
import AdminProductos from './pages/admin/AdminProductos.jsx'
import AdminUsuarios from './pages/admin/AdminUsuarios.jsx'
import Dashboard from './pages/admin/Dashboard.jsx'

export default function App() {
  return (
    <BrowserRouter>
      <Routes>
        {/* Pantallas del cliente */}
        <Route element={<LayoutCliente />}>
          <Route path="/" element={<Catalogo />} />
          <Route path="/producto/:id" element={<DetalleProducto />} />
          <Route path="/carrito" element={<Carrito />} />
          <Route path="/pago" element={<Pago />} />
          <Route path="/acceso" element={<Acceso />} />
        </Route>

        {/* Pantallas del administrador */}
        <Route path="/admin" element={<LayoutAdmin />}>
          <Route path="productos" element={<AdminProductos />} />
          <Route path="usuarios" element={<AdminUsuarios />} />
          <Route path="dashboard" element={<Dashboard />} />
        </Route>
      </Routes>
    </BrowserRouter>
  )
}
