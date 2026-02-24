# Auditoría de Deuda Técnica y Gobernanza

## Objetivo
Evaluar el estado de calidad del código mediante métricas de SonarCloud y detectar los principales "Hotspots" técnicos que representan alto riesgo.

---

## 1. Resumen
* **Riesgo global:**

| **Ámbito** | **Calificación** | **Umbral Recomendado** | **Comentario** |
|------------|------------------|------------------------|----------------|
| Seguridad | E | A | El análisis encontró 18 vulnerabilidades de impacto crítico y 4 de impacto medio. |
| Confiabilidad | C | A-B | El análisis encontró 6 bugs de impacto medio y 16 de bajo impacto. Hay 87 issues de tipo code smell que deben de ser evaluados. |
| Mantenibilidad | A | A-B | La nota es alta. Al observar los issues encontrados, los críticos corresponden a convenciones de nombres. Este apartado se encuentra saludable. |
| Code Coverage | 43.2% | > 70% | Aún se cuenta con una gran deuda técnica en el código cubierto por pruebas. |
| Ciclomatic Complexity | ~9 | < 10 | Aunque la complejidad muestra que está en un promedio menor al rango, existen varios archivos que superan los 15 puntos. |
| Duplicación | 4.7% | <5% | El código cuenta con una considerable cantidad de líneas de código duplicadas. |

* **Esfuerzo de Remediación Estimado:** 31 horas para seguridad y confiabilidad, 7 días para mantebilidad.

## 2. Métricas de Gobernanza (Resultados de SonarCloud)

| Métrica | Valor Actual |
|---------|--------------|
| **Bugs** | 22 |
| **Vulnerabilidades** | 22 |
| **Security Hotspots** | 38 |
| **Code Smells** | 454 |

## 3. Identificación de Hotspots (Riesgo de Código)
Para hacer esta evualuación, se consideraron 4 métricas: churn, complejidad, vulnerabilidades y code smells. En las siguientes tablas se detalla cuales eran los archivos con mayor cantidad de valor en cada una de las métricas mencionadas.

### 3.1 Git Churn:

| Archivo | Conteo de Cambios (Git Churn) |
| :--- | :---: |
| `server.js` | 475 |
| `frontend/src/app/score-board/score-board.component.ts` | 156 |
| `frontend/src/app/app.module.ts` | 140 |
| `routes/verify.js` | 125 |
| `server.ts` | 114 |
| `lib/utils.js` | 111 |
| `routes/order.js` | 102 |

### 3.2 Cyclomatic complexity:

| Archivo | Puntuación de Complejidad |
| :--- | :---: |
| `routes/verify.ts` | 160 |
| `frontend/src/hacking-instructor/helpers/helpers.ts` | 78 |
| `lib/startup/validateConfig.ts` | 69 |
| `server.ts` | 65 |
| `lib/utils.ts` | 64 |
| `frontend/src/app/navbar/navbar.component.ts` | 59 |

### 3.3 Vulnerabilidades:

| Archivo | Vulnerabilidades Detectadas |
| :--- | :---: |
| `lib/insecurity.ts` | 4 |
| `routes/fileUpload.ts` | 3 |
| `routes/dataErasure.ts` | 2 |

### 3.4 Code smells:

| Archivo | Cantidad de Code Smells |
| :--- | :---: |
| `frontend/src/app/mat-search-bar/mat-search-bar.component.ts` | 19 |
| `server.ts` | 17 |
| `frontend/src/hacking-instructor/helpers/helpers.ts` | 13 |
| `routes/userProfile.ts` | 13 |
| `routes/order.ts` | 11 |
| `lib/utils.ts` | 11 |

### 3.5 Módulos Críticos Seleccionados:
1.  **Archivo:** `routes/verify.ts`
    * **Motivo:** Es el archivo con cyclomatic complexity más alta (160) y tiene un Churn alto (125 cambios).
    * **Riesgo:** Con una complejidad tan alta, maneja muchas reglas de validación y al ser modificado frecuentemente, el riesgo de que un cambio afecte el funcionamiento es alto.
3.  **Archivo:** `server.ts`
    * **Motivo:** Aparece en tres de las métricas consideradas: alto Churn (114), alta complejidad (65) y es el más alto en code smells (17).
    * **Riesgo:** Tendría un riesgo muy similar al anterior, frecuentemente modificado y con complejidad considerable. Adicional, con la cantidad de code smells que contiene indica que no solo es complejo, sino que está mal estructurado y es difícil de leer.
5.  **Archivo:** `lib/insecurity.ts`
    * **Motivo:** Es el archivo con más vulnerabilidades (4) y tiene una complejidad considerable (56).
    * **Riesgo:** Aunque su complejidad no sea de las más altas, contiene demasiadas vulnerabilidades, entre las cuales se incluyen key exposed, por lo que es importante atenderlo.

---

## 6. Conclusión
Tras el análisis de las métricas obtenidas, se concluye que el proyecto se encuentra en un estado de fragilidad crítica. La combinación de una calificación Seguridad "E" con un Code Coverage insuficiente (26%) crea un escenario donde el sistema no solo es vulnerable, además, no cuenta con las herramientas necesarias para ser corregido sin utilizar regresiones.

### 6.1 Hallazgos Clave:
* Mantenibilidad: Aunque SonarCloud otorga una calificación "A", el cruce de datos revela una "falsa salud". La cyclomatic complexity alta (160) en módulos core como routes/verify.ts supera con el umbral considerado para una mantenibilidad real, indicando que el costo de introducir nuevas funcionalidades será alto.

* Riesgos combinados: El archivo server.ts esta en riesgo de ser un "God object" debido a que centraliza demasiada responsabilidad, lo que se visualiza en su Churn elevado y una acumulación de code smells. Cualquier fallo en este nodo central compromete la disponibilidad total de la aplicación.

* Deuda técnica: Con un esfuerzo para remediar de 58 horas, la cantidad de trabajo para corregir los puntos más críticos es considerable. La presencia de vulnerabilidades críticas como llaves expuestas y sql injection de varias formas, representa un riesgo de cumplimiento de seguridad que debe priorizarse sobre el desarrollo de nuevos features.
