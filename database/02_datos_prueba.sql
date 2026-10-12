-- =====================================================================
-- BikeStore - Script 2: datos de prueba
-- Ejecutar DESPUÉS de 01_crear_tablas.sql:
--   psql bikestore -f database/02_datos_prueba.sql
--
-- Usuarios de prueba (contraseñas guardadas con bcrypt):
--   admin@bikestore.com    contraseña: Admin123*
--   clientes (3 usuarios)  contraseña: Cliente123*
-- =====================================================================

-- Roles
INSERT INTO rol (id_rol, nombre) VALUES
    (1, 'Administrador'),
    (2, 'Cliente');

-- Usuarios
INSERT INTO usuario (id_usuario, nombre, correo, contrasena_hash, activo, id_rol) VALUES
    (1, 'Administrador BikeStore', 'admin@bikestore.com',  '$2b$10$vUuL5zYpO9j49Daj0kwDWOexQYMZTzOBbrO69XfiRwxusDgOtEKdi', TRUE,  1),
    (2, 'Laura Gómez',             'laura@correo.com',     '$2b$10$rgxFjn/UP/QOND8ijnv3AeFJzGolBWwUWWoO5ryTQHQZEiQiPUt5G', TRUE,  2),
    (3, 'Carlos Ramírez',          'carlos@correo.com',    '$2b$10$/OJGb.hCpPkZXybX7.XXUuXwWGsltiHXtSnV22ddqhq5ySulQD2h2', TRUE,  2),
    (4, 'Ana Torres',              'ana@correo.com',       '$2b$10$OgPayxrOUmEbIj2pi9RN3eiHtHz28zs2BC87gQSVSj/5fvcnoZ/8O', FALSE, 2);

-- Categorías
INSERT INTO categoria (id_categoria, nombre) VALUES
    (1, 'Bicicletas de montaña'),
    (2, 'Bicicletas de ruta'),
    (3, 'Cascos y protección'),
    (4, 'Luces y seguridad'),
    (5, 'Repuestos y herramientas');

-- Productos (precios en pesos colombianos).
-- El producto 4 está agotado (stock 0) y el 13 está inactivo, para probar esos casos.
-- La columna imagen queda vacía hasta que el equipo tenga las fotos.
INSERT INTO producto (id_producto, nombre, descripcion, imagen, precio, stock, activo, id_categoria) VALUES
    (1,  'Bicicleta de montaña Trail 29',   'Aro 29, cuadro de aluminio, 21 velocidades y frenos de disco.',        NULL, 1850000, 8,  TRUE,  1),
    (2,  'Bicicleta de montaña Cross 26',   'Aro 26, suspensión delantera, 18 velocidades. Ideal para principiantes.', NULL, 1250000, 5,  TRUE,  1),
    (3,  'Bicicleta de ruta Aero 700',      'Cuadro ligero, manubrio de carretera y 16 velocidades.',               NULL, 2450000, 3,  TRUE,  2),
    (4,  'Bicicleta de ruta Sprint',        'Cuadro de aluminio, 14 velocidades, llantas delgadas.',                NULL, 1980000, 0,  TRUE,  2),
    (5,  'Casco Pro ventilado',             'Casco con 18 ventilaciones y ajuste trasero.',                         NULL, 185000,  20, TRUE,  3),
    (6,  'Casco urbano ligero',             'Casco liviano para uso diario en ciudad.',                             NULL, 120000,  15, TRUE,  3),
    (7,  'Guantes de ciclismo',             'Guantes con almohadilla en la palma y cierre de velcro.',              NULL, 45000,   30, TRUE,  3),
    (8,  'Luz delantera recargable USB',    'Luz LED de 800 lúmenes con carga por USB.',                            NULL, 65000,   25, TRUE,  4),
    (9,  'Luz trasera LED',                 'Luz roja con 3 modos de destello.',                                    NULL, 35000,   40, TRUE,  4),
    (10, 'Kit de herramientas 16 en 1',     'Llaves allen, destornilladores y desmontadores de llanta.',            NULL, 78000,   12, TRUE,  5),
    (11, 'Bomba de aire de piso',           'Bomba con manómetro y válvula universal.',                             NULL, 90000,   10, TRUE,  5),
    (12, 'Cadena 10 velocidades',           'Cadena de acero compatible con sistemas de 10 velocidades.',           NULL, 55000,   18, TRUE,  5),
    (13, 'Candado de cable',                'Candado con clave de 4 dígitos.',                                      NULL, 40000,   5,  FALSE, 4);

-- Carritos: Laura tiene 2 productos, Carlos tiene el carrito vacío y Ana no tiene carrito.
INSERT INTO carrito (id_carrito, id_usuario) VALUES
    (1, 2),
    (2, 3);

INSERT INTO item_carrito (id_item_carrito, id_carrito, id_producto, cantidad) VALUES
    (1, 1, 2, 1),
    (2, 1, 7, 2);

-- Pedidos
INSERT INTO pedido (id_pedido, numero_pedido, fecha, direccion_envio, id_usuario) VALUES
    (1, 'BS-2026-0001', '2026-09-05 10:15:00', 'Calle 30 # 25-14, Palmira, Valle del Cauca', 2),
    (2, 'BS-2026-0002', '2026-09-18 16:40:00', 'Carrera 28 # 42-10, Palmira, Valle del Cauca', 3),
    (3, 'BS-2026-0003', '2026-10-02 09:05:00', 'Calle 30 # 25-14, Palmira, Valle del Cauca', 2),
    (4, 'BS-2026-0004', '2026-10-08 18:20:00', 'Avenida 4 # 12-33, Cali, Valle del Cauca', 4);

-- Detalle de los pedidos (el precio unitario es el precio al momento de la compra)
INSERT INTO detalle_pedido (id_detalle_pedido, id_pedido, id_producto, cantidad, precio_unitario) VALUES
    (1, 1, 1,  1, 1850000),
    (2, 1, 5,  1, 185000),
    (3, 2, 8,  2, 65000),
    (4, 2, 9,  2, 35000),
    (5, 3, 10, 1, 78000),
    (6, 3, 11, 1, 90000),
    (7, 3, 12, 2, 55000),
    (8, 4, 6,  2, 120000),
    (9, 4, 7,  1, 45000);

-- Pagos simulados: uno por pedido (el monto coincide con el total del pedido)
INSERT INTO pago (id_pago, fecha, monto, estado, id_pedido) VALUES
    (1, '2026-09-05 10:16:00', 2035000, 'aprobado',  1),
    (2, '2026-09-18 16:41:00', 200000,  'aprobado',  2),
    (3, '2026-10-02 09:06:00', 278000,  'aprobado',  3),
    (4, '2026-10-08 18:21:00', 285000,  'pendiente', 4);

-- Como se insertaron ids a mano, se actualizan los contadores de las columnas SERIAL
-- para que los próximos registros no repitan ids.
SELECT setval(pg_get_serial_sequence('rol',            'id_rol'),            (SELECT MAX(id_rol)            FROM rol));
SELECT setval(pg_get_serial_sequence('usuario',        'id_usuario'),        (SELECT MAX(id_usuario)        FROM usuario));
SELECT setval(pg_get_serial_sequence('categoria',      'id_categoria'),      (SELECT MAX(id_categoria)      FROM categoria));
SELECT setval(pg_get_serial_sequence('producto',       'id_producto'),       (SELECT MAX(id_producto)       FROM producto));
SELECT setval(pg_get_serial_sequence('carrito',        'id_carrito'),        (SELECT MAX(id_carrito)        FROM carrito));
SELECT setval(pg_get_serial_sequence('item_carrito',   'id_item_carrito'),   (SELECT MAX(id_item_carrito)   FROM item_carrito));
SELECT setval(pg_get_serial_sequence('pedido',         'id_pedido'),         (SELECT MAX(id_pedido)         FROM pedido));
SELECT setval(pg_get_serial_sequence('detalle_pedido', 'id_detalle_pedido'), (SELECT MAX(id_detalle_pedido) FROM detalle_pedido));
SELECT setval(pg_get_serial_sequence('pago',           'id_pago'),           (SELECT MAX(id_pago)           FROM pago));
