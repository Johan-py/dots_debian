 DevOps Stress Test Lab Johan
# Tecnologías utilizadas

- Next.js (Fullstack)
    
- TypeScript
    
- Bun
    
- Docker
    
	- Git
    
- GitHub Actions

# Estructura del proyecto

```
nextjs-stress-lab
│
├── app/
│   ├── api/
│   ├── test/
│   └── utils.ts
│
├── .github/workflows/
│   └── ci.yml
│
├── Dockerfile
├── README.md
└── bun.lockb
```

---
	
# Instalación del proyecto

## 1 Clonar repositorio

```
git clone https://github.com/Johan-py/prueba_estres_devops.git
cd prueba_estres_devops
```

## 2 Instalar dependencias

```
bun install
```

## 3 Ejecutar en desarrollo

```
bun run dev
```

La aplicación estará disponible en:

```
http://localhost:3000
```

---

# Ejecutar pruebas

```
bun test
```

---

# Build del proyecto

```
bun run build
```

---

# Ejecutar con Docker

## Construir imagen

```
docker build -t nextjs-stress-lab .
```

## Ejecutar contenedor

```
docker run -p 3000:3000 nextjs-stress-lab
```

---

# Simulación de estrés (Commits masivos)

Para simular múltiples desarrolladores trabajando simultáneamente se utilizan scripts de commits automáticos.

## Script de simulación de developer

```
./dev_simulator.sh <branch> <cantidad_de_commits>
```

Ejemplo:

```
./dev_simulator.sh Feacture/descargar_informacion_de_usuarios 20
```

---

# Simulación de estrés (Commits masivos)

Para simular múltiples desarrolladores trabajando simultáneamente se utilizan scripts de commits automáticos.

---

# Script de simulación de developer

Script que simula la actividad de un developer generando commits y pushes automáticos en una rama.

Uso:

```
./dev_simulator.sh <branch> <cantidad_de_commits>
```

Ejemplo:

```
./dev_simulator.sh Feacture/descargar_informacion_de_usuarios 20
```

Este script:

1. Cambia a la rama indicada
    
2. Genera cambios en archivos
    
3. Hace commit automáticamente
    
4. Hace push al repositorio
    
5. Espera un tiempo aleatorio antes del siguiente commit
    

---

# Simulación de múltiples developers

Para simular varios developers trabajando en paralelo se utiliza el script `chaos_devs.sh`.

Contenido del script:

```
#!/bin/bash

./dev_simulator.sh Feacture/descargar_informacion_de_usuarios 20 &
./dev_simulator.sh Feacture/cambio_nombre 20 &
./dev_simulator.sh Feacture/eliminar_cuenta 20 &

wait
```

El operador `&` permite ejecutar los procesos **en paralelo**, simulando varios developers trabajando al mismo tiempo.

---

# Ejecutar simulación

```
./chaos_devs.sh
```

Esto simulará:

- 3 developers trabajando simultáneamente
    
- 20 commits por rama
    
- múltiples pushes al repositorio
    
- activación continua del pipeline CI
    

Total aproximado generado:

```
60 commits
múltiples ejecuciones de CI/CD
```

---

# Objetivo de la simulación

Durante esta actividad el equipo DevOps debe:

- monitorear la ejecución del pipeline
    
- verificar que los builds se completen correctamente
    
- mantener estable la integración continua

---

# Pipeline CI/CD

El pipeline ejecuta automáticamente:

```
bun install
bun test
bun run build
docker build
```

Se ejecuta en:

- push
    
- pull request
    

---

# Escenario de incidente: Cambio crítico rompe el pipeline

Durante la simulación se puede provocar un incidente donde un cambio crítico llega a la rama `main` y rompe el pipeline de integración continua.

Este escenario permite probar la capacidad del equipo DevOps para **detectar, diagnosticar y corregir fallos en CI/CD**.

---

# Simulación del incidente

Modificar el archivo del pipeline:

```
.github/workflows/ci.yml
```

Introducir un error intencional. Ejemplo:

```
- name: Install dependencies
  run: bun instal
```

El comando correcto debería ser:

```
bun install
```

Guardar los cambios y hacer commit.

```
git add .
git commit -m "test: simulate CI pipeline failure"
git push origin main
```

---

# Resultado esperado

El pipeline de CI fallará porque el comando es inválido.

Esto simula un escenario donde:

- un developer introduce un error
- el pipeline falla automáticamente
- el equipo DevOps debe reaccionar

---

# Diagnóstico del problema

El DevOps debe:

1. Revisar el pipeline en GitHub Actions
2. Identificar el paso que falló
3. Analizar los logs del build
4. Determinar la causa del error
