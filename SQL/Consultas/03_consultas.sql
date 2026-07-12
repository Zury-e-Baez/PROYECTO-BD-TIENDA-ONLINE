-- ============================================================
-- PROYECTO DE BASES DE DATOS
-- Sistema de Gestión de Tienda Online
-- ============================================================
-- Archivo: 03_consultas.sql
-- Descripción:
-- Consultas solicitadas por el proyecto.
-- ============================================================

USE tienda_online;

-- ============================================================
-- CONSULTA 1
-- Productos disponibles por categoría,
-- ordenados por precio.
-- ============================================================

SELECT
    c.nombre AS categoria,
    p.nombre AS producto,
    p.descripcion,
    p.precio,
    p.stock
FROM Productos AS p
INNER JOIN Categorias AS c
    ON p.id_categoria = c.id_categoria
WHERE p.stock > 0
ORDER BY
    c.nombre ASC,
    p.precio ASC;
    
-- ============================================================
-- CONSULTA 2
-- Clientes con pedidos pendientes y total de compras.
-- ============================================================

SELECT
    c.id_cliente,
    c.nombre AS cliente,
    c.correo,
    COUNT(DISTINCT p.id_pedido) AS pedidos_pendientes,
    SUM(dp.cantidad * dp.precio_unitario) AS total_compras
FROM Clientes AS c
INNER JOIN Pedidos AS p
    ON c.id_cliente = p.id_cliente
INNER JOIN Detalles_Pedido AS dp
    ON p.id_pedido = dp.id_pedido
WHERE p.estado = 'pendiente'
GROUP BY
    c.id_cliente,
    c.nombre,
    c.correo
ORDER BY
    total_compras DESC;