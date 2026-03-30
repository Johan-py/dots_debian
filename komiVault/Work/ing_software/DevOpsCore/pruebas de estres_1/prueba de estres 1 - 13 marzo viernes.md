## **Simulación de Estrés por Rol**

### **1️⃣ DevOps 1 — Jose (Infraestructura y entornos)**

**Objetivo del estrés:** garantizar que los entornos no fallen bajo presión y que los datos de prueba se mantengan consistentes.  
**Tareas simuladas:**

- Montar un **nuevo entorno de staging** en paralelo al actual en tiempo limitado.
    
- Introducir deliberadamente datos corruptos o inconsistentes en el entorno de testing para ver si detecta problemas.
    
- Simular caídas de servicios críticos en staging y testing, evaluando su respuesta.
    
- Validar que los entornos soporten **múltiples pipelines ejecutándose simultáneamente**

---

### **2️⃣ DevOps 2 — Johan (CI/CD y automatización)**

**Objetivo del estrés:** asegurar que la integración continua resista fallas y cambios rápidos de código.  
**Tareas simuladas:**

- Crear un **pipeline que ejecute múltiples builds en paralelo** y medir tiempos y errores.
    
- Simular **Pull Requests masivos** con conflictos y código parcialmente roto para evaluar la robustez de los tests automatizados.
    
- Forzar un fallo en la integración continua (por ejemplo, un script de despliegue roto) y evaluar la capacidad de recuperación.
    
- Implementar un **rollback automático** cuando un build falla.

---

### **3️⃣ DevOps 3 — Roberto (Repositorio y monitoreo)**

**Objetivo del estrés:** detectar problemas de integración, conflictos y malas prácticas de Git bajo presión.  
**Tareas simuladas:**

- Introducir **conflictos de merge intencionales** en varias ramas.
    
- Forzar commits directos en ramas protegidas y evaluar la detección de malas prácticas.
    
- Simular **picos de actividad en el repositorio**, como 20+ PRs abiertas simultáneamente.
    
- Configurar alertas falsas y reales para probar su capacidad de filtrado de incidentes críticos vs ruido.

---

## **Fases de la Simulación**

|Fase|Duración|Actividades principales|
|---|---|---|
|**Preparación**|15 min|Cada DevOps revisa su área y recibe la “inyección de estrés” (datos corruptos, PRs masivos, scripts rotos).|
|**Ejecución**|60–90 min|Se dispara el flujo completo: despliegue de entornos, ejecución de pipelines y merges simultáneos.|
|**Evaluación**|30 min|Revisión de logs, detección de fallos, tiempos de respuesta y eficiencia de corrección.|
|**Debrief**|15 min|Discusión sobre problemas encontrados y mejora de procesos.|

---

### **Indicadores de Éxito**

- Entornos de testing y staging se mantienen estables.
- CI/CD maneja todos los PRs y builds sin detenerse completamente.
- Conflictos y malas prácticas en Git son detectados rápidamente.
- Alertas de monitoreo son precisas y accionables.



![[CI_CD_2.jpg]]


![[CI_CD_1.jpg]]
# **Explicación del flujo del diagrama**

1. **Inicio de la simulación**
    
    - Todos los roles reciben su escenario de estrés y preparación de datos.
2. **DevOps 1 — Infraestructura y entornos (Jose)**
    
    - Montaje de entornos de testing/staging.
    - Inyección de datos corruptos y simulación de caídas de servicios.
    - Salida: entornos listos o alertas de fallos.
3. **DevOps 2 — CI/CD y automatización (Johan)**
    
    - Ejecución de pipelines con builds múltiples.
    - Crear PRs masivos con conflictos y scripts intencionalmente rotos.
    - Salida: reporte de errores y builds exitosos vs fallidos.
4. **DevOps 3 — Repositorio y monitoreo (Roberto)**
    
    - Detección de conflictos de merge y malas prácticas de Git.
    - Monitoreo de alertas reales y falsas.
    - Salida: reporte de problemas críticos, alertas y métricas de repositorio.
5. **Evaluación y Debrief**
    
    - Todos los datos (logs, errores, tiempos) se consolidan.
    - Se discuten hallazgos y oportunidades de mejora en procesos.
    - Fin de la simulación.