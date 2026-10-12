-- =====================================================================
-- BikeStore - Script 1: creación de tablas (PostgreSQL)
-- Basado en el modelo relacional del Paso 5.
--
-- ATENCIÓN: este script BORRA las tablas si ya existen y las crea de
-- nuevo. Úsenlo para empezar desde cero.
--
-- Cómo ejecutarlo (desde la carpeta raíz del proyecto):
--   psql bikestore -f database/01_crear_tablas.sql
-- =====================================================================

-- Borrar tablas anteriores (primero las dependientes)
DROP TABLE IF EXISTS pago           CASCADE;
DROP TABLE IF EXISTS detalle_pedido CASCADE;
DROP TABLE IF EXISTS pedido         CASCADE;
DROP TABLE IF EXISTS item_carrito   CASCADE;
DROP TABLE IF EXISTS carrito        CASCADE;
DROP TABLE IF EXISTS producto       CASCADE;
DROP TABLE IF EXISTS categoria      CASCADE;
DROP TABLE IF EXISTS usuario        CASCADE;
DROP TABLE IF EXISTS rol            CASCADE;

-- ---------------------------------------------------------------------
-- Tablas independientes
-- ---------------------------------------------------------------------
CREATE TABLE rol (
    id_rol  SERIAL      PRIMARY KEY,
    nombre  VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE categoria (
    id_categoria  SERIAL      PRIMARY KEY,
    nombre        VARCHAR(60) NOT NULL UNIQUE
);

-- ---------------------------------------------------------------------
-- Tablas dependientes
-- ---------------------------------------------------------------------
CREATE TABLE usuario (
    id_usuario       SERIAL       PRIMARY KEY,
    nombre           VARCHAR(100) NOT NULL,
    correo           VARCHAR(150) NOT NULL UNIQUE
                     CHECK (correo LIKE '%_@_%.__%'),
    contrasena_hash  VARCHAR(255) NOT NULL,
    activo           BOOLEAN      NOT NULL DEFAULT TRUE,
    id_rol           INT          NOT NULL REFERENCES rol (id_rol)
);

CREATE TABLE producto (
    id_producto   SERIAL         PRIMARY KEY,
    nombre        VARCHAR(100)   NOT NULL,
    descripcion   TEXT,
    imagen        VARCHAR(255),
    precio        NUMERIC(12,2)  NOT NULL CHECK (precio >= 0),
    stock         INT            NOT NULL DEFAULT 0 CHECK (stock >= 0),
    activo        BOOLEAN        NOT NULL DEFAULT TRUE,
    id_categoria  INT            NOT NULL REFERENCES categoria (id_categoria)
);

CREATE TABLE carrito (
    id_carrito  SERIAL PRIMARY KEY,
    id_usuario  INT    NOT NULL UNIQUE REFERENCES usuario (id_usuario)
);

CREATE TABLE item_carrito (
    id_item_carrito  SERIAL PRIMARY KEY,
    id_carrito       INT    NOT NULL REFERENCES carrito (id_carrito) ON DELETE CASCADE,
    id_producto      INT    NOT NULL REFERENCES producto (id_producto),
    cantidad         INT    NOT NULL CHECK (cantidad > 0),
    UNIQUE (id_carrito, id_producto)
);

CREATE TABLE pedido (
    id_pedido        SERIAL       PRIMARY KEY,
    numero_pedido    VARCHAR(20)  NOT NULL UNIQUE,
    fecha            TIMESTAMP    NOT NULL DEFAULT NOW(),
    direccion_envio  VARCHAR(200) NOT NULL,
    id_usuario       INT          NOT NULL REFERENCES usuario (id_usuario)
);

CREATE TABLE detalle_pedido (
    id_detalle_pedido  SERIAL        PRIMARY KEY,
    id_pedido          INT           NOT NULL REFERENCES pedido (id_pedido) ON DELETE CASCADE,
    id_producto        INT           NOT NULL REFERENCES producto (id_producto),
    cantidad           INT           NOT NULL CHECK (cantidad > 0),
    precio_unitario    NUMERIC(12,2) NOT NULL CHECK (precio_unitario >= 0),
    UNIQUE (id_pedido, id_producto)
);

CREATE TABLE pago (
    id_pago    SERIAL        PRIMARY KEY,
    fecha      TIMESTAMP     NOT NULL DEFAULT NOW(),
    monto      NUMERIC(12,2) NOT NULL CHECK (monto >= 0),
    estado     VARCHAR(20)   NOT NULL
               CHECK (estado IN ('pendiente', 'aprobado', 'rechazado')),
    id_pedido  INT           NOT NULL UNIQUE REFERENCES pedido (id_pedido) ON DELETE CASCADE
);

-- Nota: el total del pedido NO se guarda (atributo derivado).
-- Se calcula con la suma de cantidad * precio_unitario de sus detalles
-- (ver 03_consultas.sql).
