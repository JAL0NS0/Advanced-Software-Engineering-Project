# Auditoría de Deuda Técnica y Gobernanza

## Objetivo
Evaluar el estado de calidad del código mediante métricas de SonarCloud y detectar los principales "Hotspots" técnicos que representan alto riesgo.

---

## 1. Resumen
* **Riesgo global:**

| **Ámbito** | **Calificación** | **Umbral Recomendado** | **Comentario** |
|------------|------------------|------------------------|----------------|
| Seguridad | E | A | El análisis encontró 28 vulnerabilidades de impacto crítico y 6 de impacto medio. |
| Confiabilidad | C | A-B | El análisis encontró 8 bugs de alto impacto, 6 de impacto medio y 16 de bajo impacto. Hay 97 issues de tipo code smell que deben de ser evaluados. |
| Mantenibilidad | A | A-B | La nota es alta. Al observar los issues encontrados, los críticos corresponden a convenciones de nombres. Este apartado se encuentra saludable. |
| Code Coverage | XX% | > 70% | - |
| Ciclomatic Complexity | XX | < 10 | - |
| Duplicación | XX% | <5% | El código cuenta con varias funciones y archivos duplicados. |

* **Esfuerzo de Remediación Estimado:** 58 horas
* **Deuda Técnica Identificada:** .

## 2. Métricas de Gobernanza (Resultados de SonarCloud)

| Métrica | Valor Actual |
|---------|--------------|
| **Bugs** | 38 |
| **Vulnerabilidades** | 34 |
| **Security Hotspots** | 266 |
| **Code Smells** | 656 |
| **Duplicación de Código** | 6.3% |
| **Complejidad Ciclomática** | XX |

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
| `routes/likeProductReviews.ts` | 4 |
| `routes/fileUpload.ts` | 3 |
| `routes/dataErasure.ts` | 2 |
| `routes/errorHandler.ts` | 2 |
| `routes/userProfile.ts` | 2 |

### 3.4 Code smells:

| Archivo | Cantidad de Code Smells |
| :--- | :---: |
| `server.ts` | 17 |
| `frontend/src/hacking-instructor/helpers/helpers.ts` | 13 |
| `routes/userProfile.ts` | 13 |
| `routes/metrics.ts` | 12 |
| `routes/order.ts` | 12 |

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

## 4. Auditoría de Seguridad y Supply Chain
*Análisis de riesgos externos e internos detectados durante el Onboarding.*

* **Hallazgo Crítico:** 7 Vulnerabilidades Críticas detectadas vía `npm audit`.
* **Análisis de Riesgo:** 
* **Estado del Quality Gate:** 

## 5. Línea Base de Métricas DORA
*Indicadores de eficiencia del proceso de entrega de software.*

* **Deployment Frequency:** 
* **Lead Time for Changes:** 
* **Change Failure Rate:** 

---

## 6. Observaciones
> **Principales insights:** 
