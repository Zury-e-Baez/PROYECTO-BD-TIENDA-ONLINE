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