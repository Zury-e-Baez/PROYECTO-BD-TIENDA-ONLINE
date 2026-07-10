-- ============================================================
-- PROYECTO DE BASES DE DATOS
-- Sistema de Gestión de Tienda Online
-- ============================================================
-- Archivo: 02_datos_prueba.sql
-- Descripción:
-- Inserta los datos de prueba utilizados para validar
-- el funcionamiento de la base de datos tienda_online.
-- ============================================================


-- ============================================================
-- SELECCIÓN DE LA BASE DE DATOS
-- ============================================================

USE tienda_online;


-- ============================================================
-- DATOS DE PRUEBA: Categorias
-- ============================================================

INSERT INTO Categorias (nombre, descripcion) VALUES
('Telefonos', 'Telefonos inteligentes y dispositivos moviles'),
('Laptops', 'Computadoras portatiles para uso personal y profesional'),
('Tablets', 'Dispositivos portatiles con pantalla tactil'),
('Audio', 'Audifonos, bocinas y dispositivos de sonido'),
('Accesorios', 'Accesorios y complementos para dispositivos electronicos');

-- ============================================================
-- DATOS DE PRUEBA: Clientes
-- ============================================================

INSERT INTO Clientes (nombre, correo, telefono, direccion) VALUES
('Ana Martínez', 'ana.martinez@example.com', '5512345678', 'Av. Reforma 120, Ciudad de México'),
('Carlos Hernández', 'carlos.hernandez@example.com', '5523456789', 'Calle Durango 85, Ciudad de México'),
('Mariana López', 'mariana.lopez@example.com', '5534567890', 'Av. Universidad 450, Ciudad de México'),
('José Ramírez', 'jose.ramirez@example.com', '5545678901', 'Calle Hidalgo 210, Toluca'),
('Sofía González', 'sofia.gonzalez@example.com', '5556789012', 'Av. Juárez 315, Puebla'),
('Diego Sánchez', 'diego.sanchez@example.com', '5567890123', 'Calle Morelos 78, Querétaro'),
('Valeria Torres', 'valeria.torres@example.com', '5578901234', 'Av. Insurgentes 640, Ciudad de México'),
('Miguel Flores', 'miguel.flores@example.com', '5589012345', 'Calle Independencia 156, Pachuca'),
('Fernanda Cruz', 'fernanda.cruz@example.com', '5590123456', 'Av. Central 820, Estado de México'),
('Alejandro Morales', 'alejandro.morales@example.com', '5511223344', 'Calle Allende 94, Cuernavaca'),
('Daniela Ortiz', 'daniela.ortiz@example.com', '5522334455', 'Av. Tecnológico 275, Monterrey'),
('Ricardo Mendoza', 'ricardo.mendoza@example.com', '5533445566', 'Calle Constitución 330, Guadalajara'),
('Paola Vargas', 'paola.vargas@example.com', '5544556677', 'Av. Las Torres 510, Puebla'),
('Jorge Castillo', 'jorge.castillo@example.com', '5555667788', 'Calle Primavera 42, Querétaro'),
('Natalia Romero', 'natalia.romero@example.com', '5566778899', 'Av. Revolución 725, Ciudad de México');


-- ============================================================
-- DATOS DE PRUEBA: Productos
-- ============================================================

INSERT INTO Productos (
    nombre,
    descripcion,
    precio,
    stock,
    id_categoria
) VALUES

-- Categoría 1: Telefonos
('Samsung Galaxy S24', 'Telefono inteligente con pantalla AMOLED de 6.2 pulgadas', 15999.00, 18, 1),
('iPhone 15', 'Telefono inteligente con pantalla Super Retina XDR de 6.1 pulgadas', 17999.00, 15, 1),
('Xiaomi Redmi Note 13', 'Telefono inteligente con pantalla AMOLED y camara de alta resolucion', 4999.00, 30, 1),
('Motorola Edge 50 Fusion', 'Telefono inteligente con pantalla pOLED y conectividad 5G', 7999.00, 20, 1),
('Google Pixel 8', 'Telefono inteligente con sistema Android y camara avanzada', 13999.00, 12, 1),
('Samsung Galaxy A55', 'Telefono inteligente de gama media con conectividad 5G', 8499.00, 25, 1),

-- Categoría 2: Laptops
('Lenovo IdeaPad Slim 3', 'Laptop para estudio y trabajo con pantalla de 15.6 pulgadas', 10999.00, 14, 2),
('HP Pavilion 15', 'Laptop para uso personal y profesional con pantalla Full HD', 14999.00, 10, 2),
('Dell Inspiron 15', 'Laptop de uso general con pantalla de 15.6 pulgadas', 13999.00, 12, 2),
('ASUS VivoBook 15', 'Laptop ligera para productividad y entretenimiento', 12499.00, 16, 2),
('Acer Aspire 5', 'Laptop para actividades academicas y profesionales', 13499.00, 11, 2),
('MacBook Air M2', 'Laptop ultraligera con procesador Apple M2', 22999.00, 8, 2),

-- Categoría 3: Tablets
('Samsung Galaxy Tab S9 FE', 'Tablet con pantalla de 10.9 pulgadas y almacenamiento interno', 9999.00, 17, 3),
('Apple iPad 10', 'Tablet con pantalla Liquid Retina de 10.9 pulgadas', 10999.00, 13, 3),
('Xiaomi Pad 6', 'Tablet con pantalla de alta resolucion para entretenimiento y productividad', 7499.00, 21, 3),
('Lenovo Tab P12', 'Tablet con pantalla amplia para estudio y contenido multimedia', 8999.00, 15, 3),
('Huawei MatePad 11.5', 'Tablet con pantalla de alta frecuencia de actualizacion', 7999.00, 19, 3),
('Amazon Fire HD 10', 'Tablet para entretenimiento, lectura y contenido multimedia', 3999.00, 24, 3),

-- Categoría 4: Audio
('Sony WH-1000XM5', 'Audifonos inalambricos con cancelacion activa de ruido', 7999.00, 14, 4),
('JBL Flip 6', 'Bocina portatil resistente al agua con conexion Bluetooth', 2799.00, 28, 4),
('Apple AirPods Pro 2', 'Audifonos inalambricos con cancelacion activa de ruido', 5499.00, 20, 4),
('Samsung Galaxy Buds2 Pro', 'Audifonos inalambricos compactos con sonido de alta calidad', 3499.00, 22, 4),
('Bose QuietComfort', 'Audifonos inalambricos con cancelacion de ruido', 6999.00, 9, 4),
('JBL Tune 520BT', 'Audifonos inalambricos con conexion Bluetooth', 999.00, 35, 4),

-- Categoría 5: Accesorios
('Cargador USB-C 65W', 'Cargador rapido compatible con dispositivos USB-C', 899.00, 40, 5),
('Mouse Logitech MX Master 3S', 'Mouse inalambrico ergonomico para productividad', 2299.00, 18, 5),
('Teclado Logitech K380', 'Teclado inalambrico compacto para multiples dispositivos', 899.00, 26, 5),
('Memoria USB Kingston 128GB', 'Unidad de almacenamiento portatil con capacidad de 128 GB', 399.00, 50, 5),
('Base para Laptop Ajustable', 'Soporte ajustable para mejorar la posicion de trabajo', 649.00, 32, 5),
('Cable USB-C 2 Metros', 'Cable USB-C reforzado para carga y transferencia de datos', 299.00, 60, 5);

-- ============================================================
-- DATOS DE PRUEBA: Pedidos
-- ============================================================

INSERT INTO Pedidos (
    fecha_pedido,
    estado,
    id_cliente
) VALUES
('2026-01-15', 'entregado', 1),
('2026-01-18', 'entregado', 2),
('2026-01-22', 'entregado', 3),
('2026-02-03', 'entregado', 4),
('2026-02-10', 'entregado', 5),
('2026-02-18', 'enviado', 6),
('2026-02-25', 'entregado', 7),
('2026-03-02', 'entregado', 8),
('2026-03-12', 'enviado', 9),
('2026-03-20', 'entregado', 10),
('2026-04-05', 'entregado', 11),
('2026-04-18', 'enviado', 12),
('2026-05-03', 'entregado', 13),
('2026-05-17', 'pendiente', 14),
('2026-06-01', 'enviado', 15),
('2026-06-10', 'entregado', 1),
('2026-06-18', 'pendiente', 3),
('2026-06-25', 'enviado', 5),
('2026-07-02', 'pendiente', 7),
('2026-07-08', 'pendiente', 10);

-- ============================================================
-- DATOS DE PRUEBA: Detalles_Pedido
-- ============================================================

INSERT INTO Detalles_Pedido (
    cantidad,
    precio_unitario,
    id_producto,
    id_pedido
) VALUES

-- Pedido 1
(1, 15999.00, 1, 1),
(2, 899.00, 27, 1),

-- Pedido 2
(1, 17999.00, 2, 2),
(1, 5499.00, 21, 2),

-- Pedido 3
(1, 10999.00, 7, 3),
(1, 899.00, 27, 3),

-- Pedido 4
(2, 2799.00, 20, 4),
(1, 399.00, 28, 4),

-- Pedido 5
(1, 9999.00, 13, 5),
(1, 2299.00, 26, 5),

-- Pedido 6
(1, 4999.00, 3, 6),
(2, 299.00, 30, 6),

-- Pedido 7
(1, 14999.00, 8, 7),
(1, 6999.00, 23, 7),

-- Pedido 8
(1, 7499.00, 15, 8),
(1, 999.00, 24, 8),

-- Pedido 9
(1, 7999.00, 4, 9),
(1, 899.00, 25, 9),

-- Pedido 10
(1, 13999.00, 9, 10),
(1, 2299.00, 26, 10),

-- Pedido 11
(1, 22999.00, 12, 11),
(1, 5499.00, 21, 11),

-- Pedido 12
(1, 8999.00, 16, 12),
(2, 399.00, 28, 12),

-- Pedido 13
(1, 8499.00, 6, 13),
(1, 3499.00, 22, 13),

-- Pedido 14
(1, 10999.00, 14, 14),
(1, 649.00, 29, 14),

-- Pedido 15
(1, 13999.00, 5, 15),
(1, 7999.00, 19, 15),

-- Pedido 16
(1, 13499.00, 11, 16),
(1, 899.00, 27, 16),
(2, 299.00, 30, 16),

-- Pedido 17
(1, 7999.00, 17, 17),
(1, 999.00, 24, 17),

-- Pedido 18
(1, 3999.00, 18, 18),
(1, 2799.00, 20, 18),

-- Pedido 19
(1, 12499.00, 10, 19),
(1, 2299.00, 26, 19),

-- Pedido 20
(1, 6999.00, 23, 20),
(1, 649.00, 29, 20);

-- ============================================================
-- DATOS DE PRUEBA: Reseñas
-- ============================================================

INSERT INTO Reseñas (
    calificacion,
    comentario,
    fecha,
    id_cliente,
    id_producto
) VALUES

-- Cliente 1: productos comprados en los pedidos 1 y 16
(5, 'Excelente rendimiento y muy buena calidad de pantalla.', '2026-01-25', 1, 1),
(4, 'El cargador funciona correctamente y tiene buena potencia.', '2026-01-26', 1, 27),
(5, 'Buen rendimiento para trabajo y actividades diarias.', '2026-06-20', 1, 11),

-- Cliente 2: productos comprados en el pedido 2
(5, 'El telefono tiene excelente rendimiento y buena camara.', '2026-01-28', 2, 2),
(4, 'La cancelacion de ruido funciona muy bien.', '2026-01-29', 2, 21),

-- Cliente 3: productos comprados en el pedido 3
(4, 'Buena laptop para actividades academicas y trabajo.', '2026-02-02', 3, 7),

-- Cliente 4: productos comprados en el pedido 4
(5, 'La bocina tiene buen sonido y es facil de transportar.', '2026-02-12', 4, 20),
(4, 'Buena capacidad de almacenamiento y transferencia rapida.', '2026-02-13', 4, 28),

-- Cliente 5: productos comprados en el pedido 5
(5, 'La tablet tiene una pantalla de muy buena calidad.', '2026-02-20', 5, 13),

-- Cliente 7: productos comprados en el pedido 7
(4, 'Buen equipo para trabajo y uso personal.', '2026-03-05', 7, 8),
(5, 'Los audifonos son comodos y reducen muy bien el ruido.', '2026-03-06', 7, 23),

-- Cliente 8: productos comprados en el pedido 8
(5, 'Excelente tablet para entretenimiento y productividad.', '2026-03-12', 8, 15),

-- Cliente 10: productos comprados en el pedido 10
(4, 'La laptop cumple correctamente con mis necesidades.', '2026-03-30', 10, 9),

-- Cliente 11: productos comprados en el pedido 11
(5, 'Equipo ligero, rapido y con excelente autonomia.', '2026-04-15', 11, 12),

-- Cliente 13: productos comprados en el pedido 13
(4, 'Buen telefono y excelente relacion entre precio y rendimiento.', '2026-05-15', 13, 6);