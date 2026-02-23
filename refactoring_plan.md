# Plan de Refactorización

---

## 1. Justificación de la Estrategia
Basado en la auditoría de deuda técnica, el sistema presenta una **Complejidad Ciclomática (160)** y un **Churn (125)** en módulos críticos que hacen inviable una refactorización tradicional. 

Se implementará el patrón **Strangler Fig ** para tener una estrategia que permita migrar funcionalidades de forma incremental hacia los nuevos módulos o servicios modernizados sin interrumpir la operación del negocio.

---

## 2. Objetivos de Modernización
1. **Reducción de Complejidad:** Descomponer el archivo `routes/verify.ts` para bajar su complejidad de 160 a < 15 puntos por módulo.
2. **Code Sanitization:** Eliminar los 17 Code Smells identificados en `server.ts` mediante la delegación de responsabilidades.
3. **Gobernanza de Seguridad:** Sustituir las funciones vulnerables de `lib/insecurity.ts`.
4. **Cultura de Pruebas:** Alcanzar un **80% de Code Coverage** en los nuevos componentes extraídos.

---

## 3. Fases de Ejecución

### Fase 1: Interceptación y Fachada (Semana 1)
* **Acción:** Implementar un componente "Router/Proxy" que actúe como interceptor en el monolito.
* **Módulo Target:** Rutas de verificación y autenticación (`routes/verify.ts`).
* **Técnica:** Utilizar el patrón *Facade* para que el resto de la aplicación no note el cambio de infraestructura.

### Fase 2: Desarrollo del "Nuevo Brote" (Semanas 2-3)
* **Acción:** Crear una nueva estructura de servicios (`/src/services/verification`) utilizando **Clean Architecture**.
* **Desarrollo:** Reimplementar la lógica de validación de tokens y firmas con TypeScript estricto.
* **Validación:** Cada nueva función debe incluir una suite de pruebas unitarias que garanticen el cumplimiento de la métrica de cobertura.

### Fase 3: Estrangulamiento y Retiro (Semana 4)
* **Acción:** Redirigir el 100% del tráfico de la fachada hacia el nuevo servicio.
* **Limpieza:** Una vez confirmado el éxito, eliminar físicamente los archivos `routes/verify.ts` y reducir `server.ts` a su mínima expresión.
* **Resultado:** Eliminación de la deuda técnica crítica asociada a estos archivos.

---

## 4. Matriz de Gestión de Riesgos

| Riesgo | Impacto | Mitigación |
| :--- | :--- | :--- |
| **Ruptura de dependencias** | Alto | Uso de *Feature Flags* para permitir un rollback inmediato si el nuevo código falla. |
| **Inconsistencia de Datos** | Medio | Mantener la misma interfaz de datos (Input/Output) en la fachada para no afectar al Frontend. |
| **Fuga de Seguridad** | Crítico | Ejecución automática del Pipeline de SonarCloud en cada commit del nuevo módulo. |
