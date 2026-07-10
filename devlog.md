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
## Día 2

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