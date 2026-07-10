# Normalización

## Introducción

Una vez concluido el diseño lógico de la base de datos, se procedió a verificar formalmente que el esquema relacional cumpliera con los principios de normalización.

La normalización es un proceso de análisis del modelo relacional que permite organizar los datos con el propósito de reducir redundancias, evitar anomalías de inserción, actualización y eliminación, y garantizar que cada atributo se encuentre almacenado en la relación que le corresponde.

Para realizar esta verificación se analizaron las claves primarias, claves candidatas, claves foráneas y dependencias funcionales presentes en cada una de las seis tablas del modelo.

El proceso de normalización se verificó hasta la Tercera Forma Normal (3FN).

## Esquema Relacional Analizado

El proceso de normalización se realizó sobre la versión final del modelo lógico.

El esquema relacional analizado es el siguiente:

```text
CLIENTES
---------
PK id_cliente
AK correo
nombre
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
AK (nombre, id_categoria)
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
AK (id_pedido, id_producto)
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

En este esquema:

- `PK` representa una clave primaria.
- `FK` representa una clave foránea.
- `AK` representa una clave alternativa implementada mediante una restricción de unicidad.

La tabla `Detalles_Pedido` utiliza `id_detalle_pedido` como clave primaria y la combinación `(id_pedido, id_producto)` como clave alternativa.

## Dependencias Funcionales

Para verificar las formas normales es necesario identificar las dependencias funcionales existentes en cada relación.

Una dependencia funcional se presenta cuando el valor de un atributo, o de un conjunto de atributos, determina el valor de otros atributos dentro de una relación.

Las dependencias funcionales principales del modelo son las siguientes.

### Clientes

```text
id_cliente → nombre, correo, telefono, direccion
correo → id_cliente, nombre, telefono, direccion
```

La clave primaria `id_cliente` determina todos los atributos del cliente.

Además, el correo electrónico es único dentro del sistema, por lo que constituye una clave alternativa.

### Pedidos

```text
id_pedido → id_cliente, fecha_pedido, estado
```

La clave primaria `id_pedido` determina el cliente al que pertenece el pedido, la fecha en que fue realizado y su estado.

Los datos descriptivos del cliente no se almacenan en esta tabla.

### Productos

```text
id_producto → nombre, descripcion, precio, stock, id_categoria
(nombre, id_categoria) → id_producto, descripcion, precio, stock
```

La clave primaria `id_producto` determina todos los atributos del producto.

La combinación `(nombre, id_categoria)` es única y constituye una clave alternativa. Esta restricción permite evitar el registro de dos productos con el mismo nombre dentro de una misma categoría.

La información descriptiva de la categoría no se almacena en `Productos`, sino en su propia tabla.

### Categorias

```text
id_categoria → nombre, descripcion
```

La clave primaria `id_categoria` determina el nombre y la descripción de la categoría.

### Detalles_Pedido

```text
id_detalle_pedido → id_pedido, id_producto, cantidad, precio_unitario

(id_pedido, id_producto) → id_detalle_pedido, cantidad, precio_unitario
```

La clave primaria `id_detalle_pedido` identifica de manera única cada detalle.

La combinación `(id_pedido, id_producto)` también identifica de manera única un registro debido a la restricción de unicidad establecida en el modelo.

Los atributos `cantidad` y `precio_unitario` corresponden a la participación de un producto específico dentro de un pedido específico.

### Reseñas

```text
id_reseña → id_cliente, id_producto, calificacion, comentario, fecha
```

La clave primaria `id_reseña` determina el cliente que realizó la reseña, el producto reseñado, la calificación, el comentario y la fecha.

## Primera Forma Normal (1FN)

Una relación se encuentra en Primera Forma Normal cuando cada atributo contiene valores atómicos, no existen grupos repetitivos y cada registro puede identificarse de manera única.

Para verificar esta forma normal se revisaron las seis tablas del modelo.

### Clientes

Cada registro representa un único cliente.

Los atributos `nombre`, `correo`, `telefono` y `direccion` almacenan un único valor por registro.

No existen listas de pedidos, reseñas o productos dentro de la tabla.

Por lo tanto, `Clientes` cumple con la Primera Forma Normal.

### Pedidos

Cada registro representa un único pedido.

Los atributos `fecha_pedido` y `estado` almacenan valores individuales.

Los productos incluidos en un pedido no se almacenan como una lista ni como columnas repetidas dentro de esta tabla.

Por lo tanto, `Pedidos` cumple con la Primera Forma Normal.

### Productos

Cada registro representa un único producto.

Los atributos `nombre`, `descripcion`, `precio` y `stock` almacenan valores individuales.

La categoría se representa mediante una única clave foránea, `id_categoria`.

Por lo tanto, `Productos` cumple con la Primera Forma Normal.

### Categorias

Cada registro representa una única categoría.

Los atributos `nombre` y `descripcion` almacenan valores individuales y no existen grupos repetitivos.

Por lo tanto, `Categorias` cumple con la Primera Forma Normal.

### Detalles_Pedido

Cada registro representa la participación de un producto específico dentro de un pedido específico.

Los atributos `cantidad` y `precio_unitario` almacenan valores individuales.

La existencia de esta tabla evita almacenar varios productos como una lista dentro de `Pedidos`.

Por lo tanto, `Detalles_Pedido` cumple con la Primera Forma Normal.

### Reseñas

Cada registro representa una única reseña realizada por un cliente sobre un producto.

Los atributos `calificacion`, `comentario` y `fecha` almacenan valores individuales.

Las reseñas no se almacenan como grupos repetitivos dentro de `Clientes` o `Productos`.

Por lo tanto, `Reseñas` cumple con la Primera Forma Normal.

## Resultado de la Primera Forma Normal

Todas las relaciones cumplen con la Primera Forma Normal porque:

- Cada tabla posee una clave primaria.
- Cada registro puede identificarse de manera única.
- Los atributos contienen valores atómicos.
- No existen grupos repetitivos.
- No existen listas de valores almacenadas dentro de un mismo atributo.

En consecuencia, el modelo completo cumple con la Primera Forma Normal.

## Segunda Forma Normal (2FN)

Una relación se encuentra en Segunda Forma Normal cuando cumple con la Primera Forma Normal y todos los atributos no clave dependen completamente de una clave candidata.

Además, no deben existir dependencias parciales respecto de una clave candidata compuesta.

Las tablas `Clientes`, `Pedidos`, `Categorias` y `Reseñas` poseen claves primarias simples. Por esta razón, no pueden presentar dependencias parciales respecto de sus claves primarias.

Sin embargo, para realizar una verificación completa también es necesario analizar las claves alternativas presentes en `Productos` y `Detalles_Pedido`.

### Verificación de Clientes

La dependencia principal es:

```text
id_cliente → nombre, correo, telefono, direccion
```

Todos los atributos no clave dependen completamente de `id_cliente`.

No existen dependencias parciales.

Por lo tanto, `Clientes` cumple con la Segunda Forma Normal.

### Verificación de Pedidos

La dependencia principal es:

```text
id_pedido → id_cliente, fecha_pedido, estado
```

Todos los atributos de la relación dependen completamente de `id_pedido`.

No existen dependencias parciales.

Por lo tanto, `Pedidos` cumple con la Segunda Forma Normal.

### Verificación de Productos

La tabla posee la siguiente clave alternativa compuesta:

```text
(nombre, id_categoria)
```

La dependencia funcional es:

```text
(nombre, id_categoria) → id_producto, descripcion, precio, stock
```

Los atributos `descripcion`, `precio` y `stock` corresponden al producto identificado por la combinación completa de nombre y categoría.

El modelo no establece que el nombre por sí solo determine estos atributos, debido a que un mismo nombre de producto podría existir en categorías diferentes.

De la misma manera, `id_categoria` por sí solo no determina la descripción, el precio ni el stock de un producto, ya que una categoría puede contener múltiples productos.

Por lo tanto, no existen dependencias parciales respecto de la clave alternativa compuesta.

`Productos` cumple con la Segunda Forma Normal.

### Verificación de Categorias

La dependencia principal es:

```text
id_categoria → nombre, descripcion
```

Los atributos no clave dependen completamente de la clave primaria.

No existen dependencias parciales.

Por lo tanto, `Categorias` cumple con la Segunda Forma Normal.

### Verificación de Detalles_Pedido

La tabla utiliza `id_detalle_pedido` como clave primaria y posee la siguiente clave alternativa:

```text
(id_pedido, id_producto)
```

La dependencia funcional relevante es:

```text
(id_pedido, id_producto) → id_detalle_pedido, cantidad, precio_unitario
```

La `cantidad` depende de la combinación completa entre pedido y producto.

Un mismo producto puede adquirirse en cantidades diferentes en distintos pedidos, por lo que `id_producto` por sí solo no determina la cantidad.

De la misma manera, un pedido puede contener productos con cantidades diferentes, por lo que `id_pedido` por sí solo tampoco determina la cantidad.

El `precio_unitario` representa el precio aplicado a un producto dentro de un pedido determinado.

Este valor se conserva en `Detalles_Pedido` para mantener el precio histórico de la operación, aun cuando posteriormente cambie el precio actual almacenado en `Productos`.

Por lo tanto, los atributos propios del detalle dependen de la relación completa entre el pedido y el producto y no de una parte aislada de la clave alternativa compuesta.

`Detalles_Pedido` cumple con la Segunda Forma Normal.

### Verificación de Reseñas

La dependencia principal es:

```text
id_reseña → id_cliente, id_producto, calificacion, comentario, fecha
```

Todos los atributos dependen completamente de `id_reseña`.

No existen dependencias parciales.

Por lo tanto, `Reseñas` cumple con la Segunda Forma Normal.

## Resultado de la Segunda Forma Normal

Todas las relaciones cumplen con la Segunda Forma Normal.

Las tablas con claves primarias simples no presentan dependencias parciales.

Las tablas que poseen claves alternativas compuestas también fueron analizadas:

```text
Productos:
(nombre, id_categoria)

Detalles_Pedido:
(id_pedido, id_producto)
```

En ambos casos, los atributos propios de la relación dependen de la combinación completa correspondiente.

Por lo tanto, el modelo cumple con la Segunda Forma Normal.

## Tercera Forma Normal (3FN)

Una relación se encuentra en Tercera Forma Normal cuando cumple con la Segunda Forma Normal y no existen dependencias transitivas indebidas entre atributos no clave.

Una dependencia transitiva problemática se presentaría si un atributo no clave determinara otro atributo no clave, provocando que este último dependiera indirectamente de la clave de la relación.

Durante la revisión del modelo se verificó que la información descriptiva de cada entidad permaneciera almacenada únicamente en la tabla correspondiente.

### Verificación de Clientes

La relación es:

```text
CLIENTES
---------
id_cliente
nombre
correo
telefono
direccion
```

Los atributos descriptivos dependen de las claves candidatas de la relación.

No existe un atributo no clave que determine indebidamente a otro atributo no clave.

Por lo tanto, `Clientes` cumple con la Tercera Forma Normal.

### Verificación de Pedidos

La relación es:

```text
PEDIDOS
---------
id_pedido
id_cliente
fecha_pedido
estado
```

La tabla almacena `id_cliente` para establecer la relación con el cliente propietario del pedido.

No almacena:

```text
nombre_cliente
correo_cliente
telefono_cliente
direccion_cliente
```

Si estos datos se almacenaran en `Pedidos`, se produciría una dependencia indirecta:

```text
id_pedido → id_cliente → datos del cliente
```

La separación actual evita esta redundancia.

Los datos descriptivos del cliente permanecen exclusivamente en `Clientes`.

Por lo tanto, `Pedidos` cumple con la Tercera Forma Normal.

### Verificación de Productos

La relación es:

```text
PRODUCTOS
---------
id_producto
nombre
descripcion
precio
stock
id_categoria
```

La tabla contiene `id_categoria` como clave foránea, pero no almacena:

```text
nombre_categoria
descripcion_categoria
```

Si esta información se almacenara en `Productos`, existiría una dependencia indirecta:

```text
id_producto → id_categoria → datos de la categoría
```

La información descriptiva de la categoría se encuentra únicamente en `Categorias`.

Por lo tanto, `Productos` cumple con la Tercera Forma Normal.

### Verificación de Categorias

La relación es:

```text
CATEGORIAS
---------
id_categoria
nombre
descripcion
```

Los atributos descriptivos dependen directamente de la clave primaria de la relación.

No existen dependencias transitivas entre atributos no clave.

Por lo tanto, `Categorias` cumple con la Tercera Forma Normal.

### Verificación de Detalles_Pedido

La relación es:

```text
DETALLES_PEDIDO
---------
id_detalle_pedido
id_pedido
id_producto
cantidad
precio_unitario
```

La tabla no almacena datos descriptivos del pedido, del cliente o del producto.

Por ejemplo, no contiene:

```text
fecha_pedido
estado_pedido
nombre_cliente
nombre_producto
descripcion_producto
precio_actual_producto
```

Esta separación evita dependencias indirectas como:

```text
id_detalle_pedido → id_pedido → datos del pedido
```

o:

```text
id_detalle_pedido → id_producto → datos del producto
```

La `cantidad` y el `precio_unitario` son atributos propios del detalle de la operación.

El `precio_unitario` no representa el precio actual del producto, sino el precio aplicado en la operación correspondiente.

Por lo tanto, `Detalles_Pedido` cumple con la Tercera Forma Normal.

### Verificación de Reseñas

La relación es:

```text
RESEÑAS
---------
id_reseña
id_cliente
id_producto
calificacion
comentario
fecha
```

La tabla almacena las claves foráneas necesarias para identificar al cliente y al producto relacionados con la reseña.

No almacena datos descriptivos como:

```text
nombre_cliente
correo_cliente
nombre_producto
descripcion_producto
```

Los datos del cliente permanecen en `Clientes` y los datos del producto permanecen en `Productos`.

De esta manera, se evitan dependencias transitivas y redundancia de información.

Por lo tanto, `Reseñas` cumple con la Tercera Forma Normal.

## Resultado de la Tercera Forma Normal

Después de analizar cada relación, se verificó que no existen dependencias transitivas indebidas entre atributos no clave.

La separación de las entidades evita almacenar información descriptiva en tablas donde no corresponde.

En particular:

- Los datos del cliente se almacenan únicamente en `Clientes`.
- Los datos generales del pedido se almacenan únicamente en `Pedidos`.
- Los datos del producto se almacenan únicamente en `Productos`.
- Los datos de las categorías se almacenan únicamente en `Categorias`.
- Los datos propios de la participación de un producto en un pedido se almacenan en `Detalles_Pedido`.
- Los datos propios de cada reseña se almacenan en `Reseñas`.

Por lo tanto, el modelo cumple con la Tercera Forma Normal.

## Análisis de la Relación Muchos a Muchos

Una de las decisiones principales del diseño fue la resolución de la relación muchos a muchos existente entre `Pedidos` y `Productos`.

Conceptualmente, la relación es:

```text
PEDIDOS N -------- M PRODUCTOS
```

Un pedido puede contener varios productos y un producto puede aparecer en diferentes pedidos.

Esta relación no se implementa directamente en el modelo relacional.

Para resolverla se utiliza la tabla `Detalles_Pedido`:

```text
PEDIDOS 1 -------- N DETALLES_PEDIDO N -------- 1 PRODUCTOS
```

La tabla intermedia contiene:

```text
id_detalle_pedido
id_pedido
id_producto
cantidad
precio_unitario
```

De esta manera, cada registro representa la inclusión de un producto específico dentro de un pedido específico.

Además, la tabla permite almacenar atributos propios de la relación:

```text
cantidad
precio_unitario
```

Esta estructura evita grupos repetitivos dentro de `Pedidos` y permite representar correctamente la relación muchos a muchos.

## Justificación de la Clave de Detalles_Pedido

La tabla `Detalles_Pedido` utiliza:

```text
id_detalle_pedido
```

como clave primaria.

Esta es una clave sustituta que permite identificar de manera individual cada registro.

Adicionalmente, se estableció una restricción de unicidad sobre:

```text
(id_pedido, id_producto)
```

Esta combinación constituye una clave alternativa.

La restricción evita que un mismo producto sea registrado más de una vez dentro del mismo pedido.

Por ejemplo, no sería válido almacenar:

```text
id_pedido | id_producto | cantidad
----------|-------------|---------
10        | 5           | 2
10        | 5           | 3
```

La cantidad correspondiente al producto deberá mantenerse en un único registro:

```text
id_pedido | id_producto | cantidad
----------|-------------|---------
10        | 5           | 5
```

Esta decisión mantiene la clave primaria sustituta y, al mismo tiempo, protege la regla de unicidad de la relación entre pedido y producto.

## Análisis del Atributo Total del Pedido

Durante la revisión del modelo lógico se analizó el atributo `total` que inicialmente se encontraba en la tabla `Pedidos`.

El total de un pedido puede calcularse mediante los registros de `Detalles_Pedido`:

```text
SUM(cantidad * precio_unitario)
```

Debido a que este valor puede obtenerse a partir de los datos almacenados en el detalle, mantenerlo también como atributo en `Pedidos` podría generar redundancia.

Si se modificara una cantidad o un precio unitario sin actualizar el total almacenado, podrían existir valores inconsistentes.

Por esta razón, el atributo `total` fue eliminado de la estructura lógica de `Pedidos`.

Cuando sea necesario conocer el total de una compra, este valor podrá calcularse mediante una consulta utilizando los registros correspondientes de `Detalles_Pedido`.

## Prevención de Anomalías

La estructura normalizada permite reducir diferentes tipos de anomalías.

### Anomalías de Inserción

Es posible registrar un producto sin necesidad de crear un pedido.

También es posible registrar un cliente aunque todavía no haya realizado compras.

Las categorías pueden registrarse antes de asociar productos.

La separación de las entidades permite insertar información sin depender de datos que todavía no existen.

### Anomalías de Actualización

La información de un cliente se almacena una sola vez.

Si un cliente cambia su dirección o teléfono, únicamente es necesario modificar el registro correspondiente en `Clientes`.

De la misma manera, si cambia la descripción de una categoría, solo debe actualizarse el registro correspondiente en `Categorias`.

Esto evita modificar el mismo dato en múltiples registros.

### Anomalías de Eliminación

Eliminar un detalle de pedido no elimina la información del producto.

Eliminar una reseña no elimina al cliente ni al producto relacionado.

Eliminar un pedido no implica perder la información general del cliente.

La separación de las entidades permite conservar los datos independientes de cada objeto del sistema.

## Resumen de la Verificación

El resultado del proceso de normalización puede resumirse de la siguiente manera:

| Tabla | 1FN | 2FN | 3FN |
|---|---|---|---|
| Clientes | Cumple | Cumple | Cumple |
| Pedidos | Cumple | Cumple | Cumple |
| Productos | Cumple | Cumple | Cumple |
| Categorias | Cumple | Cumple | Cumple |
| Detalles_Pedido | Cumple | Cumple | Cumple |
| Reseñas | Cumple | Cumple | Cumple |

El análisis permitió comprobar que:

- No existen grupos repetitivos.
- Los atributos contienen valores atómicos.
- No existen dependencias parciales.
- No existen dependencias transitivas indebidas.
- La relación muchos a muchos entre pedidos y productos fue resuelta mediante una tabla intermedia.
- El atributo derivado `total` fue eliminado del esquema.
- Las claves alternativas identificadas fueron protegidas mediante restricciones de unicidad.

## Resultado Final de la Normalización

El proceso realizado puede representarse de la siguiente manera:

```text
Modelo conceptual
        |
        v
Transformación al modelo relacional
        |
        v
Identificación de claves y dependencias funcionales
        |
        v
Verificación de valores atómicos y grupos repetitivos
        |
        v
Primera Forma Normal (1FN)
        |
        v
Verificación de dependencias parciales
        |
        v
Segunda Forma Normal (2FN)
        |
        v
Verificación de dependencias transitivas
        |
        v
Tercera Forma Normal (3FN)
```

Como resultado, el modelo final se encuentra normalizado hasta la Tercera Forma Normal.

## Conclusión

El proceso de normalización permitió verificar formalmente la estructura del modelo relacional de la tienda en línea.

Las seis tablas cumplen con la Primera Forma Normal debido a que sus atributos contienen valores atómicos, cada registro puede identificarse de manera única y no existen grupos repetitivos.

El modelo cumple con la Segunda Forma Normal porque los atributos dependen completamente de sus claves correspondientes y no existen dependencias parciales. Las claves alternativas compuestas de `Productos` y `Detalles_Pedido` fueron analizadas de manera específica para comprobar este requisito.

Finalmente, el modelo cumple con la Tercera Forma Normal porque la información descriptiva de clientes, productos, categorías, pedidos y reseñas se encuentra separada en las relaciones correspondientes, evitando dependencias transitivas indebidas.

La relación muchos a muchos entre `Pedidos` y `Productos` fue resuelta mediante `Detalles_Pedido`, que almacena los atributos propios de la participación de un producto en un pedido.

Además, la eliminación del atributo derivado `total` evita redundancias y posibles inconsistencias, mientras que las restricciones de unicidad permiten proteger las claves alternativas identificadas durante el diseño lógico.

Como resultado, el esquema relacional se encuentra normalizado hasta la Tercera Forma Normal y está preparado para continuar con la etapa de implementación de la base de datos en MySQL.