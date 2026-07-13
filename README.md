# Sistema de Gestión para Tienda en Línea

Universidad: Universidad Autónoma Metropolitana
Alumno: Zury Elizabeth Bautista Báez
Materia: Bases de Datos
Profesor: Guillermo Monroy Rodríguez

---

## Descripción del proyecto

Este repositorio contiene el desarrollo de una base de datos relacional para una tienda en línea.
El sistema está diseñado para administrar clientes, productos, categorías, pedidos, detalles de pedido y reseñas de productos, asegurando la integridad y consistencia de la información conforme a los requerimientos de la materia.

---

## Objetivo general

Diseñar e implementar una base de datos normalizada en MySQL que soporte las operaciones principales de la tienda en línea:

- Registrar ventas y pedidos.
- Consultar productos disponibles y su inventario.
- Administrar categorías de productos.
- Almacenar reseñas de productos realizadas por clientes que hayan comprado.

---

## Objetivos específicos

- Diseñar el modelo entidad-relación de la tienda.  
- Normalizar el diseño hasta Tercera Forma Normal (3FN).  
- Definir claves primarias y foráneas para todas las tablas.  
- Establecer restricciones de integridad referencial.  
- Preparar la estructura para procedimientos almacenados, vistas y triggers en MySQL.  

---

## Tecnologías y herramientas

- MySQL como Sistema Gestor de Bases de Datos.
- PlantUML - MySQL Workbench para el modelo lógico y físico.
- Git y GitHub para control de versiones y entrega del proyecto.
- Markdown para la documentación.

---

## Estructura del repositorio

## Estructura del proyecto

```

Proyecto BD/

├── Documentación/

├── Diagramas/

├── Evidencias/

├── SQL/

│ ├── Scripts/

│ ├── Datos/

│ ├── Procedures/

├── README.md

└── devlog.md


---

## Instalación y uso

1. Clonar este repositorio:
   ```bash
   git clone https://github.com/Zury-e-Baez/PROYECTO-BD-TIENDA-ONLINE.git
   ```
---

## Estado del proyecto

### Finalizado

- Análisis del problema.
- Objetivos del proyecto.
- Modelo Entidad-Relación.
- Modelo lógico.
- Normalización a 3FN.
- Creación de la base de datos.
- Restricciones.
- Índices iniciales.
- Inserción de datos de prueba.
- Tres consultas SQL.
- Ocho procedimientos almacenados.
- Evidencias de ejecución.
- Validación y optimización.
- Documentación final.

**Proyecto finalizado.**

## Procedimientos almacenados implementados

El proyecto implementa los ocho procedimientos almacenados solicitados en la especificación del proyecto:

1. Registrar un nuevo pedido validando límite de pedidos pendientes y disponibilidad de stock.
2. Registrar una reseña únicamente cuando el cliente haya comprado el producto.
3. Actualizar automáticamente el stock después de registrar un pedido.
4. Actualizar el estado de un pedido.
5. Eliminar las reseñas de un producto y recalcular su promedio de calificaciones.
6. Registrar un nuevo producto evitando duplicados por nombre y categoría.
7. Actualizar la información de un cliente.
8. Generar un reporte de productos con stock bajo.

Todos los procedimientos fueron probados utilizando escenarios positivos y negativos para verificar el cumplimiento de las reglas de negocio.

## Validación

La etapa de validación incluye:

- Ejecución de consultas con datos de prueba.
- Análisis del rendimiento utilizando EXPLAIN.
- Verificación del uso de índices.
- Pruebas positivas de los procedimientos almacenados.
- Pruebas negativas para comprobar el cumplimiento de las reglas de negocio.
- Propuestas de optimización para futuras versiones.

# Video de presentación

Como parte de la entrega del proyecto se elaboró un video en el que se explica el desarrollo, la estructura del repositorio, el modelo de la base de datos, la implementación en MySQL y una demostración del funcionamiento de las principales funcionalidades.

El video puede consultarse en el siguiente enlace:

**Google Drive:**  
https://drive.google.com/drive/folders/1AsjQFtltrtRVkWww_6AaN_iCvd6iDJeE?usp=sharing

## Autor

Zury Elizabeth Bautista Báez
Ciudad de México, México