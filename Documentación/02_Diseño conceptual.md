## Modelo Conceptual v0.1

Después de concluir el análisis del problema, los actores, los procesos del negocio y las reglas de negocio, se identificaron las entidades principales que forman parte del dominio de la tienda en línea.

En esta primera versión del modelo conceptual únicamente se representan las entidades detectadas durante el análisis, sin definir todavía relaciones, cardinalidades ni atributos.

El objetivo de esta versión es validar que todas las entidades necesarias para cubrir los requerimientos del proyecto hayan sido identificadas antes de iniciar el diseño de las relaciones del modelo entidad–relación.

Las entidades identificadas fueron:

- Cliente
- Producto
- Categoría
- Pedido
- DetallePedido
- Reseña

Esta versión constituye el punto de partida para el refinamiento posterior del modelo conceptual.

## Modelo Conceptual v0.2

Después de validar las entidades identificadas durante la etapa de análisis, se procedió a establecer las relaciones existentes entre ellas tomando como referencia las reglas de negocio del sistema.

Cada relación fue analizada individualmente para determinar su cardinalidad y verificar que representara correctamente el comportamiento esperado de la tienda en línea.

Durante este análisis se detectó que la relación entre Pedido y Producto era de muchos a muchos. Debido a que este tipo de relación no puede implementarse directamente en el modelo relacional, fue necesario incorporar la entidad DetallePedido, la cual permite registrar cada producto incluido dentro de un pedido, así como almacenar información adicional como la cantidad y el precio unitario.

Con esta versión el modelo conceptual ya representa la estructura básica del sistema y servirá como fundamento para la incorporación de atributos y claves en la siguiente etapa.

# Modelo Conceptual Final

Una vez identificadas las entidades principales del sistema y corregidas las relaciones detectadas durante el análisis, se incorporaron los atributos esenciales de cada entidad.

En esta etapa todavía no se consideran tipos de datos propios del modelo relacional; únicamente se representan los elementos necesarios para describir la información que administrará el sistema.

El objetivo de este modelo es servir como puente entre el análisis del problema y el diseño lógico de la base de datos, permitiendo identificar claramente la información que almacenará cada entidad antes de su transformación al modelo relacional.

Cada entidad incorpora únicamente los atributos necesarios para representar la información del negocio.

Cliente almacena la información necesaria para identificar al comprador.

Producto contiene la información comercial y de inventario de los artículos disponibles.

Categoría permite clasificar los productos para facilitar su organización y consulta.

Pedido registra cada compra realizada por un cliente.

DetallePedido almacena los productos incluidos dentro de cada pedido, junto con la cantidad solicitada y el precio correspondiente al momento de la compra.

Reseña permite registrar la opinión y calificación que un cliente realiza sobre un producto adquirido.