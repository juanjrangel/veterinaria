# Informe de Exploración Inicial: Sistema de Gestión para Clínica Veterinaria de Tamaño Dinámico

**Objetivo del Proyecto:** Diseñar una base de datos relacional para gestionar una clínica veterinaria con servicios y tamaño dinámico, enfocada en animales domésticos y el ciclo completo de atención en salud animal.


## 1. Conceptos Importantes y Relevantes en la Temática

Para abordar correctamente el modelado de datos de una clínica veterinaria moderna y escalable, es fundamental comprender los siguientes conceptos del dominio clínico y tecnológico:

* **Historia Clínica Electrónica Veterinaria (HCEV):** Es el eje central del sistema. A diferencia de la medicina humana, la HCEV tiene una estructura jerárquica particular: un **Propietario** (cliente/responsable financiero) está vinculado a uno o varios **Pacientes** (mascotas). La base de datos debe garantizar la integridad de esta relación (ej. si cambia el dueño, el historial del paciente debe mantenerse intacto).
* **Gestión de Catálogos Dinámicos:** Dado que el sistema exige "servicios dinámicos", no se pueden codificar los servicios de forma estática ("hardcode"). Se requiere un concepto de *Parametrización*. Esto implica diseñar tablas maestras (diccionarios de datos) donde los administradores puedan crear, modificar o desactivar servicios (consultas, cirugías, exámenes), categorías y precios sin alterar la estructura (esquema) de la base de datos.
* **Trazabilidad del Flujo de Atención:** El ciclo de vida de la atención abarca: Agendamiento (Cita) -> Admisión (Triage) -> Atención Médica (Diagnóstico/Tratamiento) -> Servicios Auxiliares (Laboratorio/Imagenología) -> Facturación -> Seguimiento. La base de datos debe rastrear el estado exacto del paciente en cada etapa.
* **Control de Inventario Farmacológico:** La atención médica está intrínsecamente ligada al consumo de insumos. Un concepto crítico es la relación entre los procedimientos realizados y el descargo automático de medicamentos o insumos médicos del inventario, gestionando unidades de medida precisas (ej. mililitros, miligramos, tabletas).

## 2. Tendencias Actuales en dichos Conceptos

El sector del software veterinario (VetTech) está evolucionando rápidamente. Las tendencias que dictan cómo se construyen estas bases de datos hoy en día incluyen:

* **Arquitecturas Cloud-Native (SaaS) para Escalabilidad Dinámica:** Para cumplir con el requerimiento de "tamaño dinámico", los sistemas actuales abandonaron las instalaciones locales. Utilizan bases de datos en la nube que escalan automáticamente según el volumen de datos (desde una clínica de barrio hasta una red de hospitales veterinarios).
* **Interoperabilidad e Integración con IoT (Internet of Things):** Las bases de datos modernas se diseñan para recibir información externa. Por ejemplo, integraciones directas con equipos de laboratorio (analizadores de sangre IDEXX) o collares inteligentes (wearables) que envían signos vitales del paciente directamente a su Historia Clínica Electrónica.
* **Telemedicina y Tele-Triage Veterinario:** A raíz de los últimos años, los sistemas incorporan módulos de consultas virtuales. Esto impacta la base de datos, ya que requiere tipificar los "Servicios" entre presenciales y virtuales, y almacenar enlaces a grabaciones o consentimientos informados digitales.
* **Uso de Modelos de Datos Híbridos (Relacional + JSON):** Aunque el núcleo de facturación e inventario sigue siendo estrictamente relacional (SQL) por su precisión transaccional (ACID), hay una tendencia a utilizar campos estructurados tipo JSON dentro de bases de datos relacionales (como PostgreSQL) para almacenar formularios médicos altamente dinámicos y específicos de cada especie.

## 3. Consulta y Análisis de Herramientas Existentes en el Mercado

Para entender cómo la industria resuelve este problema, analizamos dos plataformas líderes en la gestión veterinaria:

### A. Provet Cloud (por Nordhealth)
* **Descripción:** Es un software de gestión de prácticas veterinarias (PIMS) basado íntegramente en la nube, diseñado para ser altamente personalizable.
* **Análisis frente a nuestro proyecto:**
    * *Manejo del tamaño dinámico:* Su arquitectura permite que sea usado por clínicas independientes y grandes universidades. Esto nos enseña que nuestra base de datos debe contemplar roles, sucursales y permisos desde el inicio.
    * *Servicios dinámicos:* Provet permite crear "paquetes de servicios" donde un procedimiento agrupa automáticamente insumos, tiempo de personal y uso de equipos.
    * *Limitación u oportunidad:* Su curva de aprendizaje es alta debido a la excesiva parametrización. Nuestro diseño de base de datos debe buscar un equilibrio entre flexibilidad y simplicidad.

### B. eVetPractice (por Covetrus)
* **Descripción:** Un sistema integral en la nube muy popular en Norteamérica, enfocado en la usabilidad y la integración de facturación clínica.
* **Análisis frente a nuestro proyecto:**
    * *Flujo de atención:* Destaca por su "Pizarra electrónica" (Whiteboard), una vista que muestra en qué etapa de la clínica está cada mascota (espera, cirugía, recuperación). Esto sugiere que nuestra base de datos debe incluir una tabla o atributo de estado de flujo de trabajo continuo.
    * *Integración financiera:* Relaciona de manera impecable el historial clínico con el carrito de cobro. Si un veterinario anota una vacuna en el historial, el sistema inserta ese servicio automáticamente en la pre-factura. Esto requiere un diseño relacional fuerte entre las entidades `Tratamiento_Medico` y `Detalle_Factura`.


**Conclusión para el Diseño de la Base de Datos:**
La exploración evidencia que nuestro modelo relacional debe priorizar la **modularidad**. Deberemos crear una estructura que separe claramente a los actores (Humanos y Animales), el catálogo de ofertas (Servicios e Inventario configurables) y el núcleo transaccional (Historia Médica y Facturación).
