# Discovery & Reverse Engineering

## Elección del repositorio

Para este proyecto se seleccionó el repositorio **OWASP Juice Shop (The Chaos E-Commerce – Node.js/Angular)** como aplicación legacy base.

Este repositorio fue elegido debido a las tecnologías utilizadas en el proyecto, las cuales son de nuestro conocimiento, lo que facilitaría la lectura y comprensión del código.

Se realizó un **fork del repositorio a nuestras cuentas de GitHub** para trabajar de forma independiente. Todas las actividades de análisis y documentación se realizarán sobre este fork.

## Onboarding log

No se presentaron dificultades significativas relacionadas con las acciones de clonar el repositorio y ejecutar la aplicación. El detalle sobre lo realizado se encuentra a continuación:

### 1. Información General del Proceso
* **Repositorio / Módulo:** OWASP Juice Shop
* **Tiempo Total de Setup:** 20 minutos

### 2. Registro de Acciones y Latencia
| Acción | Resultado | Tiempo (Min) | Observaciones |
| :--- | :--- | :--- | :--- |
| **Provisionamiento (Fork/Clone)** | Éxito | **<5 min** | |
| **Inyección de Dependencias** | **Advertencia** | **~15 min** | 7 vulnerabilidades críticas. Tiempo prolongado para instalación. |
| **Ejecución del Entorno Local** | Éxito | **<5 min** | |

### 3. Auditoría de Seguridad (Security Scan)
Resultados de NPM audit
* **Vulnerabilidades Críticas:** 7
* **Vulnerabilidades Altas:** 23
* **Estado de Parches:** Fix disponibles a excepción de 1 vulnerabilidad crítica y 1 alta

### 4. Métricas de Salud del Proyecto (Audit Scores)

* **Autonomía (Self-Service):** [5/5] - *No fue necesaria ayuda de terceros*
* **Claridad de Documentación:** [5/5] - *El README es preciso y está actualizado*
* **Eficiencia del Toolchain:** [3/5] - *Tomó demasiado tiempo la instalación de dependencias*
* **Postura de Seguridad:** [3/5] - *Varias vulnerabilidades altas y críticas*
* **Consistencia de Dependencias:** [5/5] - *No se presentaron conflictos entre versiones*
* **Feedback del Sistema:** [5/5] - *Los logs indican que la aplicacióin está corriendo de forma clara*

### 5. Análisis de Brechas (Gap Analysis)
* **Punto de Fricción Crítico:** El tiempo de descarga e instalación de dependencias es excesivo.
* **Riesgo Tecnológico:** El uso de paquetes obsoletos con vulnerabilidades críticas representa una brecha de seguridad que debe ser atendida antes de cualquier paso a producción.

### 6. Documentación Técnica Complementaria
* No se cuenta con diagrama de arquitectura o contexto.
* No se cuenta con guía de Troubleshooting (FAQ).

---

## AI-Driven discovery

<p align="center">
  <img src="./Context Map.svg" alt="Context Map" width="800">
</p>

* **User Management**: Centraliza la identidad, seguridad de acceso y perfiles de los usuarios en la plataforma.
* **Product Catalog**: Define el catálogo comercial, gestionando la disponibilidad y visibilidad de los productos.
* **Shopping Cart**: Administra la persistencia temporal y las reglas de negocio de los artículos seleccionados antes de la compra.
* **Order Processing**: Orquesta la transición del carrito hacia una orden en firme y el seguimiento del historial de ventas.
* **Payment & Billing**: Gobierna los activos financieros, métodos de pago y el balance económico del usuario.
* **Shipping**: Controla la logística de entrega, gestionando direcciones y modalidades de envío.
* **Reviews & Feedback**: Gestiona la reputación de productos y la satisfacción del cliente a través de opiniones y quejas.
* **Communication**: Facilita la interacción directa y automatizada entre el sistema y el usuario final.
* **Security & Privacy**: Asegura el cumplimiento de normativas de datos y la integridad de las políticas de privacidad.
* **Challenge System**: Regula la lógica de gamificación, rastreando el progreso y resolución de objetivos educativos.
* **Web3 & NFT**: Integra la interacción con tecnologías descentralizadas y activos digitales en la cadena de bloques.
* **Admin & B2B**: Supervisa la configuración global del sistema y las operaciones comerciales de alto nivel.
* **Localization**: Gestiona la adaptabilidad cultural y lingüística de toda la interfaz y sus mensajes.
* **File Management**: Administra el almacenamiento técnico y la integridad de los archivos cargados al servidor.
* **Content Mgmt**: Controla el material multimedia y los activos digitales promocionales vinculados al negocio.


## Backlog recovery

Se identificaron 42 historias de usuarios asociadas a 5 roles en el sistema. Estas son descritas en el documento <a href="./User Stories Backlog.pdf" target="_blank">User Stories Backlog</a>

---

# Governance & Technical Debt Audit

Según lo indicado, se realizó la creación de un pipeline para el repositorio del proyecto en el cual se configuró SonarCloud para el análisis del código y obtención de métricas.
* Las métricas pueden ser visualizadas en el siguiente enlace <a href="https://sonarcloud.io/summary/overall?id=dacaslles_juice-shop&branch=master" target="_blank">SonarCloud Metrics</a>

Con base en a los resultados obtenidos, se generaron dos documentos para la auditoría y refactorización:
* **<a href="./tech_debt_audit.md">Tech Debt Audit</a>:** Contiene el análisis de las métricas obtenidas desde SonarCloud así como la selección de los módulos que serán trabajados inicialmente para la refactorización.
* **<a href="./refactoring_plan.md">Refactoring Plan</a>:** Describe la estrategía que será utilizada para realizar la refactorización de los archivos seleccionados.







