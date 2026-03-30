
# 🧭 Plan de Fases del Release 

Flujo general:

```
1 Planificación
2 Desarrollo
3 Integración continua
4 Feature Complete
5 Code Freeze
6 Go / No-Go
7 Release
8 Post-Release
```

---

# 1️⃣ Fase: Planificación del Sprint

Objetivo: definir alcance, dependencias y riesgos técnicos.

### 👨‍💻 Developers

- analizan historias de usuario
- estiman esfuerzo técnico
- identifican dependencias entre servicios

### 🧑‍💼 Dev Lead

- valida arquitectura
- revisa impacto entre equipos
- define contratos entre servicios (APIs / eventos)

### 🧪 QA 

- analizan requerimientos
- diseñan **casos de prueba**
- definen escenarios críticos

### 🧪 QA Lead

- define estrategia de testing
- decide qué tipo de pruebas se automatizarán

### ⚙️ DevOps / Platform Team

- revisa necesidades de infraestructura
    
- valida si habrá:
    
    - nuevas bases de datos
    - migraciones
    - nuevas colas / servicios
    - integraciones externas
        
- prepara pipelines CI/CD si hay nuevos servicios
    

### 🎯 Release Manager

- define calendario del sprint
- define fecha de **Feature Complete**
- define fecha de **Code Freeze**
- revisa dependencias entre equipos

---

# 2️⃣ Fase: Desarrollo

Objetivo: implementar funcionalidades.

### 👨‍💻 Developers

crean ramas:

```
feature/team-x/nueva-funcion
```

realizan:

- desarrollo
- commits frecuentes
- Pull Requests hacia `develop`

Buenas prácticas clave:

- PR pequeños
- integración frecuente
- tests unitarios obligatorios

---

### 🧑‍💼 Dev Lead

- revisa Pull Requests
- valida calidad del código
- asegura contratos entre servicios

---

### 🧪 QA Engineers

- prueban funcionalidades nuevas
- ejecutan pruebas funcionales
- validan criterios de aceptación

---

### ⚙️ DevOps / Platform Team

- mantiene pipelines CI/CD
- gestiona ambientes:

```
dev
integration
qa
staging
production
```

- asegura builds reproducibles

---

### 🎯 Release Manager

- monitorea avance del sprint
- detecta bloqueos entre equipos

---

# 3️⃣ Fase: Integración Continua

Objetivo: evitar que el sistema se rompa al integrar muchos equipos.

Cada Pull Request hacia `develop` ejecuta automáticamente:

```
build
tests unitarios
tests de integración
linting
análisis de seguridad
```

---

### 👨‍💻 Developers

- corrigen errores detectados por CI
- integran cambios con otros equipos

---

### 🧑‍💼 Dev Lead

- supervisa conflictos de integración
- revisa cambios críticos

---

### 🧪 QA Engineers

- ejecutan pruebas de integración
- regresión parcial

---

### ⚙️ DevOps

- mantiene estabilidad de pipelines
- monitorea builds
- despliega automáticamente a **environment integration**

---

# 4️⃣ Fase: Feature Complete

Esta fase evita que el **freeze se convierta en caos**.

Objetivo:

👉 todas las **features deben estar terminadas**

Pero aún pueden entrar fixes.

---

A partir de aquí:

❌ no se aceptan nuevas funcionalidades  
✅ solo mejoras menores o fixes

---

### 🎯 Release Manager

- confirma que todos los equipos están **feature complete**
- valida estabilidad de `develop`

---

# 5️⃣ Fase: Code Freeze

Se crea la rama:

```
release/sprint-X
```

desde `develop`.

Objetivo:

**estabilizar la versión candidata.**

---

### 👨‍💻 Developers

solo pueden:

- corregir bugs
- optimizar código
- solucionar problemas detectados por QA

los fixes se aplican en:

```
bugfix → release/sprint-X
```

---

### 🧑‍💼 Dev Lead

- revisa bugfixes
- evita cambios riesgosos

---

### 🧪 QA Engineers

ejecutan pruebas completas:

- regression testing
- integration testing
- smoke testing
- pruebas exploratorias

todo se prueba en **staging**.

---

### ⚙️ DevOps

aquí su rol es **crítico**:

- despliega `release` en **staging**
- ejecuta migraciones de base de datos
- valida infraestructura
- prepara **rollback plan**

---

### 🎯 Release Manager

- monitorea defectos críticos
- controla cambios durante freeze

Regla importante:

```
todo cambio durante freeze requiere aprobación
```

---

# 6️⃣ Fase: Go / No-Go

Reunión de decisión final del release.

Participan:

- Release Manager
- QA Lead
- Dev Leads
- DevOps

---

### QA entrega reporte

ejemplo:

```
Critical bugs: 0
High bugs: 1
Regression: PASS
Smoke tests: PASS
```

---

### DevOps confirma

- infraestructura estable
- pipelines listos
- rollback preparado

---

### Release Manager decide

```
GO → release
NO GO → continuar freeze
```

---

# 7️⃣ Fase: Release (Producción)

Merge final:

```
release → main
```

Luego:

```
release → develop
```

para no perder fixes.

---

### ⚙️ DevOps

- ejecuta deploy
- monitorea infraestructura
- valida servicios

---

### 🧪 QA

- ejecuta **smoke tests en producción**

---

### 👨‍💻 Developers

- monitorean errores
- responden a incidentes

---

# 8️⃣ Fase: Post-Release

Objetivo:

verificar estabilidad.

---

### ⚙️ DevOps

- monitorea métricas:

```
errores
latencia
uso de CPU
uso de memoria
```

---

### 👨‍💻 Developers

- corrigen incidentes
- crean **hotfixes si es necesario**

---

### 🧪 QA

- valida funcionalidades críticas

---

### 🎯 Release Manager

- analiza métricas del release
- documenta incidentes
- identifica mejoras para el próximo sprint

---

# 🧠 Flujo final del sistema

```
Planificación
      ↓
Desarrollo
      ↓
Integración continua
      ↓
Feature Complete
      ↓
Code Freeze
      ↓
Go / No-Go
      ↓
Release
      ↓
Post-Release
```
