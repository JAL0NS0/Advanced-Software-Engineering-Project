# Plan de Refactorización

---

## 1. Estrategia

### Contexto

La auditoría técnica evidenció un estado de fragilidad crítica del sistema caracterizado por:

- Complejidad Ciclomática máxima: **160**
- Code Coverage: **26%**
- 34 vulnerabilidades (28 críticas)
- 38 bugs
- 656 code smells
- Churn elevado en módulos core

Los archivos críticos identificados fueron:

1. `routes/verify.ts`
2. `server.ts`
3. `lib/insecurity.ts`

El nivel de riesgo estructural hace inviable una refactorización tradicional directa.

---

## 2. Estrategía a utilizar: Strangler Fig Pattern

Se aplicará el patrón **Strangler Fig** para permitir:

- Reemplazo incremental de funcionalidades
- Aislamiento progresivo del código legacy
- Eliminación controlada de deuda técnica

La estrategia evita una reescritura masiva, reduciendo el riesgo de regresiones críticas.

---

## 3. Objetivos de Modernización

| Objetivo | Métrica Actual | Meta |
|----------|---------------|------|
| Reducir complejidad en `routes/verify.ts` | 160 | < 15 por módulo |
| Reducir code smells en `server.ts` | 17 | 0 |
| Eliminar vulnerabilidades en `lib/insecurity.ts` | 4 críticas | 0 |
| Incrementar Code Coverage | 26% | ≥ 80% en nuevos módulos |

---

## 4. Priorización

| Prioridad | Módulo | Riesgo Técnico | Impacto en Negocio | Justificación |
|------------|----------|---------------|----------------|---------------|
| 1 | routes/verify.ts | Alto | Alto | Alta complejidad + Alto churn |
| 2 | server.ts | Alto | Alto | Posible God Object |
| 33 | lib/insecurity.ts | Crítico | Crítico | Vulnerabilidades activas |


---

## 5. Fases de Ejecución

### Fase 1: Interceptación

#### Objetivo
Aislar el módulo `routes/verify.ts` sin modificar directamente su lógica inicial.

#### Acciones
- Implementar un Router/Proxy interceptor.
- Mantener interfaz pública intacta.
- Introducir Feature Flags para rollback inmediato.

#### Resultado esperado
- Reducción del acoplamiento directo.
- Preparación para extracción.
- Riesgo de regresión controlado.

### Fase 2: Desarrollo del la primera ruta nueva

#### Objetivo
Construir nuevo módulo desacoplado usando principios de clean arquitecture.

#### Acciones
- Crear una nueva estructura de servicios utilizando **Clean Architecture**.
- Reimplementar la lógica de validación de tokens.
- Añadir pruebas unitarias.

#### Resultado esperado
- Código modular y testeable.
- Eliminación de complejidad estructural.
- Reducción de riesgo futuro.

### Fase 3: Redireccón de tráfico y eliminación de legacy

#### Objectivo
Completar el proceso de implementación.

#### Acciones
- Redirigir 100% del tráfico al nuevo módulo.
- Monitorear métricas de estabilidad.
- Eliminar físicamente `routes/verify.ts`
- Simplificar `server.ts` reduciendo responsabilidades.

#### Resultado esperado
- Reducción significativa de deuda técnica.

---

## 6. Eliminación de vulnerabilidades

El archivo `lib/insecurity.ts` será trabajado en paralelo.

### Acciones:

- Remover funciones vulnerables.
- Eliminar exposición de claves.
- Mitigar SQL injection.

### Meta:

- 0 vulnerabilidades críticas en módulo.

---

## 7. Manejo de riesgos

| Riesgo | Impacto | Mitigación |
|---------|---------|------------|
| Ruptura de dependencias | Alto | Feature Flags + pruebas automatizadas |
| Regresiones | Alto | Tests rigurosos antes de modificar |
| Inconsistencia de datos | Medio | Mantener contratos Input/Output |
| Fallas de seguridad | Crítico | SonarCloud obligatorio en PRs |

---

## 8. Conclusión

La implementación del patrón Strangler Fig permite transformar los archivos críticos hacia una arquitectura modular sin comprometer la continuidad operativa.
