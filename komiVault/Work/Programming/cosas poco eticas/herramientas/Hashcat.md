## 🔹 5.1 Identificar tipo de hash

Usa:

- hashid
    
- documentación
    

---

## 🔹 5.2 Ataques

### Diccionario:

hashcat -m 0 -a 0 hashes.txt rockyou.txt

### Fuerza bruta:

hashcat -m 0 -a 3 hashes.txt ?a?a?a?a?a

---

## 🔹 5.3 Reglas avanzadas

hashcat -m 0 -a 0 hashes.txt rockyou.txt -r rules/best64.rule

---

## 🔹 5.4 GPU vs CPU

hashcat -I

👉 Verifica hardware disponible.