import { useEffect, useState } from 'react'
import { Link, Outlet } from 'react-router-dom'
import { obtener } from '../services/api.js'

export default function LayoutCliente() {
  const [estado, setEstado] = useState('comprobando...')

  // Comprueba que el frontend se comunica con el backend
  useEffect(() => {
    obtener('/salud')
      .then(() => setEstado('conectado'))
      .catch(() => setEstado('sin conexión (¿está encendido el backend?)'))
  }, [])

  return (
    <>
      <header className="barra">
        <span className="logo">BikeStore</span>
        <nav>
          <Link to="/">Catálogo</Link>
          <Link to="/carrito">Carrito</Link>
          <Link to="/acceso">Iniciar sesión</Link>
        </nav>
      </header>
      <main className="contenido">
        <Outlet />
      </main>
      <footer className="pie">Backend: {estado}</footer>
    </>
  )
}
