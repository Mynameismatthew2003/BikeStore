// Función para pedir datos al backend. Ejemplo: obtener('/salud')
export async function obtener(ruta) {
  const respuesta = await fetch(`/api${ruta}`)
  if (!respuesta.ok) {
    throw new Error(`Error ${respuesta.status}`)
  }
  return respuesta.json()
}
