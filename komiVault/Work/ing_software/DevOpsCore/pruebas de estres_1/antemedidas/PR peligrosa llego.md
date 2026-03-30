El **rollback por tag** es una práctica muy usada en CI/CD porque permite **volver a una versión exacta del software que ya sabemos que funcionaba**, sin depender de buscar commits manualmente.

La idea central es **marcar versiones estables del código con tags**.

---

# Concepto

Un **tag en Git** es básicamente una etiqueta que apunta a un commit específico.

Ejemplo:

```
v1.0
v1.1
v1.2
```

Cada tag representa **una versión estable del sistema**.

---

# Flujo típico en DevOps

Cuando una versión pasa todas las pruebas:

```
commit
↓
tests pasan
↓
build estable
↓
se crea tag
```

Ejemplo:

```bash
git tag v1.0
git push origin v1.0
```

Ese tag queda guardado en el repositorio.

---

# Escenario de rollback

Supongamos que el historial es:

```
v1.0   (estable)
v1.1   (estable)
v1.2   (bug crítico)
```

Si `v1.2` rompe producción, simplemente vuelves a `v1.1`.

---

# Rollback usando el tag

Primero ves los tags disponibles:

```bash
git tag
```

ejemplo:

```
v1.0
v1.1
v1.2
```

Luego haces checkout al último estable:

```bash
git checkout v1.1
```

Si necesitas que el repositorio vuelva a ese estado:

```bash
git reset --hard v1.1
git push --force
```

---

# Cómo se usa en pipelines

En muchos sistemas CI/CD el deploy se hace **por tag**.

Ejemplo pipeline:

```
push tag
↓
pipeline build
↓
deploy
```

Workflow típico:

```yaml
on:
  push:
    tags:
      - 'v*'
```

Esto significa:

```
si se crea tag → se despliega
```

---

# Ejemplo real de flujo DevOps

```
main branch
   │
   ├── commit
   ├── commit
   └── commit
        │
        ▼
tests pasan
        │
        ▼
tag v1.3
        │
        ▼
deploy staging
        │
        ▼
deploy producción
```

Si algo falla:

```
rollback → v1.2
```

---

# Ventajas del rollback por tag

1️⃣ versiones claras del sistema

```
v1.0
v1.1
v1.2
```

2️⃣ rollback inmediato

```
deploy v1.1
```

3️⃣ historial limpio

no se modifica la historia del repo.

4️⃣ pipelines más simples.

---

# Cómo podrías usarlo en tu laboratorio

Cuando tu pipeline esté estable:

```bash
git tag v1.0
git push origin v1.0
```

Luego continúan commits.

Si algo rompe el sistema:

```bash
git checkout v1.0
```

o desplegar esa versión nuevamente.

---

# Ejemplo visual

```
main
│
├─ commit
├─ commit
├─ commit
│    └─ tag v1.0
│
├─ commit
├─ commit
│    └─ tag v1.1
│
└─ commit roto
```

Rollback:

```
deploy v1.1
```

---

💡 En empresas grandes esto suele combinarse con **Docker**, donde cada versión tiene también una imagen:

```
app:v1.0
app:v1.1
app:v1.2
```

Entonces el rollback es literalmente:

```
docker run app:v1.1
```
