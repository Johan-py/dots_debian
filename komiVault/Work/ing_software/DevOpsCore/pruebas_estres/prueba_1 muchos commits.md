Perfecto, Johan. Ya que tienes varias ramas (`Feacture/descargar_informacion_de_usuarios`, `Feacture/cambio_nombre`, `Feacture/eliminar_cuenta`), puedes simular **varios developers trabajando en paralelo**. La idea es que **cada “dev” tenga su propio script ejecutándose al mismo tiempo**.

Te dejo una forma simple y efectiva.

---

# 1️⃣ Script genérico para simular un developer

Crea un script:

```bash
touch dev_simulator.sh
```

Contenido:

```bash
#!/bin/bash

BRANCH=$1
COMMITS=$2

git checkout $BRANCH

for i in $(seq 1 $COMMITS)
do
  echo "$BRANCH change $i $(date)" >> dev_${BRANCH}.txt
  git add .
  git commit -m "$BRANCH commit $i"
  git push origin HEAD
  sleep $((RANDOM % 5 + 1))
done
```

Dar permisos:

```bash
chmod +x dev_simulator.sh
```

---

# 2️⃣ Ejecutar varios "developers"

Ahora abre **3 terminales**.

### Dev 1

```bash
./dev_simulator.sh Feacture/descargar_informacion_de_usuarios 20
```

### Dev 2

```bash
./dev_simulator.sh Feacture/cambio_nombre 20
```

### Dev 3

```bash
./dev_simulator.sh Feacture/eliminar_cuenta 20
```

Cada uno hará:

```
20 commits
push aleatorio
esperas aleatorias
```

Esto genera:

```
60 commits
muchos pushes
CI ejecutándose continuamente
```

---

# 3️⃣ Versión automática (un solo comando)

Si quieres lanzar **todos los developers desde un solo script**:

```bash
touch chaos_devs.sh
```

```bash
#!/bin/bash

./dev_simulator.sh Feacture/descargar_informacion_de_usuarios 20 &
./dev_simulator.sh Feacture/cambio_nombre 20 &
./dev_simulator.sh Feacture/eliminar_cuenta 20 &

wait
```

Ejecutas:

```bash
./chaos_devs.sh
```

y tendrás **3 developers trabajando en paralelo**.

---

# 4️⃣ Qué efectos verás (perfecto para tu simulación)

En tu repo:

- muchos commits simultáneos
    
- pipelines CI ejecutándose continuamente
    
- PRs acumulándose
    
- posibilidad de conflictos
    

Esto estresa a:

```
DevOps CI/CD  → pipelines
DevOps Repo   → ramas y PR
DevOps Infra  → deploys
```

---

# 5️⃣ Para hacerlo aún más realista

Agrega después:

- commits que rompan tests
    
- commits que rompan build
    
- PRs simultáneos
    
- conflictos de merge
    

Eso convierte tu repo en un **mini laboratorio DevOps de caos controlado**.

---

Si quieres, también puedo darte un **script más avanzado que simula 5 developers, commits aleatorios, archivos distintos y conflictos automáticos**. Ese se usa mucho para **stress test de pipelines CI/CD**.