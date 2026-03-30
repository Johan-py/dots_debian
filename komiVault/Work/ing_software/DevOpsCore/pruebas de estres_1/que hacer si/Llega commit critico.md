Te explico las tres formas principales.

---

# 1️⃣ Método recomendado en equipos: `git revert`

Esto **crea un nuevo commit que deshace el anterior**, sin romper el historial.

Supongamos que el commit problemático es:

```
abc123
```

Primero lo identificas:

```bash
git log --oneline
```

Luego lo reviertes:

```bash
git revert abc123
```

Esto genera automáticamente un commit como:

```
Revert "feature nueva"
```

Después:

```bash
git push origin main
```

El pipeline CI/CD se ejecutará otra vez con el código corregido.

✔ seguro  
✔ no rompe historial  
✔ estándar en equipos

---

# 2️⃣ Volver al commit anterior (reset)

Si quieres regresar exactamente al commit previo.

Ver historial:

```bash
git log --oneline
```

Ejemplo:

```
c1a2b3 nuevo cambio roto
9f8e7d commit estable
```

Volver al estable:

```bash
git reset --hard 9f8e7d
```

Luego forzar el repositorio remoto:

```bash
git push --force
```

⚠️ Esto **reescribe la historia** y puede romper el trabajo de otros developers.

Solo se usa si:

```
repositorio pequeño
o emergencia
```

---

# 3️⃣ Revertir un Pull Request completo

Si el problema viene de un PR mergeado.

GitHub permite revertirlo automáticamente en **GitHub**.

Proceso:

1. ir al PR mergeado
    
2. presionar **Revert**
    
3. GitHub crea un nuevo PR que revierte el merge
    

Esto es común en producción.

---

# 4️⃣ Rollback rápido al último commit bueno

Otra técnica rápida en CI/CD:

```bash
git revert HEAD
```

Esto revierte el **último commit inmediatamente**.

Luego:

```bash
git push
```

Pipeline se ejecuta otra vez.

---

# Ejemplo real de incidente CI/CD

```
PR mergeado
↓
pipeline pasa
↓
deploy staging
↓
error crítico en API
↓
DevOps ejecuta
git revert HEAD
↓
pipeline corre
↓
deploy corregido
```

Tiempo de recuperación:

```
1–3 minutos
```

---

# Qué haría un DevOps en tu simulación

Si llega una **PR crítica que rompe todo**:

1. identificar commit
    

```
git log
```

2. revertir
    

```
git revert <commit>
```

3. push
    

```
git push
```

4. pipeline vuelve a correr.
    

---

✅ Para tu **prueba DevOps**, el procedimiento correcto sería usar **`git revert`**.
