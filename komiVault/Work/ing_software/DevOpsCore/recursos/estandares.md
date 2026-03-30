# 📘 Guía de Buenas Prácticas y Estándares del Proyecto

## 1. 📐 Arquitectura del Proyecto

Este repositorio sigue un **modelo monorepo** con separación clara:

- `backend/` → API (Node + TS)
    
- `frontend/` → Aplicación Next.js
    
- `infra/` → pruebas, CI secundarios, stress lab
    
- `scripts/` → utilidades (no productivas)
    
- raíz → configuración global (CI, Docker, etc.)
    

### 🔑 Principio clave

> Separación por capas + modularidad por dominio

---

## 2. 🧱 Backend – Estándares

### 📂 Estructura obligatoria

```
modules/
 └── <domain>/
      ├── controller
      ├── service
      └── repository
```

### 🔁 Flujo correcto

```
Route → Controller → Service → Repository → DB
```

### 🚫 Prohibiciones críticas

- ❌ No acceder a DB desde `controller`
    
- ❌ No lógica de negocio en `repository`
    
- ❌ No lógica pesada en `middleware`
    

---

### 🧠 Responsabilidades

|Capa|Responsabilidad|
|---|---|
|controller|HTTP (req/res)|
|service|lógica negocio|
|repository|acceso a datos|

---

### 🧩 Ejemplo correcto

```ts
// controller
authController.login()

// service
authService.login()

// repository
authRepository.findUser()
```

---

## 3. 🎨 Frontend – Estándares

### 📂 Estructura

```
src/
 ├── app/        → rutas (Next App Router)
 └── components/ → UI reutilizable
```

### 📏 Reglas

- Componentes deben ser:
    
    - pequeños
        
    - reutilizables
        
- Separar:
    
    - lógica (hooks) vs UI
        
- Evitar lógica de negocio en `page.tsx`
    

---

### 🚫 Prohibiciones

- ❌ No consumir API directamente en componentes deeply nested
    
- ❌ No hardcodear URLs
    
- ❌ No mezclar estilos globales innecesarios
    

---

## 4. 🧼 Estándares de Código

### 🟢 Naming

- variables → `camelCase`
    
- clases → `PascalCase`
    
- archivos:
    
    - backend → `auth.service.ts`
        
    - frontend → `Navbar.tsx`
        

---

### 🟢 Funciones

- Máx: ~30 líneas
    
- 1 responsabilidad
    

---

### 🟢 Tipado

- Siempre usar TypeScript
    
- ❌ evitar `any`
    
- ✔ usar interfaces / types
    

---

### 🟢 ESLint

- No hacer commit si rompe lint
    
- Config centralizada:
    
    - `/eslint.config.mjs`
        
    - `/backend/eslint.config.mjs`
        
    - `/frontend/eslint.config.mjs`
        

---

## 5. 🔐 Manejo de Configuración

### 📁 Variables de entorno

- `backend/.env` → privado
    
- ❌ nunca subir `.env`
    

---

### 📌 Uso correcto

```ts
// SI
process.env.JWT_SECRET

// NO
"mi_clave_super_secreta"
```

---

## 6. 🚫 Archivos que NO deben modificarse

### 🔴 Críticos (rompen build o CI)

- `docker-compose.yml`
    
- `Dockerfile`
    
- `.github/workflows/CI.yml`
    
- `backend/vercel.json`
    
- `frontend/vercel.json`
    

---

### 🔴 Configuración interna

- `tsconfig.json`
    
- `eslint.config.mjs`
    
- `postcss.config.*`
    
- `tailwind.config.js`
    

👉 Solo modificables por responsables de arquitectura.

---

### 🔴 Generados automáticamente

- `frontend/.next/`
    
- `node_modules/`
    
- `bun.lock`
    

👉 Nunca editar manualmente.

---

### 🔴 Core del backend

- `backend/src/config/env.ts`
    
- `backend/src/utils/jwt.ts`
    

👉 Cambios aquí afectan seguridad global.

---

## 7. 🧪 Scripts y Seguridad

### ⚠️ Carpeta `scripts/`

Contiene scripts potencialmente peligrosos:

- `script_malicioso.py`
    
- `stress-test.js`
    
- `chaos_devs.sh`
    

### Reglas

- ❌ No ejecutar sin revisión
    
- ✔ usar solo en entornos controlados
    

---

## 8. 🌿 Flujo de Git

### Branching

- `main` → producción
    
- `develop` → integración
    

---

### 📌 Flujo

```
feature → develop → main
```

---

### 🧾 Commits

Formato:

```
feat(auth): login con JWT
fix(users): error en query
chore: update eslint
```

---

## 9. 🚀 CI/CD

- CI corre en:
    
    - `.github/workflows/CI.yml`
        
- Validaciones:
    
    - lint
        
    - build
        

### Regla clave

> ❌ No merge si CI falla

---

## 10. 🧠 Buenas Prácticas Generales

- Código legible > código “inteligente”
    
- Preferir composición sobre herencia
    
- Evitar duplicación (DRY)
    
- Manejar errores explícitamente
    

---

## 11. 📌 Convenciones importantes del proyecto

- Backend desacoplado por dominio (`auth`, `users`)
    
- Frontend usa App Router (Next.js moderno)
    
- Infra separada (`infra/stress-lab`)
    
- Monorepo con responsabilidades claras
---

## 12. 📦 Política de Tamaño de Commits (CRÍTICO)

### 🎯 Objetivo

Mantener cambios pequeños, revisables y seguros para evitar:

- bugs difíciles de detectar
    
- revisiones ineficientes
    
- conflictos de merge complejos
    
- degradación de la calidad del código
    

---

### 📏 Regla obligatoria

> ❌ **No se permiten commits que modifiquen más de 250 líneas de código**

Esto incluye:

- líneas añadidas
    
- líneas eliminadas
    
- líneas modificadas (diff total)
    

---

### ✅ Buenas prácticas

- Dividir cambios grandes en múltiples commits lógicos
    
- Separar:
    
    - lógica
        
    - refactor
        
    - estilos
        
    - tests
        

---

### 🧠 Ejemplo correcto

```bash
feat(auth): agregar login básico
feat(auth): agregar validación de credenciales
refactor(auth): separar service y repository
```

---

### ❌ Ejemplo incorrecto

```bash
feat: login + register + refactor + fix + cambios UI
```

(→ commit gigante, difícil de revisar)

---

### 🚨 Excepciones (controladas)

Solo se permite superar las 250 líneas en casos específicos:

- migraciones grandes
    
- generación automática (ej: Prisma, builds)
    
- cambios estructurales aprobados
    

👉 Requiere:

- aprobación en PR
    
- justificación clara
    

---

### 🔧 Recomendación técnica (muy importante)

Si quieres hacerlo realmente enforceable:

#### Opción 1: Hook de Git

Puedes validar con:

```bash
git diff --stat
```

y bloquear commits grandes en `pre-commit`.

---

#### Opción 2: En CI (mejor práctica)

Validar en `.github/workflows/CI.yml`:

```bash
git diff --shortstat origin/develop...HEAD
```

Y fallar si supera el límite.

---

### 🧩 Insight técnico

Esta regla no es estética, es ingeniería:

- ↓ tamaño de commit → ↑ calidad de review
    
- ↓ tamaño de commit → ↓ probabilidad de bugs
    
- ↓ tamaño de commit → ↑ velocidad del equipo
    

---

