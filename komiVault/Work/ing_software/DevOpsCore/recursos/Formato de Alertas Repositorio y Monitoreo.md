
# 🚨 📢 Formato de Alertas — Repositorio y Monitoreo

## 🔴 1. Alerta de conflicto de merge

```id="3x2d7k"
🚨 ALERTA: Conflicto de Merge

Repositorio: [nombre-repo]  
Rama afectada: [feature/x → develop]  
PR: [link o ID]  

Problema:
Se detectaron conflictos de merge que impiden la integración.

Impacto:
Bloquea el avance hacia develop.

Acción requerida:
@responsable revisar y resolver conflictos.

Estado CI:
❌ Fallando / ⚠️ Pendiente

Responsable asignado:
@[usuario]

Fecha límite sugerida:
[fecha]
```

---

## 🟠 2. Alerta de CI fallando

```id="0q8xkn"
⚠️ ALERTA: CI Fallando

Repositorio: [nombre-repo]  
PR / Rama: [detalle]  

Problema:
El pipeline de CI está fallando.

Detalle:
[Test fallando / build error / lint error]

Impacto:
No se puede hacer merge.

Acción requerida:
Revisar logs y corregir errores.

Link logs:
[link]

Responsable:
@[usuario]
```

---

## 🔵 3. Advertencia de malas prácticas (Git)

```id="qlqk3p"
⚠️ ADVERTENCIA: Mala práctica detectada

Repositorio: [nombre-repo]  
Rama: [nombre]  

Problema:
[Ej: commits directos a develop / nombres incorrectos / commits sin convención]

Impacto:
Puede generar conflictos o desorden en el flujo.

Acción:
Corregir según estándar del equipo.

Responsable:
@[usuario]
```

---

## 🟡 4. Notificación de limpieza de ramas

```id="k9j1yx"
🧹 INFO: Limpieza de ramas

Acción:
Se eliminaron ramas inactivas/mergeadas.

Detalle:
[listado de ramas]

Motivo:
Mantener orden del repositorio.

Fecha:
[fecha]
```

---

## 🔒 5. Alerta de Code Freeze

```id="twz61g"
🚨 CODE FREEZE ACTIVADO

Periodo:
[fecha inicio - fecha fin]

Reglas:
❌ No se permiten nuevas features  
✅ Solo hotfixes críticos  

Acción:
Todos los PR deben ser revisados estrictamente.

Responsable aprobación:
@[Roberto u otro]

Notas:
Cualquier excepción debe ser justificada.
```

---

## 🔥 6. Alerta crítica (bloqueo total)

```id="qjph6h"
🚨 CRÍTICO: Bloqueo de Integración

Problema:
[ej: CI caído / rama develop inestable]

Impacto:
🚫 Se detienen merges

Acción inmediata:
Equipo detener pushes a develop.

Responsables:
@[equipo o usuarios]

Actualización:
En progreso / Resuelto
```

---

# 🎯 Buenas prácticas (importante)

- Siempre incluir:
    
    - 📍 contexto (repo, rama)
        
    - ⚠️ problema claro
        
    - 🎯 acción concreta
        
    - 👤 responsable
        
- Mensajes deben ser:
    
    - Cortos
        
    - Accionables
        
    - Sin ambigüedad
        

---

# 💡 Recomendación pro

Define prefijos estándar:

- 🚨 CRÍTICO
    
- ⚠️ ALERTA
    
- 🟡 ADVERTENCIA
    
- 🧹 INFO
    

Así el equipo sabe la prioridad sin leer todo.

