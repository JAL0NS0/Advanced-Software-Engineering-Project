# Delivery 1 - Discovery & Reverse Engineering

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

# Delivery 2 - Governance & Technical Debt Audit

Según lo indicado, se realizó la creación de un pipeline para el repositorio del proyecto en el cual se configuró SonarCloud para el análisis del código y obtención de métricas.
* Las métricas pueden ser visualizadas en el siguiente enlace <a href="https://sonarcloud.io/summary/overall?id=dacaslles_juice-shop&branch=master" target="_blank">SonarCloud Metrics</a>

Con base en a los resultados obtenidos, se generaron dos documentos para la auditoría y refactorización:
* **<a href="./tech_debt_audit.md">Tech Debt Audit</a>:** Contiene el análisis de las métricas obtenidas desde SonarCloud así como la selección de los módulos que serán trabajados inicialmente para la refactorización.
* **<a href="./refactoring_plan.md">Refactoring Plan</a>:** Describe la estrategía que será utilizada para realizar la refactorización de los archivos seleccionados.

# Delivery 3 - Security Hardening

La siguiente sección detalla el análisis de composicíon del software (SCA) y las acciones realizadas sobre el proyecto para mitigar vulnerabilidades críticas.

---

## 1. Inventario de activos (Análisis SBOM)

Para garantizar la visibilidad total de la cadena de suministro, se ha generado un **Software Bill of Materials (SBOM)**. Aunque el proyecto sugería el uso de cyclonedx-npm, se optó por una validación que garantizará la detección de dependencias.

| Métrica | Detalle |
|---|---|
| Total de Componentes | 777 paquetes detectados |
| Ecosistema Principal | npm / Node.js |

### Dependencias Críticas

Se han identificado los siguientes componentes como los principales de la arquitectura de la aplicación:

| Dependencia | Versión | Rol de dominio (función) |
|---|---|---|
| express | 4.21.0 | Framework web principal que implementa el servidor HTTP y gestiona las rutas de la API del backend. |
| sequelize | 6.37.3 | ORM que abstrae el acceso a la base de datos y gestiona el modelo de persistencia de la aplicación. |
| sqlite3 | 5.1.7 | Motor de base de datos embebido utilizado para almacenar la información del sistema. |
| jsonwebtoken | 0.4.0 | Implementación de autenticación basada en tokens JWT para la gestión de sesiones de usuario. |
| helmet | 4.6.0 | Middleware que aplica cabeceras de seguridad HTTP para mitigar vulnerabilidades comunes. |
| multer | 1.4.5-lts.1 | Middleware de Express para manejar la subida de archivos (multipart/form-data) desde el cliente hacia el servidor. |
| express-rate-limit | 7.5.0 | Control de tasa de solicitudes para prevenir ataques de fuerza bruta o abuso del API. |
| socket.io | 3.1.2 | Comunicación en tiempo real entre servidor y cliente mediante WebSockets. |
| winston | 3.16.0 | Sistema de logging estructurado para registrar eventos y errores de la aplicación. |
| prom-client | 14.2.0 | Exposición de métricas del sistema para monitoreo mediante Prometheus. |

## 2. Auditoría de Vulnerabilidades (VSA)

Utilizando la herramienta Snyk, se detectó que el proyecto cuenta con una deuda técnica de seguridad significativa, principalmente por el uso de versiones obsoletas en librerías core.

| Métrica | Detalle |
|---|---|
| Análisis de dependencias | 968 paquetes analizados |
| Total de hallazgos | 71 hallazgos encontrados |
| Rutas de exposición | 107 rutas vulnerables |

### Hallazgos críticos y de alta prioridad

A continuación, se listan los riesgos que compromenten la integridad y la confidencialidad de la información:

| Severidad | Librería Afectada | Vulnerabilidad | Identificador | Plan de Remediación |
|---|---|---|---|---|
| Critical | vm2 | Remote Code Execution (RCE) | SNYK-JS-VM2-5772823 | Fix: Upgrade to v3.10.0 |
| Critical | vm2 | Remote Code Execution (RCE) | SNYK-JS-VM2-5772825 | Fix: Upgrade to v3.10.0 |
| Critical | vm2 | Sandbox Bypass | SNYK-JS-VM2-5537100 | Fix: Upgrade to v3.9.18 |
| Critical | marsdb | Arbitrary Code Injection | SNYK-JS-MARSDB-480405 | No upgrade available |
| Critical | multer | Uncaught Exception | SNYK-JS-MULTER-10299078 | Fix: Upgrade to v2.1.1 |
| High | jsonwebtoken | Authentication Bypass | npm:jsonwebtoken:20150331 | Fix: Upgrade to v9.0.0 |
| High | express-jwt | Authorization Bypass | SNYK-JS-EXPRESSJWT-575022 | Fix: Upgrade to v7.7.8 |
| High | jws | Forgeable Public/Private Tokens | npm:jws:20160726 | Fix: Upgrade jsonwebtoken to v9.0.0 |
| High | moment | Directory Traversal | SNYK-JS-MOMENT-2440688 | Fix: Upgrade express-jwt to v7.7.8 |
| High | tar | Symlink Attack | SNYK-JS-TAR-15416075 | Fix: Upgrade to v7.5.10 |
| High | lodash | Code Injection | SNYK-JS-LODASH-1040724 | Fix: Upgrade sanitize-html to v2.12.1 |
| High | multer | Uncontrolled Recursion | SNYK-JS-MULTER-15417528 | Fix: Upgrade to v2.1.1 |
| High | socket.io | Uncaught Exception | SNYK-JS-SOCKETIO-7278048 | Fix: Upgrade to v4.8.0 |
| High | libxmljs2 | Type Confusion | SNYK-JS-LIBXMLJS2-6808810 | No upgrade available |

### Acción correctiva (vulnerability patching)

Siguiendo la rúbrica de la entrega, se han seleccionado y parcheado dos vulnerabilidades críticas. El criterio de selección se basó según la severidad, la magnitud de la exposición y el impacto que pueden tener las vulnerabilidades, así como la disponibilidad de parches estables.

| Severidad | Librería Afectada | Vulnerabilidad | Identificador | Justificación | Plan de Remediación |
|---|---|---|---|---|---|
| Critical | vm2 | Remote Code Execution (RCE) | SNYK-JS-VM2-5772823 | Permite ejecución remota de código dentro del sandbox de la aplicación. Este tipo de vulnerabilidad puede derivar en compromiso total del servidor si un atacante logra explotar el escape del sandbox. | Actualizar a vm2 v3.10.0 |
| Critical | multer | Uncaught Exception | SNYK-JS-MULTER-10299078 | Multer gestiona la subida de archivos desde el cliente. Una vulnerabilidad en este componente puede permitir ataques de denegación de servicio o manipulación del flujo de carga de archivos, afectando directamente el endpoint expuesto al usuario. | Actualizar a multer v2.1.1 |

### Evidencia de remediación

Las siguientes imágenes muestran las vulnerabilidades mencionadas en el resultado del análisis.

<a href="./critical_vulnerability_1.png" target="_blank">Vulnerabilidades de multer</a>

<a href="./critical_vulnerability_2.png" target="_blank">Vulnerabilidades de vm2</a>

Realizada la actualización de las dependencias a las versiones solicitadas para eliminar la vulnerabilidad, fueron eliminados los riesgos y no aparecen en el análisis de Snyk como se puede visualizar en las imágenes.

<a href="./critical_resolucion_1.png" target="_blank">Eliminación de vulnerabilidades de multer</a>

<a href="./critical_resoluction_2.png" target="_blank">Eliminación de vulnerabilidades de vm2</a>


