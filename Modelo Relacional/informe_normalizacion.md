# Informe de Normalización del Esquema Relacional

**Proyecto:** Sistema de Gestión para Clínica Veterinaria
**Asignatura:** Bases de Datos I
**Integrantes del Grupo:**

* Isabella Plata - 2243568

* Mateo Leiva - 2230339

* Juan Morera - 2243581

* Diego Quintero - 2243593

* Juan José Rangel - 2243554

## Introducción

El presente informe detalla el proceso de normalización aplicado al esquema relacional derivado de nuestro modelo Entidad-Relación extendido. El objetivo principal de este proceso ha sido garantizar la integridad de los datos, eliminar redundancias y evitar anomalías de inserción, actualización y borrado en el contexto de una clínica veterinaria con servicios y tamaño dinámico.

Partiendo de una traducción literal del modelo conceptual, se evaluaron e implementaron los ajustes necesarios para alcanzar hasta la Quinta Forma Normal (5FN), tomando decisiones de diseño fundamentadas en el rendimiento transaccional.

## Proceso de Normalización Paso a Paso

### 1. Primera Forma Normal (1FN)

**Regla:** Todos los atributos de una tabla deben ser atómicos (indivisibles) y no deben existir grupos repetitivos o atributos multivaluados en un mismo registro.
**Aplicación y Ajustes:**

* **Atomicidad:** En el esquema original, la tabla `Persona` poseía el atributo `Nombre`. Para cumplir con la 1FN y optimizar futuras consultas o reportes, este campo se dividió en dos atributos atómicos: `Nombres` y `Apellidos`.

* **Atributos Multivaluados:** El atributo `Telefono` en la tabla `Persona` representaba un grupo repetitivo (una persona puede tener múltiples números de contacto, como celular y teléfono fijo). Para normalizarlo, se eliminó este campo de la tabla principal y se creó una nueva entidad débil llamada `Persona_Telefono`, conformada por una clave primaria compuesta (`ID_Persona`, `Telefono`).

### 2. Segunda Forma Normal (2FN)

**Regla:** La tabla debe estar en 1FN y todo atributo no clave debe depender por completo de la clave primaria (eliminación de dependencias parciales en claves compuestas).
**Aplicación y Ajustes:**

* **Evaluación:** Una vez aplicados los ajustes de la 1FN, el modelo **ya cumple** con la 2FN. Las únicas tablas que poseen claves primarias compuestas en nuestro diseño son `Sede_Telefono`, `Persona_Telefono` y la tabla intermedia `Atencion_Servicio`. Ninguna de estas tablas contiene atributos adicionales no clave que dependan solo de una parte de su identificador, por lo que no existen dependencias parciales.

### 3. Tercera Forma Normal (3FN)

**Regla:** La tabla debe estar en 2FN, no deben existir dependencias transitivas (ningún atributo no clave debe depender de otro atributo no clave) y no se deben almacenar valores derivados o calculables.
**Aplicación y Ajustes:**

* **Campos Derivados:** En el diseño inicial, la tabla `Mascota` incluía el atributo `Edad`. Este es un error clásico, ya que la edad es un valor volátil que cambia con el paso del tiempo, lo que obligaría a actualizaciones constantes para mantener la consistencia. Para cumplir con la 3FN, el atributo `Edad` fue reemplazado por `Fecha_Nacimiento`, un dato estático a partir del cual el sistema puede calcular la edad exacta en tiempo real cuando sea requerido.

### 4. Forma Normal de Boyce-Codd (FNBC)

**Regla:** Para cada dependencia funcional no trivial, el determinante debe ser una clave candidata. Es una versión más estricta de la 3FN.
**Aplicación y Ajustes:**

* **Evaluación:** El modelo **ya cumple** con la FNBC. En todas las tablas del esquema, los atributos dependen directa y exclusivamente de su identificador principal (ID o Claves Foráneas integradas), sin que existan determinantes que no sean claves candidatas.

### 5. Cuarta Forma Normal (4FN)

**Regla:** La tabla debe estar en FNBC y no deben existir dependencias multivaluadas independientes en una misma relación.
**Aplicación y Ajustes:**

* **Dependencias Multivaluadas:** Al analizar la tabla `Veterinario`, se identificó que el atributo `Especialidad` podía generar dependencias multivaluadas. Un veterinario puede tener múltiples especialidades (ej. Cirujano y Dermatólogo). Mantener esto en la misma tabla obligaría a duplicar el registro completo del veterinario (incluyendo su ID de persona y registro profesional) por cada especialidad adicional.

* Para resolverlo, se extrajo este campo creando una nueva tabla `Veterinario_Especialidad` (con clave compuesta `ID_Persona`, `Especialidad`), logrando así la 4FN.

### 6. Quinta Forma Normal (5FN)

**Regla:** La tabla debe estar en 4FN y no debe existir ninguna dependencia de reunión (Join Dependency) que permita reconstruir la tabla original a partir de tablas más pequeñas con claves candidatas (evitando ciclos en relaciones ternarias o superiores).
**Aplicación y Ajustes:**

* **Evaluación:** El modelo actual **ya cumple** con la 5FN. Nuestro diseño está enfocado en relaciones binarias fuertes. No poseemos relaciones n-arias (ternarias o superiores) complejas que requieran ser descompuestas en múltiples proyecciones para evitar redundancias de reunión. El esquema ha alcanzado su máxima normalización práctica y lógica para este modelo de negocio.

## Justificación Técnica: Omisión de la Sexta Forma Normal (6FN)

Aunque teóricamente existe una Sexta Forma Normal (6FN), **se tomó la decisión técnica de no implementarla en este esquema.**

La regla de la 6FN exige que toda tabla sea descompuesta hasta que contenga únicamente su Clave Primaria y, como máximo, **un solo atributo no clave**. Aplicar esto a nuestro sistema requeriría fragmentar entidades básicas de manera extrema. Por ejemplo, la tabla `Mascota` tendría que dividirse en cuatro tablas separadas: `Mascota_Nombres`, `Mascota_Nacimientos`, `Mascota_Especies`, y `Mascota_Sexos`.

**Razones para no aplicarla:**

1. **Naturaleza Transaccional (OLTP):** El objetivo de nuestra base de datos es gestionar las operaciones diarias de una clínica veterinaria (citas, facturación, atención rápida). Es un sistema de procesamiento transaccional en línea (OLTP).

2. **Degradación del Rendimiento:** Aplicar la 6FN obligaría al motor de base de datos a ejecutar decenas de operaciones `JOIN` simultáneas para consultas muy básicas (como ver el perfil completo de un paciente en pantalla). Esto destruiría el tiempo de respuesta y el rendimiento del sistema en producción.

3. **Casos de uso de la 6FN:** En la industria real, la 6FN se reserva casi exclusivamente para arquitecturas de analítica de datos complejas (como *Data Vault*) o bases de datos puramente temporales (donde se necesita rastrear el histórico de cambios de cada campo individual por milisegundos).

Por lo tanto, detener el proceso de normalización en la 5FN representa el estándar de la industria y el equilibrio perfecto entre **integridad referencial (cero anomalías)** y **rendimiento transaccional óptimo**.