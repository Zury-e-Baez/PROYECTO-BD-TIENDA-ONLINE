# Validación y Optimización

## Introducción

Una vez concluida la implementación de la base de datos, se realizó una etapa de validación con el propósito de comprobar el correcto funcionamiento de las consultas SQL, los procedimientos almacenados y los índices creados durante el desarrollo del proyecto.

Asimismo, se evaluó el rendimiento de diversas consultas utilizando la sentencia **EXPLAIN** de MySQL, la cual permite conocer el plan de ejecución empleado por el gestor de bases de datos y verificar el uso de los índices implementados.

Finalmente, se realizaron pruebas positivas y negativas sobre los procedimientos almacenados para asegurar que las reglas de negocio definidas para el sistema fueran respetadas.

---

# Resultados de consultas ejecutadas con datos de prueba

Se ejecutaron correctamente las tres consultas desarrolladas durante el proyecto utilizando los datos de prueba registrados en la base de datos.

Las consultas implementadas fueron:

- Consulta 1. Listado de productos disponibles por categoría ordenados por precio.
- Consulta 2. Clientes con pedidos pendientes y total de compras.
- Consulta 3. Reporte de los cinco productos con mejor calificación promedio.

Los resultados obtenidos fueron consistentes con la información almacenada en las tablas, comprobando que las relaciones entre clientes, productos, categorías, pedidos, detalles de pedido y reseñas funcionan correctamente.

**Evidencias**

- Captura de la Consulta 1.
- Captura de la Consulta 2.
- Captura de la Consulta 3.

---

# Explicación de los índices y análisis mediante EXPLAIN

Con el objetivo de analizar el rendimiento de las consultas desarrolladas, se utilizó la instrucción **EXPLAIN** de MySQL, la cual muestra el plan de ejecución empleado por el motor de base de datos antes de ejecutar una consulta.

Esto permitió verificar que los índices creados durante la implementación son utilizados correctamente para reducir el número de registros inspeccionados y optimizar el tiempo de respuesta.

## Consulta 1

La primera consulta obtiene los productos disponibles agrupados por categoría y ordenados por precio.

Al ejecutar **EXPLAIN**, MySQL utilizó el índice **idx_productos_categoria**, lo que permitió localizar rápidamente los productos pertenecientes a cada categoría sin recorrer completamente la tabla **Productos**.

Como resultado, la consulta realiza una búsqueda más eficiente y disminuye el tiempo requerido para recuperar la información.


**Evidencia**

![EXPLAIN Consulta 1](../Evidencias/Capturas/validacion_explain_consulta_1.png)

---

## Consulta 2

La segunda consulta muestra los clientes con pedidos pendientes y contabiliza la cantidad de pedidos asociados.

Durante el análisis mediante **EXPLAIN**, se observó el uso del índice **idx_pedidos_cliente**, el cual optimiza la relación entre las tablas **Clientes** y **Pedidos**.

Gracias a este índice, el motor de MySQL puede localizar rápidamente los pedidos pertenecientes a cada cliente, evitando recorridos innecesarios sobre toda la tabla.

**Evidencia**

![EXPLAIN Consulta 2](../Evidencias/Capturas/validacion_explain_consulta_2.png)

---

## Consulta 3

La tercera consulta calcula el promedio de calificaciones obtenidas por cada producto utilizando la tabla **Reseñas**.

El análisis mediante **EXPLAIN** mostró que MySQL aprovecha el índice asociado a la clave foránea de la tabla **Reseñas**, permitiendo realizar de manera eficiente la unión con la tabla **Productos**.

Aunque el motor utiliza una tabla temporal para calcular el promedio mediante la función **AVG()**, el acceso a los registros relacionados continúa realizándose mediante índices, reduciendo el costo del JOIN.

**Evidencia**

![EXPLAIN Consulta 3](../Evidencias/Capturas/validacion_explain_consulta_3.png)

---

# Pruebas de procedimientos almacenados

Además de validar el funcionamiento correcto de los ocho procedimientos almacenados desarrollados durante el proyecto, se realizaron pruebas utilizando distintos escenarios para verificar que las reglas de negocio fueran respetadas.

## Escenario 1. Intento de registrar un producto duplicado

Se intentó registrar un producto con el mismo nombre y la misma categoría de un producto previamente existente.

El procedimiento almacenado detectó correctamente el duplicado e impidió el registro, mostrando el siguiente mensaje:

```
Error Code: 1644

Ya existe un producto con ese nombre en la categoría seleccionada.
```

Esta prueba demuestra que el procedimiento evita inconsistencias en la información y garantiza que no existan productos duplicados dentro de una misma categoría.

**Evidencia**

![Producto duplicado](../Evidencias/Capturas/prueba_producto_duplicado.png)

---

## Escenario 2. Intento de registrar una reseña sin haber comprado el producto

Se ejecutó el procedimiento para registrar una reseña utilizando un cliente que nunca había adquirido el producto seleccionado.

El procedimiento validó correctamente la regla de negocio y generó el siguiente mensaje:

```
Error Code: 1644

El cliente no ha comprado este producto.
```

Con esta prueba se comprobó que únicamente los clientes que realmente adquirieron un producto pueden registrar una reseña, cumpliendo con uno de los principales requisitos establecidos para el sistema.

**Evidencia**

![Reseña sin compra](../Evidencias/Capturas/prueba_resena_sin_compra.png)

---

# Índices implementados

Durante el desarrollo de la base de datos se implementaron diversos índices para mejorar el rendimiento de las consultas más frecuentes.

| Índice | Tabla | Propósito |
|---------|--------|-----------|
| idx_productos_categoria | Productos | Optimizar las búsquedas por categoría. |
| idx_pedidos_cliente | Pedidos | Optimizar las búsquedas de pedidos por cliente. |
| Índice de la clave foránea de Reseñas | Reseñas | Optimizar la relación entre productos y reseñas durante consultas de promedio de calificaciones. |

El uso de estos índices permitió reducir la cantidad de registros inspeccionados durante la ejecución de las consultas, mejorando el rendimiento general de la base de datos.

---

# Propuestas de mejora

Aunque la implementación desarrollada cumple con los requisitos funcionales establecidos para el proyecto, existen diversas mejoras que podrían incorporarse en futuras versiones.

Las principales propuestas son:

- Crear un índice sobre el atributo **estado** de la tabla **Pedidos**, permitiendo acelerar consultas que filtren pedidos pendientes, enviados o entregados.

- Crear un índice compuesto sobre los campos **(nombre, id_categoria)** de la tabla **Productos**, con el fin de optimizar la validación de productos duplicados.

- Incorporar transacciones (**START TRANSACTION**, **COMMIT** y **ROLLBACK**) dentro de los procedimientos almacenados que realizan múltiples operaciones sobre diferentes tablas.

- Implementar disparadores (**TRIGGERS**) que registren automáticamente las modificaciones realizadas sobre productos, clientes y pedidos para mantener un historial de cambios.

- Agregar validaciones adicionales sobre formatos de correo electrónico, longitud del número telefónico y valores permitidos para determinados atributos antes de realizar operaciones de inserción o actualización.

Estas mejoras incrementarían la integridad, el rendimiento y la mantenibilidad del sistema.

---

# Conclusiones

La etapa de validación permitió comprobar que la base de datos implementada cumple correctamente con los requisitos establecidos para el proyecto.

Las consultas SQL generaron los resultados esperados utilizando los datos de prueba, los procedimientos almacenados aplicaron correctamente las reglas de negocio y los índices creados fueron utilizados por el optimizador de MySQL durante la ejecución de las consultas analizadas mediante **EXPLAIN**.

Las pruebas realizadas demuestran que el sistema mantiene la integridad de la información y responde adecuadamente tanto en escenarios normales como en situaciones donde se intenta violar alguna restricción del negocio.

Finalmente, las propuestas de mejora presentadas ofrecen alternativas para incrementar el rendimiento y la escalabilidad del sistema en futuras versiones.