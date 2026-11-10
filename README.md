# Proyecto Bases de Datos I: Gestión de Clínica Veterinaria

Este repositorio contiene los entregables del proyecto de la asignatura de Bases de Datos I. El objetivo central es diseñar una base de datos relacional altamente estructurada, normalizada y escalable para gestionar el funcionamiento de una clínica veterinaria con **servicios dinámicos** y un ecosistema de atención en salud animal.

## Integrantes del Grupo
*   Isabella Plata - 2243568
*   Mateo Leiva - 2230339
*   Juan Morera - 2243581
*   Diego Quintero - 2243593
*   Juan José Rangel - 2243554

## Estructura del Repositorio

Para mantener el orden y facilitar la revisión, el repositorio está dividido en dos carpetas principales, correspondientes a cada hito del proyecto:

### 📁 `Modelo E-R/` (Primera Entrega)
Contiene los archivos de la fase de análisis y diseño conceptual.
*   **Documento de Exploración:** Investigación sobre conceptos clave, tendencias y benchmarking de sistemas veterinarios reales.
*   **Modelo Entidad-Relación:** Identificación de entidades, atributos y cardinalidades que reflejan las reglas de negocio de la clínica.

### 📁 `Modelo Relacional/` (Segunda Entrega)
Contiene la evolución técnica del proyecto hacia el diseño lógico.
*   **Esquema Relacional:** Definición formal de las tablas, incluyendo Claves Primarias (PK), Claves Foráneas (FK) y el dominio (tipo de dato) estricto de cada columna.
*   **Informe de Normalización:** Documento que justifica paso a paso cómo se aplicó la Primera, Segunda y Tercera Forma Normal (1FN, 2FN, 3FN) para eliminar redundancias y prevenir anomalías (disponible en el archivo `Informe_Normalizacion.md`).

---
### 📁 **Base de Datos SQL/ (Tercera Entrega)**

Contiene la implementación física del sistema en la base de datos relacional.

* **Script DDL (Creación de Base de Datos):** Definición formal de las tablas, claves primarias (PK), claves foráneas (FK), restricciones de integridad y tipos de datos en SQL.
* **Script DML (Población de Datos y Consultas):** Insert de datos de prueba para verificar las relaciones y scripts con las consultas requeridas para el funcionamiento del sistema.
