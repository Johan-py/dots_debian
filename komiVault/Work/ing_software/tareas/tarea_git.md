Aquí tienes el flujo completo **solo con comandos**, siguiendo el ejercicio:

---

## 🧑‍💻 (1) Crear rama develop y subirla

```bash
git init
git remote add origin <URL_DEL_REPO>

git checkout -b develop
git push -u origin develop
```

---

## 👥 (2) Cada integrante clona y se posiciona en develop

```bash
git clone <URL_DEL_REPO>
cd ejercicio2
git checkout develop
git pull origin develop
```

---

## 🌿 (3) Crear rama feature

```bash
git checkout -b feature/<nombreOperacion>
```

---

## ✍️ (4) Agregar cambios (archivo aritmetica)

```bash
git add .
git commit -m "feat: agregar <operacion>"
```

---

## 🔄 (5) Actualizar rama con develop antes de subir

```bash
git checkout develop
git pull origin develop

git checkout feature/<nombreOperacion>
git merge develop
```

---

## ☁️ (6) Subir rama al remoto

```bash
git push -u origin feature/<nombreOperacion>
```

---

## 🔀 (7) Merge a develop (local)

```bash
git checkout develop
git merge feature/<nombreOperacion>
```

---

## 🚀 (8) Subir develop actualizado

```bash
git push origin develop
```

---

## 🧹 (Opcional) Eliminar rama feature

```bash
git branch -d feature/<nombreOperacion>
git push origin --delete feature/<nombreOperacion>
```


correo git: 
