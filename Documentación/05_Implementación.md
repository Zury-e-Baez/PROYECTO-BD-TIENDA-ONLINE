# Implementación

## Introducción

Una vez concluidos el diseño lógico y el proceso de normalización del modelo relacional, se procedió a implementar la base de datos en MySQL.

La implementación se realizó a partir de la versión final del modelo lógico documentado previamente y representado mediante el diagrama elaborado en MySQL Workbench.

Durante esta etapa se crearon la base de datos, las seis tablas del modelo, las claves primarias, las claves foráneas, las restricciones de integridad y los índices necesarios. Posteriormente, se incorporaron datos de prueba con el propósito de contar con información suficiente para verificar el funcionamiento de la estructura implementada.

Los scripts desarrollados hasta esta etapa son los siguientes:

```text
SQL/
├── Scripts/
│   └── 01_creacion_base_datos.sql
│
└── Datos/
    └── 02_datos_prueba.sql
```

El archivo `01_creacion_base_datos.sql` contiene la definición de la estructura de la base de datos, mientras que `02_datos_prueba.sql` contiene los registros utilizados para poblar las tablas.

## Sistema Gestor de Bases de Datos

La implementación se realizó utilizando MySQL como sistema gestor de bases de datos.

Para la ejecución y verificación de los scripts se utilizó MySQL Workbench, herramienta que permitió crear la base de datos, ejecutar las instrucciones SQL y consultar los registros almacenados.

La base de datos implementada recibe el nombre:

```text
tienda_online
```

Para permitir el almacenamiento adecuado de caracteres, se configuró el conjunto de caracteres `utf8mb4` y la intercalación `utf8mb4_unicode_ci`.

La creación de la base de datos se definió mediante las siguientes instrucciones:

```sql
DROP DATABASE IF EXISTS tienda_online;

CREATE DATABASE tienda_online
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE tienda_online;
```

La instrucción `DROP DATABASE IF EXISTS` permite eliminar una versión previa de la base de datos antes de ejecutar nuevamente el script.

Posteriormente, `CREATE DATABASE` crea la base de datos y `USE` establece `tienda_online` como la base de datos activa para la creación de las tablas y demás objetos.

## Implementación del Modelo Relacional

La estructura implementada está compuesta por las siguientes seis tablas:

```text
Categorias
Clientes
Productos
Pedidos
Detalles_Pedido
Reseñas
```

Estas tablas corresponden a la versión final del modelo lógico y conservan las relaciones definidas durante las etapas de diseño y normalización.

El esquema general implementado es el siguiente:

```text
CLIENTES
---------
PK id_cliente
AK correo
nombre
telefono
direccion

CATEGORIAS
---------
PK id_categoria
nombre
descripcion

PRODUCTOS
---------
PK id_producto
AK (nombre, id_categoria)
FK id_categoria
descripcion
precio
stock

PEDIDOS
---------
PK id_pedido
FK id_cliente
fecha_pedido
estado

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

La implementación mantiene las claves primarias simples definidas en el diseño lógico y las claves alternativas identificadas durante el análisis del modelo.

## Creación de la Tabla Categorias

La tabla `Categorias` almacena la clasificación general de los productos disponibles en la tienda.

Su estructura está compuesta por:

```text
id_categoria
nombre
descripcion
```

La columna `id_categoria` funciona como clave primaria y utiliza `AUTO_INCREMENT`, por lo que MySQL genera automáticamente un identificador único para cada nueva categoría.

La columna `nombre` es obligatoria, mientras que `descripcion` permite almacenar información adicional sobre la categoría.

La tabla fue implementada de la siguiente manera:

```sql
CREATE TABLE Categorias (
    id_categoria INT AUTO_INCREMENT,
    nombre VARCHAR(45) NOT NULL,
    descripcion VARCHAR(255),

    CONSTRAINT pk_categorias
        PRIMARY KEY (id_categoria)
) ENGINE = InnoDB;
```

## Creación de la Tabla Clientes

La tabla `Clientes` almacena la información de las personas que realizan pedidos en la tienda.

Su estructura está compuesta por:

```text
id_cliente
nombre
correo
telefono
direccion
```

La columna `id_cliente` funciona como clave primaria y utiliza `AUTO_INCREMENT`.

El correo electrónico fue definido como una clave alternativa mediante una restricción `UNIQUE`, debido a que no deben existir dos clientes registrados con el mismo correo.

La tabla fue implementada de la siguiente manera:

```sql
CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT,
    nombre VARCHAR(45) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    direccion VARCHAR(200),

    CONSTRAINT pk_clientes
        PRIMARY KEY (id_cliente),

    CONSTRAINT uq_clientes_correo
        UNIQUE (correo)
) ENGINE = InnoDB;
```

## Creación de la Tabla Productos

La tabla `Productos` almacena la información correspondiente a los artículos disponibles en la tienda.

Su estructura está compuesta por:

```text
id_producto
nombre
descripcion
precio
stock
id_categoria
```

La columna `id_producto` funciona como clave primaria.

La columna `id_categoria` funciona como clave foránea y relaciona cada producto con una categoría existente.

También se implementó una restricción de unicidad sobre la combinación:

```text
(nombre, id_categoria)
```

Esta combinación funciona como clave alternativa y evita registrar más de una vez un producto con el mismo nombre dentro de una misma categoría.

Además, se incorporaron restricciones `CHECK` para garantizar que el precio y el stock no almacenen valores negativos.

La tabla fue implementada de la siguiente manera:

```sql
CREATE TABLE Productos (
    id_producto INT AUTO_INCREMENT,
    nombre VARCHAR(45) NOT NULL,
    descripcion VARCHAR(255),
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    id_categoria INT NOT NULL,

    CONSTRAINT pk_productos
        PRIMARY KEY (id_producto),

    CONSTRAINT uq_productos_nombre_categoria
        UNIQUE (nombre, id_categoria),

    CONSTRAINT chk_productos_precio
        CHECK (precio >= 0),

    CONSTRAINT chk_productos_stock
        CHECK (stock >= 0),

    CONSTRAINT fk_productos_categorias
        FOREIGN KEY (id_categoria)
        REFERENCES Categorias (id_categoria)
) ENGINE = InnoDB;
```

## Creación de la Tabla Pedidos

La tabla `Pedidos` almacena la información general de las compras realizadas por los clientes.

Su estructura está compuesta por:

```text
id_pedido
fecha_pedido
estado
id_cliente
```

La columna `id_pedido` funciona como clave primaria.

La columna `id_cliente` funciona como clave foránea y garantiza que cada pedido se encuentre asociado con un cliente existente.

El estado del pedido se controla mediante una restricción `CHECK` que permite únicamente los siguientes valores:

```text
pendiente
enviado
entregado
```

La tabla no almacena un atributo `total`, debido a que este valor puede calcularse a partir de la información contenida en `Detalles_Pedido`.

La tabla fue implementada de la siguiente manera:

```sql
CREATE TABLE Pedidos (
    id_pedido INT AUTO_INCREMENT,
    fecha_pedido DATE NOT NULL,
    estado VARCHAR(20) NOT NULL,
    id_cliente INT NOT NULL,

    CONSTRAINT pk_pedidos
        PRIMARY KEY (id_pedido),

    CONSTRAINT chk_pedidos_estado
        CHECK (estado IN ('pendiente', 'enviado', 'entregado')),

    CONSTRAINT fk_pedidos_clientes
        FOREIGN KEY (id_cliente)
        REFERENCES Clientes (id_cliente)
) ENGINE = InnoDB;
```

## Creación de la Tabla Detalles_Pedido

La tabla `Detalles_Pedido` resuelve la relación muchos a muchos existente entre `Pedidos` y `Productos`.

Su estructura está compuesta por:

```text
id_detalle_pedido
cantidad
precio_unitario
id_producto
id_pedido
```

La columna `id_detalle_pedido` funciona como clave primaria.

Las columnas `id_producto` e `id_pedido` funcionan como claves foráneas y relacionan cada detalle con un producto y un pedido existentes.

La combinación:

```text
(id_pedido, id_producto)
```

se implementó mediante una restricción `UNIQUE` y funciona como clave alternativa. Esta restricción evita que un mismo producto aparezca más de una vez dentro del mismo pedido.

La cantidad debe ser mayor que cero y el precio unitario no puede almacenar valores negativos.

El atributo `precio_unitario` se conserva en esta tabla porque representa el precio aplicado al producto en el momento de la compra.

La tabla fue implementada de la siguiente manera:

```sql
CREATE TABLE Detalles_Pedido (
    id_detalle_pedido INT AUTO_INCREMENT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    id_producto INT NOT NULL,
    id_pedido INT NOT NULL,

    CONSTRAINT pk_detalles_pedido
        PRIMARY KEY (id_detalle_pedido),

    CONSTRAINT uq_detalles_pedido_producto
        UNIQUE (id_pedido, id_producto),

    CONSTRAINT chk_detalles_pedido_cantidad
        CHECK (cantidad > 0),

    CONSTRAINT chk_detalles_pedido_precio
        CHECK (precio_unitario >= 0),

    CONSTRAINT fk_detalles_pedido_productos
        FOREIGN KEY (id_producto)
        REFERENCES Productos (id_producto),

    CONSTRAINT fk_detalles_pedido_pedidos
        FOREIGN KEY (id_pedido)
        REFERENCES Pedidos (id_pedido)
) ENGINE = InnoDB;
```

## Creación de la Tabla Reseñas

La tabla `Reseñas` almacena las opiniones y calificaciones realizadas por los clientes sobre los productos.

Su estructura está compuesta por:

```text
id_reseña
calificacion
comentario
fecha
id_cliente
id_producto
```

La columna `id_reseña` funciona como clave primaria.

Las columnas `id_cliente` e `id_producto` funcionan como claves foráneas y permiten identificar al cliente que realizó la reseña y al producto correspondiente.

La calificación se controla mediante una restricción `CHECK` que permite únicamente valores entre 1 y 5.

La tabla fue implementada de la siguiente manera:

```sql
CREATE TABLE Reseñas (
    id_reseña INT AUTO_INCREMENT,
    calificacion TINYINT NOT NULL,
    comentario VARCHAR(255),
    fecha DATE NOT NULL,
    id_cliente INT NOT NULL,
    id_producto INT NOT NULL,

    CONSTRAINT pk_reseñas
        PRIMARY KEY (id_reseña),

    CONSTRAINT chk_reseñas_calificacion
        CHECK (calificacion BETWEEN 1 AND 5),

    CONSTRAINT fk_reseñas_clientes
        FOREIGN KEY (id_cliente)
        REFERENCES Clientes (id_cliente),

    CONSTRAINT fk_reseñas_productos
        FOREIGN KEY (id_producto)
        REFERENCES Productos (id_producto)
) ENGINE = InnoDB;
```

## Restricciones de Integridad Implementadas

La implementación incorpora restricciones destinadas a conservar la consistencia de los datos.

Las principales restricciones implementadas son las siguientes:

- Cada tabla posee una clave primaria.
- Las claves primarias utilizan identificadores enteros generados mediante `AUTO_INCREMENT`.
- El correo de cada cliente debe ser único.
- La combinación `(nombre, id_categoria)` debe ser única en `Productos`.
- La combinación `(id_pedido, id_producto)` debe ser única en `Detalles_Pedido`.
- El precio de un producto no puede ser negativo.
- El stock de un producto no puede ser negativo.
- La cantidad registrada en un detalle de pedido debe ser mayor que cero.
- El precio unitario de un detalle de pedido no puede ser negativo.
- El estado de un pedido debe corresponder a uno de los valores permitidos.
- La calificación de una reseña debe encontrarse entre 1 y 5.
- Todo producto debe estar asociado con una categoría existente.
- Todo pedido debe estar asociado con un cliente existente.
- Todo detalle de pedido debe estar asociado con un pedido y un producto existentes.
- Toda reseña debe estar asociada con un cliente y un producto existentes.

Estas restricciones permiten que parte de las reglas definidas durante el diseño lógico sean controladas directamente por el sistema gestor de bases de datos.

## Implementación de Índices

Además de los índices generados por las claves primarias, claves foráneas y restricciones de unicidad, se incorporaron índices para apoyar consultas frecuentes.

Los índices definidos fueron los siguientes:

```sql
CREATE INDEX idx_productos_nombre
    ON Productos (nombre);

CREATE INDEX idx_productos_categoria
    ON Productos (id_categoria);

CREATE INDEX idx_pedidos_cliente
    ON Pedidos (id_cliente);
```

El índice `idx_productos_nombre` permite apoyar las búsquedas de productos por nombre.

El índice `idx_productos_categoria` permite apoyar las consultas de productos pertenecientes a una categoría.

El índice `idx_pedidos_cliente` permite apoyar las consultas de pedidos asociados con un cliente.

## Ejecución del Script de Creación

El archivo utilizado para crear la estructura de la base de datos es:

```text
SQL/Scripts/01_creacion_base_datos.sql
```

El script fue ejecutado en MySQL Workbench.

Durante la ejecución se realizaron las siguientes operaciones:

```text
1. Eliminación de una versión previa de la base de datos, en caso de existir.
2. Creación de la base de datos tienda_online.
3. Selección de la base de datos.
4. Creación de la tabla Categorias.
5. Creación de la tabla Clientes.
6. Creación de la tabla Productos.
7. Creación de la tabla Pedidos.
8. Creación de la tabla Detalles_Pedido.
9. Creación de la tabla Reseñas.
10. Creación de los índices definidos para las consultas.
```

La ejecución finalizó correctamente y MySQL Workbench confirmó la creación de las seis tablas y de los índices definidos.

## Datos de Prueba

Después de crear la estructura de la base de datos, se elaboró el archivo:

```text
SQL/Datos/02_datos_prueba.sql
```

El objetivo de este script es poblar las tablas con información suficiente para verificar posteriormente el funcionamiento de la base de datos.

Los datos fueron insertados respetando el orden de las dependencias entre las tablas.

El orden utilizado fue:

```text
Categorias
    |
    v
Clientes
    |
    v
Productos
    |
    v
Pedidos
    |
    v
Detalles_Pedido
    |
    v
Reseñas
```

Primero se insertaron los registros que no dependen de otras tablas y posteriormente aquellos que contienen claves foráneas.

## Registros Insertados

El script de datos de prueba incorporó los siguientes registros:

```text
Categorias          5 registros
Clientes           15 registros
Productos          30 registros
Pedidos             20 registros
Detalles_Pedido     41 registros
Reseñas             15 registros
```

En total, la base de datos contiene:

```text
126 registros de prueba
```

Los datos representan información relacionada con una tienda en línea de productos electrónicos.

Las categorías utilizadas fueron:

```text
Telefonos
Laptops
Tablets
Audio
Accesorios
```

Los productos fueron distribuidos entre estas cinco categorías.

Los pedidos fueron asociados con clientes existentes y los registros de `Detalles_Pedido` fueron relacionados con productos y pedidos previamente registrados.

Las reseñas se asociaron con clientes y productos existentes.

## Generación Automática de Identificadores

Las claves primarias de las seis tablas fueron definidas mediante `AUTO_INCREMENT`.

Por esta razón, los identificadores no se escribieron manualmente durante la inserción de los datos.

Por ejemplo, la inserción de las categorías se realizó de la siguiente manera:

```sql
INSERT INTO Categorias (nombre, descripcion) VALUES
('Telefonos', 'Telefonos inteligentes y dispositivos moviles'),
('Laptops', 'Computadoras portatiles para uso personal y profesional'),
('Tablets', 'Dispositivos portatiles con pantalla tactil'),
('Audio', 'Audifonos, bocinas y dispositivos de sonido'),
('Accesorios', 'Accesorios y complementos para dispositivos electronicos');
```

MySQL generó automáticamente los valores de `id_categoria`.

El mismo mecanismo se utilizó para:

```text
id_cliente
id_producto
id_pedido
id_detalle_pedido
id_reseña
```

Esto permite que cada registro obtenga un identificador único sin necesidad de asignarlo manualmente.

## Verificación de los Datos Almacenados

Después de ejecutar el script `02_datos_prueba.sql`, se verificó que los registros hubieran quedado almacenados correctamente.

Para realizar la verificación se ejecutaron las siguientes consultas:

```sql
USE tienda_online;

SELECT * FROM Categorias;

SELECT * FROM Clientes;

SELECT * FROM Productos;

SELECT * FROM Pedidos;

SELECT * FROM Detalles_Pedido;

SELECT * FROM Reseñas;
```

MySQL Workbench devolvió los siguientes resultados:

```text
Categorias          5 filas recuperadas
Clientes           15 filas recuperadas
Productos          30 filas recuperadas
Pedidos             20 filas recuperadas
Detalles_Pedido     41 filas recuperadas
Reseñas             15 filas recuperadas
```

Los resultados coinciden con la cantidad de registros definida en el script de datos de prueba.

La ejecución de las consultas no produjo errores, duplicados ni advertencias relacionadas con los datos almacenados.

## Correspondencia con el Modelo Lógico

La estructura implementada conserva la correspondencia con el modelo lógico definido previamente.

Las relaciones implementadas son:

```text
Clientes 1 -------- N Pedidos

Categorias 1 -------- N Productos

Pedidos 1 -------- N Detalles_Pedido

Productos 1 -------- N Detalles_Pedido

Clientes 1 -------- N Reseñas

Productos 1 -------- N Reseñas
```

La relación muchos a muchos entre `Pedidos` y `Productos` se encuentra resuelta mediante `Detalles_Pedido`.

Las claves foráneas utilizadas para implementar estas relaciones son:

```text
Pedidos.id_cliente
    → Clientes.id_cliente

Productos.id_categoria
    → Categorias.id_categoria

Detalles_Pedido.id_pedido
    → Pedidos.id_pedido

Detalles_Pedido.id_producto
    → Productos.id_producto

Reseñas.id_cliente
    → Clientes.id_cliente

Reseñas.id_producto
    → Productos.id_producto
```

De esta manera, la implementación física mantiene la estructura definida durante las etapas de diseño lógico y normalización.

## Resultado de la Implementación Realizada

Hasta esta etapa se ha completado la creación de la estructura principal de la base de datos y su población con datos de prueba.

El proceso realizado puede resumirse de la siguiente manera:

```text
Modelo lógico final
        |
        v
Modelo normalizado hasta 3FN
        |
        v
Creación de tienda_online
        |
        v
Creación de las seis tablas
        |
        v
Implementación de claves y restricciones
        |
        v
Creación de índices
        |
        v
Inserción de datos de prueba
        |
        v
Verificación de los registros almacenados
```

La ejecución realizada en MySQL Workbench confirmó que la base de datos fue creada correctamente y que los datos de prueba pueden almacenarse y recuperarse mediante consultas.

## Conclusión

La implementación permitió transformar el modelo lógico previamente diseñado y normalizado en una base de datos funcional en MySQL.

Se creó la base de datos `tienda_online` y se implementaron las tablas `Categorias`, `Clientes`, `Productos`, `Pedidos`, `Detalles_Pedido` y `Reseñas`.

También se implementaron las claves primarias, claves foráneas, claves alternativas, restricciones de integridad e índices definidos para el modelo.

Posteriormente, se insertaron datos de prueba en las seis tablas y se verificó su almacenamiento mediante consultas `SELECT`.

Los resultados obtenidos confirman que la estructura implementada mantiene correspondencia con el diseño lógico y con las decisiones tomadas durante el proceso de normalización.