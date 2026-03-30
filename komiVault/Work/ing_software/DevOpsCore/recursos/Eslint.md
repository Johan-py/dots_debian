Aquí tienes los comandos esenciales para tu día a día con ESLint y Prettier:

## 📋 **COMANDOS ESENCIALES**

### 1. **Ver errores de código** (más usado)
```bash
# Ver qué problemas hay en tu código
cd frontend
npx eslint src --ext .js,.jsx,.ts,.tsx
```

### 2. **Arreglar errores automáticamente** (el que más usarás)
```bash
# Arregla todo lo que puede automáticamente
cd frontend
npx eslint src --ext .js,.jsx,.ts,.tsx --fix
```

### 3. **Formatear código** (para que todo se vea bonito)
```bash
# Formatea todos tus archivos
cd frontend
npx prettier --write "src/**/*.{js,jsx,ts,tsx,json,css}"
```

### 4. **El combo completo** (lo ejecutas y listo)
```bash
# Primero formatea, luego arregla errores
cd frontend
npx prettier --write "src/**/*.{js,jsx,ts,tsx,json,css}" && npx eslint src --ext .js,.jsx,.ts,.tsx --fix
```

### 5. **Scripts para package.json** (más fácil aún)
Agrega esto a `frontend/package.json`:
```json
"scripts": {
  "lint": "eslint src --ext .js,.jsx,.ts,.tsx",
  "lint:fix": "eslint src --ext .js,.jsx,.ts,.tsx --fix",
  "format": "prettier --write \"src/**/*.{js,jsx,ts,tsx,json,css}\"",
  "fix-all": "npm run format && npm run lint:fix"
}
```

Luego solo ejecutas:
```bash
cd frontend
bun run fix-all     # ¡Todo en uno!
bun run lint        # Solo ver errores
bun run format      # Solo formatear
```

## 🎯 **Para tu caso específico **
```bash
cd frontend
npx prettier --write postcss.config.js tailwind.config.js
npx eslint src --ext .js,.jsx,.ts,.tsx --fix
```

