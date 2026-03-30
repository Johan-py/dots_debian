## 🔹 6.1 Filtros avanzados

### Credenciales:

http.request.method == "POST"

### DNS:

dns

### Solo tráfico sospechoso:

tcp.flags.syn == 1 && tcp.flags.ack == 0

---

## 🔹 6.2 Exportar objetos

- File → Export → HTTP Objects
    

👉 Puedes recuperar archivos descargados.

---

## 🔹 6.3 MITM básico (conceptual)

Wireshark se usa junto con:

- ARP spoofing
    
- sniffing