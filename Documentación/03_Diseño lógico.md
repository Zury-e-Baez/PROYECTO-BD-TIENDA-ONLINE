# Diseño Lógico

## Introducción

Una vez concluido el modelo conceptual, se procedió a transformarlo al modelo lógico relacional.

Durante esta etapa se identifican las tablas que conformarán la base de datos, así como las claves primarias, claves foráneas y restricciones necesarias para conservar la integridad de la información.

El diseño lógico representa la estructura que posteriormente será implementada en MySQL.

## Transformación del Modelo Conceptual

Cada entidad identificada en el análisis fue convertida en una tabla del modelo relacional.

Las relaciones uno a muchos fueron implementadas mediante claves foráneas.

La relación muchos a muchos entre Pedido y Producto fue resuelta mediante la tabla DetallePedido.

El resultado es un modelo compuesto por seis tablas relacionadas entre sí.

## Modelo Relacional

```text
CLIENTE
---------
PK id_cliente
nombre
correo
telefono
direccion

PEDIDO
---------
PK id_pedido
FK id_cliente
fecha
total
estado

PRODUCTO
---------
PK id_producto
FK id_categoria
nombre
descripcion
precio
stock

CATEGORIA
---------
PK id_categoria
nombre
descripcion

DETALLE_PEDIDO
---------
PK (id_detalle_pedido)
FK id_pedido
FK id_producto
cantidad
precio_unitario

RESEÑA
---------
PK id_reseña
FK id_cliente
FK id_producto
calificacion
comentario
fecha
```

## Claves Primarias y Foráneas

Las claves primarias permiten identificar de manera única cada registro dentro de una tabla.

Las claves foráneas establecen la relación entre tablas y garantizan la integridad referencial de la base de datos.

### Claves Primarias

- Cliente: id_cliente
- Pedido: id_pedido
- Producto: id_producto
- Categoria: id_categoria
- DetallePedido: id_detalle_pedido
- Reseña: id_reseña

### Claves Foráneas

Pedido.id_cliente → Cliente.id_cliente

Producto.id_categoria → Categoria.id_categoria

DetallePedido.id_pedido → Pedido.id_pedido

DetallePedido.id_producto → Producto.id_producto

Reseña.id_cliente → Cliente.id_cliente

Reseña.id_producto → Producto.id_producto

## Claves Candidatas

Además de las claves primarias, se identificaron los siguientes atributos como posibles claves candidatas:

- Cliente: correo electrónico.
- Categoria: nombre.
- Producto: combinación (nombre, id_categoria).

Las claves candidatas representan atributos que podrían identificar de forma única un registro, aunque finalmente no fueron seleccionados como claves primarias del modelo.

## Descripción de las Relaciones

El modelo lógico está compuesto por seis tablas relacionadas mediante claves foráneas que garantizan la integridad referencial de la información.

Las relaciones implementadas son las siguientes:

- Un cliente puede realizar muchos pedidos, pero cada pedido pertenece a un único cliente.

- Una categoría puede contener múltiples productos, mientras que cada producto pertenece únicamente a una categoría.

- Un pedido puede contener varios productos y un mismo producto puede formar parte de diferentes pedidos. Esta relación muchos a muchos fue resuelta mediante la tabla DetallePedido.

- Un cliente puede registrar varias reseñas sobre diferentes productos.

- Un producto puede recibir múltiples reseñas realizadas por distintos clientes.

## Restricciones de Integridad

Durante el diseño lógico se establecieron diversas restricciones para garantizar la consistencia de los datos.

- Cada tabla posee una clave primaria que identifica de forma única cada registro.

- Las claves foráneas garantizan la integridad referencial entre las tablas relacionadas.

- El precio de los productos y el precio_unitario del detalle del pedido utilizarán el tipo DECIMAL para evitar errores de precisión.

- El correo electrónico del cliente deberá ser único dentro del sistema.

- El stock de un producto nunca podrá ser negativo.

- La calificación de una reseña deberá encontrarse entre 1 y 5.

- Todo pedido deberá estar asociado a un cliente existente.

- Todo detalle de pedido deberá pertenecer a un pedido y a un producto registrados.

- Ninguna clave foránea podrá almacenar valores que hagan referencia a registros inexistentes.

- No será posible registrar un detalle de pedido sin un pedido y un producto previamente registrados.

## Justificación del Diseño Lógico

El modelo lógico fue construido a partir del modelo conceptual respetando las reglas de negocio definidas durante la etapa de análisis.

Cada entidad fue transformada en una tabla independiente, evitando redundancia de información y facilitando el mantenimiento de la base de datos.

Las relaciones fueron implementadas mediante claves foráneas para garantizar la integridad referencial, mientras que la relación muchos a muchos entre pedidos y productos fue resuelta mediante la incorporación de la tabla DetallePedido.

El resultado es un modelo preparado para su implementación en MySQL y compatible con el proceso de normalización en tercera forma normal.

## Diagrama Lógico

La siguiente figura muestra el modelo lógico implementado en MySQL Workbench.

![Diagrama lógico del sistema](../Diagramas/Workbench/Modelo_logico.png)

El diagrama lógico muestra las seis tablas que conforman la base de datos, así como las relaciones implementadas mediante claves foráneas.

Se observa que la relación muchos a muchos entre Pedido y Producto fue resuelta mediante la tabla DetallePedido, mientras que las relaciones Cliente–Pedido, Categoría–Producto y Cliente–Reseña corresponden a relaciones uno a muchos.

## Conclusión

El diseño lógico permitió transformar el modelo conceptual en un esquema relacional listo para su implementación física.

Se definieron las tablas, relaciones, claves y restricciones necesarias para garantizar la integridad de los datos y cumplir con los requisitos funcionales del sistema de gestión de la tienda en línea.

Este diseño servirá como base para la creación de la base de datos, los procedimientos almacenados, las consultas y las pruebas del sistema.

