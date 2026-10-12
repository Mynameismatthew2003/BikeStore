-- =====================================================================
-- BikeStore - Script 3: consultas útiles
-- Sirven para probar los datos y son la base de lo que el backend
-- necesitará en cada sprint.
--   psql bikestore -f database/03_consultas.sql
-- =====================================================================

-- 1. Catálogo: productos activos con su categoría y disponibilidad,
--    del más barato al más caro (RF-01, RF-02, RF-04)
SELECT p.id_producto, p.nombre, c.nombre AS categoria, p.precio,
       CASE WHEN p.stock > 0 THEN 'Disponible' ELSE 'Agotado' END AS disponibilidad
FROM producto p
JOIN categoria c ON c.id_categoria = p.id_categoria
WHERE p.activo = TRUE
ORDER BY p.precio ASC;

-- 2. Filtro por categoría (RF-03): bicicletas de montaña
SELECT p.nombre, p.precio
FROM producto p
JOIN categoria c ON c.id_categoria = p.id_categoria
WHERE p.activo = TRUE AND c.nombre = 'Bicicletas de montaña';

-- 3. Carrito de Laura con subtotales y total (RF-06)
SELECT p.nombre, i.cantidad, p.precio,
       i.cantidad * p.precio AS subtotal,
       SUM(i.cantidad * p.precio) OVER () AS total
FROM carrito ca
JOIN item_carrito i ON i.id_carrito  = ca.id_carrito
JOIN producto p     ON p.id_producto = i.id_producto
WHERE ca.id_usuario = 2;

-- 4. Total de cada pedido, calculado desde sus detalles (atributo derivado)
SELECT pe.numero_pedido, pe.fecha,
       SUM(d.cantidad * d.precio_unitario) AS total
FROM pedido pe
JOIN detalle_pedido d ON d.id_pedido = pe.id_pedido
GROUP BY pe.id_pedido, pe.numero_pedido, pe.fecha
ORDER BY pe.fecha;

-- 5. Pedidos con el cliente y el estado del pago (RF-12)
SELECT pe.numero_pedido, u.nombre AS cliente, pa.estado AS estado_pago, pa.monto
FROM pedido pe
JOIN usuario u ON u.id_usuario = pe.id_usuario
JOIN pago pa   ON pa.id_pedido = pe.id_pedido
ORDER BY pe.fecha;

-- 6. Dashboard: ventas totales y cantidad de pedidos con pago aprobado (RF-21, RF-23)
SELECT COALESCE(SUM(monto), 0) AS ventas_totales,
       COUNT(*)                AS pedidos_aprobados
FROM pago
WHERE estado = 'aprobado';

-- 7. Dashboard: productos más vendidos (RF-22)
SELECT p.nombre, SUM(d.cantidad) AS unidades_vendidas
FROM detalle_pedido d
JOIN producto p ON p.id_producto = d.id_producto
JOIN pago pa    ON pa.id_pedido  = d.id_pedido AND pa.estado = 'aprobado'
GROUP BY p.id_producto, p.nombre
ORDER BY unidades_vendidas DESC, p.nombre
LIMIT 5;

-- 8. Dashboard: ventas por categoría en un rango de fechas (RF-25)
SELECT c.nombre AS categoria, SUM(d.cantidad * d.precio_unitario) AS ventas
FROM detalle_pedido d
JOIN pedido pe    ON pe.id_pedido    = d.id_pedido
JOIN pago pa      ON pa.id_pedido    = pe.id_pedido AND pa.estado = 'aprobado'
JOIN producto p   ON p.id_producto   = d.id_producto
JOIN categoria c  ON c.id_categoria  = p.id_categoria
WHERE pe.fecha BETWEEN '2026-09-01' AND '2026-10-31'
GROUP BY c.nombre
ORDER BY ventas DESC;

-- 9. Productos con poco stock (5 unidades o menos)
SELECT nombre, stock
FROM producto
WHERE activo = TRUE AND stock <= 5
ORDER BY stock;
