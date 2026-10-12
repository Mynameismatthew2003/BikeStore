import { Link, Outlet } from 'react-router-dom'

export default function LayoutAdmin() {
  return (
    <>
      <header className="barra">
        <span className="logo">Admin</span>
        <nav>
          <Link to="/admin/productos">Productos</Link>
          <Link to="/admin/usuarios">Usuarios</Link>
          <Link to="/admin/dashboard">Dashboard</Link>
        </nav>
      </header>
      <main className="contenido">
        <Outlet />
      </main>
    </>
  )
}
