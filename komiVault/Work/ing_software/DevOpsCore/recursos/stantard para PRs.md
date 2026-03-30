## 1. **Preparación Local**

```bash

# Actualiza tu rama main/master
git checkout main
git pull origin main
# Crea una rama descriptiva\

git checkout -b feature/nombre-de-la-funcionalidad
# o
git checkout -b fix/descripcion-del-bug

```

## 2. **Desarrollo y Commits**

```bash

# Realiza cambios y haz commits atómicos
git add .
git commit -m "tipo(alcance): descripción breve"
# Tipos comunes: feat, fix, docs, style, refactor, test, chore
# Ejemplo: feat(auth): agregar validación de email
```

## 3. **Mantén la Rama Actualizada**

```bash

# Antes de subir, actualiza con los últimos cambios
git checkout main
git pull origin main
git checkout tu-rama
git merge main
# o usa rebase para un historial más limpio
git rebase main
```

## 4. **Subir la Rama**

```bash

# Sube tu rama al repositorio remoto
git push origin tu-rama
# Primera vez que subes la rama
git push -u origin tu-rama


```

## **Estándar de Commits (Conventional Commits)**

El estándar más utilizado es **Conventional Commits**, que sigue este formato:

text

<tipo>[alcance opcional]: <descripción>
[cuerpo opcional]
[pie opcional]

---

## **1. Tipos de Commits (Obligatorios)**

|Tipo|Uso|Ejemplo|
|---|---|---|
|**feat**|Nueva funcionalidad|`feat: agregar autenticación con JWT`|
|**fix**|Corrección de bug|`fix: resolver error en validación de email`|
|**docs**|Cambios en documentación|`docs: actualizar README con instrucciones`|
|**style**|Formato, espacios, puntos y comas (no afecta lógica)|`style: formatear código con prettier`|
|**refactor**|Refactorización sin cambiar funcionalidad|`refactor: simplificar lógica de autenticación`|
|**perf**|Mejora de rendimiento|`perf: optimizar consultas a base de datos`|
|**test**|Agregar o corregir tests|`test: agregar pruebas para login`|
|**build**|Cambios en sistema de build o dependencias|`build: actualizar webpack a versión 5`|
|**ci**|Cambios en configuración de CI/CD|`ci: configurar GitHub Actions`|
|**chore**|Tareas de mantenimiento (no afecta código producción)|`chore: actualizar dependencias`|
|**revert**|Revertir un commit anterior|`revert: revertir commit abc123`|




# Eslint
  
Aquí tienes los comandos esenciales para tu día a día con ESLint y Prettier:

## 📋 **COMANDOS ESENCIALES**

### 1. **Ver errores de código** (más usado)

```bash
# Ver qué problemas hay en tu código
cd frontend
npx eslint src --ext .js,.jsx,.ts,.tsx
```

### 2. **Arreglar errores automáticamente** (el que más usarás)

```bash
# Arregla todo lo que puede automáticamente
cd frontend
npx eslint src --ext .js,.jsx,.ts,.tsx --fix
```

### 3. **Formatear código** (para que todo se vea bonito)

```bash
# Formatea todos tus archivos
cd frontend
npx prettier --write "src/**/*.{js,jsx,ts,tsx,json,css}"
```

### 4. **El combo completo** (lo ejecutas y listo)

```bash
# Primero formatea, luego arregla errores
cd frontend
npx prettier --write "src/**/*.{js,jsx,ts,tsx,json,css}" && npx eslint src --ext .js,.jsx,.ts,.tsx --fix
```