## Elección del repositorio

Para este proyecto se seleccionó el repositorio **OWASP Juice Shop (The Chaos E-Commerce – Node.js/Angular)** como aplicación legacy base.

Este repositorio fue elegido por las tecnologías que son utilizadas en el proyecto, ya que son de nuestro conocimiento lo cual facilitaría la lectura del código.

Se realizó un **fork a nuestra cuenta de GitHub** para trabajar de forma independiente. Todas las actividades de análisis y documentación se realizarán sobre este fork.

## Onboarding log
No se presentaron dificultares relacionadas a las acciones de clonar el repositorio y levantar el proyecto. Se realizaron las siguientes acciones:
1. Se realizo un fork del repositorio seleccionado a las cuentas de GitHub propias.
2. Se clonó el repositorio localmente para correr la aplicación.
3. Se siguieron las instrucciones indicadas en el archivo README.md del proyecto para instalar dependencias y ejecutar la aplicación, las cuales eran bastante claras.
4. Se probó la aplicación y no se encontraron inconvenientes.

## AI-Driven discovery


### **Core E-Commerce**

* **User Management**: Gestiona autenticación, perfiles, restablecimiento de contraseñas y **2FA**. Incluye preguntas/respuestas de seguridad y endpoints como *login*, *current user* y *reset*, además de la creación del wallet de usuario en el backend.
* **Product Catalog**: Administra los productos visibles en la tienda, el buscador y los detalles de cada ítem. Se apoya en el modelo `Product` y en endpoints de búsqueda y de reseñas, siendo el núcleo del “qué se vende”.
* **Shopping Cart**: Maneja el *basket* y los items del carrito. Controla cantidades, restricciones por usuario y lógica de agregado/actualización de productos antes de convertir el carrito en una orden.
* **Order Processing**: Orquesta el *checkout* y la creación de órdenes, además del historial de compras. Se conecta con el carrito y dispara el flujo hacia pagos y envío.

### **Finanzas y Logística**

* **Payment & Billing**: Administra métodos de pago (tarjetas) y el **wallet interno**. Incluye operaciones de consulta, alta y eliminación de tarjetas, más la lógica de balance.
* **Shipping**: Gestiona direcciones y métodos de entrega. Expone endpoints para obtener *delivery methods* y CRUD de direcciones asociadas al usuario.

### **Experiencia del Cliente**

* **Reviews & Feedback**: Centraliza feedbacks, reviews y *complaints*. Permite publicar opiniones, gestionar quejas y mostrar reseñas de productos.
* **Communication**: Incluye el **chatbot** y la comunicación con el usuario. Es una capa de experiencia que atiende consultas y muestra interacciones automáticas.

### **Seguridad y Cumplimiento**

* **Security & Privacy**: Maneja solicitudes de privacidad (**GDPR**), pruebas de políticas y auditoría. Supervisa acciones sensibles y expone endpoints de exportación o borrado de datos.

### **Extensiones y Gamificación**

* **Challenge System**: Es el corazón educativo de **Juice Shop**. Gestiona desafíos, pistas y progreso, resolviendo retos al detectar condiciones específicas en la app.
* **Web3 & NFT**: Conecta con contratos en la red **Sepolia** para desafíos de blockchain. Escucha eventos de *mint* y exploits, y resuelve retos cuando se detectan acciones en la wallet.

### **Infraestructura y Soporte**

* **Admin & B2B**: Contiene configuración avanzada, endpoints B2B y controles de administración (por ejemplo, control de cantidades y accesos especiales).
* **Localization**: Soporta múltiples idiomas con archivos **i18n**. Su función es traducir textos de la interfaz y mensajes de la aplicación.

### **Gestión de Contenido y Medios**

* **File Management**: Gestiona carga de archivos, imágenes de perfil y acceso a **FTP**. Incluye validación de tipo/tamaño y manejo de *uploads*.
* **Content Mgmt**: Maneja contenido visual y premium, como videos promocionales y recursos “recycles”. Se integra con el catálogo para mostrar contenido asociado.

## Backlog recovery


