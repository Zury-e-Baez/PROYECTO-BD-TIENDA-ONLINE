# DevLog

## Día 1

### Objetivo

Iniciar formalmente el desarrollo del proyecto mediante el análisis del problema.

### Actividades realizadas

- Se revisaron nuevamente las especificaciones del proyecto.
- Se definió el objetivo general del sistema.
- Se redactó la descripción del problema.
- Se estableció el alcance del proyecto.
- Se definieron los objetivos específicos.
- Se documentó la justificación de la etapa de análisis.

### Resultado

Se concluyó la primera etapa del análisis, dejando documentado el problema que resolverá la base de datos antes de comenzar el diseño conceptual.

## Día 1 (Continuación)

### Objetivo

Identificar los actores que interactúan con el sistema.

### Actividades realizadas

- Se analizaron los usuarios que participan en el funcionamiento de la tienda en línea.
- Se identificaron los actores principales.
- Se describieron las responsabilidades de cada actor.

### Resultado

Se identificaron tres actores principales: Cliente, Administrador y Sistema. Estos servirán como base para identificar los procesos y posteriormente las entidades del modelo conceptual.

## Día 1 (Continuación)

### Objetivo

Identificar los procesos principales del negocio que soportará la base de datos.

### Actividades realizadas

- Se analizaron las operaciones realizadas por el cliente, el administrador y el sistema.
- Se documentaron los procesos de negocio.
- Se elaboró un diagrama de flujo del proceso principal de compra.

### Resultado

Se identificaron las operaciones que la base de datos deberá soportar. Este análisis permitirá obtener las entidades y relaciones necesarias para el diseño conceptual del modelo entidad-relación.

## Día 2 

### Objetivo

Identificar las entidades candidatas que formarán parte del modelo conceptual.

### Actividades realizadas

- Se analizaron los objetos de información generados por los procesos del negocio.
- Se identificaron las entidades principales del sistema.
- Se justificó la inclusión de cada entidad.
- Se descartaron conceptos que no pertenecen al alcance del proyecto.
- Se elaboró una matriz de trazabilidad entre procesos y entidades.

### Resultado

Se definieron seis entidades candidatas: Cliente, Producto, Categoría, Pedido, DetallePedido y Reseña, las cuales servirán como base para construir el primer modelo conceptual.

## Día 2 (Continuación)

### Objetivo
Construir la primera versión del modelo conceptual a partir del análisis previo.

### Actividades realizadas
- Se identificaron las entidades candidatas del sistema.
- Se elaboró una primera versión del diagrama conceptual.
- Se documentó que el modelo aún está en proceso de ajuste.

### Resultado
Se obtuvo una versión preliminar del modelo conceptual que servirá como base para futuras correcciones.

## Modelo Conceptual v0.2

Se analizaron las reglas de negocio para determinar las relaciones entre las entidades identificadas previamente.

Durante esta etapa se detectó una relación muchos a muchos entre Pedido y Producto, por lo que se incorporó la entidad asociativa DetallePedido.

El modelo conceptual fue actualizado incorporando las relaciones y sus cardinalidades.

# Día 2 (Continación)

## Modelo Conceptual Final

Se incorporaron los atributos principales de cada entidad identificada durante el análisis.

También se revisaron nuevamente las relaciones entre entidades para asegurar que el modelo conceptual representara correctamente las reglas de negocio de la tienda en línea.

Esta versión constituye el modelo conceptual definitivo y servirá como base para el diseño lógico de la base de datos.

## Diseño lógico

# Día 2 (Continuación)
Se transformó el modelo conceptual al modelo lógico relacional.

Se definieron las seis tablas del sistema junto con sus atributos, claves primarias y claves foráneas.

Se elaboró el diagrama EER utilizando MySQL Workbench y se verificó que las relaciones respetaran las reglas de negocio del proyecto.

Finalmente se documentó el modelo relacional y se identificaron las claves candidatas del diseño.

## Diseño lógico (Versión final)
## Día 2 (Continuación)

### Objetivo
Refinar y consolidar el Diseño Lógico (Punto 2.3) del sistema, alineando la estructura relacional con las reglas de negocio y preparando el modelo para su implementación física en MySQL Workbench.

### Actividades realizadas
- **Ajuste de nomenclatura:** Se estandarizaron los nombres de todas las entidades a formato plural (`Clientes`, `Productos`, `Categorias`, `Pedidos`, `Detalles_Pedido`, `Reseñas`) para coincidir con los requerimientos del proyecto.
- **Eliminación de atributos derivados:** Se eliminó el campo `total` de la tabla `Pedidos`, ya que es un valor calculable a partir de `Detalles_Pedido`, evitando redundancias.
- **Definición de Claves Candidatas (AK):** Se identificaron e implementaron (vía índices `UNIQUE` en Workbench) las restricciones de unicidad para:
  - `correo` en Clientes.
  - La combinación `(nombre, id_categoria)` en Productos.
  - La combinación `(id_pedido, id_producto)` en Detalles_Pedido.
- **Definición de Tipos de Datos y Restricciones de Dominio:** Se documentaron los tipos de datos exactos a usar en SQL (`VARCHAR`, `DECIMAL(10,2)`, `ENUM`) y se prepararon las restricciones `CHECK` para garantizar stock no negativo y calificaciones entre 1 y 5.
- **Modelado Visual:** Se construyó el diagrama lógico final utilizando MySQL Workbench, aplicando todas las correcciones estructurales.
- **Documentación:** Se redactó y finalizó la documentación correspondiente al punto 2.3 (Diseño Lógico).

### Resultado
El modelo lógico relacional está 100% estructurado, validado y plasmado visualmente en Workbench. El diseño está listo para proceder con la generación de los scripts DDL (SQL) y la posterior documentación formal de la normalización.

# Día 2 (Continuación)

## Normalización del Modelo Relacional

### Actividades realizadas

Se realizó la verificación formal del modelo relacional con el propósito de comprobar su cumplimiento con la Primera, Segunda y Tercera Forma Normal.

- **Identificación de dependencias funcionales:** Se analizaron las dependencias existentes entre las claves y los atributos de las seis tablas del modelo.

- **Verificación de la Primera Forma Normal (1FN):** Se comprobó que todos los atributos almacenan valores atómicos, que no existen grupos repetitivos y que cada registro puede identificarse de manera única.

- **Verificación de la Segunda Forma Normal (2FN):** Se revisó que los atributos no clave dependieran completamente de sus claves correspondientes y que no existieran dependencias parciales.

- **Análisis de claves alternativas compuestas:** Se verificaron específicamente las claves alternativas `(nombre, id_categoria)` de `Productos` y `(id_pedido, id_producto)` de `Detalles_Pedido`.

- **Verificación de la Tercera Forma Normal (3FN):** Se comprobó que no existieran dependencias transitivas indebidas entre atributos no clave.

- **Análisis de la relación muchos a muchos:** Se justificó la resolución de la relación entre `Pedidos` y `Productos` mediante la tabla intermedia `Detalles_Pedido`.

- **Verificación de `Detalles_Pedido`:** Se confirmó el uso de `id_detalle_pedido` como clave primaria y de la combinación `(id_pedido, id_producto)` como clave alternativa protegida mediante una restricción de unicidad.

- **Análisis del atributo derivado `total`:** Se documentó la eliminación del atributo `total` de la tabla `Pedidos`, debido a que puede calcularse mediante la suma de `cantidad * precio_unitario` de los registros correspondientes en `Detalles_Pedido`.

- **Análisis de anomalías:** Se verificó que la estructura normalizada reduzca anomalías de inserción, actualización y eliminación.

- **Documentación:** Se elaboró y finalizó el archivo `04_Normalización.md` con la verificación formal del modelo hasta la Tercera Forma Normal.

### Resultado

Se verificó que las seis tablas del modelo relacional cumplen con la Primera, Segunda y Tercera Forma Normal.

El análisis confirmó que el esquema no presenta grupos repetitivos, dependencias parciales ni dependencias transitivas indebidas. También se comprobó que la relación muchos a muchos entre `Pedidos` y `Productos` está correctamente resuelta mediante `Detalles_Pedido`.

La documentación correspondiente al punto 2.4 (Normalización) quedó finalizada y el proyecto está preparado para continuar con la etapa de implementación de la base de datos en MySQL.

# Día 3

## Implementación de la Base de Datos

### Actividades realizadas

Se inició la implementación física de la base de datos correspondiente al sistema de gestión de la tienda en línea, tomando como referencia obligatoria el diseño lógico previamente validado, el proceso de normalización hasta la Tercera Forma Normal y el diagrama elaborado en MySQL Workbench.

Durante esta etapa se trabajó con MySQL como sistema gestor de bases de datos y se prepararon los scripts SQL necesarios para crear la estructura de la base de datos y poblarla con datos de prueba.

- **Creación del script de la base de datos:** Se creó el archivo `SQL/Scripts/01_creacion_base_datos.sql`, encargado de generar la base de datos `tienda_online` y construir su estructura completa.

- **Creación de la base de datos:** Se implementaron las instrucciones necesarias para eliminar una versión previa de la base de datos, en caso de existir, crear nuevamente el esquema `tienda_online` y establecerlo como base de datos activa.

- **Implementación de las tablas:** Se crearon las seis tablas definidas durante el diseño lógico:

  - `Clientes`.
  - `Categorias`.
  - `Productos`.
  - `Pedidos`.
  - `Detalles_Pedido`.
  - `Reseñas`.

- **Implementación de claves primarias:** Se definieron claves primarias para identificar de manera única los registros de cada tabla.

- **Generación automática de identificadores:** Las claves primarias fueron configuradas mediante `AUTO_INCREMENT`, permitiendo que MySQL genere automáticamente los identificadores de los nuevos registros.

- **Implementación de claves foráneas:** Se establecieron las relaciones entre las tablas mediante las claves foráneas correspondientes:

  - `Pedidos.id_cliente` → `Clientes.id_cliente`.
  - `Productos.id_categoria` → `Categorias.id_categoria`.
  - `Detalles_Pedido.id_pedido` → `Pedidos.id_pedido`.
  - `Detalles_Pedido.id_producto` → `Productos.id_producto`.
  - `Reseñas.id_cliente` → `Clientes.id_cliente`.
  - `Reseñas.id_producto` → `Productos.id_producto`.

- **Implementación de claves candidatas:** Se trasladaron al esquema físico las claves candidatas identificadas durante el diseño lógico mediante restricciones `UNIQUE`:

  - `Clientes.correo`.
  - `Productos(nombre, id_categoria)`.
  - `Detalles_Pedido(id_pedido, id_producto)`.

- **Implementación de restricciones de dominio:** Se agregaron restricciones `CHECK` para conservar la validez de los datos:

  - El precio de un producto no puede ser negativo.
  - El stock de un producto no puede ser negativo.
  - La cantidad de un detalle de pedido debe ser mayor que cero.
  - El precio unitario de un detalle no puede ser negativo.
  - La calificación de una reseña debe encontrarse entre 1 y 5.
  - El estado de un pedido solamente puede ser `pendiente`, `enviado` o `entregado`.

- **Implementación de índices:** Se crearon tres índices adicionales para apoyar la optimización de las consultas:

  - `idx_productos_nombre` sobre `Productos(nombre)`.
  - `idx_productos_categoria` sobre `Productos(id_categoria)`.
  - `idx_pedidos_cliente` sobre `Pedidos(id_cliente)`.

- **Ejecución del script de creación:** El archivo `01_creacion_base_datos.sql` fue ejecutado completamente en MySQL Workbench.

- **Verificación de la creación:** Se comprobó que la base de datos `tienda_online`, las seis tablas, las restricciones y los tres índices fueran creados correctamente.

- **Registro de evidencia:** Se guardó una captura de pantalla del resultado de la ejecución del script de creación de la base de datos.

- **Creación del script de datos de prueba:** Se creó el archivo `SQL/Datos/02_datos_prueba.sql` para poblar la base de datos con información realista y coherente con el contexto de una tienda en línea de productos electrónicos.

- **Inserción de categorías:** Se registraron 5 categorías de productos electrónicos.

- **Inserción de clientes:** Se registraron 15 clientes con nombres, correos electrónicos, teléfonos y direcciones.

- **Inserción de productos:** Se registraron 30 productos distribuidos entre las categorías disponibles.

- **Inserción de pedidos:** Se registraron 20 pedidos asociados con clientes existentes.

- **Inserción de detalles de pedido:** Se registraron 41 detalles de pedido, superando el mínimo requerido y relacionando correctamente los pedidos con los productos.

- **Inserción de reseñas:** Se registraron 15 reseñas asociadas con clientes y productos existentes.

- **Verificación de identificadores:** Se comprobó que no era necesario proporcionar manualmente los identificadores en las instrucciones `INSERT`, debido a que las claves primarias fueron configuradas mediante `AUTO_INCREMENT`.

- **Verificación de integridad referencial:** Los datos fueron insertados respetando el orden de dependencia entre las tablas, garantizando que las claves foráneas hicieran referencia a registros existentes.

- **Ejecución del script de datos de prueba:** El archivo `02_datos_prueba.sql` fue ejecutado completamente en MySQL Workbench sin errores.

- **Verificación de los datos insertados:** Se ejecutaron consultas `SELECT` sobre las seis tablas para comprobar la existencia y cantidad de los registros almacenados.

- **Resultados de la verificación:** Se obtuvieron los siguientes registros:

  - 5 categorías.
  - 15 clientes.
  - 30 productos.
  - 20 pedidos.
  - 41 detalles de pedido.
  - 15 reseñas.

- **Registro de evidencia:** Se guardó una captura de pantalla de las consultas de verificación y de los resultados obtenidos después de poblar la base de datos.

- **Documentación:** Se elaboró y finalizó el archivo `05_Implementación.md`, documentando la creación de la base de datos, las tablas, las restricciones, las claves, los índices, los datos de prueba, la ejecución de los scripts y la verificación de los resultados.

### Resultado

La implementación de la base de datos correspondiente al punto 2.2 del proyecto quedó finalizada.

La base de datos `tienda_online` fue creada correctamente en MySQL y mantiene correspondencia con el diseño lógico, el proceso de normalización y el diagrama desarrollado previamente en MySQL Workbench.

Las seis tablas fueron implementadas con sus respectivas claves primarias, claves foráneas, claves candidatas y restricciones de integridad. También se crearon los tres índices requeridos para apoyar la optimización de consultas.

La base de datos fue poblada con datos de prueba realistas y suficientes para cumplir con los requisitos establecidos. Se registraron 30 productos, 15 clientes, 20 pedidos, 41 detalles de pedido y 15 reseñas, superando los mínimos requeridos para los detalles y las reseñas.

La ejecución de los scripts y las consultas de verificación confirmó que la estructura de la base de datos y los datos de prueba fueron implementados correctamente.

El proyecto queda preparado para continuar posteriormente con la etapa de consultas y procedimientos almacenados.


# DevLog

## Día 4 Punto 2.3

### Avance realizado

Durante esta etapa se completó el apartado 2.3 del proyecto correspondiente a consultas SQL y procedimientos almacenados.

### Consultas SQL implementadas

Se desarrollaron y validaron las siguientes consultas:

1. Listado de productos disponibles por categoría ordenados por precio.
2. Clientes con pedidos pendientes y total de compras realizadas.
3. Reporte de los cinco productos con mejor calificación promedio en reseñas.

Todas las consultas fueron ejecutadas correctamente utilizando los datos de prueba de la base de datos y se documentaron mediante capturas de evidencia.

### Procedimientos almacenados implementados

Se desarrollaron los ocho procedimientos solicitados en el proyecto:

1. Registrar un nuevo pedido validando:
   - existencia del cliente;
   - existencia del producto;
   - límite máximo de cinco pedidos pendientes;
   - cantidad válida;
   - stock suficiente.

   El procedimiento registra el pedido y su detalle utilizando transacciones para garantizar la integridad de la información.

2. Registrar una reseña verificando:
   - existencia del cliente;
   - existencia del producto;
   - calificación válida;
   - que el cliente haya comprado previamente el producto.

3. Actualizar el stock de un producto después de un pedido.

4. Actualizar el estado de un pedido.

5. Eliminar las reseñas de un producto específico y recalcular el promedio de calificaciones.

6. Registrar un nuevo producto verificando que no exista otro con el mismo nombre dentro de la misma categoría.

7. Actualizar la información de un cliente (teléfono y dirección).

8. Generar un reporte de productos con stock menor a cinco unidades.

### Mejoras incorporadas

Durante la implementación se añadieron mejoras adicionales respecto al requerimiento original:

- Uso de transacciones (START TRANSACTION, COMMIT y ROLLBACK).
- Manejo de excepciones mediante EXIT HANDLER.
- Validaciones de reglas de negocio antes de modificar datos.
- Uso de FOR UPDATE para evitar problemas de concurrencia durante el registro de pedidos y actualización de inventario.
- Comentarios explicativos para facilitar el mantenimiento del código.

### Evidencias

Cada procedimiento fue ejecutado individualmente utilizando datos de prueba.

Posteriormente se verificó el resultado consultando las tablas correspondientes para confirmar que las modificaciones se realizaron correctamente.

### Estado del proyecto

Al finalizar esta etapa queda concluido el apartado 2.3 del proyecto.

Pendiente:

- Validación y optimización.
- Documentación final.
- Revisión general antes de la entrega.