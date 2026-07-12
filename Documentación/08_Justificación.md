# Justificación de los datos (Conceptual)

No es un diccionario técnico.  
Es un documento donde se justifican los atributos.

## Introducción

Después de definir las entidades y sus relaciones, se identificaron los atributos necesarios para representar la información que el sistema deberá almacenar. La selección de los atributos se realizó considerando los procesos del negocio y los requerimientos establecidos para el proyecto.

## Entidad Cliente

| Atributo    | Justificación                               |
|------------|----------------------------------------------|
| id_cliente | Identifica de forma única a cada cliente.    |
| nombre     | Permite identificar al cliente.              |
| correo     | Medio de contacto y autenticación.           |
| telefono   | Información de contacto.                     |
| direccion  | Necesaria para registrar pedidos.            |

## Entidad Producto

| Atributo    | Justificación                                |
|------------|-----------------------------------------------|
| id_producto| Identificador único del producto.             |
| nombre     | Nombre comercial del producto.                |
| descripcion| Información del producto.                     |
| precio     | Valor de venta.                              |
| stock      | Cantidad disponible.                          |

## Entidad Categoría

| Atributo    | Justificación                 |
|------------|--------------------------------|
| id_categoria | Identificador único.         |
| nombre       | Nombre de la categoría.      |
| descripcion  | Explica la categoría.        |

## Entidad Pedido

| Atributo   | Justificación        |
|-----------|-----------------------|
| id_pedido | Identificador único.  |
| fecha     | Fecha de compra.      |
| estado    | Estado del pedido.    |

## Entidad DetallePedido

| Atributo        | Justificación                                  |
|-----------------|------------------------------------------------|
| cantidad        | Número de unidades compradas.                  |
| precio_unitario | Precio del producto al momento de la venta.    |


## Entidad Reseña

| Atributo   | Justificación                       |
|-----------|--------------------------------------|
| id_reseña | Identificador único.                 |
| calificacion | Valor otorgado por el cliente.   |
| comentario   | Opinión del cliente.             |
| fecha       | Fecha de publicación.             |

## Comentario final

Es importante esta etapa porque es un sustento de que los atributos no fueron agregados arbitrariamente; fueron identificados durante el análisis del dominio del problema.
