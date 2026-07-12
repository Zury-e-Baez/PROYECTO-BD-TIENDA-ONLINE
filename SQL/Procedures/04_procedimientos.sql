-- ============================================================
-- PROCEDIMIENTO 1
-- Registrar un nuevo pedido
--
-- Regla de negocio:
-- • El cliente debe existir.
-- • El cliente no puede tener cinco pedidos pendientes.
-- • El producto debe existir.
-- • La cantidad debe ser mayor que cero.
-- • Debe existir stock suficiente.
-- • Se registra el pedido.
-- • Se registra el detalle del pedido.
-- • El stock NO se actualiza en este procedimiento.
-- ============================================================

DROP PROCEDURE IF EXISTS sp_registrar_pedido;

DELIMITER $$

CREATE PROCEDURE sp_registrar_pedido(

    IN p_id_cliente INT,
    IN p_id_producto INT,
    IN p_cantidad INT

)

BEGIN

    -- Variables

    DECLARE v_cliente INT DEFAULT 0;
    DECLARE v_producto INT DEFAULT 0;
    DECLARE v_pedidos INT DEFAULT 0;

    DECLARE v_stock INT;
    DECLARE v_precio DECIMAL(10,2);

    DECLARE v_id_pedido INT;

    -- Handler
   
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    
    -- Validar cliente


    SELECT COUNT(*)
    INTO v_cliente
    FROM Clientes
    WHERE id_cliente = p_id_cliente;

    IF v_cliente = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El cliente no existe.';
    END IF;

   
    -- Validar producto
    

    SELECT COUNT(*)
    INTO v_producto
    FROM Productos
    WHERE id_producto = p_id_producto;

    IF v_producto = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El producto no existe.';
    END IF;

    
    -- Validar cantidad
   

    IF p_cantidad <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La cantidad debe ser mayor que cero.';
    END IF;

   
    -- Validar pedidos pendientes
    

    SELECT COUNT(*)
    INTO v_pedidos
    FROM Pedidos
    WHERE id_cliente = p_id_cliente
      AND estado = 'pendiente';

    IF v_pedidos >= 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El cliente ya tiene cinco pedidos pendientes.';
    END IF;

   
    -- Iniciar transacción
  

    START TRANSACTION;


    -- Obtener stock y precio


    SELECT stock, precio
    INTO v_stock, v_precio
    FROM Productos
    WHERE id_producto = p_id_producto
    FOR UPDATE;

    -- Validar stock

    IF v_stock < p_cantidad THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stock insuficiente.';
    END IF;

    -- Registrar pedido

    INSERT INTO Pedidos(
        fecha_pedido,
        estado,
        id_cliente
    )
    VALUES(
        CURDATE(),
        'pendiente',
        p_id_cliente
    );

    SET v_id_pedido = LAST_INSERT_ID();

    -- Registrar detalle del pedido
   
    INSERT INTO Detalles_Pedido(
        cantidad,
        precio_unitario,
        id_producto,
        id_pedido
    )
    VALUES(
        p_cantidad,
        v_precio,
        p_id_producto,
        v_id_pedido
    );

    -- Confirmar transacción

    COMMIT;

    -- Resultado

    SELECT
        v_id_pedido AS id_pedido,
        p_id_cliente AS id_cliente,
        p_id_producto AS id_producto,
        p_cantidad AS cantidad,
        v_precio AS precio_unitario,
        (p_cantidad * v_precio) AS subtotal,
        'Pedido registrado correctamente.' AS mensaje;

END$$

DELIMITER ;

-- ============================================================
-- PROCEDIMIENTO 2
-- Registrar una reseña de un producto
--
-- Regla de negocio:
-- • El cliente debe existir.
-- • El producto debe existir.
-- • La calificación debe estar entre 1 y 5.
-- • El cliente debe haber comprado previamente el producto.
-- • Si todas las validaciones son correctas,
--   se registra la reseña.
-- ============================================================

DROP PROCEDURE IF EXISTS sp_registrar_resena;

DELIMITER $$

CREATE PROCEDURE sp_registrar_resena(

    IN p_id_cliente INT,
    IN p_id_producto INT,
    IN p_calificacion TINYINT,
    IN p_comentario VARCHAR(255),
    IN p_fecha DATE

)

BEGIN

    -- Variables

    DECLARE v_cliente INT DEFAULT 0;
    DECLARE v_producto INT DEFAULT 0;
    DECLARE v_compra INT DEFAULT 0;
    DECLARE v_id_resena INT;

    -- Handler

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    -- Validar cliente

    SELECT COUNT(*)
    INTO v_cliente
    FROM Clientes
    WHERE id_cliente = p_id_cliente;

    IF v_cliente = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El cliente no existe.';
    END IF;

    -- Validar producto
   
    SELECT COUNT(*)
    INTO v_producto
    FROM Productos
    WHERE id_producto = p_id_producto;

    IF v_producto = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El producto no existe.';
    END IF;

    -- Validar calificación

    IF p_calificacion < 1 OR p_calificacion > 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La calificación debe estar entre 1 y 5.';
    END IF;

    -- Validar que el cliente haya comprado el producto

    SELECT COUNT(*)
    INTO v_compra
    FROM Pedidos pe
    INNER JOIN Detalles_Pedido dp
        ON pe.id_pedido = dp.id_pedido
    WHERE pe.id_cliente = p_id_cliente
      AND dp.id_producto = p_id_producto;

    IF v_compra = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El cliente no ha comprado este producto.';
    END IF;

    -- Iniciar transacción

    START TRANSACTION;

    -- Registrar reseña

    INSERT INTO Reseñas(

        calificacion,
        comentario,
        fecha,
        id_cliente,
        id_producto

    )

    VALUES(

        p_calificacion,
        p_comentario,
        p_fecha,
        p_id_cliente,
        p_id_producto

    );

    SET v_id_resena = LAST_INSERT_ID();

    -- Confirmar transacción

    COMMIT;

    -- Resultado

    SELECT

        v_id_resena AS id_resena,
        p_id_cliente AS id_cliente,
        p_id_producto AS id_producto,
        p_calificacion AS calificacion,
        'Reseña registrada correctamente.' AS mensaje;

END$$

DELIMITER ;


-- ============================================================
-- PROCEDIMIENTO 3
-- Actualizar el stock de un producto después de un pedido
--
-- Regla de negocio:
-- • El detalle del pedido debe existir.
-- • El producto asociado debe existir.
-- • Debe existir stock suficiente.
-- • Se descuenta la cantidad solicitada.
-- ============================================================

DROP PROCEDURE IF EXISTS sp_actualizar_stock;

DELIMITER $$

CREATE PROCEDURE sp_actualizar_stock(

    IN p_id_detalle_pedido INT

)

BEGIN

    -- Variables

    DECLARE v_producto INT;
    DECLARE v_cantidad INT;

    DECLARE v_stock INT;
    DECLARE v_stock_actual INT;

    -- Handler

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    -- Validar que exista el detalle del pedido

    SELECT
        id_producto,
        cantidad
    INTO
        v_producto,
        v_cantidad
    FROM Detalles_Pedido
    WHERE id_detalle_pedido = p_id_detalle_pedido;

    IF v_producto IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El detalle del pedido no existe.';
    END IF;

    -- Iniciar transacción

    START TRANSACTION;

    -- Obtener y bloquear el producto

    SELECT stock
    INTO v_stock
    FROM Productos
    WHERE id_producto = v_producto
    FOR UPDATE;

    -- Validar stock
    

    IF v_stock < v_cantidad THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stock insuficiente para actualizar.';
    END IF;

    
    -- Actualizar inventario


    UPDATE Productos
    SET stock = stock - v_cantidad
    WHERE id_producto = v_producto;

    
    -- Obtener nuevo stock
    

    SELECT stock
    INTO v_stock_actual
    FROM Productos
    WHERE id_producto = v_producto;

    
    -- Confirmar cambios


    COMMIT;

    
    -- Resultado

    SELECT

        p_id_detalle_pedido AS id_detalle_pedido,
        v_producto AS id_producto,
        v_cantidad AS cantidad_descontada,
        v_stock AS stock_anterior,
        v_stock_actual AS stock_actual,
        'Stock actualizado correctamente.' AS mensaje;

END$$

DELIMITER ;

-- ============================================================
-- PROCEDIMIENTO 4
-- Actualizar el estado de un pedido
--
-- Regla de negocio:
-- • El pedido debe existir.
-- • El nuevo estado debe ser válido.
-- • Se actualiza el estado del pedido.
-- ============================================================

DROP PROCEDURE IF EXISTS sp_actualizar_estado_pedido;

DELIMITER $$

CREATE PROCEDURE sp_actualizar_estado_pedido(

    IN p_id_pedido INT,
    IN p_nuevo_estado VARCHAR(20)

)

BEGIN

    -- Variables

    DECLARE v_estado_actual VARCHAR(20);

    -- Handler

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    -- Validar que el pedido exista

    SELECT estado
    INTO v_estado_actual
    FROM Pedidos
    WHERE id_pedido = p_id_pedido;

    IF v_estado_actual IS NULL THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El pedido no existe.';

    END IF;

    -- Validar estado permitido

    IF p_nuevo_estado NOT IN
    (

        'pendiente',
        'enviado',
        'entregado',
        'cancelado'

    )

    THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Estado de pedido no válido.';

    END IF;

    -- Iniciar transacción

    START TRANSACTION;

    -- Actualizar estado

    UPDATE Pedidos
    SET estado = p_nuevo_estado
    WHERE id_pedido = p_id_pedido;

    -- Confirmar cambios

    COMMIT;

    -- Resultado
   
    SELECT

        p_id_pedido AS id_pedido,
        v_estado_actual AS estado_anterior,
        p_nuevo_estado AS estado_nuevo,
        'Estado del pedido actualizado correctamente.' AS mensaje;

END$$

DELIMITER ;

-- ============================================================
-- PROCEDIMIENTO 5
-- Eliminar las reseñas de un producto
--
-- Regla de negocio:
-- • El producto debe existir.
-- • Debe existir al menos una reseña.
-- • Se eliminan las reseñas del producto.
-- • Se calcula nuevamente el promedio de calificaciones.
-- ============================================================

DROP PROCEDURE IF EXISTS sp_eliminar_resenas_producto;

DELIMITER $$

CREATE PROCEDURE sp_eliminar_resenas_producto(

    IN p_id_producto INT

)

BEGIN

    -- Variables

    DECLARE v_producto INT DEFAULT 0;
    DECLARE v_total_resenas INT DEFAULT 0;
    DECLARE v_promedio DECIMAL(4,2);

    -- Handler

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    -- Validar producto

    SELECT COUNT(*)
    INTO v_producto
    FROM Productos
    WHERE id_producto = p_id_producto;

    IF v_producto = 0 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El producto no existe.';

    END IF;

    
    -- Validar que existan reseñas
    

    SELECT COUNT(*)
    INTO v_total_resenas
    FROM Reseñas
    WHERE id_producto = p_id_producto;

    IF v_total_resenas = 0 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El producto no tiene reseñas registradas.';

    END IF;

    -- Iniciar transacción
    
    START TRANSACTION;

    
    -- Eliminar reseñas
    
    DELETE
    FROM Reseñas
    WHERE id_producto = p_id_producto;

    -- Calcular nuevo promedio

    SELECT ROUND(AVG(calificacion),2)
    INTO v_promedio
    FROM Reseñas
    WHERE id_producto = p_id_producto;

    -- Confirmar cambios

    COMMIT;
    
    -- Resultado

    SELECT

        p_id_producto AS id_producto,
        v_total_resenas AS resenas_eliminadas,
        v_promedio AS promedio_actual,
        'Reseñas eliminadas correctamente.' AS mensaje;

END$$

DELIMITER ;

-- ============================================================
-- PROCEDIMIENTO 6
-- Registrar un nuevo producto
--
-- Reglas de negocio:
-- • La categoría debe existir.
-- • No puede existir otro producto con el mismo nombre
--   dentro de la misma categoría.
-- ============================================================

DROP PROCEDURE IF EXISTS sp_registrar_producto;

DELIMITER $$

CREATE PROCEDURE sp_registrar_producto(

    IN p_nombre VARCHAR(45),
    IN p_descripcion VARCHAR(255),
    IN p_precio DECIMAL(10,2),
    IN p_stock INT,
    IN p_id_categoria INT

)

BEGIN

    -- Variables

    DECLARE v_categoria_existe INT DEFAULT 0;
    DECLARE v_producto_existe INT DEFAULT 0;

    -- Handler

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    
    -- Validar categoría

    SELECT COUNT(*)
    INTO v_categoria_existe
    FROM Categorias
    WHERE id_categoria = p_id_categoria;

    IF v_categoria_existe = 0 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La categoría indicada no existe.';

    END IF;

    -- Validar producto duplicado

    SELECT COUNT(*)
    INTO v_producto_existe
    FROM Productos
    WHERE nombre = p_nombre
      AND id_categoria = p_id_categoria;

    IF v_producto_existe > 0 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ya existe un producto con ese nombre en la categoría seleccionada.';

    END IF;

    -- Iniciar transacción

    START TRANSACTION;

    -- Registrar producto

    INSERT INTO Productos(

        nombre,
        descripcion,
        precio,
        stock,
        id_categoria

    )

    VALUES(

        p_nombre,
        p_descripcion,
        p_precio,
        p_stock,
        p_id_categoria

    );

    -- Confirmar cambios

    COMMIT;

    -- Resultado

    SELECT

        LAST_INSERT_ID() AS id_producto,
        p_nombre AS producto,
        p_precio AS precio,
        p_stock AS stock,
        p_id_categoria AS categoria,
        'Producto registrado correctamente.' AS mensaje;

END$$

DELIMITER ;

-- ============================================================
-- PROCEDIMIENTO 7
-- Actualizar la información de un cliente
--
-- Reglas de negocio:
-- • El cliente debe existir.
-- • Se permite actualizar el teléfono y la dirección.
-- ============================================================

DROP PROCEDURE IF EXISTS sp_actualizar_cliente;

DELIMITER $$

CREATE PROCEDURE sp_actualizar_cliente(

    IN p_id_cliente INT,
    IN p_telefono VARCHAR(20),
    IN p_direccion VARCHAR(200)

)

BEGIN

    -- Variables

    DECLARE v_cliente_existe INT DEFAULT 0;

    -- Handler

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    -- Validar cliente

    SELECT COUNT(*)
    INTO v_cliente_existe
    FROM Clientes
    WHERE id_cliente = p_id_cliente;

    IF v_cliente_existe = 0 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El cliente indicado no existe.';

    END IF;

    -- Iniciar transacción

    START TRANSACTION;

    -- Actualizar información

    UPDATE Clientes

    SET

        telefono = p_telefono,
        direccion = p_direccion

    WHERE id_cliente = p_id_cliente;

    -- Confirmar cambios

    COMMIT;

    -- Resultado

    SELECT

        id_cliente,
        nombre,
        correo,
        telefono,
        direccion,
        'Información del cliente actualizada correctamente.' AS mensaje

    FROM Clientes

    WHERE id_cliente = p_id_cliente;

END$$

DELIMITER ;

-- ============================================================
-- PROCEDIMIENTO 8
-- Reporte de productos con stock bajo
--
-- Regla de negocio:
-- • Mostrar únicamente productos cuyo inventario
--   sea menor a cinco unidades.
-- ============================================================

DROP PROCEDURE IF EXISTS sp_reporte_stock_bajo;

DELIMITER $$

CREATE PROCEDURE sp_reporte_stock_bajo()

BEGIN

    SELECT

        p.id_producto,
        p.nombre AS producto,
        c.nombre AS categoria,
        p.precio,
        p.stock

    FROM Productos p

    INNER JOIN Categorias c

        ON p.id_categoria = c.id_categoria

    WHERE p.stock < 5

    ORDER BY

        p.stock ASC,
        p.nombre ASC;

END$$

DELIMITER ;