# Jose
# Línea de tiempo del Sprint (21 días) — Responsabilidades por Rol

## 1️⃣ DÍAS 1–3 — PLANIFICACIÓN Y PREPARACIÓN

**Objetivo de la fase:**  
Establecer el alcance del sprint, preparar infraestructura, definir pruebas y asegurar que el flujo de integración funcionará sin fricciones.

# DevOps lead

Responsable de **alinear a todos los equipos y definir la estrategia del release**.
Solo si es necesario comunicar algo critico le hara una reunion general con QA y Dev.

Acciones:

- Participa en la **Sprint Planning**.
- Define la **fecha oficial de Code Freeze (día 17)**.
- Comunica las **fechas críticas del sprint**.
- Identifica **dependencias entre equipos**.
- Establece **reglas de integración y revisiones de ramas**.

Resultado esperado:

- Calendario del sprint claro.
- Riesgos iniciales identificados.



# Equipo DevOps

Responsable de **garantizar que la infraestructura de desarrollo y despliegue esté lista**.

Acciones:

- Revisar **infraestructura del sprint anterior**.

- Validar ambientes:
    
    - testing
    - staging
    - integración

- Verificar que **CI/CD esté funcionando correctamente**.
    
- Configurar:
    
    - protecciones de ramas
    - reglas de merge
    - pipelines automáticos
    
- Preparar:
    
    - scripts de testing
    - datos de prueba
    - seeds de base de datos.

Resultado esperado:

- Pipeline estable.
- Ambientes listos para desarrollo y pruebas.



# Developers

Responsables de **implementar las historias del sprint**.

Acciones:

- Analizar historias asignadas.
- Diseñar implementación técnica.
- Crear ramas:

```
feature/nombre-feature
```

- Preparar estructura del código.
- Iniciar desarrollo de las primeras funcionalidades.

Resultado esperado:

- Desarrollo iniciado sin bloqueos técnicos.


# QA

Responsable de **definir cómo se validará la calidad del sprint**.

Acciones:

- Refinar historias con el equipo.
- Crear **casos de prueba** para cada feature.
- Definir:
    
    - pruebas manuales
    - pruebas automatizadas

- Coordinar con DevOps qué pruebas se integrarán al pipeline.
- Preparar datos de testing.

Resultado esperado:

- Estrategia de pruebas definida.


# 2️⃣ DÍAS 4–12 — DESARROLLO ACTIVO Y PRUEBAS TEMPRANAS

**Objetivo de la fase:**  
Desarrollar funcionalidades y detectar problemas lo antes posible.


# DevOps lead

Responsable de **monitorear el progreso del sprint**.

Acciones:

- Revisar avance de funcionalidades.
- Detectar **posibles retrasos**.
- Coordinar comunicación entre equipos.
- Verificar que el **plan de release siga siendo viable**    

Resultado esperado:

- El sprint progresa sin desviaciones críticas.



# DevOps

Responsable de **mantener la salud del flujo de integración**.

Acciones:

- Revisar ramas periódicamente (cada 2–3 días).
- Detectar:
    
    - conflictos de merge
    - malas prácticas de git
    
- Supervisar:
    
    - Pull Requests
    - pipelines CI
        
- Garantizar que el **build permanezca estable**.

Resultado esperado:

- Integración continua funcionando correctamente.


# Developers

Responsables de **construir las funcionalidades del sprint**.

Acciones:

- Desarrollo activo de features.
- Crear Pull Requests hacia `develop`.
- Resolver comentarios de code review    
- Corregir bugs detectados por QA.

Resultado esperado:

- Features funcionales integrándose gradualmente al repositorio.


# QA

Responsable de **detectar errores tempranos**.

Acciones:

- Probar funcionalidades terminadas.
- Ejecutar pruebas en ambiente de testing.
- Reportar bugs tempranos.
- Validar pruebas automatizadas.

Resultado esperado:

- Bugs detectados antes de la fase final.


# 3️⃣ DÍAS 13–16 — RECTA FINAL Y PRE-FREEZE 

**Objetivo de la fase:**  
Estabilizar el código y preparar el release.


# DevOps lead

Responsable de **preparar el Code Freeze**.

Acciones:

- Iniciar **cuenta regresiva al freeze**.
- Recordar a los equipos la fecha límite.
- Coordinar prioridades finales con el PO.
- Evaluar riesgos de release.

Resultado esperado:

- Equipos alineados hacia el freeze.


# DevOps

Responsable de **estabilizar el repositorio principal**.

Acciones:

- Revisiones **diarias** de ramas.
- Acelerar revisiones de PRs.
- Resolver conflictos complejos.
- Verificar estabilidad de `develop`.

Resultado esperado:

- Código consolidado y estable.

# Developers

Responsables de **cerrar funcionalidades del sprint**.

Acciones:

- Terminar desarrollo pendiente.
- Integrar cambios finales.
- Resolver bugs críticos    
- Preparar documentación técnica.

Resultado esperado:

- Todas las features integradas antes del freeze.


# QA

Responsable de **validar estabilidad del sistema**.

Acciones:

- Ejecutar pruebas de regresión parciales (primera corrida QA).
- Probar interacción entre features.
- Clasificar bugs:
    
    - bloqueantes
    - menores

Resultado esperado:

- Sistema cercano a estado liberable.


# 4️⃣ DÍA 17 - 20 — CODE FREEZE

**Objetivo de la fase:**  
Congelar el código para validar estabilidad final.

# DevOps lead

Responsable de **controlar el release**.

Acciones:

- Declarar **Code Freeze oficialmente**.
- Autorizar excepciones (hotfixes).
- Liderar reunión **Go / No-Go**.

Resultado esperado:

- Decisión de si el release puede salir.


# DevOps

Responsable de **proteger el repositorio**.

Acciones:

- Bloquear merges no autorizados.
- Permitir solo **hotfixes críticos**.
- Monitorear pipelines constantemente.
- Ejecutar builds finales.

Resultado esperado:

- Código congelado y estable.

# Developers

Responsables de **correcciones críticas únicamente**.

Acciones:

- Implementar solo **hotfixes aprobados**.
- Resolver bugs críticos detectados por QA.

Resultado esperado:

- Correcciones mínimas necesarias.

# QA

Responsable de **validar completamente el sistema**.

Acciones:

- Ejecutar **regresión completa**  (segunda corrida QA).
- Verificar estabilidad del sistema.
- Validar hotfixes.

Resultado esperado:

- Confirmación de calidad del release.


# 5️⃣ DÍA 21 — SPRINT REVIEW Y CIERRE

**Objetivo de la fase:**  
Evaluar el sprint y preparar el siguiente ciclo.

# DevOps lead

Acciones:

- Presentar resumen del sprint:
    
    - features completadas
    - estado del release
    - riesgos futuros
    
- Levantar Code Freeze si procede.

# DevOps

Acciones:

- Presentar métricas:
    
    - pipelines
    - integraciones
    - conflictos resueltos
- Proponer mejoras técnicas.

# Developers

Acciones:

- Demostrar funcionalidades desarrolladas.
- Explicar decisiones técnicas relevantes.

# QA

Acciones:

- Presentar reporte de calidad:
    
    - bugs encontrados
    - bugs resueltos
    - bugs pendientes.


# Resumen conceptual del sprint

| Fase   | Enfoque principal              |
| ------ | ------------------------------ |
| D1–3   | Planificación y preparación    |
| D4–12  | Desarrollo y pruebas tempranas |
| D13–16 | Estabilización                 |
| D17-20 | Code Freeze                    |
| D21    | Evaluación del sprint          |

