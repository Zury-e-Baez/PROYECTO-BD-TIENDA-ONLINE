# Diseño Lógico

## Introducción

Una vez concluido el modelo conceptual, se procedió a transformarlo en un modelo lógico relacional.

Durante esta etapa, las entidades identificadas previamente fueron convertidas en tablas y se definieron las claves primarias, claves foráneas y claves candidatas necesarias para representar las relaciones del sistema y conservar la integridad de la información.

También se identificaron las restricciones de integridad y las reglas de negocio que deberán considerarse durante la implementación de la base de datos.

El diseño lógico constituye la estructura relacional que servirá como base para la posterior implementación de la base de datos en MySQL.

## Transformación del Modelo Conceptual

El modelo conceptual desarrollado en la etapa anterior estaba compuesto por las entidades Cliente, Producto, Categoría, Pedido, DetallePedido y Reseña.

Para obtener el modelo lógico, cada entidad fue transformada en una tabla del modelo relacional.

Las relaciones uno a muchos fueron implementadas mediante claves foráneas ubicadas en las tablas correspondientes.

La relación muchos a muchos existente entre Pedido y Producto fue resuelta mediante la tabla Detalles_Pedido. Esta tabla permite representar cada producto incluido en un pedido y almacenar los atributos propios de dicha relación: cantidad y precio_unitario.

Como resultado de esta transformación, el modelo lógico quedó compuesto por seis tablas relacionadas entre sí:

- Clientes.
- Pedidos.
- Productos.
- Categorias.
- Detalles_Pedido.
- Reseñas.

## Modelo Relacional

El esquema relacional obtenido es el siguiente:

```text
CLIENTES
---------
PK id_cliente
nombre
correo
telefono
direccion

PEDIDOS
---------
PK id_pedido
FK id_cliente
fecha_pedido
estado

PRODUCTOS
---------
PK id_producto
FK id_categoria
nombre
descripcion
precio
stock

CATEGORIAS
---------
PK id_categoria
nombre
descripcion

DETALLES_PEDIDO
---------
PK id_detalle_pedido
FK id_pedido
FK id_producto
cantidad
precio_unitario

RESEÑAS
---------
PK id_reseña
FK id_cliente
FK id_producto
calificacion
comentario
fecha
```

## Descripción de las Tablas

### Clientes

La tabla Clientes almacena la información correspondiente a los clientes registrados en la tienda en línea.

```text
CLIENTES
---------
PK id_cliente
nombre
correo
telefono
direccion
```

La clave primaria `id_cliente` identifica de manera única a cada cliente.

El atributo `correo` representa una clave candidata debido a que cada dirección de correo electrónico deberá ser única dentro del sistema. Esta condición se representa mediante una restricción de unicidad.

Los atributos `nombre`, `correo`, `telefono` y `direccion` almacenan la información descriptiva correspondiente a cada cliente.

### Pedidos

La tabla Pedidos almacena la información general de los pedidos realizados por los clientes.

```text
PEDIDOS
---------
PK id_pedido
FK id_cliente
fecha_pedido
estado
```

La clave primaria `id_pedido` identifica de manera única cada pedido.

La clave foránea `id_cliente` establece la relación con la tabla Clientes y permite identificar al cliente que realizó el pedido.

El atributo `fecha_pedido` almacena la fecha en la que se registra el pedido.

El atributo `estado` permite representar las etapas establecidas para un pedido, como pendiente, enviado y entregado.

El total del pedido no se almacena como atributo en la tabla Pedidos, debido a que puede calcularse a partir de los registros asociados en Detalles_Pedido mediante la cantidad y el precio_unitario de cada producto.

El valor correspondiente al total de un pedido puede obtenerse mediante la siguiente operación:

```text
SUM(cantidad × precio_unitario)
```

Esta decisión evita almacenar un valor derivado que podría volverse inconsistente con el contenido real de los detalles del pedido.

### Productos

La tabla Productos almacena la información correspondiente a los productos disponibles en la tienda.

```text
PRODUCTOS
---------
PK id_producto
FK id_categoria
nombre
descripcion
precio
stock
```

La clave primaria `id_producto` identifica de manera única cada producto.

La clave foránea `id_categoria` relaciona cada producto con la categoría a la que pertenece.

La combinación de los atributos `nombre` e `id_categoria` se considera una clave candidata, debido a que no deberá existir más de un producto con el mismo nombre dentro de una misma categoría.

Los atributos `descripcion`, `precio` y `stock` almacenan las características propias de cada producto.

### Categorias

La tabla Categorias almacena las categorías utilizadas para organizar los productos de la tienda.

```text
CATEGORIAS
---------
PK id_categoria
nombre
descripcion
```

La clave primaria `id_categoria` identifica de manera única cada categoría.

Cada categoría puede agrupar múltiples productos, mientras que cada producto pertenece a una categoría.

Los atributos `nombre` y `descripcion` almacenan la información descriptiva correspondiente a cada categoría.

### Detalles_Pedido

La tabla Detalles_Pedido resuelve la relación muchos a muchos existente entre Pedidos y Productos.

```text
DETALLES_PEDIDO
---------
PK id_detalle_pedido
FK id_pedido
FK id_producto
cantidad
precio_unitario
```

La clave primaria `id_detalle_pedido` identifica de manera única cada registro del detalle.

La clave foránea `id_pedido` indica el pedido al que pertenece el detalle, mientras que la clave foránea `id_producto` identifica el producto incluido.

Los atributos `cantidad` y `precio_unitario` pertenecen al detalle específico de la compra.

La cantidad no pertenece exclusivamente a un pedido ni exclusivamente a un producto, debido a que un mismo producto puede solicitarse en diferentes cantidades dentro de distintos pedidos.

El atributo `precio_unitario` se almacena en Detalles_Pedido porque representa el precio aplicado al producto en el momento de la compra. De esta manera, los cambios posteriores en el precio actual almacenado en Productos no modifican la información correspondiente a pedidos realizados anteriormente.

La combinación formada por `id_pedido` e `id_producto` constituye una clave candidata y se encuentra restringida mediante una condición de unicidad:

```text
(id_pedido, id_producto)
```

Esta restricción evita que un mismo producto aparezca más de una vez dentro del mismo pedido. En caso de requerirse varias unidades del mismo producto, la cantidad de unidades se representa mediante el atributo `cantidad`.

### Reseñas

La tabla Reseñas almacena las evaluaciones realizadas por los clientes sobre los productos.

```text
RESEÑAS
---------
PK id_reseña
FK id_cliente
FK id_producto
calificacion
comentario
fecha
```

La clave primaria `id_reseña` identifica de manera única cada reseña.

La clave foránea `id_cliente` identifica al cliente que realizó la reseña y la clave foránea `id_producto` identifica el producto evaluado.

El atributo `calificacion` representa la evaluación asignada al producto y deberá encontrarse entre 1 y 5.

El atributo `comentario` almacena la opinión escrita por el cliente y el atributo `fecha` registra la fecha correspondiente a la reseña.

De acuerdo con las reglas de negocio del sistema, solamente podrán registrar reseñas los clientes que hayan comprado previamente el producto evaluado. Esta condición requiere comprobar información relacionada con pedidos y detalles de pedido, por lo que será validada durante la etapa de implementación correspondiente.

## Claves Primarias y Foráneas

### Claves Primarias

Las claves primarias definidas en el modelo son las siguientes:

- Clientes: `id_cliente`.
- Pedidos: `id_pedido`.
- Productos: `id_producto`.
- Categorias: `id_categoria`.
- Detalles_Pedido: `id_detalle_pedido`.
- Reseñas: `id_reseña`.

Cada clave primaria identifica de manera única los registros de su tabla correspondiente.

### Claves Foráneas

Las claves foráneas del modelo son las siguientes:

```text
Pedidos.id_cliente → Clientes.id_cliente

Productos.id_categoria → Categorias.id_categoria

Detalles_Pedido.id_pedido → Pedidos.id_pedido

Detalles_Pedido.id_producto → Productos.id_producto

Reseñas.id_cliente → Clientes.id_cliente

Reseñas.id_producto → Productos.id_producto
```

Estas claves foráneas permiten establecer las relaciones entre las tablas y garantizarán la integridad referencial durante la implementación de la base de datos.

## Claves Candidatas

Además de las claves primarias seleccionadas, se identificaron claves candidatas capaces de identificar de manera única determinados registros de acuerdo con las reglas de negocio del sistema.

### Correo del cliente

```text
Clientes.correo
```

El correo electrónico puede identificar de manera única a un cliente.

Por esta razón, se estableció una restricción de unicidad sobre este atributo, evitando que dos clientes sean registrados con la misma dirección de correo electrónico.

### Nombre y categoría del producto

```text
Productos(nombre, id_categoria)
```

La combinación del nombre del producto y su categoría permite identificar un producto dentro de una categoría específica.

De acuerdo con la regla establecida para el modelo, no deberá existir más de un producto con el mismo nombre dentro de una misma categoría.

Por esta razón, la combinación se encuentra definida mediante una restricción de unicidad.

### Pedido y producto en el detalle

```text
Detalles_Pedido(id_pedido, id_producto)
```

Esta combinación identifica la participación de un producto dentro de un pedido específico.

La restricción de unicidad evita que el mismo producto sea registrado más de una vez dentro del mismo pedido.

Cuando un cliente solicita varias unidades del mismo producto, el número de unidades se almacena en el atributo `cantidad`.

## Descripción de las Relaciones

El modelo lógico presenta las siguientes relaciones:

### Clientes y Pedidos

```text
CLIENTES 1 -------- N PEDIDOS
```

Un cliente puede realizar múltiples pedidos, mientras que cada pedido pertenece a un único cliente.

La relación se implementa mediante la clave foránea `id_cliente` almacenada en la tabla Pedidos.

### Categorias y Productos

```text
CATEGORIAS 1 -------- N PRODUCTOS
```

Una categoría puede contener múltiples productos, mientras que cada producto pertenece a una categoría.

La relación se implementa mediante la clave foránea `id_categoria` almacenada en la tabla Productos.

### Pedidos y Detalles_Pedido

```text
PEDIDOS 1 -------- N DETALLES_PEDIDO
```

Un pedido puede contener múltiples registros de detalle, mientras que cada detalle pertenece a un único pedido.

La relación se implementa mediante la clave foránea `id_pedido` almacenada en la tabla Detalles_Pedido.

### Productos y Detalles_Pedido

```text
PRODUCTOS 1 -------- N DETALLES_PEDIDO
```

Un producto puede aparecer en los detalles de diferentes pedidos, mientras que cada registro de detalle corresponde a un único producto.

La relación se implementa mediante la clave foránea `id_producto` almacenada en la tabla Detalles_Pedido.

Por medio de Detalles_Pedido, la relación muchos a muchos original entre Pedidos y Productos queda representada de la siguiente manera:

```text
PEDIDOS 1 -------- N DETALLES_PEDIDO N -------- 1 PRODUCTOS
```

### Clientes y Reseñas

```text
CLIENTES 1 -------- N RESEÑAS
```

Un cliente puede realizar múltiples reseñas, mientras que cada reseña pertenece a un único cliente.

La relación se implementa mediante la clave foránea `id_cliente` almacenada en la tabla Reseñas.

### Productos y Reseñas

```text
PRODUCTOS 1 -------- N RESEÑAS
```

Un producto puede recibir múltiples reseñas, mientras que cada reseña corresponde a un único producto.

La relación se implementa mediante la clave foránea `id_producto` almacenada en la tabla Reseñas.

## Restricciones Identificadas

Durante el diseño lógico se identificaron las restricciones necesarias para conservar la integridad de la información y cumplir con las reglas de negocio del sistema.

Las principales restricciones son las siguientes:

- Cada tabla deberá poseer una clave primaria.
- Las claves foráneas deberán conservar la integridad referencial.
- El correo electrónico de cada cliente deberá ser único.
- La combinación de nombre y categoría de un producto deberá ser única.
- La combinación de pedido y producto en Detalles_Pedido deberá ser única.
- El stock de los productos no podrá ser negativo.
- La cantidad registrada en un detalle de pedido deberá representar una cantidad válida de unidades.
- La calificación de una reseña deberá encontrarse entre 1 y 5.
- Todo pedido deberá estar asociado con un cliente existente.
- Todo detalle de pedido deberá estar asociado con un pedido y un producto existentes.
- Toda reseña deberá estar asociada con un cliente y un producto existentes.
- Un cliente no podrá tener más de cinco pedidos pendientes.
- Un cliente solamente podrá realizar una reseña de un producto que haya comprado previamente.

Las restricciones de unicidad identificadas en el modelo lógico se representan mediante índices únicos.

Las restricciones simples de dominio e integridad serán implementadas mediante los mecanismos correspondientes del esquema SQL.

Las reglas de negocio que requieren consultar información de varias tablas, como limitar la cantidad de pedidos pendientes de un cliente o comprobar que un cliente haya comprado un producto antes de reseñarlo, serán implementadas mediante los mecanismos definidos en la etapa correspondiente del proyecto.

## Tipos de Datos y Dominios

Para preparar la posterior implementación de la base de datos en MySQL, se definieron tipos de datos adecuados para los atributos del modelo.

### Identificadores

Las claves primarias y foráneas utilizan el tipo:

```text
INT
```

Las claves primarias serán configuradas durante la implementación para generar identificadores únicos de los registros.

### Datos de texto

Los atributos de texto utilizan `VARCHAR` con longitudes definidas de acuerdo con la naturaleza de la información almacenada:

```text
nombre                  VARCHAR(45)
correo                  VARCHAR(100)
telefono                VARCHAR(20)
direccion               VARCHAR(200)
descripcion             VARCHAR(255)
comentario              VARCHAR(255)
estado                  VARCHAR(20)
```

El uso de estas longitudes permite almacenar la información requerida por el sistema y mantiene consistencia con el modelo desarrollado en MySQL Workbench.

### Valores monetarios

Los atributos monetarios utilizan:

```text
DECIMAL(10,2)
```

Este tipo de dato se utiliza en:

```text
Productos.precio
Detalles_Pedido.precio_unitario
```

El uso de `DECIMAL(10,2)` permite representar valores monetarios con dos posiciones decimales y evita los problemas de precisión asociados con los tipos de punto flotante.

### Cantidades y existencias

Los atributos utilizados para representar cantidades y existencias utilizan:

```text
INT
```

Este tipo de dato se utiliza en:

```text
Productos.stock
Detalles_Pedido.cantidad
```

Durante la implementación se establecerán las restricciones necesarias para impedir valores no válidos.

### Fechas

Los atributos correspondientes a fechas utilizan:

```text
DATE
```

Este tipo de dato se utiliza en:

```text
Pedidos.fecha_pedido
Reseñas.fecha
```

### Calificaciones

El atributo correspondiente a la calificación utiliza:

```text
TINYINT
```

Este tipo de dato se utiliza en:

```text
Reseñas.calificacion
```

La calificación deberá restringirse a los valores comprendidos entre 1 y 5.

### Estados de los pedidos

El atributo correspondiente al estado del pedido utiliza:

```text
VARCHAR(20)
```

Este tipo de dato se utiliza en:

```text
Pedidos.estado
```

Los valores permitidos para representar el estado de un pedido serán:

```text
pendiente
enviado
entregado
```

La validación de estos valores se establecerá durante la implementación de la base de datos.

## Justificación del Diseño Lógico

El modelo lógico fue construido a partir del modelo conceptual y de las reglas de negocio identificadas durante el análisis.

Cada entidad fue transformada en una tabla independiente y las relaciones uno a muchos fueron representadas mediante claves foráneas.

La relación muchos a muchos entre Pedidos y Productos fue resuelta mediante la tabla Detalles_Pedido, la cual permite registrar los productos incluidos en cada pedido y almacenar los atributos propios de esta relación.

El modelo evita almacenar información descriptiva de una entidad dentro de otras tablas.

Por ejemplo, Pedidos almacena únicamente la referencia al cliente mediante `id_cliente`, mientras que los datos descriptivos del cliente permanecen en Clientes.

De la misma manera, Productos almacena únicamente `id_categoria`, mientras que el nombre y la descripción de la categoría permanecen en Categorias.

La información correspondiente a los productos incluidos en un pedido no se almacena como un grupo repetitivo dentro de Pedidos. Cada participación se representa mediante un registro independiente en Detalles_Pedido.

Asimismo, el total del pedido no se almacena directamente, debido a que puede obtenerse mediante la suma de la cantidad multiplicada por el precio unitario de los detalles asociados.

Estas decisiones reducen la redundancia de información, evitan posibles inconsistencias y preparan el modelo para la verificación formal de la Primera, Segunda y Tercera Forma Normal.

## Diagrama Lógico

La siguiente figura muestra el modelo lógico desarrollado mediante MySQL Workbench.

![Diagrama lógico del sistema](../Diagramas/Workbench/Modelo_Logico.png)

El diagrama representa las seis tablas que conforman la base de datos, sus atributos, claves primarias, claves foráneas y relaciones.

También se incorporaron restricciones de unicidad para representar las claves candidatas identificadas durante el diseño:

```text
Clientes.correo

Productos(nombre, id_categoria)

Detalles_Pedido(id_pedido, id_producto)
```

El modelo obtenido constituye la estructura lógica que posteriormente será implementada en MySQL.

## Conclusión

El diseño lógico permitió transformar el modelo conceptual en un esquema relacional compuesto por seis tablas relacionadas.

Durante esta etapa se definieron las tablas, sus atributos, las claves primarias, las claves foráneas y las claves candidatas necesarias para representar la información del sistema.

La relación muchos a muchos entre Pedidos y Productos fue resuelta mediante la tabla Detalles_Pedido, permitiendo representar correctamente los productos incluidos en cada pedido y almacenar los atributos propios de esta relación.

También se identificaron las restricciones de integridad y las reglas de negocio que deberán ser implementadas en las siguientes etapas del proyecto.

La eliminación del atributo `total` de la tabla Pedidos evita almacenar un valor derivado que puede calcularse a partir de los registros de Detalles_Pedido.

El modelo lógico resultante mantiene correspondencia con el diagrama desarrollado en MySQL Workbench y se encuentra preparado para la verificación formal del proceso de normalización hasta la Tercera Forma Normal.