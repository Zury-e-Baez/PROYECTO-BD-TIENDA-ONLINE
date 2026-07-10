-- ============================================================
-- PROYECTO DE BASES DE DATOS
-- Sistema de Gestión de Tienda Online
-- ============================================================
-- Archivo: 01_creacion_base_datos.sql
-- Descripción:
-- Crea la base de datos, sus tablas, restricciones,
-- claves primarias, claves foráneas e índices.
-- ============================================================


-- ============================================================
-- CREACIÓN DE LA BASE DE DATOS
-- ============================================================

DROP DATABASE IF EXISTS tienda_online;

CREATE DATABASE tienda_online
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE tienda_online;


-- ============================================================
-- TABLA: Categorias
-- ============================================================

CREATE TABLE Categorias (
    id_categoria INT AUTO_INCREMENT,
    nombre VARCHAR(45) NOT NULL,
    descripcion VARCHAR(255),

    CONSTRAINT pk_categorias
        PRIMARY KEY (id_categoria)
) ENGINE = InnoDB;


-- ============================================================
-- TABLA: Clientes
-- ============================================================

CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT,
    nombre VARCHAR(45) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    direccion VARCHAR(200),

    CONSTRAINT pk_clientes
        PRIMARY KEY (id_cliente),

    CONSTRAINT uq_clientes_correo
        UNIQUE (correo)
) ENGINE = InnoDB;

-- ============================================================
-- TABLA: Productos
-- ============================================================

CREATE TABLE Productos (
    id_producto INT AUTO_INCREMENT,
    nombre VARCHAR(45) NOT NULL,
    descripcion VARCHAR(255),
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    id_categoria INT NOT NULL,

    CONSTRAINT pk_productos
        PRIMARY KEY (id_producto),

    CONSTRAINT uq_productos_nombre_categoria
        UNIQUE (nombre, id_categoria),

    CONSTRAINT chk_productos_precio
        CHECK (precio >= 0),

    CONSTRAINT chk_productos_stock
        CHECK (stock >= 0),

    CONSTRAINT fk_productos_categorias
        FOREIGN KEY (id_categoria)
        REFERENCES Categorias (id_categoria)
) ENGINE = InnoDB;


-- ============================================================
-- TABLA: Pedidos
-- ============================================================

CREATE TABLE Pedidos (
    id_pedido INT AUTO_INCREMENT,
    fecha_pedido DATE NOT NULL,
    estado VARCHAR(20) NOT NULL,
    id_cliente INT NOT NULL,

    CONSTRAINT pk_pedidos
        PRIMARY KEY (id_pedido),

    CONSTRAINT chk_pedidos_estado
        CHECK (estado IN ('pendiente', 'enviado', 'entregado')),

    CONSTRAINT fk_pedidos_clientes
        FOREIGN KEY (id_cliente)
        REFERENCES Clientes (id_cliente)
) ENGINE = InnoDB;

-- ============================================================
-- TABLA: Detalles_Pedido
-- ============================================================

CREATE TABLE Detalles_Pedido (
    id_detalle_pedido INT AUTO_INCREMENT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    id_producto INT NOT NULL,
    id_pedido INT NOT NULL,

    CONSTRAINT pk_detalles_pedido
        PRIMARY KEY (id_detalle_pedido),

    CONSTRAINT uq_detalles_pedido_producto
        UNIQUE (id_pedido, id_producto),

    CONSTRAINT chk_detalles_pedido_cantidad
        CHECK (cantidad > 0),

    CONSTRAINT chk_detalles_pedido_precio
        CHECK (precio_unitario >= 0),

    CONSTRAINT fk_detalles_pedido_productos
        FOREIGN KEY (id_producto)
        REFERENCES Productos (id_producto),

    CONSTRAINT fk_detalles_pedido_pedidos
        FOREIGN KEY (id_pedido)
        REFERENCES Pedidos (id_pedido)
) ENGINE = InnoDB;


-- ============================================================
-- TABLA: Reseñas
-- ============================================================

CREATE TABLE Reseñas (
    id_reseña INT AUTO_INCREMENT,
    calificacion TINYINT NOT NULL,
    comentario VARCHAR(255),
    fecha DATE NOT NULL,
    id_cliente INT NOT NULL,
    id_producto INT NOT NULL,

    CONSTRAINT pk_reseñas
        PRIMARY KEY (id_reseña),

    CONSTRAINT chk_reseñas_calificacion
        CHECK (calificacion BETWEEN 1 AND 5),

    CONSTRAINT fk_reseñas_clientes
        FOREIGN KEY (id_cliente)
        REFERENCES Clientes (id_cliente),

    CONSTRAINT fk_reseñas_productos
        FOREIGN KEY (id_producto)
        REFERENCES Productos (id_producto)
) ENGINE = InnoDB;

-- ============================================================
-- ÍNDICES PARA OPTIMIZACIÓN DE CONSULTAS
-- ============================================================

-- Optimiza la búsqueda de productos por nombre.
CREATE INDEX idx_productos_nombre
    ON Productos (nombre);

-- Optimiza la consulta de productos pertenecientes a una categoría.
CREATE INDEX idx_productos_categoria
    ON Productos (id_categoria);

-- Optimiza la consulta de pedidos realizados por un cliente.
CREATE INDEX idx_pedidos_cliente
    ON Pedidos (id_cliente);