# 📚 **Guía de Práctica Git: SOCIAL_IS - Laboratorio de Colaboración**

## 🎯 **Objetivo de la Práctica**
Aprender Git colaborativo usando **GitHub Flow** adaptado para 7 equipos. Cada grupo desarrolla funcionalidades y el Lead de cada equipo gestiona los Pull Requests hacia `develop`.

---

## 🏗 **Arquitectura del Proyecto**

```
prueba_integracion_DevOpsCore/
├── backend/                 # API con Bun + Express
│   └── src/modules/posts/
│       └── data/posts.json  # ← 📍 ARCHIVO A EDITAR
├── frontend/                # Next.js + TailwindCSS
└── infra/                   # Proyectos adicionales
```

---

### **📌 Roles en el Equipo**
- **Desarrolladores**: Crean posts en su rama `feature/grupo-[N]`
- **Lead de Grupo**: Revisa y hace merge de las ramas de su grupo hacia `develop`
- **DevOps**: Gestiona `develop` → `release` → `main`

---

## 📝 **Flujo de Trabajo PASO a PASO**

### **FASE 1: Configuración Inicial (Solo una vez)**

```bash
# Clonar repositorio
git clone <URL_DEL_REPO>
cd prueba_integracion_DevOpsCore

# Verificar las ramas disponibles
git branch -a
```

---

### **FASE 2: Crear tu Rama de Trabajo (Cada desarrollador)**

```bash
# Asegurarte que develop está actualizada
git checkout develop
git pull origin develop

# Crear tu rama de grupo (usa el número de tu grupo)
git checkout -b feature/grupo-...

# Ejemplo: Si eres del equipo_3
git checkout -b feature/equipo_3
```

---

### **FASE 3: Ejecutar el Proyecto Localmente**

**Terminal 1 - Backend:**
```bash
cd backend
bun install
bun run dev
# ✅ Backend en http://localhost:5000
```

**Terminal 2 - Frontend:**
```bash
cd frontend
bun install
bun run dev
# ✅ Frontend en http://localhost:3000
```


**O solo una terminal - Full:**
```bash
bun install
bun run dev
# ✅ Frontend en http://localhost:3000
# ✅ Backend en http://localhost:5000
```

---

### **FASE 4: Agregar tu Post (¡EL EJERCICIO!)**

Edita el archivo: **`backend/src/modules/posts/data/posts.json`**

Agrega un **NUEVO objeto** al array:

```json
{
  "id": 1003,  // ← USA EL SIGUIENTE NÚMERO DISPONIBLE
  "username": "grupo3_miembro1",
  "avatar": "https://api.dicebear.com/7.x/avataaars/svg?seed=grupo3",
  "content": "¡Hola desde el Grupo 3! Estamos aprendiendo Git colaborativo 🚀",
  "image": "https://images.unsplash.com/photo-1550745165-9bc0b252726f",
  "time": "Hace 1 minuto",
  "tags": ["#Grupo3", "#GitPractice", "#DevOps"]
}
```

**📌 REGLAS POR GRUPO:**
- **Grupo 1:** IDs 1001-1010
- **Grupo 2:** IDs 1011-1020  
- **Grupo 3:** IDs 1021-1030
- **Grupo 4:** IDs 1031-1040
- **Grupo 5:** IDs 1041-1050
- **Grupo 6:** IDs 1051-1060
- **Grupo 7:** IDs 1061-1070

---

### **FASE 5: Verificar Localmente**
```bash
# Refresca http://localhost:3000
# ✅ Tu post debe aparecer en el feed
```

---

### **FASE 6: Git - Commit y Push (Desarrollador)**

```bash
# Ver cambios
git status

# Añadir archivo modificado
git add backend/src/modules/posts/data/posts.json

# Commit con mensaje descriptivo
git commit -m "feat(tomate): agregar post de [tu-nombre]"

# Subir tu rama
git push -u origin feature/grupo-3
```

---

### **FASE 7: Pull Request hacia Develop (Lead del Grupo)**

**El Lead del Grupo debe:**

1. Ir a GitHub y crear un **Pull Request**
2. **Base:** `develop` ← **Compare:** `feature/grupo-3`
3. Título: `feat(grupo3): integración de posts del grupo 3`
4. Revisar que no hay conflictos
5. Asignar revisores (otros Leads)
6. **Hacer merge** cuando esté aprobado

```bash
# Después del merge, eliminar rama local
git branch -d feature/grupo-3
```

---

### **FASE 8: Code Freeze simulacion - Rama Release (devops)**

Cuando todos los grupos terminaron:

```bash
# Crear rama de release
git checkout develop
git pull origin develop
git checkout -b release/sprint-1

# Push de la rama release
git push -u origin release/sprint-1
```

En esta fase:
- ❌ **NO** se aceptan nuevas features
- ✅ **SOLO** fixes críticos
- QA prueba exhaustivamente

---

### **FASE 9: Despliegue a Producción (Administrador)**

Cuando QA aprueba:

```bash
# Merge a main
git checkout main
git pull origin main
git merge release/sprint-1
git push origin main

# Opcional: taggear la versión
git tag -a v1.0.0 -m "Versión 1.0.0"
git push origin v1.0.0

# Sincronizar develop con main
git checkout develop
git merge main
git push origin develop
```

---

## 🚨 **Escenarios Comunes por Grupo**

### **Conflicto en posts.json**
```bash
# Si dos miembros del grupo modifican el mismo archivo
git pull origin feature/grupo-3
# Resolver conflictos manualmente
# Buscar markers: <<<<<<< ======= >>>>>>>
git add backend/src/modules/posts/data/posts.json
git commit -m "fix: resolver conflicto en posts.json"
git push
```

### **Error: "ID duplicado"**
```bash
# Ver IDs usados por tu grupo
grep -A2 "id" backend/src/modules/posts/data/posts.json
# Usar el siguiente número de tu rango asignado
```

### **Pull Request rechazado por el Lead**
```bash
# Hacer cambios solicitados
git add .
git commit -m "fix: correcciones solicitadas en PR"
git push
# El PR se actualiza automáticamente
```

---

## 👥 **Estructura de 7 Grupos**

| Grupo | Rango IDs | Lead | Color |
|-------|-----------|------|-------|
| **Grupo 1** | 1001-1010 | Lead 1 | 🟥 Rojo |
| **Grupo 2** | 1011-1020 | Lead 2 | 🟧 Naranja |
| **Grupo 3** | 1021-1030 | Lead 3 | 🟨 Amarillo |
| **Grupo 4** | 1031-1040 | Lead 4 | 🟩 Verde |
| **Grupo 5** | 1041-1050 | Lead 5 | 🟦 Azul |
| **Grupo 6** | 1051-1060 | Lead 6 | 🟪 Morado |
| **Grupo 7** | 1061-1070 | Lead 7 | ⚫ Negro |

---

## ✅ **Checklist por Grupo**

### **Desarrollador:**
- [ ] Creé rama `feature/grupo-X`
- [ ] Agregué mi post con ID único
- [ ] Verifiqué localmente que funciona
- [ ] Hice commit y push
- [ ] Notifiqué a mi Lead

### **Lead de Grupo:**
- [ ] Revisé los posts de mi grupo
- [ ] Verifiqué IDs únicos
- [ ] Creé PR hacia `develop`
- [ ] Resolví conflictos si existieron
- [ ] Hice merge aprobado

### **Todos:**
- [ ] El proyecto corre localmente
- [ ] Los posts se ven en el feed
- [ ] Entendemos el flujo feature → develop → release → main

---

## 🎓 **Comandos Git Esenciales**

```bash
# Diarios
git status                    # Ver estado
git add .                     # Añadir cambios
git commit -m "mensaje"       # Committear
git push                      # Subir cambios
git pull                      # Actualizar

# Ramas
git branch                    # Ver ramas locales
git checkout -b rama          # Crear y cambiar
git branch -d rama            # Eliminar rama

# Pull Requests (vía GitHub)
git fetch origin              # Actualizar referencias
git merge origin/develop      # Merge manual
```

---

## 🚀 **¡Manos a la obra!**

Cada grupo tiene asignado su rango de IDs. Respeten los rangos para evitar conflictos entre grupos. Los Leads tienen la responsabilidad de mantener la calidad del código que entra a `develop`.

**¿Dudas? ¡Pregunta a tu Lead o al instructor!** 💬

![[ramas.png]]



![[WhatsApp Image 2026-03-18 at 15.58.34.jpeg]]