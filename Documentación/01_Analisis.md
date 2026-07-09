## 2.1 Análisis del problema

### Objetivo del sistema

El proyecto consiste en diseñar una base de datos relacional para administrar la información de una tienda en línea. El sistema deberá permitir gestionar clientes, productos, categorías, pedidos, detalles de pedido y reseñas de productos, garantizando la integridad y consistencia de la información.
El diseño de la base de datos servirá como soporte para las operaciones principales de la tienda, permitiendo registrar ventas, consultar productos disponibles, controlar el inventario y almacenar las opiniones de los clientes sobre los productos adquiridos.
El desarrollo del proyecto se realiza siguiendo las especificaciones establecidas por el profesor para la materia de Bases de Datos, utilizando MySQL como Sistema Gestor de Bases de Datos y documentando cada etapa del proceso en un repositorio GitHub.

### Descripción del problema

Actualmente una tienda en línea requiere centralizar la administración de la información relacionada con sus clientes, productos y pedidos.
Sin una base de datos adecuada sería difícil mantener actualizado el inventario, controlar los pedidos realizados por los clientes y consultar el historial de compras.
Además, el sistema debe permitir que los clientes registren reseñas únicamente sobre productos que hayan adquirido, mantener el control del stock disponible y facilitar la obtención de reportes útiles para la administración.
Por ello se propone diseñar una base de datos relacional normalizada que permita almacenar la información de manera organizada, evitando redundancia de datos y asegurando la integridad referencial.

### Alcance

La base de datos permitirá administrar la información correspondiente a:

- Clientes.
- Productos.
- Categorías.
- Pedidos.
- Detalles de los pedidos.
- Reseñas de productos.

Asimismo, deberá soportar consultas, procedimientos almacenados, restricciones de integridad, índices y mecanismos automáticos para mantener la consistencia de la información, conforme a los requerimientos del proyecto.

### Objetivos específicos

- Diseñar un modelo entidad-relación que represente correctamente el funcionamiento de la tienda.
- Normalizar la base de datos hasta la Tercera Forma Normal (3FN).
- Definir las claves primarias y foráneas necesarias.
- Garantizar la integridad de los datos mediante restricciones.
- Preparar la estructura necesaria para implementar procedimientos almacenados, vistas y triggers.

### Justificación

El análisis previo del problema permite comprender las necesidades del sistema antes de iniciar el diseño del modelo de datos.
Realizar esta etapa evita errores de modelado, facilita la identificación correcta de las entidades y relaciones del sistema y proporciona una base sólida para las siguientes fases del proyecto.

## 2. Identificación de actores

### Actor 1 – Cliente
Es la persona que realiza compras dentro de la tienda en línea.
El cliente puede consultar productos disponibles, realizar pedidos y registrar reseñas sobre los productos adquiridos.
Además, su información personal será almacenada para mantener un historial de compras.

### Actor 2 – Administrador
Es el encargado de administrar el catálogo de productos y supervisar el funcionamiento de la tienda.
Puede agregar nuevos productos, modificar precios, actualizar existencias, administrar categorías y consultar la información almacenada en la base de datos.

### Actor 3 – Sistema
Representa los procesos automáticos que garantizan la integridad de la información.
Entre sus funciones se encuentran verificar el stock disponible antes de registrar un pedido, actualizar automáticamente las existencias después de una venta y validar reglas de negocio mediante procedimientos almacenados y triggers.

### Conclusión
Después del análisis se identifican tres actores principales que interactúan directa o indirectamente con la base de datos: **cliente**, **administrador** y **sistema**.
Cada uno genera información que será considerada durante el diseño conceptual del modelo entidad–relación.

## 3. Identificación de procesos del negocio

### Introducción
Una vez identificados los actores del sistema, se analizaron las actividades que cada uno realiza dentro de la tienda en línea. Este análisis permite comprender el flujo de información que deberá soportar la base de datos y facilita la identificación de las entidades y relaciones necesarias para el diseño del modelo conceptual.

### Procesos del Cliente
El cliente interactúa con el sistema realizando las siguientes actividades:

- Consultar el catálogo de productos.
- Buscar productos por categoría.
- Realizar un pedido.
- Consultar el historial de pedidos.
- Registrar una reseña de un producto adquirido.

### Procesos del Administrador
El administrador es responsable de la gestión de la información del sistema mediante las siguientes actividades:

- Registrar nuevos productos.
- Actualizar la información de productos.
- Administrar las categorías.
- Consultar pedidos realizados.
- Supervisar el inventario.
- Consultar reportes de ventas.

### Procesos automáticos del Sistema
El sistema ejecutará automáticamente diversos procesos para mantener la integridad de la información:

- Verificar que exista stock suficiente antes de registrar un pedido.
- Descontar automáticamente el stock cuando se registra una venta.
- Validar que un cliente solo pueda registrar reseñas de productos comprados.
- Verificar que no existan productos duplicados con el mismo nombre y categoría.
- Generar reportes de productos con bajo inventario.

### Flujo principal del negocio
El siguiente flujo representa el proceso principal de compra dentro de la tienda en línea:


                CLIENTE
                    │
        Consulta productos
                    │
                    ▼
            Selecciona producto
                    │
                    ▼
             Realiza pedido
                    │
                    ▼
     Sistema verifica existencias
                    │
          ┌─────────┴─────────┐
          │                   │
      Hay stock          No hay stock
          │                   │
          ▼                   ▼
 Registra pedido      Cancela operación
          │
          ▼
 Actualiza inventario
          │
          ▼
 Cliente recibe pedido
          │
          ▼
 Registra reseña

### Conclusión
El análisis de procesos permitió identificar las operaciones principales que la base de datos deberá soportar. A partir de estos procesos será posible determinar las entidades, relaciones y reglas de negocio que conformarán el modelo entidad-relación.

## 4. Identificación de entidades candidatas

### Introducción
Con base en el análisis de actores y procesos del negocio, se identificaron los principales objetos de información que deberán almacenarse de forma permanente en la base de datos. Estos objetos constituyen las entidades candidatas del modelo conceptual.
Cada entidad fue seleccionada por representar información relevante para el funcionamiento de la tienda en línea y por participar directamente en los procesos definidos durante el análisis.

### Entidades identificadas

#### Cliente
Representa a las personas que realizan compras dentro de la tienda y que pueden registrar reseñas sobre los productos adquiridos.

**Justificación:**
El sistema debe almacenar la información de cada cliente para mantener el historial de compras y permitir la identificación del propietario de cada pedido y reseña.

#### Producto
Representa los artículos disponibles para su venta.

**Justificación:**
Es necesario almacenar la información de cada producto para controlar el inventario, registrar ventas y mostrar el catálogo disponible.

#### Categoría
Permite clasificar los productos según su tipo.

**Justificación:**
Facilita la organización del catálogo y permite realizar búsquedas por categoría, una de las consultas solicitadas en el proyecto.

#### Pedido
Representa cada compra realizada por un cliente.

**Justificación:**
Permite registrar la fecha, estado y propietario de cada compra realizada.

#### DetallePedido
Representa cada producto incluido dentro de un pedido.

**Justificación:**
Se identifica como una entidad asociativa necesaria para resolver la relación muchos a muchos entre Pedido y Producto.
Además, permite almacenar información específica de cada producto vendido, como la cantidad y el precio unitario.

#### Reseña
Representa la opinión de un cliente sobre un producto adquirido.

**Justificación:**
El proyecto requiere registrar calificaciones y comentarios únicamente de clientes que hayan comprado previamente el producto.

### Entidades descartadas
Durante el análisis también surgieron algunos conceptos que inicialmente parecían entidades, pero que finalmente no se incorporaron al modelo debido a que no forman parte del alcance del proyecto.

- **Carrito**: El profesor no solicita gestionar carritos de compra.
- **Pago**: No existen requerimientos relacionados con métodos de pago.
- **Envío**: El proyecto únicamente administra pedidos.
- **Proveedor**: No se contempla la gestión de proveedores.

### Trazabilidad

| Proceso del negocio           | Entidad obtenida |
|------------------------------|------------------|
| Registrar cliente            | Cliente          |
| Administrar productos        | Producto         |
| Clasificar productos         | Categoría        |
| Realizar pedido              | Pedido           |
| Registrar productos vendidos | DetallePedido    |
| Registrar opinión            | Reseña           |

Para justificar la relación entre los procesos del negocio y las entidades identificadas, se presenta la siguiente matriz de trazabilidad:

### Conclusión
Como resultado del análisis se identificaron seis entidades principales: **Cliente**, **Producto**, **Categoría**, **Pedido**, **DetallePedido** y **Reseña**.
Estas entidades servirán como base para la construcción del primer modelo conceptual.

## 5. Modelo conceptual versión 1

Con base en el análisis de actores, procesos y entidades candidatas, se elaboró una primera versión del modelo conceptual. Esta versión representa un avance preliminar del diseño y tiene como objetivo visualizar las entidades principales identificadas durante el análisis.

En esta etapa se incluyeron las entidades Cliente, Producto, Pedido, Categoría y Reseña, junto con sus relaciones básicas. Esta versión aún es incompleta, ya que posteriormente se realizarán ajustes para incorporar correctamente la entidad asociativa DetallePedido y definir con mayor precisión las cardinalidades y atributos del modelo.

El propósito de conservar esta versión es documentar la evolución del diseño y mostrar las correcciones realizadas durante el desarrollo del proyecto.

